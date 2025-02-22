from contextlib import asynccontextmanager

from api.routers import router
from db.database import connect_db, disconnect_db
from fastapi import FastAPI


@asynccontextmanager
async def lifespan(app: FastAPI):  # noqa: ANN201
    await connect_db()
    yield
    await disconnect_db()


app = FastAPI(lifespan=lifespan)


app.include_router(router)
