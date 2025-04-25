<script setup>
import { ref, onMounted, computed, watch } from "vue";
import draggable from "vuedraggable";

// Estado para armazenar a lista de tarefas
const items = ref([]);
// Input para adicionar nova tarefa
const newItem = ref("");
// Referência para o input
const inputRef = ref(null);
// Estado para controlar o tema atual
const currentTheme = ref("light");

// Lista de temas disponíveis no DaisyUI
const themes = [
  "light",
  "dark",
  "cupcake",
  "bumblebee",
  "emerald",
  "corporate",
  "synthwave",
  "retro",
  "cyberpunk",
  "valentine",
  "halloween",
  "garden",
  "forest",
  "aqua",
  "lofi",
  "pastel",
  "fantasy",
  "wireframe",
  "black",
  "luxury",
  "dracula",
  "cmyk",
  "autumn",
  "business",
  "acid",
  "lemonade",
  "night",
  "coffee",
  "winter",
  "dim",
  "nord",
  "sunset",
  "caramellatte",
  "abyss",
];

// Função para mudar o tema
const changeTheme = (theme) => {
  currentTheme.value = theme;
  document.documentElement.setAttribute("data-theme", theme);
  localStorage.setItem("theme", theme);
};

// Carregar tema salvo no localStorage
onMounted(() => {
  const savedTheme = localStorage.getItem("theme");
  if (savedTheme) {
    changeTheme(savedTheme);
  }
});

// Contador de itens concluídos
const completedItems = computed(() => {
  return items.value.filter((item) => item.finished).length;
});

// Adicionar uma nova tarefa
const addItem = () => {
  if (newItem.value.trim()) {
    // Criar um novo item com texto, status e uma ordem (posição)
    items.value.push({
      id: Date.now(),
      text: newItem.value.trim(),
      finished: false,
      order: items.value.length,
    });
    // Limpar o input
    newItem.value = "";
    // Salvar no localStorage
    saveToLocalStorage();
    // Focar no input para nova adição
    setTimeout(() => {
      inputRef.value.focus();
    }, 0);
  }
};

// Alternar o status de uma tarefa (concluído/não concluído)
const toggleStatus = (item) => {
  item.finished = !item.finished;
  saveToLocalStorage();
};

// Remover uma tarefa
const removeItem = (id) => {
  items.value = items.value.filter((item) => item.id !== id);
  // Reordenar os itens após a remoção
  items.value.forEach((item, index) => {
    item.order = index;
  });
  saveToLocalStorage();
};

// Atualizar a ordem após arrastar e soltar
const onDragEnd = () => {
  // Atualizar as ordens dos itens baseado na nova posição na lista
  items.value.forEach((item, index) => {
    item.order = index;
  });
  saveToLocalStorage();
};

// Salvar itens no localStorage
const saveToLocalStorage = () => {
  localStorage.setItem("checklist-items", JSON.stringify(items.value));
};

// Carregar itens do localStorage ao iniciar o app
onMounted(() => {
  const savedItems = localStorage.getItem("checklist-items");
  if (savedItems) {
    items.value = JSON.parse(savedItems);
  }
});
</script>

<template>
  <div class="min-h-screen py-6">
    <!-- Seletor de tema no canto superior direito -->
    <div class="fixed top-2 right-4 z-50">
      <select
        class="select select-bordered select-sm w-full max-w-xs"
        v-model="currentTheme"
        @change="changeTheme(currentTheme)"
      >
        <option disabled value="">Escolha um tema</option>
        <option v-for="theme in themes" :key="theme" :value="theme">
          {{ theme }}
        </option>
      </select>
    </div>

    <div class="hero mb-4">
      <div class="hero-content text-center">
        <div class="max-w-md">
          <h1 class="text-3xl font-bold">Checklist</h1>
        </div>
      </div>
    </div>

    <div class="container mx-auto px-2">
      <!-- Formulário para adicionar nova tarefa -->
      <div class="card bg-base-200 shadow-xl mb-6">
        <div class="card-body">
          <form @submit.prevent="addItem" class="flex w-full">
            <input
              type="text"
              ref="inputRef"
              v-model="newItem"
              placeholder="Adicione um novo item..."
              class="input input-bordered w-4/5"
              autocomplete="off"
            />
            <button type="submit" class="btn btn-primary w-1/5 ml-1">
              Adicionar
            </button>
          </form>

          <div class="text-right mt-2">
            <span class="badge badge-accent">
              Concluídos: {{ completedItems }} / {{ items.length }}
            </span>
          </div>
        </div>
      </div>

      <!-- Lista de tarefas -->
      <div v-if="items.length > 0" class="card bg-base-200 shadow-xl">
        <div class="card-body">
          <h2 class="card-title">Sua Lista</h2>

          <draggable
            v-model="items"
            @end="onDragEnd"
            item-key="id"
            handle=".drag-handle"
            ghost-class="ghost"
            class="space-y-2"
          >
            <template #item="{ element }">
              <div
                class="flex items-center p-3 rounded-lg bg-base-300 hover:bg-base-100 transition-colors"
                :class="{ 'opacity-70': element.finished }"
              >
                <div class="drag-handle p-2 cursor-move">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-5 w-5"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M4 6h16M4 12h16M4 18h16"
                    />
                  </svg>
                </div>

                <div
                  @click="toggleStatus(element)"
                  class="flex-grow cursor-pointer"
                >
                  <span :class="{ 'line-through': element.finished }">
                    {{ element.text }}
                  </span>
                </div>

                <button
                  @click="removeItem(element.id)"
                  class="btn btn-ghost btn-sm text-error"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-5 w-5"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                    />
                  </svg>
                </button>
              </div>
            </template>
          </draggable>
        </div>
      </div>

      <!-- Mensagem quando não há tarefas -->
      <div v-else class="card bg-base-100 shadow-xl">
        <div class="card-body text-center">
          <p>Você ainda não tem intes na lista.</p>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
.ghost {
  opacity: 0.5;
  background: #c8ebfb;
}
</style>
