# Variables and all kita declare right? So the declared variables tu their values are here. V A L U E S
# If we want to reuse the things we have built, we can just this this tfvars and just edit here, for example add a new bucket / change current bucket name etc (Only do this if dependancy has been checked la of course)

aws_region = "ap-southeast-1"

# Bucket Name dalam S3 nanti
state_bucket_name = "farhanazrayl-guitar-tfstate"

lock_table_name = "terraform-locks"