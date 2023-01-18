# SQL Statements

## Insert data for freetext masking


## Useful list of contact data for masking compare
select id, first_name, last_name, Primary_address_street, primary_address_city, primary_address_state, phone_home, description from dbo.contacts;

select id, first_name, last_name, Primary_address_street, primary_address_city, primary_address_state, phone_home, description from dbo.contacts order by date_entered DESC;

## Pull out specific record added during demo
select id, first_name, last_name, Primary_address_street, primary_address_city, primary_address_state, phone_home, description from dbo.contacts where dbo.contacts.id='XXX';

## Find added record if needed, assuming address is blank
select id, first_name, last_name, Primary_address_street, primary_address_city, primary_address_state, phone_home, description from dbo.contacts where dbo.contacts.Primary_address_street='';

## Break a database for self service demo
drop TABLE dbo.contacts;

# Git Statements for Demo

## Get Ready / prove real
git checkout main && git pull && git fetch 

git checkout main && \
git pull && \
git fetch 

## Create branch - one liner
git branch DevBranch && git checkout DevBranch && git commit --allow-empty -m "Created DevBranch from main" && git push --set-upstream origin DevBranch

git branch DevBranch && \
git checkout DevBranch && \
git commit --allow-empty -m "Created DevBranch from main" && \
git push --set-upstream origin DevBranch

## Edit branch - one liner
echo `date` > changefile && git add . && git commit -m 'Refresh branch environment' && git push

echo `date` > changefile && \
git add . && \
git commit -m 'Refresh branch environment' && \
git push

## Clean Up - one liner
git checkout main && git pull && git fetch && git remote prune origin && git branch -D DevBranch

git checkout main && \
git pull && \
git fetch && \
git remote prune origin && \
git branch -D DevBranch

## Generic commit all changes
git add . && git commit -m ' ' && git push