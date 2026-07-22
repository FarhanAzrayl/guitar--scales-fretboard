# Variables and all kita declare right? So the declared variables tu their values are here. V A L U E S
# If we want to reuse the things we have built, we can just this this tfvars and just edit here, for example add a new bucket / change current bucket name etc (Only do this if dependancy has been checked la of course)

aws_region = "ap-southeast-1"

# Bucket Name in S3 to store the state lock (the thing that acts like a token so that the DB is locked if there is a second or more person trying to access the database)
state_bucket_name = "tfstatelock-for-guitar-project"

# Table Name in DynamoDB
lock_table_name = "tfstatelock-for-guitar-project"