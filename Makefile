.PHONY: help compile run-discovery purge-runs

help:
	@echo "weird-but-true — available targets:"
	@echo ""
	@echo "  compile        Recompile all .md workflows to .lock.yml via gh aw"
	@echo "  run-discovery  Manually trigger the content discovery workflow"
	@echo "  purge-runs     Delete completed workflow run history"

compile:
	gh aw compile \
		.github/workflows/discover-content.md

run-discovery:
	gh workflow run discover-content.md

purge-runs:
	gh run list --limit 100 --json databaseId --jq '.[].databaseId' \
		| xargs -I {} gh run delete {}
