.PHONY: all ghost gitlab redmine joomla

all: ghost gitlab redmine joomla

ghost:
	cd ghost && \
		fakeroot /usr/share/qdk2/QDK/bin/qbuild --build-dir build

gitlab:
	cd gitlab && \
		fakeroot /usr/share/qdk2/QDK/bin/qbuild --build-dir build

redmine:
	cd redmine && \
		fakeroot /usr/share/qdk2/QDK/bin/qbuild --build-dir build

joomla:
	cd joomla && \
		fakeroot /usr/share/qdk2/QDK/bin/qbuild --build-dir build
