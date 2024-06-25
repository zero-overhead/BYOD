.PHONY: web-entwicklung
student:
	home-manager switch --flake .#web-entwicklung

.PHONY: jupyter-chatbook
desktop:
	home-manager switch --flake .#jupyter-chatbook

.PHONY: desktop
desktop:
	home-manager switch --flake .#demo

.PHONY: clean
clean:
	nix-collect-garbage -d
