variable "lines" {
  type        = number
  default     = 5
  description = "The number of lines to write to the output file. Defaults to 5."

  validation {
    condition     = var.lines > 0
    error_message = "Number of lines must be greater than 0."
  }
}

variable "words" {
  type        = number
  default     = 2
  description = "The number of words (in each line) to write to the output file. Defaults to 2."

  validation {
    condition     = var.words > 0
    error_message = "Number of words must be greater than 0."
  }
}

variable "filename" {
  type        = string
  description = "Name of the output file."
}
