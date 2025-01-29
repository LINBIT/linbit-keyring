REL=linbit-keyring-$(VERSION)

all: output/keyrings/linbit-keyring.gpg output/keyrings/linbit-keyring.asc output/sha512sums.txt output/README

output/keyrings/linbit-keyring.%: linbit-keyring-gpg/0x*.%
	cat $^ > $@

output/keyrings/emeritus-keyring.%: emeritus-keyring-gpg/0x*.%
	cat $^ > $@

output/sha512sums.txt: output/keyrings/linbit-keyring.gpg output/keyrings/linbit-keyring.asc
	cd output; sha512sum keyrings/* > sha512sums.txt

output/README: README
	cp README output/

clean:
	rm -f output/keyrings/*.gpg output/keyrings/*.asc output/sha512sums.txt output/README output/keyrings/*~

ifndef VERSION
debrelease:
	$(error environment variable VERSION is not set)
else
debrelease: clean
	dh_clean
	ln -s . $(REL) || true
	tar --owner=0 --group=0 -czvf $(REL).tar.gz \
		$(REL)/Makefile \
		$(REL)/README \
		$(REL)/LICENSE \
		$(REL)/linbit-keyring-gpg \
		$(REL)/emeritus-keyring-gpg \
		$(REL)/output/keyrings/.placeholder \
		$(REL)/linbit-keyring.spec \
		$(REL)/debian
	if test -L "$(REL)"; then rm $(REL); fi
endif
