# Titanic MLOps — Spark + MLflow + DVC + FastAPI

This repo implements a production-style pipeline on the Titanic dataset using Spark for preprocessing/training, DVC for data & pipeline versioning, MLflow for experiment tracking & model registry, and FastAPI for serving.

## Running locally (no Docker)
See Quickstart in the project doc; Spark runs in local mode.

## Pipeline
- `dvc repro` runs: preprocess → train → evaluate → register.
- MLflow logs parameters, metrics (AUC/accuracy), artifacts (plots) and registers the best model under `titanic_spark`.

## API

> Note: The API container is Java-free. You only need Java 8 for local Spark jobs.
- Loads the **Production** model from MLflow registry and exposes `/predict`.
- `tests/test_api.py` sends a sample request.

## Drift & Auto-retrain
- `src/drift/drift_detection.py` computes per-feature KS statistics vs reference; if drift score > threshold, triggers `dvc repro`.

## Optional Docker (for API only)
- `src/deploy/Dockerfile` builds a small image to serve the API. Not required to run locally.