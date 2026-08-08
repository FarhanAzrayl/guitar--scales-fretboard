# guitar--scales-fretboard
Guitar Fretboard featuring notes, scales and visual indicators for learning. This project is to assist in solidifying my understanding of a potential team-oriented workflow, and while doing that to also learn musical and guitar scales as I am a guitar player and would like to improve myself. The project is aimed to hit two birds with one stone, mixing practical working knowledge and hobby related knowledge.

Functionality Goals to achieve:
- Dispaly guitar fretboard; toggle between an empty fretboard and a note-filled fretboard
- Choose a root note and a desired scale, and a highlighted guitar fretboard in accordance with the choice
- Change the tuning on each string to enable custom tunings while still highlighting the notes within a scale
- Admin Role - to add additional scales in the future, and also custom tuning presets if desired

Source for AWS Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
GitHub Documentation: https://docs.github.com/en/actions/reference/security/oidc
- That resolves the OIDC issue. GitHub has recently changed the path for repos that are created from 15th of July 2026 onwards

Next Addition/Action: 
- CloudFront invalidation will cost money after 1000 requests. For this project, it will not be an issue > However, will setup CloudWatch notification later on
- Add Route 53 and ACM for REST API's and domain
- Add Admin page to enable CRUD for the tunings and scales data
- Add option to highlight the notes within a scale with different distinctive colours
- Add metronome

8/82026
- Fixed the errors on Javascript file; app.js again after facing errors when adding new functions > Testing
- Changed the table frets for easier navigation letter for re-rendering, added values to indicate which string, frets and which fret is a normal fret and which has a marker (dots)
- Testing if the function to read the index is running correctly on the console
- Testing the function if a value more than the array will be called console > Changed from using if/else to using modulo % to return the remainder for better loop wrap around if value is higher than the max length of the array. Current array is from [0] - [12]
- Testing if all the notes will appear on the fretboard
- Fixing errors, notes not rendered correctly. Testing and debugging
- Testing toggle button's functionality
- Fixed the issue where the initial tuning notes, dot markers, and 12th notes double markers are gone when toggled off > Testing
- Faced issue after adding more fields and attributes to the DynamoDB table
- boto3 is unable to read Python integers and changes it to decimal > Added import for decimal-integer in the Python code
- Changing the architecture a little in the HTML and added a function to call the initial tuning on initial load to display standard tuning from Javascript instead of hard coding, and added functionality so that the open strings are editable for custom tunings
- Testing the highlight function
- Added the functionality of the tuning preset > Testing

Note: 
- boto3 intentionally converts every DynamoDB Number into a Python Decimal object, hence the need for the import > The importt encoder basically converts any decimals into an int first.
- Remember to add DecimalEncoder for any AWS projects in the future, it is good practice to do so
-  Current issue as of this date, each deployment does not reflect on the CloudFront > Would have to invalidate the cache with every deployment > Will add the invalidation behaviour for CloudFront in Terraform later after everything is done

7/8/2026
- html file is not updated with each Terraform Apply > Need to invalidate manually through AWS Console
- Adding behaviour for CloudFront cache invalidation for each time terraform apply is executed


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

- S3 Module
- Bucket
- Versioning
- Encryption
- Ownership Controls
- Public Access Block


- CloudFront Module
- Distribution
- OAC
- Cache Behavior

- S3 Bucket Policy Module
- Generating IAM policy
- Attaching policy