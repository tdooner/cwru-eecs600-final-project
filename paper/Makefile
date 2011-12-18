final.pdf: final.bbl final.dvi
	dvipdfm final.dvi

final.dvi: final.aux
	latex final.tex

final.bbl: final.aux
	bibtex final

final.aux: final.tex
	latex final.tex
