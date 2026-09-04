# 🐍 Python Project Template

[![Python](https://img.shields.io/badge/Python-3.13+-3776AB?logo=python&logoColor=white)](https://www.python.org/downloads/)
[![Docker](https://img.shields.io/badge/Docker-multi--stage-2496ED?logo=docker&logoColor=white)](https://docs.docker.com/get-docker/)
[![Task](https://img.shields.io/badge/Task-runner-29BEB0?logo=task&logoColor=white)](https://taskfile.dev/)
[![uv](https://img.shields.io/badge/uv-managed-DE5FE9?logo=uv&logoColor=white)](https://docs.astral.sh/uv/)
[![Ruff](https://img.shields.io/badge/linting-ruff-D7FF64?logo=ruff&logoColor=black)](https://docs.astral.sh/ruff/)
[![Checked with mypy](https://img.shields.io/badge/mypy-checked-2A6DB2.svg)](https://mypy-lang.org/)
[![Tested with pytest](https://img.shields.io/badge/testing-pytest-0A9EDC?logo=pytest&logoColor=white)](https://docs.pytest.org/)
[![Coverage gate](https://img.shields.io/badge/coverage-90%25%20gate-0A9EDC)](https://coverage.readthedocs.io/)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-FAB040?logo=pre-commit&logoColor=black)](https://pre-commit.com/)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-FE5196?logo=conventionalcommits&logoColor=white)](https://www.conventionalcommits.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE.md)

**Python Project Template** is the starting point for a new Python project: a
`src/` package managed by `uv`, a quality gate wired from `ruff`, `mypy`,
`pytest` and `pip-audit`, a two-stage Docker build that ends up running as an
unprivileged user, and one `task` command for each of those so none of it has
to be remembered.

The design follows from what happens to a template after it is copied: **nobody
comes back to set it up properly later**. So the rules live in files git carries
rather than in instructions — the gate is a task, the commit format is a
`pre-commit` hook, secrets are scanned before they land, and the coverage floor
fails the build rather than appearing in a review comment. A project generated
from here inherits enforcement, not good intentions.

## 📦 Dependencies

* [Python 3.13+](https://www.python.org/downloads/) — the floor set in
  `pyproject.toml` and pinned for `uv` in `.python-version`
* [uv](https://docs.astral.sh/uv/getting-started/installation/) — environment
  and lock file
* [Task](https://taskfile.dev/) — every command below is a task
* [Docker](https://docs.docker.com/get-docker/) — only for the container build

Everything else, `ruff` and `commitizen` included, is in the `dev` dependency
group and arrives with the first sync. Nothing needs a global install.

## 🚀 Running

Create the project from this template (GitHub's **Use this template**, or a
clone), then set up the environment and the git hooks in one go:

```sh
task init
```

Run the example entry point:

```sh
task run
```

It prints a greeting from `src/app/main.py` — that module is the placeholder you
replace. Renaming the `app` package means changing it in four places:
`[project].name`, `[tool.hatch.build.targets.wheel].packages`,
`[tool.coverage.run].source` and `[tool.deptry].known_first_party`.

## 🧰 Tasks

`Taskfile.yml` is the interface to the project. `task --list` prints them all
with their descriptions; these are the ones worth knowing:

| Task | Does |
| --- | --- |
| `task init` | Sync dependencies, then install the git hooks |
| `task sync` | `uv sync --all-groups` |
| `task sync-frozen` | The same from the lock file, no resolution |
| `task fmt` | `ruff format`, then `ruff check --fix` |
| `task fmt-unsafe` | The same, allowing ruff's unsafe fixes |
| `task lint` | `ruff check`, format check, `mypy` |
| `task test` | `pytest` |
| `task test-cov` | `pytest` with coverage, terminal and XML reports |
| `task audit` | `pip-audit` against the installed set |
| `task unused-libs` | `deptry` — declared but unused, and undeclared imports |
| `task build` | `uv build` — wheel and sdist |
| `task check` | The full gate: lint, coverage, build, audit, unused-libs |
| `task ci` | What a pipeline runs: lint, coverage, build |
| `task ci-frozen` | `task ci` against locked versions |
| `task cz-commit` | Commit through commitizen's prompts |
| `task cz-check` | Validate commit messages |
| `task docker` | Build the image and run it |

`check` and `ci` differ on purpose. `ci` is the subset that runs reproducibly
from the lock file; `audit` and `unused-libs` reach for advisory data and
resolve imports, so they belong to the local gate rather than to a build that
should not fail for a reason unrelated to the change.

## 🔧 Configuration

Four files hold everything, and each owns one thing:

| File | Governs |
| --- | --- |
| `pyproject.toml` | Dependencies, build backend, and the configuration of ruff, mypy, coverage, deptry and commitizen |
| `Taskfile.yml` | Every command, and what the gate is composed of |
| `.pre-commit-config.yaml` | What runs at commit, commit-msg and pre-push |
| `Dockerfile` | The runtime image |

The settings that will actually be felt:

| Setting | Value | What it means |
| --- | --- | --- |
| `line-length` | `88` | Ruff formats and lints to it |
| `target-version` / `python_version` | `py313` | Rewrites and type checks assume 3.13 |
| ruff `select` | 16 rule families | Beyond the defaults: `S` (bandit), `D` (docstrings, Google convention), `PTH`, `TRY`, `PL`, `ARG`, `C90` |
| ruff `ignore` | `E203`, `D100` | `E203` conflicts with the formatter; `D100` drops the module-docstring requirement |
| coverage `fail_under` | `90` | Under 90% the coverage task exits non-zero |
| coverage `branch` | `true` | Branch coverage, not line coverage |
| mypy strictness | `disallow_untyped_defs`, `disallow_untyped_calls`, `disallow_any_unimported`, `warn_return_any`, `warn_unreachable` | Every definition is annotated, so docstrings need not repeat types |
| commitizen `major_version_zero` | `true` | A breaking change bumps the minor while the version is `0.x` |

Tests get their own ruff exemptions (`S101` for `assert`, `D` for docstrings,
`PLR2004` for magic values), because the rules that keep source code honest are
noise in a test file.

`.claude/` is excluded from ruff, mypy and deptry. The Python under it is
vendored agent tooling written to other people's conventions, and linting it
would fail the gate on code this project does not own.

## 🪝 Git hooks

`pre-commit` runs with `fail_fast: true`, so the first failing hook stops the
commit instead of producing a wall of unrelated output.

| Stage | Hooks |
| --- | --- |
| `pre-commit` | `ruff --fix`, `ruff-format`, `uv-lock` (when `pyproject.toml` or `uv.lock` changed), YAML and TOML checks, end-of-file and trailing-whitespace fixers, large-file and merge-conflict guards, `gitleaks` |
| `commit-msg` | `commitizen` — the message must be Conventional Commits |
| `pre-push` | `commitizen-branch` — validates the messages on the branch |

`gitleaks` runs on every commit rather than in a pipeline because a secret that
reaches the remote has to be rotated, not reverted.

## 🧪 Tests

```sh
task test-cov
```

One test ships, covering the example entry point, and it exists so the gate is
green from the first commit: a template that arrives with a failing command
teaches you to ignore that command. Coverage is 100% of two statements, which
proves nothing about your code and everything about the wiring — pytest finds
the package, coverage measures the right one, and the 90% floor is enforced.

`pytest` is configured through `pyproject.toml`, coverage is measured on the
`app` package with branch coverage, and `task test-cov` writes `coverage.xml`
for anything that wants to consume it. The `if __name__ == "__main__":` guard is
in `exclude_also`, since no test can reach a line that only runs when the module
is the program.

## 🐳 Docker

```sh
task docker
```

The build is two-stage. The builder installs `uv`, resolves from `uv.lock` with
`--frozen --no-dev`, and creates the environment in `/opt/venv`; the final stage
copies that environment into a fresh `python:3.13-slim` and never carries the
resolver, the dev group or the build cache into the image.

Dependency manifests are copied before the source, so editing code reuses the
install layer instead of resolving again. The container runs as `shrimp`, a
non-root user with a fixed UID and GID of `10000` — fixed rather than
auto-assigned so a mounted volume has predictable ownership under Kubernetes.
`ENTRYPOINT` is `python -m app.main`, with `CMD` left empty for arguments.

An `EXPOSE` line and a `HEALTHCHECK` are present but commented out, since what
they should point at depends on the service you build.

## 🤖 Agent setup

`.claude/` is committed, so a project made from this template inherits the same
agent behaviour rather than being configured again by hand:

| Path | What it is |
| --- | --- |
| `.claude/settings.json` | A `PreToolUse` hook on `Bash`, plus the enabled plugins |
| `.claude/scripts/guard-commit.sh` | Refuses a commit that carries AI attribution, a message body, or `-F/--file` |
| `.claude/scripts/git-commit.sh` | The safe wrapper: validates the `type(scope): subject` shape, neutralises `commit.template`, then re-reads the stored message and strips anything a hook injected |
| `.claude/skills/` | Project skills, `commit` and `docstrings` among them |

The guard exists because the failure it prevents is invisible: a signature or a
body added by a template or a hook is only noticed once it is in the history,
where removing it means a rewrite.

## 📁 Source layout

```
src/app/
  __init__.py           makes app a real package, not a namespace one
  main.py               entry point; task run calls it as python -m app.main
tests/
  test_main.py          the one test that keeps the coverage gate green
.claude/                agent configuration: commit guard, wrapper, skills
Dockerfile              two-stage build, non-root runtime
Taskfile.yml            every command, and the composition of the gate
pyproject.toml          dependencies plus the whole tool configuration
.pre-commit-config.yaml what runs at commit, commit-msg and pre-push
```

## 📜 License

This project is licensed under the MIT License. See the
[LICENSE](./LICENSE.md) file for details.
