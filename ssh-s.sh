#!/bin/bash

# Define o nome do usuário
usuario="meu_usuario"

# Verifica se o fzf está instalado
if ! command -v fzf &> /dev/null; then
    echo "O fzf não está instalado. Instale-o com 'sudo apt-get install fzf' e execute o script novamente."
    exit 1
fi

# Define o arquivo hosts
hosts_file="/etc/hosts"

# Array para armazenar as categorias e servidores
declare -A servers_by_location
locations=()

# Lê o arquivo linha por linha
while IFS= read -r line; do
    # Verifica se a linha indica uma nova categoria
    if [[ $line =~ ^#--- ]]; then
        # Extrai o nome da categoria removendo o prefixo "#---"
        current_location=$(echo $line | sed 's/^#---//')
        locations+=("$current_location")
        servers_by_location["$current_location"]=""
        continue
    fi
    
    # Se estamos dentro de uma categoria e a linha não é um comentário ou vazia
    if [[ -n $current_location && ! $line =~ ^# && ! -z $line ]]; then
        # Extrai o nome do servidor
        server=$(echo $line | awk '{print $2}')
        servers_by_location["$current_location"]+="$server\n"
    fi

done < "$hosts_file"

# Converte o array de categorias em uma string separada por novas linhas
locations_string=$(printf "%s\n" "${locations[@]}")

# Usa fzf para selecionar uma categoria
selected_location=$(echo -e "$locations_string" | fzf --prompt="Selecione uma categoria: ")

# Verifica se uma categoria foi selecionada
if [ -n "$selected_location" ]; then
    # Converte a lista de servidores da categoria selecionada em uma string separada por novas linhas
    servers_string=$(echo -e "${servers_by_location[$selected_location]}")
    
    # Usa fzf para selecionar um servidor
    selected_server=$(echo -e "$servers_string" | fzf --prompt="Selecione um servidor: ")
    
    # Verifica se um servidor foi selecionado
    if [ -n "$selected_server" ]; then
        ssh -l "$usuario" "$selected_server"
    else
        echo "Nenhum servidor selecionado."
    fi
else
    echo "Nenhuma categoria selecionada."
fi
