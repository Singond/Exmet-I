PROJECT_NAME=Exmet-I-{{cookiecutter.subproject_number}}
include ../basic.make

.PHONY: all clean tex_resources
all: tex_resources

tex_resources: makefile # List prerequisities for protokol.tex
	@mkdir -p build/plots
	@echo Successfully updated prerequisities for protokol.tex

clean:
	rm -rf plots
	rm -rf build

