#!/bin/bash
# Script: daily_report.sh
# Objetivo: Gerar um relatório diário de arquivos criados/modificados em /shared
# Uso: ./daily_report.sh

SHARED_DIR="/shared"
REPORT_DIR="/var/reports"
DATA=$(date +%Y-%m-%d)
ARQUIVO_RELATORIO="$REPORT_DIR/report_$DATA.txt"

mkdir -p "$REPORT_DIR"

echo "🕓 Gerando relatório de arquivos modificados em $SHARED_DIR nas últimas 24h..."
echo "Relatório diário - $DATA" > "$ARQUIVO_RELATORIO"
echo "=============================================" >> "$ARQUIVO_RELATORIO"

find "$SHARED_DIR" -type f -mtime -1 | while read -r FILE; do
    PROJETO=$(echo "$FILE" | cut -d'/' -f3)
    echo "[$PROJETO] $FILE" >> "$ARQUIVO_RELATORIO"
done

echo "=============================================" >> "$ARQUIVO_RELATORIO"
echo "Relatório gerado em: $ARQUIVO_RELATORIO"
