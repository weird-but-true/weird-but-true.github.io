.DEFAULT_GOAL := help

.PHONY: help compile run-discovery copilot-token purge-runs

# Fine-grained PAT on personal account with Account Permissions > GitHub Copilot (read).
COPILOT_TOKEN_URL := https://github.com/settings/personal-access-tokens/new?name=weird-but-true%20Copilot&description=gh-aw%20engine%20token%20for%20weird-but-true.github.io&expires_in=90

compile:
	gh aw compile \
		.github/workflows/discover-content.md

run-discovery:
	gh workflow run "Discover Content"

copilot-token:
	@url='$(COPILOT_TOKEN_URL)'; \
	if command -v open >/dev/null 2>&1; then \
		open "$$url"; \
	elif command -v xdg-open >/dev/null 2>&1; then \
		xdg-open "$$url"; \
	else \
		printf '%s\n' "$$url"; \
	fi
	@echo ""
	@echo "1. Set resource owner to your personal account (not an org)"
	@echo "2. Under Account permissions, enable: GitHub Copilot → Read"
	@echo "3. Create the token, then add it as an org secret:"
	@echo ""
	@echo "  gh secret set COPILOT_GITHUB_TOKEN --org weird-but-true --visibility all"
	@echo ""
	@echo "Paste the token when prompted."

purge-runs:
	gh run list --limit 100 --json databaseId --jq '.[].databaseId' \
		| xargs -I {} gh run delete {}

help:
	@echo ""
	@echo "\033[2mWorkflows\033[0m"
	@echo "  \033[36mcompile\033[0m        Recompile .md workflows to .lock.yml via gh aw"
	@echo "  \033[36mrun-discovery\033[0m  Manually trigger content discovery workflow"
	@echo ""
	@echo "\033[2mSetup\033[0m"
	@echo "  \033[36mcopilot-token\033[0m  Open GitHub PAT form for Copilot engine access"
	@echo ""
	@echo "\033[2mMaintenance\033[0m"
	@echo "  \033[36mpurge-runs\033[0m     Delete completed workflow run history"
	@echo ""
