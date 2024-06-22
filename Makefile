.PHONY: web-entwicklung
student:
	home-manager switch --flake .#web-entwicklung

.PHONY: desktop
desktop:
	home-manager switch --flake .#demo

.PHONY: clean
clean:
	nix-collect-garbage -d
