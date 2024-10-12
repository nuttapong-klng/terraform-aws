module "sqs" {
    source  = "terraform-aws-modules/sqs/aws"
    version = "~> 3.0"
    for_each = var.sqs_queues
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