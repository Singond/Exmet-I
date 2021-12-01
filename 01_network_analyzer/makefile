PROJECT_NAME=Exmet-I-01
include ../basic.make

.PHONY: all clean tex_resources
all: protokol.pdf

PLOTS != find data -name data*.csv | sed -E 's/^data\/(.*).csv/plots\/\1.tex/'
plots/data%.tex plots/data%.eps : main.m export.m real.gp imag.gp \
results-12-z.gp results-12-l.gp
	@mkdir -p plots
	octave export.m

tex_resources: makefile ${PLOTS}
	@mkdir -p build/plots
	@echo Successfully updated prerequisities for protokol.tex

protokol.pdf : protokol.tex tex_resources
	TEXINPUTS=.:..: pdflatex protokol.tex

clean:
	rm -rf plots
	rm -rf build
