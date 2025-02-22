#!/bin/bash

# Цвета для вывода
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
NC="\033[0m"  # No Color

# Переменные
SRC_DIR="."
ROUTES_DIR="app/api"  # Фиксированная директория для роутеров
ROUTERS_FILE="app/api/routers.py"  # Файл, куда добавляется роутер

# Функция для создания нового роутера
create_router() {
    # Проверка, указано ли имя роутера
    if [ -z "$NAME" ]; then
        echo -e "${YELLOW}Ошибка: укажите имя роутера через NAME=<name>${NC}"
        exit 1
    fi

    # Проверка прав на запись в текущей директории
    if [ ! -w "$SRC_DIR" ]; then
        echo -e "${YELLOW}Ошибка: нет прав на запись в текущей директории${NC}"
        exit 1
    fi

    # Создание директорий
    mkdir -p "./${ROUTES_DIR}/${NAME}"
    mkdir -p "./${ROUTES_DIR}/${NAME}/errors"
    mkdir -p "./${ROUTES_DIR}/${NAME}/models"
    mkdir -p "./${ROUTES_DIR}/${NAME}/utils"

    # Создание пустых файлов __init__.py
    touch "./${ROUTES_DIR}/${NAME}/__init__.py"
    touch "./${ROUTES_DIR}/${NAME}/dao.py"
    touch "./${ROUTES_DIR}/${NAME}/errors/__init__.py"
    touch "./${ROUTES_DIR}/${NAME}/models/__init__.py"
    touch "./${ROUTES_DIR}/${NAME}/utils/__init__.py"

    # Создание файла router.py с содержимым
    cat << EOF > "./${ROUTES_DIR}/${NAME}/router.py"
from fastapi import APIRouter

router = APIRouter(prefix="/${NAME}", tags=["${NAME}"])
EOF

    # Добавление роутера в файл routers.py
    if [ -f "$ROUTERS_FILE" ]; then
        # Импорт и добавление роутера
        {
            echo "from ${NAME}.router import router as ${NAME}_router"
            echo "router.include_router(${NAME}_router)"
        } >> "$ROUTERS_FILE"
        echo -e "${GREEN}Роутер '${NAME}' успешно добавлен в ${ROUTERS_FILE}!${NC}"
    else
        echo -e "${YELLOW}Файл ${ROUTERS_FILE} не найден. Роутер не был добавлен.${NC}"
    fi

    # Вывод сообщения об успехе
    echo -e "${GREEN}Роутер '${NAME}' успешно создан в ./${ROUTES_DIR}/${NAME}!${NC}"
}

# Проверка, передан ли аргумент NAME
if [ $# -eq 0 ]; then
    echo -e "${YELLOW}Ошибка: укажите имя роутера, например: $0 NAME=test${NC}"
    exit 1
fi

# Парсинг аргумента NAME
for arg in "$@"; do
    if [[ $arg =~ ^NAME= ]]; then
        NAME="${arg#NAME=}"
    fi
done

# Вызов функции
create_router
