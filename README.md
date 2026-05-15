# SQLite Low-Selectivity Index Experiment

This experiment demonstrates that SQLite may choose an index on a low-selectivity column (`gender`) even when a full table scan is faster.

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