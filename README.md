# 🚀 FastAPI Project Template

This project is a template for developing FastAPI applications using modern tools to enhance code quality and streamline development. The project includes the following tools:

- **UV**: A fast and modern dependency manager and runtime for Python.
- **Pyright**: A static type checker for Python.
- **Ruff**: A tool for linting and code formatting.
- **Pytest**: A framework for writing and running tests.
- **Prisma**: An ORM for database interactions.

## 🛠️ Installation and Setup

### Installing Dependencies

To install all project dependencies, run:

```bash
make install
```

### Generating `.env` File

To generate a `.env` file with default settings, run:

```bash
make env
```

You can specify the application name using the `APP_NAME` variable:

```bash
make env APP_NAME="MyApp"
```

## 🚦 Running the Development Server

To start the server in development mode, use:

```bash
make dev
```

## 🔍 Code Linting and Formatting

### Linting Code

To lint your code using Ruff, run:

```bash
make lint
```

### Formatting Code

To format your code using Ruff, run:

```bash
make format
```

### Type Checking

To check types using Pyright, run:

```bash
make typecheck
```

## 🧪 Testing

To run tests using Pytest, execute:

```bash
make test
```

## 🗄️ Working with Prisma

### Generating Prisma Client

To generate the Prisma Client, run:

```bash
make prisma-gen
```

### Applying Migrations

To apply Prisma migrations, run:

```bash
make prisma-migrate
```

## 🧹 Utilities

### Cleaning Temporary Files

To remove temporary files, run:

```bash
make clean
```

### Running All Checks and Tests

To run all checks and tests, execute:

```bash
make all
```

### Creating a New Router

To create a new router, use:

```bash
make router NAME=<router_name>
```

## 📖 Help

To display help for all available commands, run:

```bash
make help
```

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **FastAPI** for the awesome web framework.
- **UV**, **Pyright**, **Ruff**, **Pytest**, and **Prisma** for their excellent tools.
- The open-source community for continuous inspiration and support.

---

Happy coding! 🎉
```
