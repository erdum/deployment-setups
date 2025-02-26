# Shared Hosting Deployment Pipeline

- Get FTP details from your hosting provider

- Place deploy.php at the root of your Laravel project

- Place htaccess.example at the root of your Laravel project

- Place .env.production file with the required values in the serving directory of your hosting provider usually in public_html

- Put FTP details in the github repo secrets as defined inside .github/workflows/deploy.yaml

- Make sure branch and script paths are correct in your .github/workflows/deploy.yaml

## How flow triggers and works

1. when you push commit to the specified branch it run the .github/workflows/deploy.yaml workflow file which checkout your latest code

2. Then it runs the deploy.sh script which make your Laravel project ready and create a zip file of it with all of the dependencies and packages.

3. Workflow file then transfer the zip to your hosting provider via FTP

4. Finally workflow file triggers the deploy.php script and it cleaned up the deployment

> [!IMPORTANT]
> **Note:** Double-check that the FTP credentials are correct and have the necessary permissions to upload and modify files on your hosting server.
> **Note:** If your project depends on additional PHP extensions then make sure they are available in your hosting plan.