# Create IAM User

## Step 1: Sign in to the AWS Management Console

* [X] Log into the AWS Management Console using your root user credentials.

* [X] Once logged in, you'll be on the AWS Management Console homepage. The most
  recently used services are displayed here.

## Step 2: Update Account Name (Optional)

* [X] If you want to change your account name:

    * Click on your account name in the top right corner and select "My Account."
    * In the "Account Settings" section, click "Edit" to change the account name.

## Step 3: Log Out and Familiarize with AWS Login

* [X] Log out of your root account to practice logging back in.

* [X] Go to the login page, and you'll notice two options: "Root user" and "IAM
  user."

    * When using the "Root user" option, you log in with your email address.
    * When using the "IAM user" option, you log in with your account ID or alias.

## Step 4: Set Up an IAM User

* [X] Log back in to your root account.

* [X] In the search bar, type "IAM" and select "IAM" from the services.

* [X] On the IAM dashboard, you will see security recommendations

    One of the recommendations is to set up an alias for your account. You can set the
    alias to make it easier to log in.

* [X] In the left sidebar, select "Users."

* [X] Click "Add users" to create a new IAM user.

## Step 5: Provide User Details

* [X] Enter a username for the new IAM user (e.g., "Andrew Brown").

* [X] Choose the access type:

    * Programmatic access: Allows access to AWS via API, CLI, or SDK.
    * AWS Management Console access: Allows the user to log into the AWS Console.
    * You can choose one or both options based on the requirements.

* [X] If you select "AWS Management Console access," select the password option:

    * Auto-generate a password or Custom password.
    * Ensure "Require password reset" is checked.

## Step 6: Set Permissions

* [X] Click "Next: Permissions."

* [X] Choose how to assign permissions:

    * Add user to group: Click "Create group" and name it (e.g., "admin").
    * Select the "AdministratorAccess" policy to provide full access to AWS services.

* [X] If you want more specific permissions, explore "AWS managed policies" to assign
  roles like "PowerUserAccess."

* [X] Click "Create group" and add the user to the new group.

## Step 7: (Optional) Add Tags

* [X] Click "Next: Tags."

* [X] Optionally, add metadata to your user (e.g., department, role).

## Step 8: Review and Create User

* [X] Click "Next: Review" to see a summary of the user's details.

* [X] Click "Create user."

* [X] A page will display the new user's Access key ID and Secret access key. Copy
  these credentials and store them securely.

## Step 9: Set Up Account Alias

* [X] To set up an account alias (useful for logging in):

    * In the IAM dashboard, under "Account settings," click "Create account alias."
    * Enter an alias (e.g., "DeepSpaceNine").

## Step 10: Log In with the IAM User

* [X] Log out of the root account.

* [X] Go to the AWS login page and choose "IAM user."

* [X] Enter your account alias or account ID.

* [X] Enter the IAM username (e.g., "Andrew Brown") and the password.

* [X] If prompted, reset the password using a strong, unique one.

## Step 11: Verify Login

* [X] Log out and log back in to ensure that the new IAM user account is set up
  correctly.

* [X] When logged in as the IAM user, the console displays the username and account
  alias to distinguish it from the root account.

For detailed information on IAM user creation, refer to the official AWS
documentation.
