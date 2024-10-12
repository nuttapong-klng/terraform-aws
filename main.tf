module "sqs" {
    source  = "terraform-aws-modules/sqs/aws"
    version = "~> 3.0"
    for_each = {
        queue1 = {
            name                        = "my-sqs-queue-1"
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
        queue2 = {
            name                        = "my-sqs-queue-2"
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

    name                        = each.value.name
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