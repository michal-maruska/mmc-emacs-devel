
pkgname=mmc-emacs-devel
install=install
pkgdir=$(DESTDIR)/usr/share/emacs/site-lisp/$(pkgname)


# todo: compile!
all:


install:
	$(install) -d   $(pkgdir)
	$(install) *.el $(pkgdir)
	$(install) -d   $(pkgdir)/tempo
	$(install) tempo/*.el $(pkgdir)/tempo


clean:
