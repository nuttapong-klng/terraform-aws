# Terraform Side Project - Using `for_each` for Dynamic Resource Creation
This project demonstrates the use of Terraform's for_each meta-argument to dynamically manage AWS resources. It automates the provisioning of multiple instances of the same resource (like EC2 instances, S3 buckets, or security groups) based on an input list or map, improving scalability and flexibility.

# Use Case
WIP

# Project Structure
- `main.tf`: Contains the core Terraform configuration using `for_each` to create SQS queues dynamically.
- `variables.tf`: Defines input variables, including a list of queues to be created.
- `outputs.tf`: WIP

# How It Works
The `for_each` meta-argument in Terraform allows you to iterate over a map or set of strings to create multiple instances of a resource. In this project, `for_each` is used in the `main.tf` file to dynamically create SQS queues based on the values provided in the `sqs_queues` variable defined in `variables.tf`.

Here's a breakdown of how it works:

1. **Define the Input Variable**: In `variables.tf`, you define a variable `sqs_queues` which is a map of SQS queue names and their respective attributes.

    ```hcl
    variable "sqs_queues" {
        description = "A map of SQS queues to create"
        type    = map(object({
            delay_seconds               = number
            max_message_size            = number
            message_retention_seconds   = number
            receive_wait_time_seconds   = number
            visibility_timeout_seconds  = number
            fifo_queue                  = bool
            content_based_deduplication = bool
            kms_master_key_id           = string
            kms_data_key_reuse_period_seconds = number
        }))
    }
    ```

2. **Use `for_each` in Resource Block**: In `main.tf`, you use the `for_each` meta-argument to iterate over the `sqs_queues` map and create an SQS queue for each entry.

    ```hcl
    resource "aws_sqs_queue" "this" {
        for_each = var.sqs_queues

        name                        = each.key
        delay_seconds               = each.value.delay_seconds
        max_message_size            = each.value.max_message_size
        message_retention_seconds   = each.value.message_retention_seconds
        receive_wait_time_seconds   = each.value.receive_wait_time_seconds
        visibility_timeout_seconds  = each.value.visibility_timeout_seconds
        fifo_queue                  = each.value.fifo_queue
        content_based_deduplication = each.value.content_based_deduplication
        kms_master_key_id           = each.value.kms_master_key_id
        kms_data_key_reuse_period_seconds = each.value.kms_data_key_reuse_period_seconds
    }
    ```

    In this example, `each.key` refers to the name of the SQS queue, and `each.value` refers to the attributes of the queue.

3. **Provisioning**: When you run `terraform apply`, Terraform will create an SQS queue for each entry in the `sqs_queues` map, using the specified attributes.

This approach allows you to manage multiple SQS queues efficiently and dynamically, without having to write separate resource blocks for each queue.


# How to Use
To run this project, follow these steps:

1. **Install Terraform**: Ensure you have Terraform installed on your machine. You can download it from the [official Terraform website](https://www.terraform.io/downloads.html).

2. **Clone the Repository**: Clone this repository to your local machine.

    ```sh
    git clone /Users/bonus/workspaces/personal/terraform-aws-for-each
    cd terraform-aws-for-each
    ```

3. **Initialize the Project**: Initialize the Terraform project to download the necessary providers and set up the backend.

    ```sh
    terraform init
    ```

4. **Define Input Variables**: Update the `variables.tf` file with the desired SQS queue configurations. For example:

    ```hcl
    variable "sqs_queues" {
        default = {
            "queue1" = {
                delay_seconds               = 0
                max_message_size            = 262144
                message_retention_seconds   = 345600
                receive_wait_time_seconds   = 0
                visibility_timeout_seconds  = 30
                fifo_queue                  = false
                content_based_deduplication = false
                kms_master_key_id           = ""
                kms_data_key_reuse_period_seconds = 300
            },
            "queue2" = {
                delay_seconds               = 0
                max_message_size            = 262144
                message_retention_seconds   = 345600
                receive_wait_time_seconds   = 0
                visibility_timeout_seconds  = 30
                fifo_queue                  = false
                content_based_deduplication = false
                kms_master_key_id           = ""
                kms_data_key_reuse_period_seconds = 300
            }
        }
    }
    ```

5. **Apply the Configuration**: Run the following command to apply the Terraform configuration and create the SQS queues.

    ```sh
    terraform apply
    ```

6. **Confirm the Apply**: Terraform will show you a plan of the resources to be created. Type `yes` to confirm and proceed.

7. **Verify the Resources**: After the apply completes, you can verify the created SQS queues in the AWS Management Console.

By following these steps, you will be able to dynamically create and manage multiple SQS queues using Terraform's `for_each` meta-argument.

# Document References
- [Terraform Official Docs - The for_each Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
