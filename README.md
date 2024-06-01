Bismillah Arrahman Rahhim.
***EXPLANATION DOWN BELOW***

Shell Script made by :
	***Meryem MISSAOUI HAJIB***, 116976, meryem.missaoui-hajib@uir.ac.ma
	***Mehdi ALKADI***, 117724, mehdi.alkadi@uir.ac.ma

Our initial process of thought (some stuff is contradictory with the final code or straight up wrong, so it should be seen just as point of reference):

if there is no parameter what to do ?
	--- the arguments are exactly 2, so which means it should add a task.
	- the script should prompt the user to add due time (required as it is the continuation of the required arguments, it should check it is empty, if so then the script halts.
	- the script should prompt the user to add description (optional).
	- the script should prompt the user to add location (optional).
	- the script should prompt the user to add is the task is completed or no (optional).
	- the script should check it the todo file is empty or no:
		- if the file is empty, it initialize the id to 1.
		- if the file has some data, it should read the field of the id of the last line and increment it by 1 and assign it to the newly added task.
	- if there is a todo that have the same title, the script should either overwrite it, or add a number to it to distinguish it from the old one. it should be the user choice to do so:
		- the script should read all the title field of the file to check for the uniqueness of the title.
		- if the title is not unique (the treatment should be done before prompting the user to enter the optional information), the user is presented with a choice of either overwrite the old task, or add a number next to this task (automatically) to distinguish it.

if there is a parameter
	--- the arguments then are exactly 3, then it should read the first argument to do the necessary treatment 
	-- the -u parameter:
		- this parameter expect from the user the title of the desired task, the field to be updated (title, due date/time, description, location, completion marker), and the new value.
		- if the completion marker is selected, the script expect either a yes or a no.
	-- the parameter -d:
		- this parameter expect from the user a title, if the task is found, it shows a confirmation message, if the task is not found, it show that the task is not found (obvious no ?)
	-- the parameter -i:
		- this parameter expect from the user a title and it will show the related information about that said task.
	-- the parameter -d:
		- this parameter expect from the user a date (DD/MM/YYYY).
	-- the parameter -s:
		- this parameter expect from the user a title of a certain task, if found, it returns the related info, or else it shows an error.

if there is no parameter & no arguments
	--- the arguments then are exactly 0, it should show the task of the given day
	
the ifs needed:
if equals 0
if more than 0 and less than 2
if equals 2
if equals 3

and the edited homework (can see the advancement from the initial thought to this) :

Write a script called “todo” that maintains your todo tasks. Each todo task has a unique identifier, a title, a description, a location, a due date and time, and a completion marker. The script should prompt the user to enter all latter information. The title and the due date are required, and the other fields are optional.
The todo script should be able to perform the following actions:
• Create a task. DONE
• Update a task. -u DONE
• Delete a task. -d DONE
• Show all information about a task. -i DONE
• List tasks of a given day in two output sections: completed and uncompleted. -p DONE
• Search for a task by title. -s
When “todo” is invoked without arguments, it displays completed and uncompleted tasks of the current day. DONE
Make sure to control the validity of user inputs as much as possible. Error messages should be redirected to standard error.

and also our raw thought process of the -u and -d:
	parameters : -u field_to_update title new_value
		             $2          $3     $4
	parcourir le todo.txt
	check if title is unique
	if not
	print ids and details of the said tasks
	let the user choose the id
	for each line that doesn't have the same id, get written in a new temp file
	if same id:
	switch field to update
	case title
	case date
	case time
	case description
	case location
	case completion
	
delete:
	parameters : -d title
			  $2
	parcourir le todo.txt
	check if title is unique
	if not
	print ids and details of the said tasks
	let the user choose the id
	for each line that doesn't have the same id, get written in a new temp file
	if same id:
	skip it
	each line that doesn't have the same id, get written in a new temp file
	replace todo.txt with temp.txt


##### EXPLANATION #####

this script uses bash, and was made in Visual Studio Code in a virtual machine using Linux Manjaro.
this script can either take 0 parameters, 2 parameters, or 4 parameters (one case), anything else should prompt an error.
Case of 0 parameters:
	the script should show the user the task of the current day, this is done by calling the date function and assigning it to a variable, which is later compared to the third field of each line. If the dates are equal, it shows the content of the line, or else, it will skip it. This is done through the function called "searchByDate".
Case of 1 parameter:
	this prompt an error as there is no such input that needs 1 parameter.

Case of 2 parameters:
	with 2 parameters, the first one being an option, and second one being the argument, its gets broken down into such:
		- if no option is given and instead there are two arguments: the script checks first if the todo.txt file is empty, if so, it initializes the ID to 1 and put all the data entered by the user into the file. If however the file is not empty, it reads until the last line, gets the ID of the last line, increment it by 1 and assign it to the new task. task input and addition is done by the function "create_task"
		- option -p (period): takes as argument a date, and shows all the related info of the tasks that matches this date. it is done by reading each line and comparing the date field. to have the two sections of completed and uncompleted tasks separated, the loop is done two times
		- option -i (information): take a task title as argument, and shows the related info of that said task.
			NB: From what we deduced, the option -s and -i do the same exact thing, so we settled on keeping only -i (shows all the info a task, which also means it search for a task by its title).
		- option -d (delete): as it name suggest, it deletes a task from its title, if there is multiple tasks with the same title, it shows the info of all the tasks with the same title, shows along them their ID, and tells the user to choose the ID of the desired task to delete, then deletes it. if the task name is unique, it deletes it directly without user interaction. the function "check_uniqueness" is the one responsible for checking if the given title is unique or not.

Case of 3 parameter:
	this prompt an error as there is no such input that needs 3 parameter.

Case of 4 parameter:
	the only input that need 4 parameter is the update:
	-option -u (update): this option takes as argument the field to be updated (title, date, time, description, location, completion), the title of the task, and the new value of that said field, as mentioned previously, if a task title is not unique, the script prompt the user to choose which task based on its ID. the filed selection is done via a switch case,

How we control the input into the text file:
	- the important field are always required (title, date, time) without them, no new task is being added. With that being said, for the optional fields, if the field is kept empty, the script fills it with null, in order to not have just a void (task1,date,time,,,)

The internal field separator was modified to consider only "\n" as a delimiter so that we can read and write fields that contain spaces in them.

What could been done better ?
A LOT of the code could be shortened into functions, which will improve the code readability and organization.

Resources:
To be completely honest and fair, chatGPT was used but not to give any type of code, the entirety of this code was written by us, the only thing that was given by us via chatGPT were
	- [[]] is the enhanced version of []
	- IFS=$'\n': it enabled us to read fields with space in them
	- We asked chatGPT to give us some shell-like error messages like this (Missing arguments. Please refer to the manual for the correct script usage.
other resources are:
https://www.geeksforgeeks.org/bash-scripting-how-to-read-a-file-line-by-line/
https://stackoverflow.com/questions/2264428/how-to-convert-a-string-to-lower-case-in-bash

