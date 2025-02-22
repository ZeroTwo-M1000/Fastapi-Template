from typing import Any

from core.logging import logger

from prisma import Prisma
from prisma.errors import PrismaError

prisma_client: Any = Prisma()


async def connect_db() -> None:
    try:
        await prisma_client.connect()
        logger.info("Database Connected")
    except PrismaError as e:
        logger.error(e)


async def disconnect_db() -> None:
    try:
        await prisma_client.disconnect()
        logger.info("Database Disconnected")
    except PrismaError as e:
        logger.error(e)
