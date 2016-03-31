@echo off

echo Installing pre-commit hook...
(
echo #!/bin/sh
echo "tools/sqlite3.exe" assets/itempatch.db .dump ^> assets/itempatch_dump.sql ^& git add assets/itempatch_dump.sql
) > .git/hooks/pre-commit

echo Installing post-merge hook...
(
echo #!/bin/sh
echo rm assets/itempatch.db
echo "tools/sqlite3.exe" assets/itempatch.db ^< assets/itempatch_dump.sql
) > .git/hooks/post-merge

echo Installing post-checkout hook...
(
echo #!/bin/sh
echo rm assets/itempatch.db
echo "tools/sqlite3.exe" assets/itempatch.db ^< assets/itempatch_dump.sql
) > .git/hooks/post-checkout

if exist .git/hooks/pre-commit (
    if exist .git/hooks/post-merge (
		if exist .git/hooks/post-checkout (
			echo Hooks installed successfully.
		)
	)
) else (
    echo Hooks were not installed successfully.
)

pause