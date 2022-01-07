PROJECT_NAME=Exmet-I-02
include ../basic.make

MAKEFLAGS += --no-builtin-rules
ifneq (,$(shell which latexmk 2> /dev/null))
	LATEX := latexmk --pdf
else
	LATEX := pdflatex
endif

results/slice.png: export_imgslice.m imgslice.m load_data.m
	@mkdir -p results
	octave export_imgslice.m

.PHONY: all
all: protokol.pdf

tex_resources = build/plots results/slice.png

build/plots:
	mkdir -p build/plots

.PHONY: tex_resources
tex_resources: makefile ${tex_resources}
	@echo Successfully updated prerequisities for protokol.tex

protokol.pdf : protokol.tex ${tex_resources}
	TEXINPUTS=.:..: ${LATEX} protokol.tex && touch protokol.pdf

.PHONY: clean
clean:
	rm -rf plots
	rm -rf build
