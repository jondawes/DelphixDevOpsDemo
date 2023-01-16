# SQL Statements

## Useful list of contact dat for masking compare
select id, first_name, last_name, Primary_address_street, primary_address_city, primary_address_state, phone_home, description from dbo.contacts;

## Pull out specific record added during demo
select id, first_name, last_name, Primary_address_street, primary_address_city, primary_address_state, phone_home, description from dbo.contacts where dbo.contacts.id='58ad9c21-ce82-ed6d-e325-63c0cd5547c5';

## Find added record if needed, assuming address is blank
select id, first_name, last_name, Primary_address_street, primary_address_city, primary_address_state, phone_home, description from dbo.contacts where dbo.contacts.Primary_address_street='';

## Break a database for self service demo
drop TABLE dbo.contacts;

# Git Statements

git checkout main && git pull && git fetch 

git branch DevBranch && git checkout DevBranch && git commit --allow-empty -m "Created DevBranch from main" && git push --set-upstream origin DevBranch

echo `date` > changefile && git add . && git commit -m 'Refresh branch environment' && git push

git checkout main && git pull && git fetch 
git remote prune origin && git branch -D DevBranch
git branch

git checkout main && git pull && git fetch && git remote prune origin && git branch -D DevBranch