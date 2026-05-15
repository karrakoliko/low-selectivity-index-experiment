.DEFAULT_GOAL:= run-experiment

run-experiment:
	docker build -q -t sqlite-exp .
	docker run --rm -v $(PWD):/app sqlite-exp