# SSH-Selector


Este script Bash permite que você gerencie e selecione localidades  ou categorias de servidores a partir do arquivo `/etc/hosts` usando o `fzf` para facilitar a navegação e conexão SSH.

## Pré-requisitos

`fzf` instalado. Você pode instalá-lo com:
  ```bash
  sudo apt-get install fzf
```

## Funcionamento
O script lê o arquivo /etc/hosts, identifica as categorias e os servidores configurados e permite que você selecione um servidor para se conectar via SSH.

Estrutura do Arquivo /etc/hosts
Para que o script funcione corretamente, o arquivo /etc/hosts deve seguir a seguinte estrutura:

* Categorias devem ser indicadas com um comentário no formato `#---Localidade`.
* Servidores dentro de cada categoria devem ser listados com o endereço IP e nome do host, separados por espaços.


Exemplo:
  ```bash
#---São Paulo
192.168.0.1 servidor1
192.168.0.2 servidor2

#---Rio de Janeiro
192.168.1.1 servidor3
192.168.1.2 servidor4
```

## Uso
Clone o repositório e navegue até o diretório do projeto.

```bash
git clone git@github.com:Rochelly/SSH-Selector.git
cd SSH-Selector
```
Execute o script.

```bash

./ssh-s.sh
```

Siga as instruções interativas para selecionar uma localidade e um servidor.

## Exemplo de Execução
Ao executar o script, você verá um prompt para selecionar uma localidade:

```bash
Selecione uma localidade:
> São Paulo
  Rio de Janeiro
```
Após selecionar uma localidade, você verá um prompt para selecionar um servidor:

```bash
Selecione um servidor:
> servidor1
  servidor2
```
Finalmente, o script se conectará ao servidor selecionado via SSH.

Contribuição
Sinta-se à vontade para abrir issues e pull requests com melhorias e correções. Todas as contribuições são bem-vindas!



