.PHONY: web-entwicklung
web-entwicklung:
	home-manager switch --flake .#web-entwicklung

.PHONY: chatbook
chatbook:
	home-manager switch --flake .#jupyter-chatbook

.PHONY: desktop
desktop:
	home-manager switch --flake .#demo

.PHONY: clean
clean:
	nix-collect-garbage -d
