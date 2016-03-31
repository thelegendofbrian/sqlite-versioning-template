echo "../../tools/sqlite3.exe ../../assets/itempatch.db .dump > ../../assets/itempatch_dump.sql & git add ../../assets/itempatch_dump.sql" > .git/hooks/pre-commit
echo "../../tools/sqlite3.exe ../../assets/itempatch.db < ../../assets/itempatch_dump.sql" > .git/hooks/post-merge
echo "../../tools/sqlite3.exe ../../assets/itempatch.db < ../../assets/itempatch_dump.sql" > .git/hooks/post-checkout