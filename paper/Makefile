all: final.bbl
	pdflatex final.tex
	pdflatex final.tex

final.bbl: final.aux
	bibtex final

final.aux: final.tex
	latex final.tex
