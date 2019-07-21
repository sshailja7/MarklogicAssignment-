## Step 1:
	Start the marklogic server on 8001
	
## Step 2:
	Go to 'Configure->Databases'. Create the database named 'shakplays'.
	
## step 3:
	Go to 'Configure->Forests' in left side tree view. Now create new
	forest named '1011-shakplays'
	
## Step 4:
	Go to 'Configure->Databases->shakplays->Forests' and attach the 
	forest named '1011-shakplays'4.
	
## Step 5:
	Go to 'Configure->Databases->shakplays'. Select tab 'Load'. Now
	inside  'Directorty' put the path to the following folder -> 'docs_to_upload'
	and click next and you will have database loaded

## Step 6:
	Go to 'Configure->Groups->Defaults->App Servers' and go to 'Create HTTP' tab.
	Fill in 'server name' as '1012-shakplays'
	Put the Directory where you have your project setup in 'root' field. e.g E:\Coding\Assignment
	Put the port as '1012' in 'port' fieldx
	Select the 'database' as 'shakplays'

## Step 7:
	Go to browser and open 'http://localhost:1012/'
	