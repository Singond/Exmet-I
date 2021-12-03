MAKEFLAGS += --no-builtin-rules

PROJECT_NAME=Exmet-I-01
include ../basic.make

.PHONY: all clean tex_resources
all: protokol.pdf

figs != find data -name data*.csv | sed -E 's/^data\/(.*).csv/plots\/\1.tex/'
figs += $(shell echo plots/results{03..05}-{s11,s21}{.eps,.tex})
figs += $(shell echo plots/results{12-l,12-z,13-c,13-z}{.eps,.tex})

plots/data%.tex plots/data%.eps : load_data.m export_data.m \
octave/plot_sparam.m gnuplot/real.gp gnuplot/imag.gp
	@mkdir -p plots
	octave export_data.m

plots/results%.tex plots/results%.eps : load_data.m main.m export_results.m \
octave/plot_sparam.m gnuplot/real.gp gnuplot/imag.gp
	@mkdir -p plots
	octave export_results.m

tex_resources: makefile ${figs}
	@mkdir -p build/plots
	@echo Successfully updated prerequisities for protokol.tex

protokol.pdf : protokol.tex tex_resources
	TEXINPUTS=.:..: pdflatex protokol.tex

clean:
	rm -rf plots
	rm -rf build
