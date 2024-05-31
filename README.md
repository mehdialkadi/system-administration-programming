# system-administration-programming


***Our initial analysis***

if there is no parameter what to do ?
	--- the arguments are exactly 2, so which means it should add a task.
	- the script should prompt the user to add due time (required as it is the continuation of the required arguments, it should check it is empty, if so then the script halts.
	- the script should prompt the user to add description (optional).
	- the script should prompt the user to add location (optional).
	- the script should prompt the user to add is the task is completed or no (optional).
	- the script should check it the todo file is empty or no:
		- if the file is empty, it initialise the id to 1.
		- if the file has some data, it should read the field of the id of the last line and incerement it by 1 and assign it to the newly added task.
	- if there is a todo that have the same title, the script should either overwrite it, or add a number to it to distinguish it from the old one. it should be the user choice to do so:
		- the script should read all the title field of the file to check for the uniqness of the title.
		- if the title is not unique (the treatment should be done before prompting the user to enter the optional informations), the user is presented with a choice of either overwrite the old task, or add a number next to this task (automaticaly) to distinguish it.




if there is a parameter
	--- the arguments then are exactly 3, then it should read the first argument to do the necessary treatment 
	-- the -u parameter:
		- this parameter expect from the user the title of the desired task, the field to be updated (title, due date/time, description, location, completion marker), and the new value.
		- if the completion marker is selected, the script expect either a yes or a no.
	-- the parameter -d:
		- this parameter expect from the user a title, if the task is found, it shows a confirmation message, if the task is not found, it show that the task is not found (obvious no ?)
	-- the parameter -i:
		- this parameter expect from the user a title and it will show the related informations about that said task.
	-- the parameter -d:
		- this parameter expect from the user a date (DD/MM/YYYY).
	-- the parameter -s:
		- this parameter expect from the user a title of a certain task, if found, it returns the related infos, or else it shows an error.




if there is no parameter & no arguments
	--- the arguments then are exactly 0, it should show the task of the given day

the ifs needed:
if equals 0
if more than 0 and less than 2
if equals 2
if equals 3
