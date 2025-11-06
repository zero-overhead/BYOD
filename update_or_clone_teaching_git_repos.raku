#!/usr/bin/env raku

##################################################
# repo setup - what pupils need
# auth token for repos must be environment variables (export TOKEN_NAME=....) 
# have the same name as the repo, except all upper case and all - replaced by _
my %repos =
  'edu-public-jupyter-notebooks' => {
    url => "github.com",
    user => "rcmlz",
    private => False
  },
  'python-course' => {
    url => "github.com",
    user => "zero-overhead",
    private => False
  },
  'inf-schule.de' => {
    url => "github.com",
    user => "zero-overhead",
    private => False,
    extra_init_cmd => ( 
                'git config --global advice.ignoredHook false',
                'git config --global http.postBuffer 157286400'
    ),
    extra_post-clone_cmd => ( 
                'git lfs install'
    )
  }
;

##################################################
# Folder setup
my $HOME = %*ENV<HOME>;
my $DOCUMENTS = $HOME.IO.add("Documents").e 
                  ?? $HOME.IO.add("Documents")
                  !! $HOME.IO.add("Dokumente").e 
                      ?? $HOME.IO.add("Dokumente")
                      !! $HOME.IO;

if $DOCUMENTS ne $HOME.IO {
  $DOCUMENTS = $DOCUMENTS.add("Informatik");
  mkdir $DOCUMENTS unless $DOCUMENTS.e;
}

##################################################
# init or update repos
for %repos.kv -> $repo, %details {
  my $repo-dir = $DOCUMENTS.add($repo);

  if $repo-dir.e {
    my $ts = DateTime.now( :formatter(-> $d { sprintf '%04d-%02d-%02d-%02d-%02d-%02d',
                            $d.year, $d.month, $d.day, $d.hour, $d.minute, $d.whole-second }));
    note "update repo $repo-dir at $ts";
    my $cmd-backup = ( 
                'git config user.email "demo@byod.com"',
                'git config user.name "demo"',
                "git checkout -b backup-main-$ts",
                'git add -A',
                'git commit -m"Backup before reset"',
                'git checkout main',
    ).join(" ; "); # execute next command even when previous command was unsuccessfull
    my $cmd-reset = ( 
                'git fetch origin',
                'git reset --hard origin/main',
                'git submodule update --remote --merge'
    ).join(" && "); # execute next command only when previous command was successfull
    
    #note $cmd-backup;
    #note $cmd-reset;
    
    indir $repo-dir, {
      shell $cmd-backup;
      shell $cmd-reset;
    }, w => True;
  } else {
    my $token-name = $repo.uc.subst("-", "_", :g);
    my $token-value = %*ENV{$token-name};
    
    if not $token-value and %details<private> {
      note "auth token: $token-name is missing";
      note "set it with: export $token-name=....";
      last
    }

    note "init repo $repo-dir ";
    
    my $auth = $token-value ~~ Str ?? $token-value ~ "@" !! "";
    my $url = join "/", ("https:/", $auth ~ %details<url>, %details<user>, $repo);
    my @extra-cmd = |%details<extra_init_cmd> if %details<extra_init_cmd>:exists;
    my $cmd-init = ( 
                "git clone --depth 1 --recurse-submodules $url",
                |@extra-cmd
    ).join(" && "); # execute next command only when previous command was successfull
    
    my @extra-post-clone-cmd = |%details<extra_post-clone_cmd> if %details<extra_post-clone_cmd>:exists;
    my $cmd-post-clone = ( 
                "cd $repo-dir",
                |@extra-post-clone-cmd
    ).join(" && "); # execute next command only when previous command was successfull
    
    #note $cmd;
    
    indir $DOCUMENTS, {
      shell $cmd-init;
      shell $cmd-post-clone;
    }, w => True;
  }
}
