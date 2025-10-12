	  ensureUsers = [
        {
          # bound to localhost, uses system password
          name = "demo";
          ensurePermissions = {
            "*.*" = "ALL PRIVILEGES";
          };
        }
      ];


	    #fastcgi.server = ( 
		#	# Load-balance requests for this path...
		#	".php" => (
		#		# ... among the following FastCGI servers. The string naming each
		#		# server is just a label used in the logs to identify the server.
		#		"localhost" => ( 
		#			"bin-path" => "${pkgs.php}/bin/php-cgi",
		#			"socket" => "/tmp/php-fastcgi.sock",
		#			# breaks SCRIPT_FILENAME in a way that PHP can extract PATH_INFO
		#			# from it 
		#			"broken-scriptfilename" => "enable",
		#			# Launch (max-procs + (max-procs * PHP_FCGI_CHILDREN)) procs, where
		#			# max-procs are "watchers" and the rest are "workers". See:
		#			# https://wiki.lighttpd.net/frequentlyaskedquestions#How-many-php-CGI-processes-will-lighttpd-spawn 
		#			"max-procs" => "4", # default value
		#			"bin-environment" => (
		#				"PHP_FCGI_CHILDREN" => "1" # default value
		#			)
		#		)
		#	)   
		#)		
	  '';


	    server.modules += ( "mod_openssl" )
	    #$SERVER["socket"] == ":8089" {
		#								ssl.engine = "enable" 
		#								ssl.pemfile = "/root/.local/share/mkcert/rootCA.pem" 
		#}


  # nix-shell -p mkcert
  # sudo mkcert -install
  # sudo mkcert -CAROOT
  # sudo mkcert localhost 127.0.0.1 ::1
  # sudo mv localhost*.pem /root/.local/share/mkcert/
  # sudo chmod +x /root
  # security.pki.certificateFiles = [ /root/.local/share/mkcert/rootCA.pem ];



#	services.phpfpm.pools.mypool = {                                                                                                                                                                                                             
#	  user = "nobody";                                                                                                                                                                                                                           
#	  settings = {                                                                                                                                                                                                                               
#		"pm" = "dynamic";            
#		"listen.owner" = config.services.nginx.user;                                                                                                                                                                                                              
#		"pm.max_children" = 5;                                                                                                                                                                                                                   
#		"pm.start_servers" = 2;                                                                                                                                                                                                                  
#		"pm.min_spare_servers" = 1;                                                                                                                                                                                                              
#		"pm.max_spare_servers" = 3;                                                                                                                                                                                                              
#		"pm.max_requests" = 500;                                                                                                                                                                                                                 
#	  };                                                                                                                                                                                                                                         
#	};

#	services.httpd = {
#	  enable = true;
#	  enablePerl = true;
#	  enablePHP = true;
#	  adminAddr = "root@home.local";
#	  extraModules = [ "userdir" ];
#	  #extraConfig = builtins.readFile "${src}/apache.conf";
#	  virtualHosts."localhost" = {
#	    documentRoot = "${pkgs.httpd}/htdocs";
#
#		locations."/adminer/index.php" = {
#		  alias = "${pkgs.adminer}/adminer.php";
#		};
#
#	  };
#	};

#	services.nginx = {
#		enable = true;
#		recommendedProxySettings = true;
#        recommendedTlsSettings = true;
#        virtualHosts.localhost = {
#			locations."~ \\.php$".extraConfig = ''
#			  fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
#			  fastcgi_index index.php;
#			'';
#			locations."/" = {
#			  return = "200 '<html><body>It works</body></html>'";
#			  extraConfig = ''
#				default_type text/html;
#			  '';
#			};
#            locations."/adminer/index.php" = {
#				alias = "${pkgs.adminer}/adminer.php";
#			};
#		  };
#	};

