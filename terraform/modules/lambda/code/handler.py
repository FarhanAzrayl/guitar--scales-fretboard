# boto3 ni untuk import AWS punya resource library
import boto3
import json
import os

dynamodb = boto3.resource("dynamodb")

# Scales table tu dapat dari environment variable yang kita set dalam Lambda.
scales_table = dynamodb.Table(
    os.environ["SCALES_TABLE"]
)

# Tunings table tu dapat dari environment variable yang kita set dalam Lambda.
tunings_table = dynamodb.Table(
    os.environ["TUNINGS_TABLE"]
)

def lambda_handler(event, context):

    # Gets the URL path from API Gateway.
    # Kalau browser calls GET /scales, then path jadi = /scales.
    # Kalau browser calls GET /tunings, then path jadi = /tunings.
    path = event["requestContext"]["http"]["path"]

    if path == "/scales":

        response = scales_table.scan()

        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json"
            },
            "body": json.dumps(response["Items"])
        }

    elif path == "/tunings":

        response = tunings_table.scan()

        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json"
            },
            "body": json.dumps(response["Items"])
        }


    else:
        return {
            "statusCode": 404,
            "body": json.dumps({
                "message": "Route not found."
            })
        }

# Later we use this. Had too many bugs when testing. We debug and update later. Just use the above first and use if and elif dulu lahh
# 
# routes = {
#     "/scales": get_scales,
#     "/tunings": get_tunings,
# }
# 
# fetch("/scales")