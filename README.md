# terraform-learning
A minimal Terraform application to learn how to use it and apply in projects later.

### How to use environment variables
Create a `variables.tf` file and then declare the variable. The file may have any name because all `.tf` files are loaded when calling `terraform apply`.

```h
variable "container_name" {
    description = "Name for the Docker container"
    type = string
    default = "defaultContainerName"
}
```

Call the variable inside the other .tf files that contains configurations.

```h
resource "docker_container" "nginx" {
  name  = var.container_name
  ...
}
```

Then, you can just define a value in the CLI.

```bash
terraform apply -var "container_name=new_customized_name"
```

You can also use a env file (*.auto.tfvars or terraform.tfvars).

```h
# example.auto.tfvars
container_name = "new_customized_name"
```

```bash
terraform apply -var-file="example.auto.tfvars"
```

#### Variable extra fields
There are two optional fields a variable block can receive:
- sensitive
- nullable

Sensitive means that a variable value will not appear in the terminal during `terraform plan` or `terraform apply`.

A sensitive value **may be disclosed** if the value is invalid for the field (something like `"Invalid value 'foo' for field"`) or if the value is part of the id. In the example `prefix=jae`, see that it appears when creation is complete.

```
# random_pet.animal will be created
+ resource "random_pet" "animal" {
    + id        = (known after apply)
    + length    = 2
    + prefix    = (sensitive value)
    + separator = "-"
  }

Plan: 1 to add, 0 to change, 0 to destroy.

...
 
random_pet.animal: Creating...
random_pet.animal: Creation complete after 0s [id=jae-known-mongoose]
```

Nullable means `null` is a valid value for that variable and the configuration will always account for this possibility.
Passing `null` value as a input argument will override any `default` value.

### Environment variables in automation
Terraform variables can be defined in the terminal using the prefix `TF_VAR_` followed by the name of the variable. This can be useful in automation.

```bash
export TF_VAR_image_id=ami-abc123
terraform plan
...
```

### How to output data from the Terraform infrastructure
Create a file `outputs.tf` and add the configuration that is in there. Then after the `terraform apply`, it is possible to get specific queried data from the provisioned infrastructured in STDOUT.

```bash
terraform output
```
