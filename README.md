# ZDMadisonJobScraper
My First Ruby Application

## What do
The app queries the Zendesk job board for Madison, WI, seeking only the engineering positions, and compares the current count with that of the previous run. If they're different, it sends a text message to my cell via AWS SNS.

This app is currently deployed to one of my Heroku dynamos, and runs every 10 minutes via the Heroku addon, Scheduler. The scheduler is running right now.
