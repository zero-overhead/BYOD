{ pkgs, ... }:

{
  # ollama run gemma3:270m
  services.ollama = {
    enable = true;
    #package = pkgs.ollama-cuda;
    # acceleration = null;    
    #if nixpkgs.config.rocmSupport is enabled, uses "rocm"
    #if nixpkgs.config.cudaSupport is enabled, uses "cuda"
    # or hardcode via
    #acceleration = "cuda"; # Or "rocm"
    
    environmentVariables = {
      OLLAMA_HOST = "0.0.0.0:11434"; # Make Ollama accessable outside of localhost
      OLLAMA_ORIGINS = "*";
	  
	    # allow the GPU to use system RAM when it runs out of VRAM
	    GGML_CUDA_ENABLE_UNIFIED_MEMORY = "1";
	  
      # Conservative memory settings
      # Limit the number of parallel requests
      OLLAMA_NUM_PARALLEL = "1";
      # Limit the number of loaded models - all consume full RAM
      OLLAMA_MAX_LOADED_MODELS = "1";
      # free unused models after this time
      OLLAMA_KEEP_ALIVE = "60m";

      # Always schedule model across all GPUs
	    #OLLAMA_SCHED_SPREAD = "1";
	  
      # deactivate GPUs as we get errors
      #CUDA_VISIBLE_DEVICES = "-1";
      #CUDA_VISIBLE_DEVICES = "0,1";
      #OLLAMA_GPU_OVERHEAD = "2147483648";  # GB overhead
	    #OLLAMA_NUM_PARALLEL = "1";
      
      # Enable experimental Intel GPU detection
      #OLLAMA_INTEL_GPU = "1";
      
      # Enable debug mode
  	  #OLLAMA_DEBUG = "1";

	    # Verbose logging
	    #OLLAMA_VERBOSE = "1";

	    # Performance metrics
	    #OLLAMA_METRICS = "1";
	};
        
    # Optional: preload models, see https://ollama.com/library
    #loadModels = [ "gpt-oss:20b" "llama3.2:3b" "deepseek-r1:8b" "gemma3:4b"];
    #loadModels = [ "deepseek-r1:8b" ];
  };
}
