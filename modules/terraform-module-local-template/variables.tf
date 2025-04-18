variable "lines" {
  type        = number
  description = "The number of lines to write to the output file"
  default     = 5

  validation {
    condition     = var.lines > 0
    error_message = "Number of lines must be greater than 0"
  }
}

variable "words" {
  type        = number
  description = "The number of words (in each line) to write to the output file"
  default     = 2

  validation {
    condition     = var.words > 0
    error_message = "Number of words must be greater than 0"
  }
}

variable "filename" {
  type        = string
  description = "Name of the output file"
}

variable "environment" {
  type        = string
  description = "Environment / stage to provision ('dev' or 'prod')"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'"
  }
}
