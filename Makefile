default: pdf 
all: pdf
SRC = perrinet_curriculum-vitae
pdf: $(SRC).pdf $(SRC)-full_fr.pdf $(SRC)-full_en.pdf $(SRC)-short.pdf $(SRC)-short_fr.pdf perrinet_publications.pdf

LATEXMK = latexmk -pdf -pdflatex=lualatex
BIBTEX = bibtex -terse
BIB = LaurentPerrinet_publications.bib LaurentPerrinet_talks.bib

$(SRC).pdf: $(SRC).tex $(BIB)
	$(LATEXMK) $(SRC).tex

# the generic rule below only depends on the .tex file: declare the .bib files
# these documents cite, otherwise editing a reference never triggers a rebuild
$(SRC)-full_fr.pdf $(SRC)-full_en.pdf $(SRC)-short.pdf $(SRC)-short_fr.pdf perrinet_publications.pdf: $(BIB)

push: pdf $(BIB)
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
	rm -f *.dvi *.fls *.ilg *.ind *.idx *.bcf *.run.xml *.dvi *.ps *.out *.log *.aux *.bbl *.blg  *.fdb_latexmk *.snm *.nav *.toc *.info *.synctex.gz* *.bbl-SAVE-ERROR

touch:
	touch *.tex

.PHONY: default all pdf push clean touch
