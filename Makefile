CC=coffee

all: PPGEditor.js

# coffeescript files

PPGEditor.js: PPGEditor.coffee
	$(CC) -cm PPGEditor.coffee

# cleanup

.PHONY: clean
clean:
	-rm PPGEditor.js
