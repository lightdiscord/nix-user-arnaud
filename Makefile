.PHONY: lint fix-lint

lint:
	npx eclint check '**/*.nix'

fix-lint: lint
	npx eclint fix '**/*.nix'
