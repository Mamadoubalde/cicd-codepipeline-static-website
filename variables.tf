variable "account_id" {
  description = "AWS Account ID"
}

variable "aws_region" {
  description = "AWS Region for the s3 bucket"
}

variable "app_name" {
  description = "Website project name"
}

variable "git_repository_owner" {
  description = "Github Repository Owner"
}

variable "git_repository_name" {
  description = "Project name on Github"
}

variable "git_repository_branch" {
  description = "Github Project Branch"
}

variable "access_key" {
  description = "AWS access key"
  type        = "string"
  default     = ""
}

variable "secret_key" {
  description = "AWS secret key"
  type        = "string"
  default     = ""
}

variable "env_name" {
  description = "Environment name string to be used for decisions and name generation. Appended to name_suffix to create full_suffix"
  type        = "string"
}

variable "source_repo" {
  description = "name of repo which holds this code"
  type        = "string"
}

variable "developer" {
  description = "name of developer who has written this code"
  type        = "string"
}
