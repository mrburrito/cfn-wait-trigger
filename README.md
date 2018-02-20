# cfn-wait-trigger

A simple Docker container that waits for some amount of time then sends a SUCCESS response to a CloudFormation WaitCondition

## Usage

Specify the following environment variables:

- `WAIT_TIMEOUT`: The number of seconds before the wait will be triggered (default: 10)
- `UNIQUE_ID`: A unique ID for this wait condition message
- `WAIT_HANDLE`: The pre-signed S3 URL provided by CloudFormation when the WaitConditionHandle is created
- `KEEP_ALIVE_AFTER_TRIGGER`: If set to any non-empty value, this container will remain alive after triggering the wait condition until it is explicitly stopped.

```bash
docker run -e WAIT_TIMEOUT=10 \
           -e UNIQUE_ID=my-unique-wait-id \
           -e WAIT_HANDLE=https://aws-cfn-provided-bucket.amazonaws.com/presigned=params \
           -e KEEP_ALIVE_AFTER_TRIGGER=true \
           --rm \
           mrburrito/cfn-wait-trigger
``` 
