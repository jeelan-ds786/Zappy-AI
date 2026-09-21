PYTHON := .venv/bin/python
PYTHONPATH := .:packages/python:workers/content_ingestion:services/api
INDEX := data/index/chunks.json
DATASET := evaluations/datasets/part1_golden_queries.json
QUALITY_DATASET := evaluations/datasets/part4_quality_v1.json
CRAWL_MANIFEST := workers/content_ingestion/zappy_ingestion/crawler/configs/sky-public-manifest.json
CRAWL_POLICY := workers/content_ingestion/zappy_ingestion/crawler/configs/sky-public.json
CRAWL_REPORT := data/crawled/sky-public.json
INDEX_SOURCES = --source data/curated $(if $(wildcard $(CRAWL_REPORT)),--source data/crawled,)

.PHONY: bootstrap bootstrap-web index crawl-public refresh-public test evaluate lint typecheck audit web-test web-lint web-build web-audit web-check serve serve-mcp serve-mcp-smarthome serve-web check

bootstrap:
	python3.11 -m venv .venv
	$(PYTHON) -m pip install --upgrade "pip>=26.2" "setuptools>=83.0.0" wheel
	$(PYTHON) -m pip install -r requirements-dev.txt
	$(MAKE) bootstrap-web

bootstrap-web:
	pnpm --dir apps/web install

index:
	PYTHONPATH=$(PYTHONPATH) $(PYTHON) -m zappy_ingestion.main \
		$(INDEX_SOURCES) --output $(INDEX)

crawl-public:
	PYTHONPATH=$(PYTHONPATH) $(PYTHON) -m zappy_ingestion.crawl \
		--manifest $(CRAWL_MANIFEST) --policy $(CRAWL_POLICY) --output $(CRAWL_REPORT)

refresh-public: crawl-public index

test:
	PYTHONPATH=$(PYTHONPATH) $(PYTHON) -m pytest --cov --cov-report=term-missing

evaluate: index
	PYTHONPATH=$(PYTHONPATH) $(PYTHON) -m evaluations.grounding.evaluate \
		--index $(INDEX) --dataset $(DATASET) --output evaluations/results/part1.json
	PYTHONPATH=$(PYTHONPATH) $(PYTHON) -m evaluations.quality.evaluate \
		--dataset $(QUALITY_DATASET) --output evaluations/results/part4.json

lint:
	$(PYTHON) -m ruff check services workers packages evaluations tests

typecheck:
	PYTHONPATH=$(PYTHONPATH) $(PYTHON) -m pyright --pythonpath $(PYTHON)

audit:
	$(PYTHON) -m pip_audit --local --skip-editable

web-test:
	pnpm --dir apps/web test

web-lint:
	pnpm --dir apps/web lint

web-build:
	pnpm --dir apps/web build

web-audit:
	pnpm audit --audit-level high

web-check: web-audit web-lint web-test web-build

serve: index
	PYTHONPATH=$(PYTHONPATH) ZAPPY_RAG_INDEX_PATH=$(INDEX) \
		$(PYTHON) -m uvicorn app.main:app --reload --port 8000

serve-mcp: index
	PYTHONPATH=$(PYTHONPATH) ZAPPY_RAG_INDEX_PATH=$(INDEX) \
		$(PYTHON) -m app.mcp_server

serve-mcp-smarthome: index
	PYTHONPATH=$(PYTHONPATH):services/mcp/smarthome_protect \
		ZAPPY_RAG_INDEX_PATH=$(INDEX) \
		$(PYTHON) -m zappy_smarthome_protect_mcp.server

serve-web:
	pnpm --dir apps/web dev

check: lint typecheck audit test evaluate web-check
