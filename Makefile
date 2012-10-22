# Replace this name with the name of the main tex file, sans ".tex"
BASEFILE = scopatz_sme

DESCFILES = $(BASEFILE).tex

OUTPUT = $(BASEFILE).pdf

OPTS = -halt-on-error

# all: $(OUTPUT)
all: all-via-dvi

$(BASEFILE).pdf: $(BASEFILE).tex
	env TEXINPUTS=${TEXINPUTS}:..: pdflatex $(OPTS) $(BASEFILE).tex
	bibtex $(BASEFILE).aux
	pdflatex $(OPTS) $(BASEFILE).tex
	pdflatex $(OPTS) $(BASEFILE).tex

clean:
	rm -f *.pdf *.dvi *.toc *.aux *.out *.log *.bbl *.blg *.log *.spl *~ *.spl *.zip

realclean: clean
	rm -rf $(BASEFILE).dvi
	rm -f $(OUTPUT)

%.ps :%.eps
	convert $< $@

%.png :%.eps
	convert $< $@

all-via-dvi:
	latex $(OPTS) $(BASEFILE)
	#bibtex $(BASEFILE).aux
	latex $(OPTS) $(BASEFILE)
	latex $(OPTS) $(BASEFILE)
	dvipdf $(BASEFILE)

zip:
	zip paper.zip *.tex *.eps *.bib
