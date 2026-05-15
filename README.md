# SQLite Low-Selectivity Index Experiment

This experiment demonstrates that SQLite may choose an index on a low-selectivity column (`gender`) even when a full table scan might be faster.

The dataset contains:
- 10 million rows
- only 2 distinct `gender` values
- approximately 50% row match rate for `WHERE gender = 1`

The experiment compares:
- query plan with index
- query plan without index
- execution time with index
- execution time without index

## Usage

Run:

```bash
make
```

## Output

```
=== QUERY PLAN WITHOUT INDEX ===
QUERY PLAN
`--SCAN users

=== QUERY TIME WITHOUT INDEX ===
real    0m 1.26s
user    0m 1.10s
sys     0m 0.16s

=== CREATING INDEX ===

=== QUERY PLAN WITH INDEX ===
QUERY PLAN
`--SEARCH users USING INDEX genderindex (gender=?)

=== QUERY TIME WITH INDEX ===
real    0m 0.99s
user    0m 0.91s
sys     0m 0.07s
```
