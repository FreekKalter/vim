#!/usr/bin/env perl

use v5.12;
use Cwd;
use File::Spec;

my $script= qq{#!/bin/sh
SCRIPT_LOC=\$(readlink -f \$0)
SCRIPT_PATH=`dirname \$SCRIPT_LOC`
GIT_DIR="\$SCRIPT_PATH/.."

ln -f \$GIT_DIR/../.vimrc ~/.vimrc

echo "Links created"
};

for( qw(post-commit  post-merge) ){
    my $file = ".git/hooks/$_";
    open(my $dh, ">" , $file) or die "Can't open $file for writing: $!";
    print $dh $script;
    close($dh);
    system("chmod", "+x", $file) == 0 or die "Can't change permission for $file: $?";
};
say "Hooks created";

system(".git/hooks/post-commit") ==0 or die "Can't execute post-commit hook: $?";
