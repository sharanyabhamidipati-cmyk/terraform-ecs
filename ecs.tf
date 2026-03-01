resource "aws_ecs_cluster" "this" {
  name = "demo-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.app_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name  = var.app_name
      image = var.image_url
      portMappings = [
        {
          containerPort = 8080
        }
      ]
    }
  ])
}
