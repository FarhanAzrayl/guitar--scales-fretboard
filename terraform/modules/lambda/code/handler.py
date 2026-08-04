# boto3 ni untuk import AWS punya resource library
import boto3
import json
import os

dynamodb = boto3.resource("dynamodb")

# Scales table tu dapat dari environment variable yang kita set dalam Lambda.
scales_table = dynamodb.Table(
    os.environ["SCALES_TABLE"]
)


def lambda_handler(event, context):
    response = scales_table.scan()

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(response["Items"])
    }