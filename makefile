default: elm-build

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
project_root := $(dir $(mkfile_path))

elm-build:
	npx webpack

css: elm-build
	npx elm-css $(project_root)src/Stylesheets.elm --output=$(project_root)src/assets/styles/

build-prod:
	rm -rf dist && npx webpack && touch dist/Staticfile

deploy:
	cd dist && cf push lutra -m 64M

dev-server:
	npm start
