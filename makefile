default: elm-build

elm-build:
	elm-make src/Main.elm --output=index.html

css:
	elm css src/Stylesheets.elm --output assets/styles/