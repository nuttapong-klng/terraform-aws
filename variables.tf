variable "aws_access_key" {
    description = "AWS access key"
    type        = string
    sensitive   = true
}

variable "aws_secret_key" {
    description = "AWS secret key"
    type        = string
    sensitive   = true
}

variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "ap-southeast-1"
}

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
    default = {
        my-sqs-queue-1 = {
            delay_seconds               = 0
            max_message_size            = 262144
            message_retention_seconds   = 345600
            receive_wait_time_seconds   = 0
            visibility_timeout_seconds  = 30
            fifo_queue                  = false
            content_based_deduplication = false
            kms_master_key_id           = null
            kms_data_key_reuse_period_seconds = null
        },
        my-sqs-queue-2 = {
            delay_seconds               = 10
            max_message_size            = 262144
            message_retention_seconds   = 345600
            receive_wait_time_seconds   = 0
            visibility_timeout_seconds  = 30
            fifo_queue                  = false
            content_based_deduplication = false
            kms_master_key_id           = null
            kms_data_key_reuse_period_seconds = null
        }
    }
}
