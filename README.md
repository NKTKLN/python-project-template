# 🐍 Python Project Template

[![Python](https://img.shields.io/badge/python-3.13+-3776AB?logo=python&logoColor=white)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE.md)
[![uv](https://img.shields.io/badge/uv-managed-261230?logo=uv&logoColor=white)](https://docs.astral.sh/uv/)
[![Ruff](https://img.shields.io/badge/linting-ruff-D7FF64?logo=ruff&logoColor=black)](https://docs.astral.sh/ruff/)
[![Checked with mypy](https://img.shields.io/badge/mypy-checked-2A6DB2.svg)](https://mypy-lang.org/)
[![Tested with pytest](https://img.shields.io/badge/testing-pytest-0A9EDC?logo=pytest&logoColor=white)](https://docs.pytest.org/)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-FAB040?logo=pre-commit&logoColor=black)](https://pre-commit.com/)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-FE5196?logo=conventionalcommits&logoColor=white)](https://www.conventionalcommits.org/)

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

This project is licensed under the MIT License. See the [LICENSE](./LICENSE.md) file for details.
