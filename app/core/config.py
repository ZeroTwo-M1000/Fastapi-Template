from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    app_name: str = ""
    debug: bool = False
    database_url: str = "file:database.db"

    model_config = {
        "env_file": ".env",
        "env_file_encoding": "utf-8",
    }


settings = Settings()
