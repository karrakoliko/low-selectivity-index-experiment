#!/bin/sh

ROWS_NUMBER=10000000

set -e

rm -f app.db

sqlite3 app.db <<EOF
PRAGMA cache_size = 0;

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    gender INT NOT NULL,
    name TEXT NOT NULL
);

WITH RECURSIVE cnt(x) AS (
    SELECT 1
    UNION ALL
    SELECT x + 1 FROM cnt WHERE x < $ROWS_NUMBER
)
INSERT INTO users(gender, name)
SELECT
    abs(random() % 2),
    'user' || x
FROM cnt;
EOF


echo
echo "=== QUERY PLAN WITHOUT INDEX ==="

sqlite3 app.db "
EXPLAIN QUERY PLAN
SELECT name
FROM users
WHERE gender = 1;
"

echo
echo "=== QUERY TIME WITHOUT INDEX ==="

time sqlite3 app.db "
SELECT name
FROM users
WHERE gender = 1;
" >/dev/null


echo
echo "=== CREATING INDEX ==="

sqlite3 app.db "
CREATE INDEX genderindex ON users(gender);
"

echo
echo "=== QUERY PLAN WITH INDEX ==="

sqlite3 app.db <<EOF
EXPLAIN QUERY PLAN
SELECT name
FROM users
WHERE gender = 1;
EOF

echo
echo "=== QUERY TIME WITH INDEX ==="

time sqlite3 app.db "
SELECT name
FROM users
WHERE gender = 1;
" >/dev/null
