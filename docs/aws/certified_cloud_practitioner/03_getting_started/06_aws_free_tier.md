# AWS Free Tier

The AWS Free Tier allows new AWS account holders to access certain services for free
for the first 12 months. This Free Tier provides the opportunity to experiment with
cloud services without incurring costs, which can be highly beneficial for learning.
However, it is essential to track your usage to ensure you stay within the Free Tier
limits.

* [Objective](#objective)
* [Steps](#steps)
    * [Step 1: Understanding the AWS Free Tier](#step-1-understanding-the-aws-free-tier)
    * [Step 2: Set Up Free Tier Usage Alerts](#step-2-set-up-free-tier-usage-alerts)
    * [Step 3: Enable Billing Alerts](#step-3-enable-billing-alerts)
    * [Step 4: Monitor Free Tier Usage](#step-4-monitor-free-tier-usage)
* [Conclusion](#conclusion)

## Objective

* Learn how to utilize the AWS Free Tier for different services like EC2 and RDS.
* Set up alerts to track Free Tier usage and avoid unexpected costs.

## Steps

### Step 1: Understanding the AWS Free Tier

* [X] Access AWS Free Tier Information

    * Open your browser and go to Google.
    * Search for "AWS Free Tier."
    * Click on the official AWS Free Tier page.
    * Review the offerings available under the Free Tier, such as:
        * 750 hours of EC2 usage (t2.micro or t3.micro instances running Linux, Red Hat,
        etc.)
        * Other services like RDS, S3, Lambda, etc.
    * Be sure to read the fine print for each service as stipulations vary (e.g., some
        services are only free for the first two months).

### Step 2: Set Up Free Tier Usage Alerts

* [X] Log into Your AWS Account:

    * Make sure you are logged into your AWS Management Console.
    * Double-check the account you are working in (visible in the top-right corner of
        the console).

* [X] Navigate to the Billing Dashboard:

    * From the AWS Management Console, go to the Billing Dashboard by typing “Billing”
        into the search bar or selecting it from the dropdown menu.
    * On the Billing Dashboard, locate the "Preferences" tab in the left-hand menu.

* [X] Enable Free Tier Usage Alerts:

    * Under Billing Preferences, check the box labeled Receive Free Tier Usage Alerts.
    * Enter your email address to receive these alerts.
    * This will notify you when your Free Tier service usage is approaching or has
        exceeded the Free Tier limits.

### Step 3: Enable Billing Alerts

* [X] Enable Billing Alerts

    * While still in the Billing Preferences section, scroll down to find the Receive
        Billing Alerts checkbox.
    * Check this box to receive billing notifications.
    * This feature allows you to set billing alerts and budgets through AWS Budgets in
        the Billing Console.

### Step 4: Monitor Free Tier Usage

* [X] Review Free Tier Usage in the Billing Dashboard:

    * Go back to the Billing Dashboard.
    * There isn’t a specific "Alerts" section within the Billing Dashboard, but you can
        track your Free Tier usage under the Cost and Usage Reports or by setting up AWS
        Budgets.
    * AWS will send email notifications if your Free Tier usage approaches or exceeds
        the Free Tier limits for services like EC2, S3, etc.

* [X] Access Usage Alerts:

    * Free Tier usage alerts are sent via email, and you can set up additional budget
        alerts to monitor your overall spending.
    * The Billing Dashboard will display usage information, but alerts themselves are
        not shown directly on the dashboard.

  Example:

    * You may see a notification such as “Your Free Tier usage limit is here and you
        have exceeded it.” This alert will be clearly displayed on your billing dashboard
        for the relevant service.

## Conclusion

By setting up these Free Tier usage alerts and billing notifications, you can
efficiently manage your usage of AWS services without incurring unexpected charges.
Be proactive in checking your usage regularly and adjusting resources as needed to
stay within the Free Tier limits.
