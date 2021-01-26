resource "aws_cloudfront_distribution" "site_s3_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  comment             = "Cloudfront Distribution for ${var.app_name}-${var.account_id}-${var.git_repository_branch} Static Site"
  tags                = "${local.common_tags}"

  depends_on = ["aws_s3_bucket.bucket_site"]

  origin {
    domain_name = "${aws_s3_bucket.bucket_site.website_endpoint}"
    origin_id   = "${aws_s3_bucket.bucket_site.id}"

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1"]
    }
  }

  default_cache_behavior {
    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id = "${aws_s3_bucket.bucket_site.id}"

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 1800
    default_ttl            = 1800
    max_ttl                = 1800
  }

  ordered_cache_behavior {
    path_pattern     = "*.js"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]

    target_origin_id = "${aws_s3_bucket.bucket_site.id}"

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    min_ttl                = 1800
    default_ttl            = 1800
    max_ttl                = 1800
    compress               = true
    viewer_protocol_policy = "allow-all"
  }

  ordered_cache_behavior {
    path_pattern     = "*.css"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]

    target_origin_id = "${aws_s3_bucket.bucket_site.id}"

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    min_ttl                = 1800
    default_ttl            = 1800
    max_ttl                = 1800
    compress               = true
    viewer_protocol_policy = "allow-all"
  }

  ordered_cache_behavior {
    path_pattern     = "*.png"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]

    target_origin_id = "${aws_s3_bucket.bucket_site.id}"

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    min_ttl                = 1800
    default_ttl            = 1800
    max_ttl                = 1800
    compress               = true
    viewer_protocol_policy = "allow-all"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    ssl_support_method  = "sni-only"
  }
}
