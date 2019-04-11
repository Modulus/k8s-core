
#!/bin/bash
vars=("$@")
if [ ${#vars[@]} -lt 2 ]
then
    echo "Usage sh roles.sh apply/delete role namespace1 namespace2"
    echo "Example: sh roles.sh apply developer ai"
    echo "Exmpale: sh roles.sh delete ns-admin ai"
elif [ ${vars[0]} == *"create"* ] || [[ ${vars[0]} == *"apply"* ]] || [[ ${vars[0]} == *"delete"* ]]
then
    echo "Running ${vars[0]} on roles and rolebindings in namespaces ${vars[@]:1}"
    for var in ${vars[@]:2}; do
        echo "${vars[0]} ${vars[1]} role in namespace $var with file ${vars[1]}.yml"

        sed -e "s/\${NS}/${var}/"  ./${vars[1]}.yml |  kubectl ${vars[0]} -f -
    done

else
    echo "Something weird happened"
fi


# elif [ ${#vars[@]} -ge 2 ] && [[ ${vars[0]} == *"apply"* ]]
# for var in ${vars[@]:1}; do
#     echo ${var}
# done

# for n in ${ns[@]}
# do
#     echo "Creating developer role in namespace $n"

#     sed -e "s/\${NS}/${n}/"  ./developer.yml |  kubectl apply -f -
# done