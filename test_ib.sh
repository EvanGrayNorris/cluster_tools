#!/bin/bash

min_node="2"
max_node="69"
node_file="/tmp/nodes_ib_testing"
old_NODES=${NODES}
export NODES=${node_file}

function create_node_file()
{
    # Create node file
    rm -f ${node_file}
    for node_id in `seq ${min_node} ${max_node}`; do
        echo "node${node_id}" >> ${node_file}
    done
}

# Run: rcom-nodes ibv_rc_pingpong

function ping_ib_nodes()
{
    for node_id in `seq ${min_node} ${max_node}`; do
        echo "###############################################################"
        ssh node${node_id} "/home/nicolas/cluster_tools.git/run_ibv_rc_pingpong.sh" &
        sleep 1
        #echo "node_id = $node_id"
        command="ibv_rc_pingpong node${node_id}"
        echo "$command"
        eval $command
        sleep 2
    done
}

export NODES=${old_NODES}
