OPENSCAD=openscad

SCAD=$(wildcard *.scad)
PNG=$(SCAD:.scad=.png)

all: $(PNG)
clean:
	@rm -f *.png

%.png: %.scad
	$(OPENSCAD) -o $@ --render $<


.PHONY: all clean
