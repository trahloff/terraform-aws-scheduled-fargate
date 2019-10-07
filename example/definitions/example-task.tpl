[
	{
		"name": "example",
		"image": "hello-world",
		"logConfiguration": {
			"logDriver": "awslogs",
			"options": {
				"awslogs-group": "${log_group}",
				"awslogs-region": "${log_region}",
				"awslogs-stream-prefix": "tmp"
			}
		}
	}
]
