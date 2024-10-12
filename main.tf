module "sqs" {
    source  = "terraform-aws-modules/sqs/aws"
    version = "~> 3.0"
    name = "my-sqs-queue"

    delay_seconds                  = 0
    max_message_size               = 262144
    message_retention_seconds      = 345600
    receive_wait_time_seconds      = 0
    visibility_timeout_seconds     = 30
    fifo_queue                     = false
    content_based_deduplication    = false
    kms_master_key_id              = null
    kms_data_key_reuse_period_seconds = null
}