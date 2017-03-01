default: elm-build

elm-build:
	/usr/local/bin/elm-make src/Main.elm --output=index.html

css:
	/usr/local/bin/elm-css src/Stylesheets.elm --output assets/styles/