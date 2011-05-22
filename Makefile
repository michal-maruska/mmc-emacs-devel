
pkgname=mmc-emacs-devel
install=install
pkgdir=$(DESTDIR)/usr/share/emacs/site-lisp/$(pkgname)


all:


install:
	$(install) -d   $(pkgdir)
	$(install) --mode=444 *.el $(pkgdir)
	$(install) -d   $(pkgdir)/tempo
	$(install) --mode=444 tempo/*.el $(pkgdir)/tempo


clean:
