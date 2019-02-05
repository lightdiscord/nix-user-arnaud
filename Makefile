.PHONY: lint fix-lint

lint:
	npx eclint check '**/*.nix'

fix-lint:
	npx eclint fix '**/*.nix'
	npx eclint check '**/*.nix'
