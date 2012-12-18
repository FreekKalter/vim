#!/usr/bin/env perl

use v5.12;
use Cwd;
use File::Spec;

my $script= qq{#!/bin/sh
SCRIPT_LOC=\$(readlink -f \$0)
SCRIPT_PATH=`dirname \$SCRIPT_LOC`
GIT_DIR="\$SCRIPT_PATH/.."

ln -f \$GIT_DIR/../.vim ~/.vim

echo "Links created"
};

for( qw(post-commit  post-merge) ){
    my $file = ".git/hooks/$_";
    open(my $dh, ">" , $file) or die "Can't open $file for writing";
    print $dh $script;
    `chmod +x $file`;
};
say "Hooks created";
