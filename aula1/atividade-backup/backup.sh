#!/usr/bin/env bash

timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
backup_dir="backup_${timestamp}"
zip_file="backup_${timestamp}.zip"

mkdir -p "$backup_dir"

for dir in "$@"; do
  if [ -d "$dir" ]; then
    echo "→ Copiando '$dir' para '$backup_dir/'"
    cp -a "$dir" "$backup_dir/"
  else
    echo "Aviso: '$dir' não é um diretório válido. Pulando..."
  fi
done

echo "→ Criando '$zip_file'..."
zip -r "$zip_file" "$backup_dir"

rm -rf "$backup_dir"

echo "Backup concluído: $zip_file"