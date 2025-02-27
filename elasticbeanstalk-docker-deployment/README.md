# Elasticbeanstalk Docker Deployment

## Why do all of this headache?
	1. Automatic horizontal scaling up/down of application instances based on traffic
	2. Configurable scaling triggers
	3. Automatic load balancer
	4. Cost effective

## Prerequisites
	Because your application will run on multiple instances, you have to make sure that some important should be centralized so every instance will have shared resources

	1. Database should be centralized
	2. Cache should be centralized
	3. Queue should be centralized
	4. Cron jobs should be synced

1. Dockerize your environment so Elasticbeanstalk can quickly create instances and run the environment container without having to install all the extensions and packages
	- Place Dockerfile in the root of your project
	- Create .dockerignore file as per your need
	- Build image in your project
	- Push the image to docker hub so Elasticbeanstalk will pull it when creating instance
	- Remove Dockerfile as it will conflict with Dockerrun.aws.json on Elasticbeanstalk

2. Create Elasticbeanstalk application and deploy project
	- Place Dockerrun.aws.json file in your project root directory
	- Place .ebextension/instance_config.config
	- Place ./platform/hooks/postdeploy/run_postdeploy.sh
	- `eb init`
	- `eb create "prod-env-01"`
	- Set your environment variables in your Elasticbeanstalk
	- Use ACM to generate certificate for SSL
	- Verify the domain name and put certificate ARN in .ebextension/instance_config.config file

> [!IMPORTANTT]
> **Note:** [useful resource](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html)
