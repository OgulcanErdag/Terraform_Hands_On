# Hands-on Terraform-02: Terraform Commands, Variables, Conditionals, Loops:

The purpose of this hands-on training is to give students the knowledge of Terraform commands, variables, conditionals, and loops in Terraform.

## Learning Outcomes

At the end of this hands-on training, students will be able to;

- Use Terraform commands, variables, conditionals, and loops.

## Outline

- Part 1 - Terraform Commands

- Part 2 - Variables

- Part 3 - Conditionals and Loops

## Part 1: Terraform Commands

- Create a directory ("terraform-aws") for the new configuration and change into the directory.

```bash
mkdir terraform-aws && cd terraform-aws && touch main.tf
```

- Create a file named `main.tf` for the configuration code and copy and paste the following content.

```go

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.30.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "tf-ec2" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
  key_name      = "ogi-us-key"  # write your pem file without .pem extension
  tags = {
    "Name" = "tf-ec2"
  }
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = "tf-test-bucket-addwhateveryouwant"
}
```

- Run the commands `terraform plan` and `terraform apply`.

```bash
terraform init

terraform plan
```

### Validate command

- Go to the terminal and run `terraform validate`. It validates that the Terraform files are syntactically correct and internally consistent.

```bash
terraform validate
```

- Go to `main.tf` file and delete the last curly bracket "}" and key_name's last letter (key_nam). And go to the terminal and run the command `terraform validate`. After taking the errors correct them. Then run the command again.
- Go to `main.tf` file, write "key-name" insteade of this "key_name".

```bash
terraform validate
```

Error: Unclosed configuration block
│
│ on main.tf line 23, in resource "aws_s3_bucket" "tf-s3":
│ 23: resource "aws_s3_bucket" "tf-s3" {
│
│ There is no closing brace for this block before the end of the file. This may be caused by incorrect brace nesting elsewhere in this file.

│ Error: Unsupported argument
│
│ on main.tf line 17, in resource "aws_instance" "tf-ec2":
│ 17: key-name = "ogi-us-key"
│
│ An argument named "key-name" is not expected here. Did you mean "key_name"?

```bash
terraform validate
```

Error: Unsupported argument
│
│ on main.tf line 17, in resource "aws_instance" "tf-ec2":
│ 17: key_nam = "test"
│
│ An argument named "key_nam" is not expected here. Did you mean "key_name"?

```bash
terraform validate
```

Success! The configuration is valid.

- Go to `main.tf` file and copy the EC2 instance block and paste it. And go to the terminal and run the command `terraform validate`. After taking the errors, correct them. Then run the command again.

```bash
$ terraform validate
│Error: Duplicate resource "aws_instance" configuration
│
│   on main.tf line 23:
│   23: resource "aws_instance" "tf-ec2" {
│
│ A aws_instance resource named "tf-ec2" was already declared at main.tf:14,1-33. Resource names must be unique per type in each module.
```

- Go to `main.tf` file and delete the second EC2 instance.

### fmt command

- Go to `main.tf` file and add random indentations. Then go to the terminal and run the command `terraform fmt`. The "terraform fmt" command reformats your configuration file in the standard style.

```bash
terraform fmt
terraform apply
```

- Now, show `main.tf` file. It was formatted again.

### terraform console : we can get "Expression, variable and state"s values very quick

- Go to the terminal and run `terraform console`.This command provides an interactive command-line console for evaluating and experimenting with expressions. This is useful for testing interpolations before using them in configurations, and for interacting with any values currently saved in state. You can see the attributes of resources in the tfstate file and check built-in functions before you write in your configuration file.

- Let's create a file under the terraform-aws directory and name it `cloud` and paste `hello devops engineers`.

```bash
echo "hello devops engineers" > cloud
```

Run the following commands.

```bash
terraform console
> aws_instance.tf-ec2.private_ip
> min (1,2,3)
> lower("HELLO")
> file("${path.module}/cloud")
> aws_s3_bucket.tf-s3.bucket
> exit or (ctrl+c)
```

NOT: echo '"54.226.136.26"' | tr -d '"'
echo "54.226.136.26" | tr -d '"'

### show command

- Go to the terminal and run `terraform show`.

You can see the tfstate file or plan in the terminal. It is more readable than `terraform.tfstate`.

```bash
terraform show
```

NOT: we can not use it this command for specified resource like this

```bash
terraform show aws_instance.tf-ec2
```

It gives this Error:

```bash

│ Error: Failed to read the given file as a state or plan file
│
│ State read error: Error loading statefile: open aws_instance.tf-ec2: no such file or directory
│
│ Plan read error: couldn't load the provided path as either a local plan file (open aws_instance.tf-ec2: no such file or directory) or a saved cloud plan (open
│ aws_instance.tf-ec2: no such file or directory)
```

But we can use like this

```bash

terraform state show aws_instance.tf-ec2
```

### graph command

- Go to the terminal and run `terraform graph`. It creates a visual graph of Terraform resources. The output of the "terraform graph" command is in the DOT format, which can easily be converted to an image by making use of the dot provided by GraphViz.

- Copy the output and paste it into the `https://dreampuf.github.io/GraphvizOnline`. Then display it. If you want to display this output locally, you can download Graphviz (`sudo yum install graphviz`) and take a `graph.svg` with the command `terraform graph | dot -Tsvg > graph.svg`.

```bash
terraform graph
terraform graph > graph.dot # It gives a file
terraform graph -type=plan-destroy
terraform graph -type=apply

```

### output command

- Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use.

- Now add the following to the `main.tf` file. Then run the commands `terraform apply or terraform refresh` and `terraform output`. `terraform output` command is used for reading an output from a state file. It reads an output variable from a Terraform state file and prints the value. With no additional arguments, output will display all the outputs for the (parent) root module. If NAME is not specified, all outputs are printed.

```go
resource "aws_s3_bucket" "tf-s3" {
  bucket = "tf-test-bucket-ogulcan-13"
}

output "tf_ec2_public_ip" {
    value = aws_instance.tf-ec2.public_ip

}

output "tf_s3_bucket_name" {
    value = aws_s3_bucket.tf-s3.bucket

}

output "my_app_url" {
    value = "http://${aws_instance.tf-ec2.public_ip}:5000" # place holder

}
```

```bash
terraform apply
terraform output
terraform output -json # it gives "programmable output"
terraform output -json > tf.json # programmable output. we can use like this:
APP_URL=$(terraform output -json | jq -r '.my_app_url.value') # tool-agnostic -->CI/CD, Ansible, Python,Go,Node.js,Helm
terraform output -raw my_app_url
echo "$(terraform output -raw my_app_url)" # for Shell string
echo $APP_URL
curl $APP_URL
terraform output tf_ec2_public_ip
```

NOT: echo '"54.226.136.26"' | tr -d '"'
echo "54.226.136.26" | tr -d '"'
Not: Json is the most popular "Data seriliziation" format!!!

## Part 2: Variables

- Variables let you customize aspects of Terraform modules without altering the module's own source code. This allows you to share modules across different Terraform configurations, making your module composable and reusable.

- When you declare variables in the root module of your configuration, you can set their values using CLI options and environment variables.

### Declaring and Using Variables

- Each input variable accepted by a module must be declared using a variable block.

- Make the changes in the `main.tf` file.

```go
provider "aws" {
  region  = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.30.0"
    }
  }
}

variable "ec2_name" {
  default = "ogulcan-tf-ec2"
}

variable "ec2_type" {
  default = "t3.micro"
}

variable "ec2_ami" {
  default = "ami-0532be01f26a3de55"
}

variable "key_name" {
  default = "ogi-us-key"

}
variable "user_name" {
  default = "ogulcan"

}

resource "aws_instance" "tf-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  key_name      = var.key_name
  tags = {
    Name = "${var.ec2_name}-test"
  }
}

variable "s3_bucket_name" {
  default = "s3-bucket-variable-ogulcan-13"
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = var.s3_bucket_name
}

output "tf_example_public_ip" {
  value = aws_instance.tf-ec2.public_ip
}

output "tf_example_private_ip" {
  value = aws_instance.tf-ec2.private_ip
}

output "tf_s3_meta" {
  value = aws_s3_bucket.tf-s3.bucket
}
```

```bash
terraform apply
```

- Create a file named `variables.tf`. Take the variables from `main.tf` file and paste them into "variables.tf".

```bash
terraform validate

terraform fmt

terraform apply
```

- Go to the `variables.tf` file and comment the s3 bucket name variable's default value.

```go
variable "s3_bucket_name" {
#   default     = "s3-bucket-variable-ogulcan-13"
}
```

```bash
terraform plan
```

### Assigning Values to Root Module Variables

- When variables are declared in the root module of your configuration, they can be set in a number of ways:
  - Individually, with the -var command line option.
  - In variable definitions (.tfvars) files, either specified on the command line or automatically loaded.
  - As environment variables.

#### -var command line option

- You can define variables with `-var` command

```bash
terraform plan -var="s3_bucket_name=new-s3-bucket-13-tr"
```

#### environment variables

- Terraform searches the environment of its own process for environment variables named `TF_VAR_` followed by the name of a declared variable.

- You can also define a variable with environment variables that begin with `TF_VAR_`.

```bash
export TF_VAR_s3_bucket_name=env-varible-bucket
terraform plan
```

#### In variable definitions (.tfvars)

- Create a file named `terraform.tfvars`. Add the following.

```go
s3_bucket_name = "tfvars-bucket"
```

- Run the command below.

```bash
terraform plan
```

- Create a file named `my.tfvars`. Add the following.

```go
s3_bucket_name = "my-tfvar-bucket"
```

- Run the command below.

```bash
terraform plan --var-file="my.tfvars"
```

- Create a file named `my.auto.tfvars`. Add the following.

```go
s3_bucket_name = "my-auto-tfvar-bucket"
```

```bash
terraform plan
```

- Terraform loads variables in the following order:
  - Any -var and -var-file options on the command line, in the order they are provided.
  - Any _.auto.tfvars or_.auto.tfvars.json files, processed in lexical order of their filenames.
  - The terraform.tfvars.json file, if present.
  - The terraform.tfvars file, if present.
  - Environment variables

## Not

-var
-var-file
_.auto.tfvars
terraform.tfvars
export TF*VAR*_
variable default

- Run the `terraform apply` command.

```bash
terraform apply
```

### Locals

- A local value assigns a name to an expression, so you can use it multiple times within a module without repeating it.

- Make the changes in the `main.tf` file.

```go
locals {
  mytag = "my-local-name"
  creation_date = timestamp()
  username = var.user_name
}

resource "aws_instance" "tf-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  key_name      = var.key_name
  tags = {
    Name = "${local.mytag}-test-${local.username}"
    date = local.creation_date
  }
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = var.s3_bucket_name
  tags = {
    Name = "${local.mytag}-test-${local.username}"
    date = local.creation_date
  }
}

```

- Run the command `terraform plan`

```bash
terraform plan
```

- Run the command `terraform apply` again. Check the EC2 instance's Name tag column.

```bash
terraform apply
```

- Terminate the resources.

```bash
terraform destroy
```

## Part 3: Conditionals and Loops

### count

- By default, a resource block configures one real infrastructure object. However, sometimes you want to manage several similar objects (like a fixed pool of compute instances) without writing a separate block for each one. Terraform has two ways to do this: count and for_each.

- The `count` argument accepts a whole number and creates that many instances of the resource or module. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

- Create a directory ("terraform-conditions-loops") for the new configuration and change into the directory.

```bash
cd && mkdir terraform-conditions-loops && cd terraform-conditions-loops && touch main.tf
```

- Go to the `main.tf` file, make the changes in order.

```go

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.30.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

variable "num_of_buckets" {
  default = 2
}

variable "s3_bucket" {
  default     = "new-s3-bucket-ogulcan-devops13-tr"
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = "${var.s3_bucket}-${count.index}"
  count = var.num_of_buckets
}
```

## Not

bucket = "${var.s3_bucket}-${count.index + 1}"

```bash
terraform init   # you are in different directory!!!
terraform apply
```

- Check the S3 buckets from the console.

### Conditional Expressions

- A conditional expression uses the value of a Boolean expression to select one of two values.

- Go to the `main.tf` file, make the changes in order.

```go
resource "aws_s3_bucket" "tf-s3" {
  bucket = "${var.s3_bucket}-${count.index}"

  # count = var.num_of_buckets
  count = var.num_of_buckets != 0 ? var.num_of_buckets : 3    # ternary operator
}
```

## NOT: "ternary operator" if a then b else c --> a ? b : c

```bash
terraform plan
```

### for_each

- The for_each meta-argument accepts a map or a set of strings, and creates an instance for each item in that map or set. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

- Go to the `main.tf` file again and add a new variable.

```go
variable "users" {
  default = ["aakadir", "aaogulcan", "aababek"]
}
```

- Go to the `main.tf` file, make the changes. Change the IAM role and add `IAMFullAccess` policy.

```go
resource "aws_s3_bucket" "tf-s3" {
  # bucket = "${var.s3_bucket}-${count.index}"
  # count = var.num_of_buckets
  # count = var.num_of_buckets != 0 ? var.num_of_buckets : 1
  for_each = toset(var.users)
  bucket   = "example-tf-s3-bucket-${each.value}"
}

resource "aws_iam_user" "new_users" {
  for_each = toset(var.users)
  name = each.value
}

```

```bash
terraform apply
```

- Go to the AWS console (IAM and S3) and check the resources.

- Delete all the infrastructure.

```bash
terraform destroy
```
