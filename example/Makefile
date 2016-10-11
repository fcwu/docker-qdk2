
all: gitlab nginx redmine joomla

gitlab:
	cd gitlab && qdk2 build --qdk1 --build-dir build --build-arch x86_64

nginx:
	cd nginx && qdk2 build --qdk1 --build-dir build --build-arch x86_64

redmine:
	cd redmine && qdk2 build --qdk1 --build-dir build --build-arch x86_64

joomla:
	cd joomla && qdk2 build --qdk1 --build-dir build --build-arch x86_64


clean:
	sudo rm -f */build/*.qpkg

.PHONY: all clean gitlab nginx redmine joomla
