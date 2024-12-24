# AWS Budgets

By default, IAM users and roles within an AWS account can’t access the Billing and
Budgets pages even if they have the AdministratorAccess policy attached.

The AWS account root user can allow IAM users and roles access to Billing console
pages by using the Activate IAM Access setting.

You will still need the AdministratorAccess policy attached, but you will need to do
the following using the Root user:

* [X] Sign in to your Root account
* [X] Go to My Account
* [X] Scroll down, and you should see IAM User and Role Access to Billing
  Information, choose Edit

  ![AWS Budgets](
    05_aws_budgets_01.png
  )

* [X] Select the Activate IAM Access checkbox to activate access to the Billing and
  Cost Management console pages

  ![AWS Budgets 02](
    05_aws_budgets_02.png
  )

* [X] Choose Update
* [X] Log out of your Root account and log in to your IAM user account.

You should be able to see the Billing information.

Note: In the new UI, you may need to go into IAM to add the Billing permission policy
to the Admin user group.
