#!/bin/bash

if [ ! -z $GITDIR ]; then
    # The script can be used as a git hook in project_dir/.git/hooks/post-commit
    # in this case the $GIT_DIR env variable will be set and you can use this to
    # navigate to the root of the project_dir to start linking.
    cd $GIT_DIR/..
else
    # If you have this file in the root of your prject_dir you can call it manualy
    # from the commandline to in that case the location of this script itself will
    # be used as the working directory.
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    cd $DIR
fi

ln -f .vimrc ~/.vimrc

echo "Links created"
