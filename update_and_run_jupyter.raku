#!/usr/bin/env raku
#usage: curl -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/update_and_run_jupyter.raku | raku -

my @commands = [
  'curl -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/fetch_BYOD.sh | bash -',
  'raku $HOME/BYOD/update_or_clone_teaching_git_repos.raku',
  'cd $HOME && $HOME/BYOD/jupyter.sh',
];

for @commands -> $cmd {
      shell $cmd;
}
