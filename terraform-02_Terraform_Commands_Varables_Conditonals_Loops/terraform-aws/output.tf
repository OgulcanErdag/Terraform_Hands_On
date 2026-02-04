output "tf-ec2_public_ip" {
  value = aws_instance.tf-ec2.public_ip
}

output "tf-s3_bucket_name" {
  value = aws_s3_bucket.tf-s3.bucket
}

output "my_app-url" {
  value = "http://${aws_instance.tf-ec2.public_ip}:5000"
}
