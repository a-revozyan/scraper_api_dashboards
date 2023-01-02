output "cars_data_s3_bucket_arn" {
  description = "S3 Bucket for cars data"
  value = aws_s3_bucket.carsdatascraperapidash1.arn
}

#output "cars_data_s3_bucket_name" {
#  description = "S3 Bucket for cars data"
#  value = aws_s3_bucket.carsdatascraperapidash1.name
#}