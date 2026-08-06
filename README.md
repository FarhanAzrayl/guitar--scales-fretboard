# guitar--scales-fretboard
Guitar Fretboard featuring notes, scales and visual indicators for learning. This project is to assist in solidifying my understanding of a potential team-oriented workflow, and while doing that to also learn musical and guitar scales as I am a guitar player and would like to improve myself. The project is aimed to hit two birds with one stone, mixing practical working knowledge and hobby related knowledge.

Functionality Goals to achieve:
- Dispaly guitar fretboard; toggle between an empty fretboard and a note-filled fretboard
- Choose a root note and a desired scale, and a highlighted guitar fretboard in accordance with the choice
- Change the tuning on each string to enable custom tunings while still highlighting the notes within a scale
- Admin Role - to add additional scales in the future, and also custom tuning presets if desired

Reasons for not using Javascript is to solidify the usage of cloud services already learned and to improve upon it.

Source for AWS Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs

6/8/2026
- Issue was caused by CORS > Adding CORS Access to the API Gateway to enable CloudFront to access
- Added CORS configuration in the API Gateway module


5/8/2026
- Facing issues with the frontend > Javascript is not executed > Debugging

4/8/2026
- Added DynamoDB table for tunings > Similar to scales
- Added the IAM policies for the Lambda to access the tables created
- Debugged Python codes in local > works. Now deploying > Testing the API endpoint for GET /scales first
- API endpoint + /scales work but /tunings didn't work > Forgot to add the endpoint for the tunings table in the apigateway module > Now added

3/8/2026
- Added DynamoDB table for guitar scales
- Debugging Python codes locally first

2/8/2026
- Adding hashicorp/archive provider to the Terraform dev environment > ran terraform init
- Adding apigateway module - Decided to use REST API, but since cost is considered we will not add API Gateway Caching, and we will try to not attach AWS WAF (Web Application Firewall) later on
- Testing after addeding the deployment details in the API Gateway
- Facing issues with Lambda and API Gateway architecture. Lambda > API Gateway, then API Gateway needs Lambda's invoked ARN - Circular dependency issue
- Created a new module ONLY for Lambda permissions
- Finished creating the new module for Lambda's permissions. Resolved issue with circular dependancy between Lambda and API Gateway (Gateway requesting resource (ARN) from Lambda) after fixing multiple bugs and errors due to migrating the information from Lambda/permissions file to lambda/lambda_permissions/permissions file

30/7/2026
- Done with Github Actions - multiple issues with the OIDC
- Finally debugged The issue; the current setup is using GitHub's old immutable subject claim - Updatedating the module so that the module becomes modular/reusable
- Hard coded the repo on the github_actions module instead of restructuring the module again. Testing
- Access issues. Added more Roles to the list in github_actions role condition > Note: If we are facing too many access issues, might as well just use :* but lets kee it proper for now
- Adding the groundwork for Lambda functionality

29/7/2026
- Finished with the pipeline setup - testing

28/7/2026
- Issues with the setup of the pipeline - debugging

25/7/2026
- Adding Pipeline > Github Actions

24/7/2026
- Adding and setting up Cloudfron module. Had to fix all issues that came up when setting it up

23/7/2026:
- Had to create a new module for the S3 bucket policy, because of a circular dependancy issue and after troubleshooting, the current module responsibilities:

S3 Module
Bucket
Versioning
Encryption
Ownership Controls
Public Access Block


CloudFront Module
Distribution
OAC
Cache Behavior

S3 Bucket Policy Module
Generating IAM policy
Attaching policy