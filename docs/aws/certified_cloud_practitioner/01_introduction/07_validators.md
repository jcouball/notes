# Validators

Validators are below the class content (e.g. the video ./ follow-along) which
automatically validates that you did the follow-along correctly.

You have to give permission for this automation to access your account to do these
checks.

Generally you have to provide your account id, region deployed to, and other
information.

This generates a CloudFormation template that you will have to download and run via
CLI and run in the cloud shell via the AWS web interface.

You can go to CloudFormation in the AWS web UI to see if the template ran
successfully.

Be very aware that you are in the right region when finding your CloudFormation
results.

Make sure to delete the CloudFormation stack after you run it to ensure that
the permissions you gave exampro are removed from your account.
