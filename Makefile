DIRS= `find -maxdepth 1  -type d ! -wholename \*.svn\* | grep /`
PDF = $(addsuffix .pdf, $(basename $(wildcard *.eps)))

show: all

all: $(PDF) $(GNUPLOT) $(INKSCAPE) 
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	mv ./tmp/document.pdf .

evince:
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	mv ./tmp/document.pdf .
	evince document.pdf &> /dev/null

okular:
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	mv ./tmp/document.pdf .
	okular ./document.pdf 2> /dev/null

prepare:
	mkdir tmp

%.pdf: %.eps
	epstopdf $(basename $@).eps

clean:
	-rm -f ./tmp/*.bak ./tmp/*.aux ./tmp/*.log ./tmp/*.toc ./tmp/*.out ./tmp/*.nav ./tmp/*.snm ./tmp/*.bbl ./tmp/*.blg
	-rm -f ./tmp/*~	
	-rm -f ./tmp/*.pdf
	-rm -f *.pdf

all-evince: show
