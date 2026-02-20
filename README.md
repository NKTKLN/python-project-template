# 🐍 Python Project Template

**python-project-template** is a starter template for Python projects with advanced setup for code quality tools, static analysis, formatting, testing, coverage control, dependency security auditing, and release automation.

This template uses modern tooling such as `uv`, `ruff`, `mypy`, `pytest`, `pre-commit`, `commitizen`, `hatchling` and `gitleaks`, along with a ready-to-use `Taskfile.yml` for convenient task management.

## 📦 Dependencies

* [Python 3.13+](https://www.python.org/downloads/)
* [uv](https://docs.astral.sh/uv/getting-started/installation/)
* [commitizen](https://commitizen-tools.github.io/commitizen/#installation)
* [Docker](https://docs.docker.com/get-docker/)
* [Task](https://taskfile.dev/)

## ⚙️ Configuration & Features

The project comes pre-configured with:

* Code formatting and linting via `ruff`
* Static type checking via `mypy`
* Testing with `pytest`
* Coverage reporting via `coverage`
* Security auditing via `pip-audit`
* Unused dependency detection via `deptry`
* Conventional commits & versioning via `commitizen`
* Git hooks via `pre-commit`
* Secret scanning via `gitleaks`
* Packaging with `hatchling`
* Dependency management via `uv`

All settings target **Python 3.13** with a max line length of 88 characters.

## 🛠️ Installation & Usage

### 💻 Local Setup

1. Make sure you have **Python 3.13 or newer** installed.

2. Sync dependencies (including dev group):

```bash
task sync
```

3. Install Git hooks:

```bash
task init
```

4. Run the application (example module `app.main`):

```bash
task run
```

## 🐳 Docker

Build image:

```bash
task docker-build
```

Run container:

```bash
task docker-run
```

Build and run:

```bash
task docker
```

## 🧪 Development Commands

Auto-fix lint issues and format code:

```bash
task fmt
```

Run Ruff and MyPy:

```bash
task lint
```

Tests with Coverage:

```bash
task test
```

Security audit:

```bash
task audit
```

Detect unused libraries:

```bash
task unused-libs
```

Full Quality Check:

```bash
task check
```

## 🚀 Release Management

Commit using Conventional Commits:

```bash
task cz-commit
```

Check commit messages:

```bash
task cz-check
```

Bump version and update changelog:

```bash
task cz-bump
```

Release (bump + push tags):

```bash
task release
```

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
