# SugarCRM / MSSQL based DevOps Demo
Deplpoy, refresh and delete an MSSQL instance based on github actions

## Demo Flow

# Create new branch
Create a new branch in the GitHub GUI
Got to Actions and see workflow kickoff
Watch dataset get provisioned in Delphix Engine
Watch database appear in SQL server / DevOps server
Optional: Delete data to simulate issue/changes

# Edit branch
Git Checkout <branchname> locally
echo `date` > changefile 
git add *
git commit -m "branch changes"
git push

Goto github actions and see data fresh wqorkflow take place
Track in Delphix Engine
Optional: validate data refreshed via deveops machine

# Delete Branch
in Github, create and finalise a merge request
Then delete the branch
watch workflows, engine and sever to see cleanup occur
Optional: git checkout main
show the changefile update has rolled in

# Cleanup local git
git checkout main
git branch --merged
git branch -d <branchname> (for each merged branch above)
git remote prune origin
git fetch -p  (?)