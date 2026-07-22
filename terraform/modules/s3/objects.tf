resource "aws_s3_object" "website_files" {

  # Use this so it discovers all of the files in the source path including subfolders. Easier than declaring one by one
  for_each = fileset(var.website_source_path, "**")

  bucket = aws_s3_bucket.website.id

  key = each.value

  source = "${var.website_source_path}/${each.value}"

  # This is to read the filetype for the upload (Check in locals.tf for more details)
  content_type = lookup(
    local.mime_types,
    element(split(".", each.value), -1),
    "application/octet-stream"
  )

  # We'll use the Filemd5 so that the files' MD5 hash of each file is calculated. If the MD5 hash is unchagned, files will not be reuploaded
  # If there are any changes this will detect it (Good for file update detection. If detects there is a change in the hash? Reupload!)
  etag = filemd5("${var.website_source_path}/${each.value}")

}