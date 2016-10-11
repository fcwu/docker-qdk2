
all: gitlab nginx redmine joomla

gitlab:
	cd gitlab && qdk2 build --qdk1 --build-dir build --build-arch x86_64

nginx:
	cd nginx && qdk2 build --qdk1 --build-dir build --build-arch x86_64

redmine:
	cd redmine && fakeroot /usr/share/qdk2/QDK/bin/qbuild --build-dir build

joomla:
	cd joomla && fakeroot /usr/share/qdk2/QDK/bin/qbuild --build-dir build


clean:
	sudo rm -f */build/*.qpkg

.PHONY: all clean gitlab nginx redmine joomla
