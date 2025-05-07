variable "environment" {
  description = "Deployment environment (dev, test, prod)"
  type        = string
}

variable "backend_vm_ip" {
  description = "IP address of the backend VM"
  type        = string
  default     = ""
}

variable "frontend_vm_ip" {
  description = "IP address of the frontend VM"
  type        = string
  default     = ""
}