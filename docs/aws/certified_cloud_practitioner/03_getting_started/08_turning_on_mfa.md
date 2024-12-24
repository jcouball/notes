# Turning on MFA for the AWS Root User Account

* [Objective](#objective)
* [Steps](#steps)
    * [Step 1: Log in as the Root User](#step-1-log-in-as-the-root-user)
    * [Step 2: Navigate to MFA Settings](#step-2-navigate-to-mfa-settings)
    * [Step 3: Choose MFA Device Type](#step-3-choose-mfa-device-type)
    * [Step 4: Configure Virtual MFA (if chosen)](#step-4-configure-virtual-mfa-if-chosen)
    * [Step 5: Verify MFA Setup](#step-5-verify-mfa-setup)
    * [Step 6: Test the MFA](#step-6-test-the-mfa)
    * [Optional: Use a Security Key for MFA](#optional-use-a-security-key-for-mfa)
* [Notes and Recommendations](#notes-and-recommendations)

## Objective

Enable Multi-Factor Authentication (MFA) for the AWS root user account to enhance
account security.

## Steps

### Step 1: Log in as the Root User

* [X] Sign Out of your current IAM user account (if logged in).

* [X] Go to the AWS Management Console login page.

* [X] Select Root user at the login screen (if it doesn’t default to it).

* [X] Enter the root user email address and click Next.

* [X] Complete the CAPTCHA verification (if prompted).

* [X] Enter your root user password and click Sign In.

### Step 2: Navigate to MFA Settings

* [X] Once logged in, go to the IAM Dashboard:

    * Use the search bar at the top of the AWS Console and type IAM.
    * Select IAM from the search results.

* [X] In the left-hand menu, click Dashboard.

* [X] Look for the Security Recommendations section and find Root user MFA.

* [X] Click Add MFA next to the root user recommendation.

### Step 3: Choose MFA Device Type

* [X] On the Manage MFA Device screen, select your preferred MFA device type:

    * Virtual MFA device (e.g., Authy, Google Authenticator, or Microsoft
        Authenticator).
    * U2F Security Key (e.g., YubiKey or hardware token).
    * Other hardware MFA device (e.g., Gemalto token).

* [X] Click Continue.

### Step 4: Configure Virtual MFA (if chosen)

* [X] Install a compatible authenticator app on your smartphone:

    * Recommended: Google Authenticator, Microsoft Authenticator, or Authy.

* [X] In the app, tap Add Account or Scan QR Code.

* [X] On the AWS Console, click Show QR Code.

* [X] Use your phone’s camera within the app to scan the displayed QR code.

* [X] Optionally, rename the account in the app for easy identification (e.g., AWS
  Root User).

### Step 5: Verify MFA Setup

* [X] The authenticator app will generate a 6-digit code. Enter the first code into
  the MFA Code 1 field in the AWS Console.

* [X] Wait for the app to generate a new 6-digit code. Enter this second code into
  the MFA Code 2 field.

* [X] Click Assign MFA to complete the setup.

### Step 6: Test the MFA

* [X] Log out of your root user account.

* [X] Attempt to log back in as the root user.

    * Enter your root email and password.
    * When prompted, retrieve the 6-digit MFA code from your authenticator app.
    * Enter the code and click Submit.

* [X] Ensure you can successfully log in with MFA.

### Optional: Use a Security Key for MFA

1. If using a security key (e.g., YubiKey):
    * Select U2F Security Key on the MFA setup screen.
    * Insert your security key into a USB port.
    * Tap the key when prompted.
2. Click Assign MFA to complete the setup.
3. Log out and test the security key for login.

## Notes and Recommendations

* Virtual MFA is free and works on any smartphone.
* Security keys offer a more convenient experience, especially for frequent logins,
  as they require only a button press.
* Ensure you securely store your root user credentials and MFA device to prevent
  account lockout.
