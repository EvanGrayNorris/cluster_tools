#!/bin/bash

if [[ "x$@" == "x" ]]; then
    echo "Flush (synchronize) NFS mounts on the nodes (make sure the headnode gets all data)."
    echo "Usage:"
    echo "$ `basename $0` node_ids"
    echo "Examples:"
    echo "$ `basename $0` 2 3 6     # Flush disk on nodes 2, 3 and 6"
    echo "$ `basename $0` 6-10 63   # Flush disk on nodes 6 to 10 (inclusively) and node 63"
fi

`dirname $0`/run_on_nodes.sh sync ${@}
