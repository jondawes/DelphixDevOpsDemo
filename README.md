# SugarCRM / MSSQL based DevOps Demo

Deploy, refresh and delete an MSSQL instance based on github actions

# Demo Flow

## Create new branch

Create a new branch in the GitHub GUI<br/>
Got to Actions and see workflow kickoff<br/>
Watch dataset get provisioned in Delphix Engine<br/>
Watch database appear in SQL server / DevOps server<br/>
Optional: Delete data to simulate issue/changes<br/>

Or via CLI:<br/>
git branch DevBranch<br/>
git checkout DevBranch<br/>
git push --set-upstream origin DevBranch

## Edit branch

git fetch 
git Checkout <branchname> locally<br/>
``echo `date` > changefile`` <br/>
git add *<br/>
git commit -m "branch changes"<br/>
git push<br/>

git add . && git commit -m 'Refresh branch environment' && git push

Goto github actions and see data fresh workflow take place<br/>
Track in Delphix Engine<br/>
Optional: validate data refreshed via deveops machine<br/>

## Delete Branch

in Github, create and finalise a merge request<br/>
Then delete the branch<br/>
watch workflows, engine and sever to see cleanup occur<br/>
Optional: git checkout main<br/>
show the changefile update has rolled in<br/>

## Cleanup local git (or just delete it and checkout again)

git checkout main<br/>
git branch --merged<br/>
git branch -d <branchname> (for each merged branch above)<br/>
git remote prune origin<br/>
git fetch -p  (?)<br/>