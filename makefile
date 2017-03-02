default: elm-build

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
project_root := $(dir $(mkfile_path))

elm-build:
	/usr/local/bin/elm-make $(project_root)src/Main.elm --output=$(project_root)index.html

css: elm-build
	/usr/local/bin/elm-css $(project_root)src/Stylesheets.elm --output=$(project_root)assets/styles/
