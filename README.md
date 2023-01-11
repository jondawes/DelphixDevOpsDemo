# SugarCRM / MSSQL based DevOps Demo

Deploy, refresh and delete an MSSQL instance based on github actions.

# Pre-Reqs

## Configure scripts

Update the follwing files with the correct addresses for your environment

## Start MSSQL Environments

Run the Datasource Sqlserver > Sqlserver_start pipeline in Jenkins to ensure MSSQL environments are available.

## DBeaver setup

create a new connection under SQL Server:
- host: 10.160.1.62
- port: 1433
- Database/Schema: GHvDB
- Username: sa
- Password: (sa password from lab passwords sheet)

Right click on dbo and SQL Editor > Open SQL Console
select * from contacts;
CTRL+ENTER

# Demo Flow

## Create new branch

`git branch DevBranch && git checkout DevBranch && git commit --allow-empty -m "Created DevBranch from main" && git push --set-upstream origin DevBranch`<br/>
Go to Actions and see workflow kickoff<br/>
Watch dataset get provisioned in Delphix Engine<br/>
Watch database appear in SQL server / DevOps server

Optional: Delete data to simulate issue/changes<br/>

## Edit branch

``echo `date` > changefile`` <br/>
`git add . && git commit -m 'Refresh branch environment' && git push`

Goto github actions and see data refresh workflow take place<br/>
Track in Delphix Engine & Self Service portal<br/>

Optional: validate data refreshed via deveops machine<br/>

## Delete Branch

In Github, create and finalise a merge request, then delete the branch.<br/>
Watch workflows, engine and sever to see cleanup occur<br/>

## Cleanup local git (or just delete it and checkout again)

`git checkout main && git pull && git fetch`<br/>
Optional: show the changefile update has rolled into main<br/>
`git remote prune origin`<br/>
`git branch -d DevBranch` (for each branch output above to be deleted)<br/>
