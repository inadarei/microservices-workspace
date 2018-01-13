default: build-all

.PHONY: build-all
build-all: linux-intel mac-intel windows-intel

.PHONY: mac-intel
mac-intel:
	env GOOS=darwin GOARCH=386 go build -o build/checkout-mac
	chmod u+x build/checkout-mac

.PHONY: linux-intel
linux-intel:
	env GOOS=linux GOARCH=386 go build -o build/checkout-linux
	chmod u+x build/checkout-linux

.PHONY: windows-intel
windows-intel:
	env GOOS=windows GOARCH=386 go build -o build/checkout.exe
