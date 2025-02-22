from loguru import logger

log_format = (
    "<green>{time:YYYY-MM-DD HH:mm:ss}</green> | "
    "<level>{level: <8}</level> | "
    "<cyan>{name}</cyan>:<cyan>{function}</cyan>:<cyan>{line}</cyan> - "
    "<level>{message}</level>"
)

logger.add(
    "logs/app.log",
    format=log_format,
    level="INFO",
    rotation="10 MB",
    retention="1 week",
    compression="zip",
    enqueue=True,
)

logger.add(
    "logs/errors/errors.log",
    format=log_format,
    level="WARNING",
    rotation="10 MB",
    retention="1 week",
    compression="zip",
    enqueue=True,
)
