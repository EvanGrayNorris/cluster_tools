#!/bin/bash

# Copyright 2010 Nicolas Bigaouette
# nbigaouette@gmail.com

# Choose which node file by uncommenting the rigth one.
#nodes_file="/etc/nodes-ib"  # InfiniBand
nodes_file="/etc/nodes"     # Gigabit


nodes=(`cat ${nodes_file}`)
#nodes=("unicron-ib" "node3-i") # For debug purpose

NOW=`date +%Y%m%d_%Hh%M`
null="/dev/null"
s="    "
log="connections_${NOW}.log"
#log="${null}"

sharps="#############################################################"
dashes="-------------------------------------------------------------"

e="echo"
er="[\e[31;1mFAIL\e[0m]"
ok="[\e[32;1mOK\e[0m]"

echo "${sharps}"                                         2>&1 | tee    ${log}
echo -n "# Testing all $((${#nodes[@]}*${#nodes[@]})) "  2>&1 | tee -a ${log}
echo "connections between nodes:"                        2>&1 | tee -a ${log}
echo "# ${nodes[@]}"                                     2>&1 | tee -a ${log}
echo "${dashes}"                                         2>&1 | tee -a ${log}

exec_n2="$e -e \"'$s'to \$n2 '${ok}'\" 2>$null ||$e -e \"    to \$n2 ${er}\""
exec_n1="for n2 in ${nodes[@]}; do rsh \$n2 ${exec_n2} ; done"

for n1 in ${nodes[@]}; do
    rsh $n1 "echo \"From $n1...\" && ${exec_n1}"         2>&1 | tee -a ${log}
done

echo "Done."                                             2>&1 | tee -a ${log}
echo "${sharps}"                                         2>&1 | tee -a ${log}

