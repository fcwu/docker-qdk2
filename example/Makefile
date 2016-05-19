.PHONY: all ghost gitlab redmine

all: ghost gitlab redmine

ghost:
	cd ghost && \
		fakeroot /usr/share/qdk2/QDK/bin/qbuild --build-dir build

gitlab:
	cd gitlab && \
		fakeroot /usr/share/qdk2/QDK/bin/qbuild --build-dir build

redmine:
	cd redmine && \
		fakeroot /usr/share/qdk2/QDK/bin/qbuild --build-dir build
