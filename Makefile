default: push
all: push
SRC = perrinet_curriculum-vitae
pdf: $(SRC).pdf $(SRC)-full.pdf $(SRC)-short.pdf perrinet_publications.pdf

LATEXMK = latexmk -pdf -pdflatex=lualatex
BIBTEX = bibtex -terse

$(SRC).pdf: $(SRC).tex
	$(LATEXMK) $(SRC).tex

push: pdf
	git commit -m "Build website" -a ; git push

# macros
%.pdf: %.tex
	$(LATEXMK) $<

%.pdf: %.svg
	$(INKSCAPE) --without-gui $< --export-pdf=$@

%.png: %.svg
	$(INKSCAPE) --without-gui $< --export-png=$@ -d 450

# cleaning macro
clean:
	rm -f *.dvi *.fls *.ilg *.ind *idx *.bcf *.run.xml *.dvi *.ps *.out *.log *.aux *.bbl *.blg  *.fdb_latexmk *.snm *.nav *.toc *.info *.synctex.gz*

touch:
	touch *.tex

.PHONY: clean
