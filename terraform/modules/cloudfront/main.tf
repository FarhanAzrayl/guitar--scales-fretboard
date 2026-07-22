# This is the standard parameters for a Cloudfront configurations
# This is the OAC (Origin Access Control) resource that we are creating in order for Cloudfront to be able to access resources. Think of this like it is an ID, or an ID/Access card to offices

resource "aws_cloudfront_origin_access_control" "website" {
  name = "${var.project_name}-${var.environment}-oac"
  description = "Allows CloudFront to securely access the private S3 bucket."
  origin_access_control_origin_type = "s3"

  # Important > Every request sent from CloudFront to S3 is cryptographically signed. This is for S3 to verify who this is: Cloudfront. 
  # Remember that we have set the standard security practices for the S3 bucket, so OAC ni is bascically an authorized identity yang boleh access the bucket.
  # Just think of it macam ni, private buckets can only be accessed by requests that goes through here, where the requests are signed by OAC. Dia cop their permission slip gitchew
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

# Create the distribution

resource "aws_cloudfront_distribution" "website" {
  # If false, ofc la no traffic could go through
  enabled = true
 
  origin {

  # domain name ofc from the output S3 module sends on their output that was provided to them by the environment (dev/prod/test)
    domain_name = var.bucket_regional_domain_name
    origin_id = "s3-origin"

  # This one literally dekat atas > the OAC that we just created on the first resource within this main.tf jugak
  origin_access_control_id = aws_cloudfront_origin_access_control.website.id 
        }

  default_cache_behavior {
    # Notice that this is created just above us in the origin nest. It is referencing from the same resource block as when this is declared / created
    target_origin_id = "s3-origin"

    # Always redirect the traffic to https. Even if we don't have a domain yet, Cloudfront could and will give us HTTPS for an better secured enrypted connection
    viewer_protocol_policy = "redirect-to-https"

    # GET retrieves the content, HEAD retrieves only the response headers.
    allowed_methods = ["GET", "HEAD"]

    # This will pretty much cache all of the methods that are declared here
    cached_methods = ["GET", "HEAD"]

    # Compresses any data that goes through Cloudfront. It's basically free performance. 
    # Remember that Cloudfront is a paid service that depends on the amount of data that goes through it, so compression is pretty much a cost saving method too
    compress = true

    # This is the default AWS managed CachingOptimized policy
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"

  }
  # This is the closing curly bracket for default_cache_behavior btw

    # If we buy a domain, we completely replace this block with our purchased domain
    viewer_certificate {
      cloudfront_default_certificate = true
    }

    # In case we want to restrict certain countries, this is where we set it up
    restrictions {
        geo_restriction {
        restriction_type = "none"
                }
        }

    # If nothing specific is requested, the default object is as per declared here
    default_root_object = "index.html"

}



