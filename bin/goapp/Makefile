default: build-all

.PHONY: build-all
build-all: linux-intel mac-intel windows-intel

.PHONY: mac-intel
mac-intel:
	env GOOS=darwin GOARCH=386 go build -o checkout-mac
	chmod u+x checkout-mac

.PHONY: linux-intel
linux-intel:
	env GOOS=linux GOARCH=386 go build -o checkout-linux
	chmod u+x checkout-linux

.PHONY: windows-intel
windows-intel:
	env GOOS=windows GOARCH=386 go build -o checkout.exe
