# ZDMadisonJobScraper
My First Ruby Application

## What Do
The app queries the Zendesk job board for Madison, WI, seeking only the engineering positions, and compares the current count with that of the previous run. If they're different, it sends a text message to my cell via AWS SNS, and updates the count, which is stored in AWS DynamoDB.

This app is currently deployed to one of my Heroku dynamos, and runs every 10 minutes via the Heroku addon, Scheduler. The scheduler is running right now.

This app runs as coded. That's my SNS arn, there in the code, but that's fine. The secrets are in ENV, where AWS-SDK looks first.

## TODO
Dockerize it for the sake of groking Docker.
