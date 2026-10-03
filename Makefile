.PHONY: dev build test lint clean install

install:
	pnpm install

dev:
	pnpm dev

build:
	pnpm build

test:
	pnpm test --run

lint:
	pnpm lint

clean:
	rm -rf node_modules dist .next .turbo
