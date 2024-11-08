# terraform-learning
A minimal Terraform application to learn how to use it and apply in projects later.

### How to use environment variables
Create a `variables.tf` file and then declare the variable. The file may have any name because all `.tf` files are loaded when calling `terraform apply`.

```tf
variable "container_name" {
    description = "Name for the Docker container"
    type = string
    default = "defaultContainerName"
}
```


Call the variable inside the other .tf files that contains configurations.

```tf
resource "docker_container" "nginx" {
  name  = var.container_name
  ...
}
```

Then, you can just define a value in the CLI.

```bash
terraform apply -var "container_name=new_customized_name"
```

### How to output data from the Terraform infrastructure
Create a file `outputs.tf` and add the configuration that is in there. Then after the `terraform apply`, it is possible to get specific queried data from the provisioned infrastructured in STDOUT.

```bash
terraform output
```