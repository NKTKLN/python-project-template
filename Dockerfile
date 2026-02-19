# ===== Stage 1: Assembler =====
FROM python:3.13-slim AS builder

# Base python runtime env + uv settings + venv in /opt/venv
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_LINK_MODE=copy \
    UV_PROJECT_ENVIRONMENT=/opt/venv \
    PATH="/opt/venv/bin:$PATH"

WORKDIR /app

# Install uv binary (fast deps resolver/installer)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Copy only dependency manifests first (better layer cache)
COPY pyproject.toml uv.lock ./

# Create venv + install prod deps (locked, without dev)
RUN uv venv /opt/venv \
    && uv sync --frozen --no-dev

# Copy source code after deps to keep caching efficient
COPY . .

# Install your package into the venv (so `python -m app.main` works)
RUN uv pip install .

# ===== Stage 2: Final =====
FROM python:3.13-slim AS final

# Runtime python env; use the prebuilt venv binaries
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:$PATH"

# Runtime-only deps (keep image slim)
RUN apt-get update && apt-get install --no-install-recommends -y \
      curl \
    && rm -rf /var/lib/apt/lists/*

# Create unprivileged user (fixed UID/GID for k8s-friendly perms)
RUN groupadd -g 10000 shrimp && \
    useradd -m -u 10000 -g shrimp shrimp

WORKDIR /app

# Bring in venv + app from builder stage
COPY --from=builder /opt/venv /opt/venv
COPY --from=builder /app /app

# Fix ownership so non-root user can read/run everything
RUN chown -R shrimp:shrimp /app /opt/venv

USER shrimp

# Optional app port (e.g., streamlit default)
# EXPOSE 8501

# Optional healthcheck (uncomment if you want container-level health)
# HEALTHCHECK --interval=30s --timeout=10s --start-period=20s --retries=3 \
#   CMD curl --fail http://localhost:8501/_stcore/health || exit 1

# Run module as entrypoint; CMD left empty for optional args override
ENTRYPOINT ["python", "-m", "app.main"]
CMD [""]
