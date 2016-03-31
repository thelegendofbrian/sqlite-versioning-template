File system:
	database.db
	database_dump.sql

Summary:
	Edit database.db, but only commit database_dump.sql

.gitignore
	database.db

Git hooks:
	post-checkout hook:
		- Create database.db from database_dump.sql
	pre-commit hook:
		- Dump database.db into database_dump.sql
		- git add database_dump.sql
	post-merge hook:
		- Merge database.db from database_dump.sql to keep it up to date

Timeline:
	- Clone repo
	- Install hooks
	- Create database.db from database_dump.sql
	- Edit database.db
	- Commit changes (Wouldn't there be no changes if you only edited database.db? "The pre-commit hook is run first, before you even type in a commit message.")