# Most of the time, people just create a write in a JSON file and it should be enough, but we are trying to simulate apa kena buat in an actual working environment so we make it using this
# We can write this in the main .tf but this one macam I want to separate a bit since we are creating the JSON file using this. Karang keliru masa baca balik main file
# The documentation on Terraform Registry > https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy (Included because I needed help to find this)

# We had to add this since we are unable to add the policy in the Cloudfront module since we faced a circular dependancy issue
# This is to Generate an IAM policy document (The JSON file) from Cloudfront and attach the policy to it so that the the S3 bucket can be read/accessed by our Cloudfront.

data "aws_iam_policy_document" "cloudfront_access" {

 statement {

    effect = "Allow"

    # For benda2 lain such as chords, intervals etc we will not be need to do it here since this is only for Cloudfront to read files from our S3 bucket, tu je. The others we will handle on our API's on Lambda and shit
    actions = [
      "s3:GetObject"
    ]

    resources = [

    # Since we had to create this policy, it owns nothing so we had to the variable from this module
    # Letak je /* so boleh access any object, no need to specify for this project I think
      "${var.bucket_arn}/*"
    ]

    # What service is this?
    # AWS represents services using principal, that is why we are using this to declare that "This is a Cloudfront service, dawg"
    principals {

      type = "Service"

      # This is basically announcing " Weh, CloudFront is the the AWS service making the request weh"
      identifiers = [
        "cloudfront.amazonaws.com"
      ]
    }

    # Who is this? Which Cloudfront Distribution (ARN)? Other ARN's than the one(s) that are stated here or if not matching, no access to the bucket
    condition {
      test = "StringEquals"
      variable = "AWS:SourceArn"

      # This is the ARN that we fetch from the Cloudfront modeule output
      values = [
        var.cloudfront_distribution_arn
      ]
    }
  }

}


# Don't forget to add the resource policy here man!! Troubleshooted for HOURS
# This aAttaches the generated IAM policy to the existing bucket. The policy document above only generates JSON; this resource applies it to our S3 bucket.

resource "aws_s3_bucket_policy" "website" {

  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.cloudfront_access.json
}