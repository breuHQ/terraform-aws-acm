variable domain_name {
  description = "A domain name for which the certificate should be issued"
  type        = string
}

variable subject_alternative_names {
  description = "a list of alternative DNS names against which the certificate is required, cannot be used with `is_wildcard`"
  type        = list
  default     = []
}

variable is_wildcard {
  description = "if the certificate to be create is a wildcard certificate, cannot be used with `subject_alternative_names`"
  type        = bool
  default     = false
}
