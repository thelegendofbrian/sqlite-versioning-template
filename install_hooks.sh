#!/bin/bash

echo Installing pre-commit hook...
{
cat > .git/hooks/pre-commit <<EOL
#!/bin/sh
sqlite3 assets/itempatch.db .dump > assets/itempatch_dump.sql
git add assets/itempatch_dump.sql
EOL
cat .git/hooks/pre-commit
} &> /dev/null

echo Installing post-merge hook...
{
cat > .git/hooks/post-merge <<EOL
#!/bin/sh
rm assets/itempatch.db
sqlite3 assets/itempatch.db < assets/itempatch_dump.sql
EOL
cat .git/hooks/post-merge
} &> /dev/null

echo Installing post-checkout hook...
{
cat > .git/hooks/post-checkout <<EOL
#!/bin/sh
rm assets/itempatch.db
sqlite3 assets/itempatch.db < assets/itempatch_dump.sql
EOL
cat .git/hooks/post-checkout
} &> /dev/null

chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/post-merge
chmod +x .git/hooks/post-checkout

if [ \( -x .git/hooks/pre-commit \) -a \( -x .git/hooks/post-merge \) -a \( -x .git/hooks/post-checkout \) ]
then
	echo "Hooks installed successfully."
else
	echo "Hooks were not installed successfully."
fi

