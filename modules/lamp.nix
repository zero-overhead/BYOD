{ pkgs, ... }:
let
  myperl = pkgs.perl.withPackages(ps: [ 
	                           ps.CGI
	                           ps.XMLSimple 
	                          ]
	                     );
in
{
	# nix search pkg-name
	environment.systemPackages = with pkgs; [
	  adminer
	  php
	  mariadb
	];

	#server.document-root = "/srv/www";
	#save as index.html in document-root:
	#<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"\>\<html xmlns="http://www.w3.org/1999/xhtml"><head><title></title><meta http-equiv="refresh" content="0;url=http://127.0.0.1:8088/server-status" /></head><body></body></html>
    #sudo mkdir /srv/www && sudo nano /srv/www/index.html
	#status.status-url = "/server-status"
	#status.statistics-url = "/server-statistics"
	#status.config-url = "/server-config"

	services.lighttpd = {
	  enable = true;
	  port = 8088;
	  mod_userdir = true;
	  mod_status = true;
	  extraConfig = ''

	    alias.url += ( "/adminer/" => "${pkgs.adminer}/" )
	    
	    server.bind = "0.0.0.0"
	    server.dir-listing = "enable"	    
	    server.modules += ( "mod_cgi", "mod_alias", "mod_webdav", "mod_authn_file")

		cgi.assign                += ( ".pl"  => "${myperl}/bin/perl",
									   ".cgi" => "${myperl}/bin/perl",
									   ".rb"  => "/usr/bin/env ruby",
									   ".erb" => "/usr/bin/env eruby",
									   ".py"  => "/usr/bin/env python",
									   ".php" => "${pkgs.php}/bin/php-cgi" )

		index-file.names           +=( "index.pl",   "default.pl",
									   "index.rb",   "default.rb",
									   "index.erb",  "default.erb",
									   "index.py",   "default.py",
									   "index.php",  "default.php" )	    
	  '';
	};

	services.mysql = {
	  enable = true;
	  package = pkgs.mariadb;
	  settings.mysqld.bind-address = "0.0.0.0";
	  initialScript = ./lamp.sql;
	  #ensureUsers = [
	  #	  {
	  #		name = "demo";
	  #		ensurePermissions = {
	  #		  "*.*" = "ALL PRIVILEGES";
	  #		};
	  #	  }
	  #];
	};
}
