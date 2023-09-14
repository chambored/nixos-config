#!/run/current-system/sw/bin/bash

project_dir=~/Data/Personal/Projects/

if [[ ! -d $project_dir ]]; then
    echo "Project $1 does not exist."
    exit 1
fi

if [[ ! -f $project_dir/setup.sh ]]; then
    echo "The setup.sh script does not exist for $1."
    exit 1
fi

cd $project_dir
source setup.sh
