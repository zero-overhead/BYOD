{ pkgs, ... }:

{
  # we assume you run in Virtual Box and Ollama runs on the Host - whih is also the gateway
	services.open-webui = {
	  enable = true;
	  port = 8080;
      host = "0.0.0.0"; # Make Open-WebUI accessible outside of localhost
	  openFirewall = true;
	  environment = {
		ANONYMIZED_TELEMETRY = "False";
		DO_NOT_TRACK = "True";
		SCARF_NO_ANALYTICS = "True";
		OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
		OLLAMA_BASE_URL = "http://127.0.0.1:11434";
	  };
	};
}
