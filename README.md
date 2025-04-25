# Checklist App

Um aplicativo simples de checklist construído com Vue.js, Tailwind CSS e DaisyUI.

## Sobre o Projeto

Este aplicativo permite criar e gerenciar itens de uma lista de tarefas (checklist) com as seguintes funcionalidades:

- Adicionar novos itens à lista
- Marcar itens como concluídos
- Remover itens da lista
- Reorganizar itens usando arrastar e soltar (drag and drop)
- Mudar entre múltiplos temas visuais
- Armazenamento local (localStorage) para persistência de dados

## Tecnologias Utilizadas

- **Vue.js 3** - Framework JavaScript progressivo
- **Vite** - Build tool e servidor de desenvolvimento
- **Tailwind CSS** - Framework CSS utilitário
- **DaisyUI** - Componentes para Tailwind CSS
- **Vue Draggable** - Biblioteca para funcionalidade de arrastar e soltar
- **Docker** - Containerização da aplicação

## Como Iniciar

### Desenvolvimento Local

```bash
# Instalar dependências
npm install

# Iniciar servidor de desenvolvimento
npm run dev
```

### Usando Docker

```bash
# Construir a imagem Docker
docker build -t checklist-app .

# Executar o container
docker run -p 8080:80 checklist-app
```

Após iniciar o aplicativo, acesse-o em seu navegador no endereço http://localhost:8080 (ou na porta configurada).

## Funcionalidades

- **Adicionar Tarefas**: Digite o texto da tarefa e clique em "Adicionar" ou pressione Enter
- **Concluir Tarefas**: Clique em uma tarefa para marcá-la como concluída/não concluída
- **Remover Tarefas**: Clique no ícone de lixeira para remover uma tarefa
- **Reorganizar Tarefas**: Arraste as tarefas para alterar sua ordem
- **Mudar Temas**: Selecione entre vários temas usando o menu no canto superior direito
