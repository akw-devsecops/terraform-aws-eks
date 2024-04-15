resource "aws_eip" "this" {
  count = var.nlb_eip_count
}
