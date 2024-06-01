#!/bin/bash

file=$(cat todo.txt)
IFS=$'\n'

create_task(){
    read -r -p "Time > " time
                while [ "$time" == "" ]
                do
                    echo "Time is a required attribute, please try again"
                    read -r -p "Time > " time
                done

                read -r -p "Description > " description
                if [[ $description == "" ]];
                then
                    description=null
                fi

                read -r -p "Location > " location
                if [[ $location == "" ]];
                then
                    location=null
                fi

                read -r -p "Is It Complete[Y/n] ? > " completionMarker
                if [[ $(echo "$completionMarker" | tr '[:upper:]' '[:lower:]') == "y" ]];
                then
                    completionMarker=true
                
                elif [[ $(echo "$completionMarker" | tr '[:upper:]' '[:lower:]') == "n" ]];
                then
                    completionMarker=false
                else
                    completionMarker=null
                fi

                echo "$1,$2,$3,$time,$description,$location,$completionMarker" >> todo.txt
                echo "--- Task added Successfully ! ---"
                echo "Task details :"
                echo "  Task Title       : $2"
                echo "  Task Date        : $3"
                echo "  Task Time        : $time"
                echo "  Task Description : $description"
                echo "  Task Location    : $location"
                echo "  Task Completion  : $completionMarker"
}

searchByDate(){
    i=1
        for line in $file
        do
            date=$(echo "$line" | cut -d "," -f 3)
            if [[ "$date" == "$1" ]];
            then
                echo "Task $i :"
                echo "  -- Task details :"
                echo "      - Task Title       : $(echo "$line" | cut -d "," -f 2)"
                echo "      - Task Date        : $(echo "$line" | cut -d "," -f 3)"
                echo "      - Task Time        : $(echo "$line" | cut -d "," -f 4)"
                echo "      - Task Description : $(echo "$line" | cut -d "," -f 5)"
                echo "      - Task Location    : $(echo "$line" | cut -d "," -f 6)"
                echo "      - Task Completion  : $(echo "$line" | cut -d "," -f 7)"
                i=$((i+1))
            fi
        done
}

taskStatus(){
            i=1
        for line in $file
        do
            date=$(echo "$line" | cut -d "," -f 3)
            if [[ "$date" == "$1" ]];
            then
                if [[ $(echo "$line" | cut -d "," -f 7) == "$2" ]];
                then
                echo "Task $i :"
                echo "  -- Task details :"
                echo "      - Task Title       : $(echo "$line" | cut -d "," -f 2)"
                echo "      - Task Date        : $(echo "$line" | cut -d "," -f 3)"
                echo "      - Task Time        : $(echo "$line" | cut -d "," -f 4)"
                echo "      - Task Description : $(echo "$line" | cut -d "," -f 5)"
                echo "      - Task Location    : $(echo "$line" | cut -d "," -f 6)"
                i=$((i+1))
                foundTasks=1
                fi
            fi
        done
            if [[ "$foundTasks" != 1 ]] && [[ "$2" == "true" ]];
            then
                echo "No completed task found for this date !"
            fi
            if [[ "$foundTasks" != 1 ]] && [[ "$2" == "false" ]];
            then
                echo "No uncompleted task found for this date !"
            fi
}

check_uniqueness(){
        flag=0
        for line in $file
        do
            if [[ $(echo "$line" | cut -d "," -f 2) == "$1" ]];
            then
                flag=$((flag+1))
            fi
        done
        return $flag
}

taskExistance(){
    exist=0
    for line in $file
        do
            if [[ "$(echo "$line" | cut -d "," -f 2)" == "$1" ]];
            then
                exist=1
            fi
        done
    return $exist
}

if [ $# -eq 0 ];
then
    todayDate=$(date +"%d/%m/%Y")
    searchByDate "$todayDate"
elif [ $# -eq 1 ];
then
    echo "Missing arguments. Please refer to the manual for the correct script usage."

elif [ $# -eq 2 ] || [ $# -eq 4 ];
then
if [[ -s todo.txt ]];
then
        if [[ $1 == -* ]]; then
            parameter=$1
            case $parameter in
        -u)
            if [[ $# != 4 ]];
            then
                echo "Missing arguments. Please refer to the manual for the correct script usage."
            else
                taskExistance "$3"
                result=$?
                if [[ "$result" -eq 0 ]];
                then
                echo "--- No Such Task Found ---"
                exit 1
                fi
                check_uniqueness "$3"
                result=$?
                if [[ "$result" -gt 1 ]];
                then
                echo "There is more that one task with the same name, please choose the id of the desired task to continue"
                for line in $file
                do
                if [[ "$3" == $(echo "$line" | cut -d "," -f 2) ]];
                then
                    echo "  -- Task details :"
                    echo "      - Task Id          : $(echo "$line" | cut -d "," -f 1)"
                    echo "      - Task Title       : $(echo "$line" | cut -d "," -f 2)"
                    echo "      - Task Date        : $(echo "$line" | cut -d "," -f 3)"
                    echo "      - Task Time        : $(echo "$line" | cut -d "," -f 4)"
                    echo "      - Task Description : $(echo "$line" | cut -d "," -f 5)"
                    echo "      - Task Location    : $(echo "$line" | cut -d "," -f 6)"
                    echo "      - Task Completion  : $(echo "$line" | cut -d "," -f 7)"
                fi
                done
                read -r -p "Enter the id of the desired task to update : " id
                case $2 in
                title)
                for line in $file
                do
                if [[  $(echo "$line" | cut -d "," -f 1) == "$id" ]];
                then
                    echo "$(echo "$line" | cut -d "," -f 1),$4,$(echo "$line" | cut -d "," -f 3),$(echo "$line" | cut -d "," -f 4),$(echo "$line" | cut -d "," -f 5),$(echo "$line" | cut -d "," -f 6),$(echo "$line" | cut -d "," -f 7)" >> temp.txt
                else
                    echo "$line" >> temp.txt
                fi
                done
                ;;
                date)
                for line in $file
                do
                if [[  $(echo "$line" | cut -d "," -f 1) == "$id" ]];
                then
                    echo "$(echo "$line" | cut -d "," -f 1),$(echo "$line" | cut -d "," -f 2),$4,$(echo "$line" | cut -d "," -f 4),$(echo "$line" | cut -d "," -f 5),$(echo "$line" | cut -d "," -f 6),$(echo "$line" | cut -d "," -f 7)" >> temp.txt
                else
                    echo "$line" >> temp.txt
                fi
                done
                ;;
                time)
                for line in $file
                do
                if [[  $(echo "$line" | cut -d "," -f 1) == "$id" ]];
                then
                    echo "$(echo "$line" | cut -d "," -f 1),$(echo "$line" | cut -d "," -f 2),$(echo "$line" | cut -d "," -f 3),$4,$(echo "$line" | cut -d "," -f 5),$(echo "$line" | cut -d "," -f 6),$(echo "$line" | cut -d "," -f 7)" >> temp.txt
                else
                    echo "$line" >> temp.txt
                fi
                done
                ;;
                description)
                for line in $file
                do
                if [[  $(echo "$line" | cut -d "," -f 1) == "$id" ]];
                then
                    echo "$(echo "$line" | cut -d "," -f 1),$(echo "$line" | cut -d "," -f 2),$(echo "$line" | cut -d "," -f 3),$(echo "$line" | cut -d "," -f 4),$4,$(echo "$line" | cut -d "," -f 6),$(echo "$line" | cut -d "," -f 7)" >> temp.txt
                else
                    echo "$line" >> temp.txt
                fi
                done
                ;;
                location)
                for line in $file
                do
                if [[  $(echo "$line" | cut -d "," -f 1) != "$id" ]];
                then
                    echo "$(echo "$line" | cut -d "," -f 1),$(echo "$line" | cut -d "," -f 2),$(echo "$line" | cut -d "," -f 3),$(echo "$line" | cut -d "," -f 4),$(echo "$line" | cut -d "," -f 5),$4,$(echo "$line" | cut -d "," -f 7)" >> temp.txt
                else
                    echo "$line" >> temp.txt
                fi
                done
                ;;
                completion)
                for line in $file
                do
                if [[  $(echo "$line" | cut -d "," -f 1) = "$id" ]];
                then
                    echo "$(echo "$line" | cut -d "," -f 1),$(echo "$line" | cut -d "," -f 2),$(echo "$line" | cut -d "," -f 3),$(echo "$line" | cut -d "," -f 4),$(echo "$line" | cut -d "," -f 5),$(echo "$line" | cut -d "," -f 6),$4" >> temp.txt
                else
                    echo "$line" >> temp.txt
                fi
                done
                ;;
                esac
                else
                case $2 in
                title)
                for line in $file
                do
                    if [[  $(echo "$line" | cut -d "," -f 2) != "$3" ]];
                    then
                    echo "$line" >> temp.txt
                    else
                        echo "$(echo "$line" | cut -d "," -f 1),$4,$(echo "$line" | cut -d "," -f 3),$(echo "$line" | cut -d "," -f 4),$(echo "$line" | cut -d "," -f 5),$(echo "$line" | cut -d "," -f 6),$(echo "$line" | cut -d "," -f 7)" >> temp.txt
                    fi
                done
                ;;
                date)
                for line in $file
                do
                    if [[  $(echo "$line" | cut -d "," -f 2) != "$3" ]];
                    then
                    echo "$line" >> temp.txt
                    else
                        echo "$(echo "$line" | cut -d "," -f 1),$(echo "$line" | cut -d "," -f 2),$4,$(echo "$line" | cut -d "," -f 4),$(echo "$line" | cut -d "," -f 5),$(echo "$line" | cut -d "," -f 6),$(echo "$line" | cut -d "," -f 7)" >> temp.txt
                    fi
                done
                ;;
                time)
                for line in $file
                do
                    if [[  $(echo "$line" | cut -d "," -f 2) != "$3" ]];
                    then
                    echo "$line" >> temp.txt
                    else
                        echo "$(echo "$line" | cut -d "," -f 1),$(echo "$line" | cut -d "," -f 2),$(echo "$line" | cut -d "," -f 3),$4,$(echo "$line" | cut -d "," -f 5),$(echo "$line" | cut -d "," -f 6),$(echo "$line" | cut -d "," -f 7)" >> temp.txt
                    fi
                done
                ;;
                description)
                for line in $file
                do
                    if [[  $(echo "$line" | cut -d "," -f 2) != "$3" ]];
                    then
                    echo "$line" >> temp.txt
                    else
                        echo "$(echo "$line" | cut -d "," -f 1),$(echo "$line" | cut -d "," -f 2),$(echo "$line" | cut -d "," -f 3),$(echo "$line" | cut -d "," -f 4),$4,$(echo "$line" | cut -d "," -f 6),$(echo "$line" | cut -d "," -f 7)" >> temp.txt
                    fi
                done
                ;;
                location)
                for line in $file
                do
                    if [[  $(echo "$line" | cut -d "," -f 2) != "$3" ]];
                    then
                    echo "$line" >> temp.txt
                    else
                        echo "$(echo "$line" | cut -d "," -f 1),$(echo "$line" | cut -d "," -f 2),$(echo "$line" | cut -d "," -f 3),$(echo "$line" | cut -d "," -f 4),$(echo "$line" | cut -d "," -f 5),$4,$(echo "$line" | cut -d "," -f 7)" >> temp.txt
                    fi
                done
                ;;
                completion)
                for line in $file
                do
                    if [[  $(echo "$line" | cut -d "," -f 2) != "$3" ]];
                    then
                    echo "$line" >> temp.txt
                    else
                        echo "$(echo "$line" | cut -d "," -f 1),$(echo "$line" | cut -d "," -f 2),$(echo "$line" | cut -d "," -f 3),$(echo "$line" | cut -d "," -f 4),$(echo "$line" | cut -d "," -f 5),$(echo "$line" | cut -d "," -f 6),$4" >> temp.txt

                    fi
                done
                ;;
                esac
                fi
                mv -f "temp.txt" "todo.txt"
                echo "--- Task updated successfully --- "
            fi
            ;;
        -p)
            if [[ $# != 2 ]];
            then
                echo "Missing arguments. Please refer to the manual for the correct script usage."
            else
            echo "-- Completed Tasks : "
                taskStatus "$2" "true"
            echo ""
            echo "-- Uncompleted Tasks : "
                taskStatus "$2" "false"
            fi
            ;;
        -i)
            if [[ $# != 2 ]];
            then
                echo "Missing arguments. Please refer to the manual for the correct script usage."
            else
                for line in $file
                do
                if [[ "$(echo "$line" | cut -d "," -f 2)" == "$2" ]];
                then
                    echo "  -- Task details :"
                    echo "      - Task Title       : $(echo "$line" | cut -d "," -f 2)"
                    echo "      - Task Date        : $(echo "$line" | cut -d "," -f 3)"
                    echo "      - Task Time        : $(echo "$line" | cut -d "," -f 4)"
                    echo "      - Task Description : $(echo "$line" | cut -d "," -f 5)"
                    echo "      - Task Location    : $(echo "$line" | cut -d "," -f 6)"
                    echo "      - Task Completion  : $(echo "$line" | cut -d "," -f 7)"
                    found=1
                fi
                done
                if [[ "$found" != 1 ]];
                then
                    echo "--- No Such Task Found ---"
                fi
            fi
            ;;
        -d)
            if [[ $# != 2 ]];
            then
                echo "Missing arguments. Please refer to the manual for the correct script usage."
            else
                check_uniqueness "$2"
                echo "$result"
                if [[ "$result" -gt 1 ]];
                then
                echo "There is more that one task with the same name, please choose the id of the desired task to continue"
                for line in $file
                do
                if [[ "$2" == $(echo "$line" | cut -d "," -f 2) ]];
                then
                    echo "  -- Task details :"
                    echo "      - Task Id          : $(echo "$line" | cut -d "," -f 1)"
                    echo "      - Task Title       : $(echo "$line" | cut -d "," -f 2)"
                    echo "      - Task Date        : $(echo "$line" | cut -d "," -f 3)"
                    echo "      - Task Time        : $(echo "$line" | cut -d "," -f 4)"
                    echo "      - Task Description : $(echo "$line" | cut -d "," -f 5)"
                    echo "      - Task Location    : $(echo "$line" | cut -d "," -f 6)"
                    echo "      - Task Completion  : $(echo "$line" | cut -d "," -f 7)"
                fi
                done
                read -r -p "Enter the id of the desired task to delete :" id
                for line in $file
                do
                if [[  $(echo "$line" | cut -d "," -f 1) != "$id" ]];
                then
                    echo "$line" >> temp.txt
                fi
                done
                fi
                mv -f "temp.txt" "todo.txt"
                echo "--- Task deleted successfully --- "
            fi
            ;;
        *)
            echo "Wrong Parameter. Please refer to the manual for the correct script usage."
            ;;
    esac
    
        else
            if [[ $# != 2 ]];
            then
                echo "Missing arguments. Please refer to the manual for the correct script usage."
            else
                if [ -s todo.txt ]; # Checks if file exist and is empty or not. (-s)
                then
                    for line in $file
                    do
                        id=$(( $(echo "$line" | cut -d "," -f 1) + 1 ))
                    done
                    create_task "$id" "$1" "$2"
                else
                    create_task 1 "$1" "$2"
                fi
            fi
        fi
else
echo "--- The file is empty, add some todo task to operate on them ---"
fi
else
    echo "Missing arguments. Please refer to the manual for the correct script usage."
fi






# Script made by Meryem & Mehdi.
