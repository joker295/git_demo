####locals###


# In Terraform, locals are a way to define named values that you want to reuse in your configuration. They are useful for making your configuration more readable and maintainable by avoiding duplication of expressions or values.
# Defining Locals

# You define locals in a locals block within your Terraform configuration file. Here's an example of how to define and use locals:


# locals {
   environment = "production"
   instance_count = 3
   vpc_cidr_block = "10.0.0.0/16"
   subnet_cidr_blocks = [for i in range(local.instance_count) : cidrsubnet(local.vpc_cidr_block, 8, i)]
 }

 resource "aws_vpc" "main" {
   cidr_block = local.vpc_cidr_block
 }

# resource "aws_subnet" "subnets" {
   count = local.instance_count
   cidr_block = local.subnet_cidr_blocks[count.index]
   vpc_id = aws_vpc.main.id
 }



# Key Points

#     Declaration: Locals are declared in a locals block. Each local value is a key-value pair.
#     Scope: Locals are scoped to the configuration where they are declared. They cannot be accessed outside that scope.
#     Usage: You reference a local value using the local.<name> syntax.

# Use Cases

#     Reusability: Store common values or expressions to avoid duplication. For example, if you use the same instance_type in multiple places, you can define it once in locals.
#     Complex Expressions: Simplify complex expressions by breaking them into more manageable parts.
#     Readability: Improve the readability of your configuration by giving meaningful names to values.


# Limitations

#     No Dynamic Values: Locals cannot be used to create resources or manage their lifecycle. They are purely for defining static values.
#     No Dependencies: Locals do not have dependencies like resources, so they cannot be used to dynamically create values based on the state of other resources.

