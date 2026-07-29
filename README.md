# guitar--scales-fretboard
Guitar Fretboard featuring notes, scales and visual indicators for learning

Reasons for not using Javascript is to solidify the usage of cloud services learned and to improve upon it.

Source for AWS Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs


30/7/2026
- Done with Github Actions - multiple issues with the OIDC
- Finally debugged The issue; the current setup is using GitHub's old immutable subject claim - Updatedating the module so that the module becomes modular/reusable
- Hard coded the repo on the github_actions module instead of restructuring the module again. Testing

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