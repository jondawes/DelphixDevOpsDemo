# SugarCRM / MSSQL based DevOps Demo

Deploy, refresh and delete an MSSQL instance based on github actions. Used the standard Delphix Cloudshare lab environment to support a DevOps focussed demo.

# Pre-Reqs

## Configure scripts

Update the follwing files with the correct addresses for your environment:
- data_ops.sh - edit Variables section at the top fo the script as noted in the file
- dxtoolkit2/dxtools.conf - Update hostname and ip_address with the public URL of your Delphic engine e.g.:
    - `"hostname": "uvo1ezo6orp6mrdjwzd.vm.cld.sr",`
	- `"ip_address": "uvo1ezo6orp6mrdjwzd.vm.cld.sr",`

## Start MSSQL Environments

Inside the Cloudshare environment run the Datasource Sqlserver > Sqlserver_start pipeline in Jenkins to ensure MSSQL environments are available.

## Open lab environments
Ideally you want to have the following screens prepared for the runthrough:
- a terminal with this repositorty checked out and up to date
- This GitHub reposiroty in a browser on the Actions tab
- Delphix Engine management interface
- Delphix Engine self service interface
- Developer VM with DBeaver open and SQL consoles pre-configured with SQL commands for the GH DB
- Optionally the SQL Server Target VM to show the drive mount process with the Disk Management MMC

## DBeaver setup

Create a new connection under SQL Server:
- host: 10.160.1.62
- port: 1433
- Database/Schema: GHvDB
- Username: sa
- Password: (sa password from lab passwords sheet)

Right click on dbo and SQL Editor > Open SQL Console and enter the following lines:
- `select * from contacts;`  Use to show contents are available
- `drop TABLE contacts;`    Use to delete data to show refresh works
Place cursor on either line and hit CTRL+ENTER to run

# Demo Flow

## Create new branch

- `git branch DevBranch && git checkout DevBranch && git commit --allow-empty -m "Created DevBranch from main" && git push --set-upstream origin DevBranch`
- Go to Actions in the GitHub repository and watch workflow kickoff
- Watch dataset get provisioned in Delphix Engine
- Show the Self Service container and highlight the operations available
- Optional: Watch database appear in SQL server / DevOps server
- Optional: Delete data to simulate issue/changes via DBeaver

## Edit branch

- ``echo `date` > changefile`` 
- `git add . && git commit -m 'Refresh branch environment' && git push`
- Goto github actions and see data refresh workflow take place
- Track in Delphix Engine & Self Service portal
- Optional: Show data restored in DBeaver

## Delete Branch

- In Github, create and finalise a merge request, then delete the branch.
- Watch workflows, engine and sever to see cleanup occur

## Cleanup local git (or just delete it and checkout again)

- `git checkout main && git pull && git fetch`
- Optional: show the changefile update has rolled into main (if not emoing this, the cleanup section can be done post demo)
- `git remote prune origin`
- `git branch -d DevBranch` 
