# Este módulo define recursos específicos de la aplicación

# Define los servicios que componen la aplicación
locals {
  services = {
    auth_api = {
      name         = "auth-api"
      port         = 8000
      has_public_access = true
      dependencies = ["users-api"]
      health_check_path = "/health"
      environment_variables = {
        AUTH_API_PORT     = "8000"
        USERS_API_ADDRESS = "http://users-api:8083"
      }
    },
    users_api = {
      name         = "users-api"
      port         = 8083
      has_public_access = false
      dependencies = []
      health_check_path = "/actuator/health"
      environment_variables = {
        SERVER_PORT = "8083"
      }
    },
    todos_api = {
      name         = "todos-api"
      port         = 8082
      has_public_access = true
      dependencies = ["redis"]
      health_check_path = "/health"
      environment_variables = {
        TODO_API_PORT = "8082"
        REDIS_HOST    = "redis"
        REDIS_PORT    = "6379"
        REDIS_CHANNEL = "log_channel"
      }
    },
    log_message_processor = {
      name         = "log-message-processor"
      port         = null
      has_public_access = false
      dependencies = ["redis"]
      health_check_path = null
      environment_variables = {
        REDIS_HOST    = "redis"
        REDIS_PORT    = "6379"
        REDIS_CHANNEL = "log_channel"
      }
    },
    frontend = {
      name         = "frontend"
      port         = 8080
      has_public_access = true
      dependencies = ["auth-api", "todos-api"]
      health_check_path = "/"
      environment_variables = {
        PORT = "8080"
      }
    }
  }
}

# API endpoints para el API Gateway
locals {
  api_endpoints = [
    {
      name         = "auth-api"
      display_name = "Authentication API"
      path         = "auth"
      backend_url  = "http://${var.backend_vm_ip}:8000"
      operations = [
        {
          name        = "login"
          display_name = "Login"
          method      = "POST"
          url_template = "/login"
          description = "User login operation"
        }
      ]
    },
    {
      name         = "todos-api"
      display_name = "TODOs API"
      path         = "todos"
      backend_url  = "http://${var.backend_vm_ip}:8082"
      operations = [
        {
          name        = "list-todos"
          display_name = "List TODOs"
          method      = "GET"
          url_template = "/todos"
          description = "Get all TODOs for the user"
        },
        {
          name        = "create-todo"
          display_name = "Create TODO"
          method      = "POST"
          url_template = "/todos"
          description = "Create a new TODO"
        },
        {
          name        = "delete-todo"
          display_name = "Delete TODO"
          method      = "DELETE"
          url_template = "/todos/{taskId}"
          description = "Delete a TODO by ID"
        }
      ]
    }
  ]
}