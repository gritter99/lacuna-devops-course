variable "pgpassword" {
  description = "The password for the PostgreSQL database."
  type        = string
  sensitive   = true
  default     = "H@Sh1CoR3!"
}

variable "pgadmin" {
  description = "The administrator username for the PostgreSQL database."
  type        = string
  default     = "psqladmin"
}

variable "pgport" {
  description = "The port for the PostgreSQL database."
  type        = number
  default     = 5432
}