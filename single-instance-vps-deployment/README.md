# Single Instance VPS Deployment Pipeline

1. Create RSA key pair on your vps
   > It will ask you for the location, give it some describing name for example: github_actions_deploy_key
   
   $ `ssh-keygen -t rsa -b 4096 -C "github-actions"`

2. Copy th public key to the authorized_keys on your vps

   $ `cat ~/.ssh/github_actions_deploy_key.pub`

   > Copy the output of this command to your clipboard.

   $ `vim ~/.ssh/authorized_keys`

   > Paste the public key you copied above. Ensure it is on a new line if there are already other keys present.

4. Place the public key into to the Github
   > Copy the public key
   
   $ `cat ~/.ssh/github_actions_deploy_key`

   > Go to github.com your project repo's setting then in security -> Deploy keys
   > Then add the deploy key and allow write access

6. Replace the repo remote origin https URL with ssh one
