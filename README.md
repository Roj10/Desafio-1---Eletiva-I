# Automação de Gerenciamento de Projetos e Relatórios

Este projeto contém dois scripts Bash criados para automatizar tarefas de administração de sistemas relacionadas a **gerenciamento de permissões** e **relatórios diários** de arquivos.

## 🧩 Parte 1 — manage_permissions.sh

### 📋 Função:
Cria grupos e diretórios de projetos no `/shared`, adicionando os usuários correspondentes e ajustando permissões para garantir acesso seguro apenas aos membros do projeto.

### 🚀 Uso:
```bash
sudo ./manage_permissions.sh <nome_do_projeto> <usuario1> <usuario2> ...
```

### 🧠 Exemplo:
```bash
sudo ./manage_permissions.sh projetoA alice bob carlos
```

Isso irá:
- Criar o grupo `projetoA` (se não existir)
- Criar o diretório `/shared/projetoA`
- Adicionar `alice`, `bob` e `carlos` ao grupo
- Configurar permissões (apenas o grupo pode acessar)

## 🕓 Parte 2 — daily_report.sh

### 📋 Função:
Gera um relatório diário contendo todos os arquivos **criados ou modificados nas últimas 24 horas** dentro do diretório `/shared`.

O relatório é salvo em:
```
/var/reports/report_YYYY-MM-DD.txt
```

### 🚀 Uso:
```bash
./daily_report.sh
```

### 💡 Dica:
Pode ser agendado no **cron** para execução automática diária, por exemplo:
```bash
0 23 * * * /caminho/para/daily_report.sh
```

## ⚙️ Requisitos:
- Execução com permissões de **root**
- Diretórios `/shared` e `/var/reports` acessíveis
- Sistema baseado em Linux

## 🧾 Autor:
Administrador de Sistemas — Desafio de Automação de Scripts Bash
