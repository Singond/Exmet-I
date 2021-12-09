PROJECT_NAME=Exmet-I-02
include ../basic.make

.PHONY: all clean tex_resources
all: tex_resources

results/slice.png: export_imgslice.m imgslice.m load_data.m
	@mkdir -p results
	octave export_imgslice.m

tex_resources: makefile results/slice.png
	@mkdir -p build/plots
	@echo Successfully updated prerequisities for protokol.tex

clean:
	rm -rf plots
	rm -rf build

