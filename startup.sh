#!/bin/sh

# Enter the source directory to make sure the script runs where the user expects
cd "/home/site/wwwroot"

export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
if [ -z "$PORT" ]; then
                export PORT=8080
fi

echo Found tar.gz based node_modules.
extractionCommand="tar -xzf node_modules.tar.gz -C /node_modules"
echo "Removing existing modules directory from root..."
rm -fr /node_modules
mkdir -p /node_modules
echo Extracting modules...
$extractionCommand
export NODE_PATH="/node_modules":$NODE_PATH
export PATH=/node_modules/.bin:$PATH
if [ -d node_modules ]; then
    mv -f node_modules _del_node_modules || true
fi

if [ -d /node_modules ]; then
    ln -sfn /node_modules ./node_modules 
fi

echo "Done."
yarn run start
