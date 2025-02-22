# Makefile для проекта FastAPI с UV, Pyright, Ruff, Pytest и Prisma

# === Переменные ===
SRC_DIR       := .        # Основная директория с исходным кодом
TEST_DIR      := tests    # Директория с тестами
APP_NAME      ?= "App"  # Значение по умолчанию для APP_NAME

# === Цвета для вывода ===
GREEN         := \033[0;32m
BLUE          := \033[0;34m
YELLOW        := \033[0;33m
NC            := \033[0m  # No Color

# === Основные цели ===

# Вывод справки
.PHONY: help
help:
	@echo "$(BLUE)==========================================$(NC)"
	@echo "$(BLUE)=== Makefile для проекта FastAPI ===$(NC)"
	@echo "$(BLUE)==========================================$(NC)"
	@echo "$(YELLOW)Управление проектом:$(NC)"
	@printf "  $(GREEN)%-18s$(NC) %s\n" "make install"       "Установить зависимости проекта"
	@printf "  $(GREEN)%-18s$(NC) %s\n" "make dev"          "Запустить сервер в режиме разработки"
	@echo ""
	@echo "$(YELLOW)Конфигурация:$(NC)"
	@printf "  $(GREEN)%-18s$(NC) %s\n" "make env"          "Сгенерировать файл .env (APP_NAME по умолчанию: App)"
	@echo ""
	@echo "$(YELLOW)Проверка и форматирование кода:$(NC)"
	@printf "  $(GREEN)%-18s$(NC) %s\n" "make lint"         "Проверить код с помощью Ruff"
	@printf "  $(GREEN)%-18s$(NC) %s\n" "make format"       "Форматировать код с помощью Ruff"
	@printf "  $(GREEN)%-18s$(NC) %s\n" "make typecheck"    "Проверить типы с помощью Pyright"
	@echo ""
	@echo "$(YELLOW)Тестирование:$(NC)"
	@printf "  $(GREEN)%-18s$(NC) %s\n" "make test"         "Запустить тесты с помощью Pytest"
	@echo ""
	@echo "$(YELLOW)Prisma (база данных):$(NC)"
	@printf "  $(GREEN)%-18s$(NC) %s\n" "make prisma-gen"   "Сгенерировать Prisma Client"
	@printf "  $(GREEN)%-18s$(NC) %s\n" "make prisma-mig"   "Выполнить миграции Prisma"
	@echo ""
	@echo "$(YELLOW)Утилиты:$(NC)"
	@printf "  $(GREEN)%-18s$(NC) %s\n" "make clean"        "Удалить временные файлы"
	@printf "  $(GREEN)%-18s$(NC) %s\n" "make all"          "Выполнить все проверки и тесты"
	@printf "  $(GREEN)%-18s$(NC) %s\n" "make router"       "Создать новый роутер (используйте NAME=<name>)"
	@echo "$(BLUE)==========================================$(NC)"

# Установка зависимостей
.PHONY: install
install:
	uv sync

# Запуск сервера в режиме разработки
.PHONY: dev
dev:
	uv run fastapi dev

# === Конфигурация ===

# Генерация файла .env
.PHONY: env
env:
	@echo "DATABASE_URL=\"file:database.db\"" > .env
	@echo "DEBUG=True" >> .env
	@echo "APP_NAME=\"$(APP_NAME)\"" >> .env
	@echo "ALGORITHM=\"RS256\"" >> .env
	@echo "ACCESS_TOKEN_EXPIRE_MINUTES=1000" >> .env
	@echo "$(GREEN)Файл .env успешно создан с APP_NAME=$(APP_NAME)!$(NC)"

# === Инструменты проверки кода ===

# Проверка кода с помощью Ruff
.PHONY: lint
lint:
	ruff check $(SRC_DIR) $(TEST_DIR)

# Форматирование кода с помощью Ruff
.PHONY: format
format:
	ruff format $(SRC_DIR) $(TEST_DIR)

# Проверка типов с помощью Pyright
.PHONY: typecheck
typecheck:
	pyright $(SRC_DIR)

# === Тестирование ===

# Запуск тестов с помощью Pytest
.PHONY: test
test:
	uv run pytest $(TEST_DIR) -v

# === Prisma ===

# Генерация Prisma Client
.PHONY: prisma-gen
prisma-gen:
	uv run prisma generate

# Выполнение миграций Prisma
.PHONY: prisma-migrate
prisma-migrate:
	uv run prisma migrate dev

# === Утилиты ===

# Очистка временных файлов
.PHONY: clean
clean:
	find . -type d -name "__pycache__" -exec rm -r {} +
	find . -type d -name "*.egg-info" -exec rm -r {} +
	find . -type d -name "*.pyc" -exec rm -r {} +
	find . -type d -name "*.pyo" -exec rm -r {} +
	find . -type d -name "*.pyd" -exec rm -r {} +
	find . -type d -name ".pytest_cache" -exec rm -r {} +
	find . -type d -name ".ruff_cache" -exec rm -r {} +

# Выполнение всех проверок и тестов
.PHONY: all
all: format lint typecheck test
	@echo "Все проверки выполнены успешно!"

# Создание нового роутера
.PHONY: router
router:
	@if [ -z "$(NAME)" ]; then \
		echo -e "$(YELLOW)Ошибка: укажите имя роутера через NAME=<name>$(NC)"; \
		exit 1; \
	fi
	@./create_router.sh NAME=$(NAME)
