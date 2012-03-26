# A Makefile for building TeX documents and the Cornell thesis document class
#
include commondefs

DOC = sampleThesis
OUTPUTTYPE = pdf
TARGETS = cornell.cls cornell.$(OUTPUTTYPE) $(DOC).$(OUTPUTTYPE)

all: $(TARGETS)

# These following rules are a little crude but should work
cornell.cls: cornell.dtx
	latex cornell.ins
cornell.dvi: cornell.dtx
	latex cornell.dtx
	latex cornell.dtx
cornell.pdf: cornell.dvi
	pdflatex cornell.dtx

LDIRT = cornell.aux cornell.glo cornell.idx cornell.log

TEXS = $(DOC).tex cornell.cls
FIGS =
#
# List of postscript figures to be included

PDFFIGS = $(FIGS:.eps=.pdf)

BIBFILE = $(DOC).bib
#
# Ignore this if you're not using bibtex. Change the $(DOC) part if your bib
# file has a different name from your document

$(DOC).dvi: $(TEXS) $(FIGS) $(DOC).stamp      $(DOC).bbl $(BIBFILE)
$(DOC).pdf: $(TEXS) $(PDFFIGS) $(DOC).stamp   $(DOC).bbl $(BIBFILE)
#
# To use bibtex, add these to dependency list:
# $(DOC).bbl $(BIBFILE)
# 
# To use makeindex, add this to dependency list:
# $(DOC).ind
#
# To use glossaries, add this to dependency list:
# $(DOC).glo

$(DOC).bbl: $(BIBFILE) $(DOC).stamp
$(DOC).glo $(DOC).ind: $(DOC).stamp
$(DOC).ps: $(DOC).dvi $(FIGS)
#
# These are standard dependencies. Shouldn't need to modify these.

include $(COMMONRULES)
