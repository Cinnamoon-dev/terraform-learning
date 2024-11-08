# The variables file may have any name
# Since all .tf files are loaded anyway

variable "container_name" {
    description = "Value of the name for the Docker container"
    type = string
    default = "defaultContainerName"
}