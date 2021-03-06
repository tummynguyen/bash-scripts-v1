#!/bin/bash

# RUNNING THE SCRIPT FILE 
echo "[+] RUNNING $0" 

# INPUT THE SCRIPT NAME
echo -e '\n[+] ENTER NAME: '
read name 

# INPUT THE INTERPRETER 
echo -e '\n[+] ENTER INTERPRETER (TYPE A NUMBER): '
echo '1) BASH'
echo '2) PYTHON'
echo '3) CUSTOM!'
echo '4) EXIT!'
read script 

# GENERATING SCRIPT FILE USING CASE STATEMENT
case $script in
 1)
 touch ${name}.sh | chmod +x ${name}.sh | echo '#!/bin/bash' >> ${name}.sh 
 echo -e "\n${name}.sh was sucessfully created on $(pwd) at $(date)" ;;

 2)
 touch ${name}.py | chmod +x ${name}.py 
 read -p "PYTHON 3? [Y/n]" python
 if [[ $python == yes ]] || [[ $python == y ]] || [[ $python == "" ]]
  then
      echo '#!/usr/bin/python3' >> ${name}.py
  else 
      echo '#!/usr/bin/python' >> ${name}.py
 fi 
  echo -e "\n${name}.py was sucessfully created on $(pwd) at $(date)" ;;

 3)
 echo -e "\n[+] TYPE A INTERPRETER"
 read type 
 touch ${name}.${type} | chmod +x ${name}.${type} | echo "#!/usr/bin/${type}" >> ${name}.${type}
 echo "${name}.${type} was sucessfully created on $(pwd) at $(date)" ;;

 *)
 echo -e "\n EXITING $0!"
 exit 1 ;;

esac