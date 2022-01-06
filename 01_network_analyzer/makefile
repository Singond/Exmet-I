# Copyright 2021 Radek Hornak, Jan Slany, Lukas Vrana

SHELL := /bin/bash
MAKEFLAGS += --no-builtin-rules
ifneq (,$(shell which latexmk 2> /dev/null))
	LATEX := latexmk --pdf
else
	LATEX := pdflatex
endif

PROJECT_NAME=Exmet-I-01
include ../basic.make

.PHONY: all
all: protokol.pdf

figs != find data -name data*.csv | sed -E 's/^data\/(.*).csv/plots\/\1.tex/'
figs += $(shell echo plots/results{03..05}-{s11,s21}{.eps,.tex})
figs += $(shell echo plots/results{12-l,12-z,13-c,13-z}{.eps,.tex})

tex_resources = makefile ${figs}

plots/data%.tex plots/data%.eps : load_data.m export_data.m \
octave/plot_sparam.m gnuplot/real.gp gnuplot/imag.gp
	@mkdir -p plots
	octave export_data.m

plots/results%.tex plots/results%.eps : load_data.m main.m export_results.m \
octave/plot_sparam.m gnuplot/real.gp gnuplot/imag.gp \
$(shell find gnuplot -name *.gp)
	@mkdir -p plots
	octave export_results.m

.PHONY: tex_resources
tex_resources: ${tex_resources}
	@mkdir -p build/plots
	@echo Successfully updated prerequisities for protokol.tex

protokol.pdf : protokol.tex references.bib ${tex_resources}
	TEXINPUTS=.:..: ${LATEX} protokol.tex

.PHONY: clean
clean:
	rm -rf plots
	rm -rf build
