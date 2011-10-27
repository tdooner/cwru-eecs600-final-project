proposal.pdf: proposal.aux proposal.blg
	pdflatex proposal.tex

proposal.blg: citations.bib proposal.aux
	bibtex proposal

proposal.aux: proposal.tex
	latex proposal.tex
