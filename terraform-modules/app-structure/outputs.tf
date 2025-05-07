output "services" {
  description = "Definition of all microservices in the application"
  value       = local.services
}

output "api_endpoints" {
  description = "API endpoints for API Gateway"
  value       = local.api_endpoints
}

output "gateway_paths" {
  description = "List of all paths to register in API Gateway"
  value       = [for api in local.api_endpoints : api.path]
}

output "service_names" {
  description = "Names of all services"
  value       = [for k, v in local.services : v.name]
}

output "public_services" {
  description = "Services that need public access"
  value       = [for k, v in local.services : v.name if v.has_public_access]
}