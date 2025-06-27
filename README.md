# 🐍 Python Project Template

**python-project-template** is a starter template for Python projects with advanced setup for code quality tools, static analysis, formatting, documentation checks, and dependency security auditing.

This template includes configurations for `poetry`, `ruff`, `black`, `mypy`, `pylint`, `pre-commit`, and other popular tools, along with a ready-to-use `Taskfile.yml` for convenient task management.

## 📦 Dependencies

* [Python 3.12+](https://www.python.org/downloads/)
* [Poetry](https://python-poetry.org/docs/#installation)
* [Docker](https://docs.docker.com/get-docker/) (optional)
* [Task](https://taskfile.dev/) (optional)

## ⚙️ Configuration & Features

The project comes pre-configured with:

* Code formatting via `black`, `isort`, `ruff`
* Static code analysis using `ruff`, `mypy`, `pylint`
* Docstring style checks via `interrogate`
* Dead code detection with `vulture`
* Dependency vulnerability auditing using `pip-audit`
* Unused library checks via `deptry`
* `pre-commit` hooks setup for Git

All settings target Python 3.12+ with a max line length of 88 characters.

## 🛠️ Installation & Usage

### 💻 Local Setup

1. Make sure you have Python 3.12 or newer installed.

2. Install dependencies:

   ```bash
   poetry install --no-root
   ```

3. Install Git hooks via pre-commit:

   ```bash
   poetry run pre-commit install
   ```

4. Run the application (example module `app.main`):

   ```bash
   poetry run python -m app.main
   ```

### 🐳 Running with Docker

1. Build the Docker image:

   ```bash
   docker build -t python-app .
   ```

2. Run the container:

   ```bash
   docker run -it --rm python-app
   ```

### 🤖 Using Taskfile

To simplify project tasks, you can use the included `Taskfile.yml`:

* Install dependencies:

  ```bash
  task install
  ```

* Format code:

  ```bash
  task format
  ```

* Run linting and static analysis:

  ```bash
  task lint
  ```

* Check docstring style:

  ```bash
  task docstyle
  ```

* Find dead code:

  ```bash
  task deadcode
  ```

* Audit dependencies for vulnerabilities:

  ```bash
  task audit
  ```

* Run full check (formatting, linting, auditing, etc.):

  ```bash
  task check
  ```

* Run the application:

  ```bash
  task run
  ```

* Build and run Docker container:

  ```bash
  task docker
  ```

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
