OTF=build/Affine-Regular.otf

all: otf specimen
specimen: specimen.png
otf: $(OTF)

clean:
	@rm --force --recursive --verbose build specimen.png

build/%.otf: %.sfdir
	@mkdir --parents --verbose $(@D)
	fontforge -lang=ff -c 'Open($$1); Generate($$2)' '$<' '$@'

specimen.png: specimen/specimen.html specimen/render.mjs specimen/node_modules $(OTF)
	./specimen/render.mjs '$<' '$@'
	ect -keep '$@'

specimen/node_modules: specimen/yarn.lock
	@cd 'specimen' && yarn install --immutable
