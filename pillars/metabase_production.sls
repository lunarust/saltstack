DBTYPE: postgres
DBHOST: 127.0.0.1
DBPORT: 5432
DBNAME: metabase_production
DBUSER: mb_sandbox
DBPASS: mbsandbox

DOCKERMBPORT: 3070
NGINXMBPORT: 3001

MB_DB_USER_FILE: /run/secrets/db_user
MB_DB_PASS_FILE: /run/secrets/db_password

production: true