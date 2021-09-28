PROJECTS := $(shell find . -maxdepth 1 -type d -regextype posix-egrep -regex '\./[0-9]{2}_.*' -printf '%P\n')
PDF_OUTPUT := $(PROJECTS:%=%.pdf)

.PHONY: pdf

# PDF output documents in top-level directory
pdf: ${PDF_OUTPUT}

${PDF_OUTPUT}: %.pdf: %/protokol.pdf
	ln -s "$^" "$@"
