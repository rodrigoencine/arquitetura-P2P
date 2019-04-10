#!/bin/bash

compile()
{
    javac -d bin/ src/server/*.java src/client/*.java src/bench/*.java src/util/*.java
}


run_server()
{
    PORT=$1

    if [ $# -eq 1 ]; then
        java -classpath bin/ server.CentralIndexingServer $PORT
    else
        java -classpath bin/ server.CentralIndexingServer
    fi
}

run_client()
{
    DIRECTORY=$1
    PORT=$2
    SERVER=$3
    SERVERPORT=$4

    if [ $# -lt 2 ]; then
        echo "It should be run_client directory port"
    elif [ $# -lt 2 ]; then
        java -classpath bin/ client.Client $DIRECTORY $PORT $SERVER $SERVERPORT
    else
        java -classpath bin/ client.Client $DIRECTORY $PORT
    fi
}

benchmarking()
{
    N=$1
    PORT=13000
    FOLDERNAME=$2
    FILENAME=$3
    NUMREQUESTS=$4
    SERVER=$5
    SERVERPORT=$6

    if [ $# -lt 4 ]; then
        echo "It should be benchmarking numNodes folderName fileName numRequests"
    elif [ $# -gt 4 ]; then
        for ((i=0; i<N; i++)); do
            java -classpath bin/ bench.Benchmarking $FOLDERNAME $(($PORT+$i)) $FILENAME $NUMREQUESTS $SERVER $SERVERPORT &
        done
    else
        for ((i=0; i<N; i++)); do
            java -classpath bin/ bench.Benchmarking $FOLDERNAME $(($PORT+$i)) $FILENAME $NUMREQUESTS $SERVER $SERVERPORT &
        done
    fi

}

help(){
    if [ $# -eq 0 ]; then
        echo "        "
        echo "        run_server - Run the Central Indexing Server"
        echo "        run_client - Run a Peer"
        echo "        benchmarking - Run a Benchmarking with multiple requests to the server"
        echo "        Type 'help command' to know more about each one"
        echo "        "
    elif [ $1 = "run_server" ]; then
            echo "        "
            echo "        Run a Central Indexing Server at port 3434"
            echo "        "
            echo "        or"
            echo "        "
            echo "        run_server port"
            echo "        "
    elif [ $1 = "run_client" ]; then
            echo "        "
            echo "        Run a Peer"
            echo "        run_client directory port"
            echo "        "
            echo "        or"
            echo "        "
            echo "        run_client directory port serverAddress serverPort"
            echo "        "
    elif [ $1 = "benchmarking" ]; then
            echo "        "
            echo "        Run a Benchmarking with multiple requests to the server"
            echo "        benchmarking numNodes folderName fileName numRequests"
            echo "        "
            echo "        - numNodes: number of nodes"
            echo "        - folderName: the benchmarking is a peer so needs a folder name to register to the Server"
            echo "        - fileName: the file you want to search in the Server"
            echo "        - numRequests: number of requests per node"
            echo "        "
            echo "        or"
            echo "        "
            echo "        benchmarking numNodes folderName fileName numRequests serverAddress serverPort"
            echo "        "
    fi
}
