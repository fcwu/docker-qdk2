
all: gitlab nginx redmine joomla

gitlab:
	cd gitlab && /usr/share/qdk2/QDK/bin/qbuild --build-dir build --build-arch x86_64

nginx:
	cd nginx && /usr/share/qdk2/QDK/bin/qbuild --build-dir build --build-arch x86_64

redmine:
	cd redmine && /usr/share/qdk2/QDK/bin/qbuild --build-dir build --build-arch x86_64

joomla:
	cd joomla && /usr/share/qdk2/QDK/bin/qbuild --build-dir build --build-arch x86_64


clean:
	sudo rm -f */build/*.qpkg

.PHONY: all clean gitlab nginx redmine joomla
