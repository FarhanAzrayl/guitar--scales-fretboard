# guitar--scales-fretboard
Guitar Fretboard featuring notes, scales and visual indicators for learning. This project is to assist in solidifying my understanding of a potential team-oriented workflow, and while doing that to also learn musical and guitar scales as I am a guitar player and would like to improve myself. The project is aimed to hit two birds with one stone, mixing practical working knowledge and hobby related knowledge.

Functionality Goals to achieve:
- Dispaly guitar fretboard; toggle between an empty fretboard and a note-filled fretboard
- Choose a root note and a desired scale, and a highlighted guitar fretboard in accordance with the choice
- Change the tuning on each string to enable custom tunings while still highlighting the notes within a scale
- Admin Role - to add additional scales in the future, and also custom tuning presets if desired

Reasons for not using Javascript is to solidify the usage of cloud services already learned and to improve upon it.

Source for AWS Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs


2/8/2026
- Adding hashicorp/archive provider to the Terraform dev environment > ran terraform init
- Adding apigateway module - Decided to use REST API, but since cost is considered we will not add API Gateway Caching, and we will try to not attach AWS WAF (Web Application Firewall) later on

30/7/2026
- Done with Github Actions - multiple issues with the OIDC
- Finally debugged The issue; the current setup is using GitHub's old immutable subject claim - Updatedating the module so that the module becomes modular/reusable
- Hard coded the repo on the github_actions module instead of restructuring the module again. Testing
- Access issues. Added more Roles to the list in github_actions role condition > Note: If we are facing too many access issues, might as well just use :* but lets kee it proper for now
- Adding the groundwork for Lambda functionality

29/7/2026
Finished with the pipeline setup - testing

28/7/2026
Issues with the setup of the pipeline - debugging

25/7/2026
Adding Pipeline to the Github

24/7/2026
Adding and setting up Cloudfron module. Had to fix all issues that came up when setting it up

23/7/2026:
Had to create a new module for the S3 bucket policy, because of a circular dependancy issue and after troubleshooting, the current module responsibilities:

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