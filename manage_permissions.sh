#!/bin/bash
# Script: manage_permissions.sh
# Objetivo: Gerenciar permissões e grupos de usuários para projetos no /shared
# Uso: sudo ./manage_permissions.sh <nome_do_projeto> <usuario1> <usuario2> ...

if [ "$(id -u)" -ne 0 ]; then
    echo "Este script precisa ser executado como root."
    exit 1
fi

if [ $# -lt 2 ]; then
    echo "Uso: $0 <nome_do_projeto> <usuario1> <usuario2> ..."
    exit 1
fi

PROJETO=$1
shift
USUARIOS=("$@")

GRUPO=$PROJETO
DIRETORIO="/shared/$PROJETO"

echo "Configurando projeto: $PROJETO"

if getent group "$GRUPO" > /dev/null; then
    echo "Grupo '$GRUPO' já existe."
else
    groupadd "$GRUPO"
    echo "🆕 Grupo '$GRUPO' criado."
fi

if [ ! -d "$DIRETORIO" ]; then
    mkdir -p "$DIRETORIO"
    echo "Diretório '$DIRETORIO' criado."
else
    echo "Diretório '$DIRETORIO' já existe."
fi

for USUARIO in "${USUARIOS[@]}"; do
    if id "$USUARIO" &>/dev/null; then
        usermod -aG "$GRUPO" "$USUARIO"
        echo "Usuário '$USUARIO' adicionado ao grupo '$GRUPO'."
    else
        echo "Usuário '$USUARIO' não existe. Pulando..."
    fi
done

chown root:"$GRUPO" "$DIRETORIO"
chmod 770 "$DIRETORIO"

echo "Permissões configuradas: apenas membros do grupo '$GRUPO' têm acesso."
echo "Configuração concluída!"
