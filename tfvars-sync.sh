#!/usr/bin/env bash
set -euo pipefail

ENV="poc"
PREFIX="/edenred/${ENV}"

MODULES="common infrastructure nullplatform nullplatform-bindings"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_file() {
  local name="$1"
  case "$name" in
    common)                echo "common.tfvars" ;;
    infrastructure)        echo "infrastructure/terraform.tfvars" ;;
    nullplatform)          echo "nullplatform/terraform.tfvars" ;;
    nullplatform-bindings) echo "nullplatform-bindings/terraform.tfvars" ;;
  esac
}

valid_module() {
  local name="$1"
  for m in $MODULES; do
    [[ "$m" == "$name" ]] && return 0
  done
  return 1
}

usage() {
  echo "Uso: $0 <push|pull> [modulo]"
  echo ""
  echo "Modulos: $MODULES"
  echo "Si no se especifica modulo, aplica a todos."
  echo ""
  echo "Ejemplos:"
  echo "  $0 push                      # sube todos los tfvars"
  echo "  $0 pull                      # baja todos los tfvars"
  echo "  $0 push infrastructure       # sube solo infrastructure"
  echo "  $0 pull nullplatform          # baja solo nullplatform"
  exit 1
}

push_one() {
  local name="$1"
  local file="${SCRIPT_DIR}/$(get_file "$name")"
  local param="${PREFIX}/${name}.tfvars"

  if [[ ! -f "$file" ]]; then
    echo "ERROR: no existe $file"
    return 1
  fi

  aws ssm put-parameter \
    --name "$param" \
    --type "String" \
    --value "$(cat "$file")" \
    --overwrite \
    --no-cli-pager

  echo "OK: $file -> $param"
}

pull_one() {
  local name="$1"
  local file="${SCRIPT_DIR}/$(get_file "$name")"
  local param="${PREFIX}/${name}.tfvars"

  local value
  value=$(aws ssm get-parameter --name "$param" --query "Parameter.Value" --output text --no-cli-pager 2>/dev/null) || {
    echo "ERROR: no se encontro $param en Parameter Store"
    return 1
  }

  printf '%s\n' "$value" > "$file"
  echo "OK: $param -> $file"
}

# --- main ---

[[ $# -lt 1 ]] && usage

ACTION="$1"
MODULE="${2:-}"

case "$ACTION" in
  push|pull)
    if [[ -n "$MODULE" ]]; then
      if ! valid_module "$MODULE"; then
        echo "ERROR: modulo '$MODULE' no valido"
        echo "Modulos: $MODULES"
        exit 1
      fi
      "${ACTION}_one" "$MODULE"
    else
      for name in $MODULES; do
        "${ACTION}_one" "$name"
      done
    fi
    ;;
  *)
    usage
    ;;
esac
