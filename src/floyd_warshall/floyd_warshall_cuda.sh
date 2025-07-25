#!/bin/bash

# Read values from config/default.yaml
config="./config/default.yaml"

get_yaml_array() {
  key=$1
  grep "^$key:" "$config" | sed "s/$key: \[//" | sed 's/\]//' | tr ',' ' '
}

all_num_nodes=$(get_yaml_array all_num_nodes)
all_num_threads=$(get_yaml_array all_num_threads)
num_iters=$(grep "^num_iters:" "$config" | awk '{print $2}')

# Compile
nvcc floyd_warshall_cuda.cu -o floyd_warshall_cuda -ccbin "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\MSVC\14.29.30133\bin\Hostx64\x64"

# Run the rest only if the compilation was successful
if [ $? -ne 0 ]; then
  echo "Compilation failed. Exiting."
  exit 1
fi

# Set the time format to seconds
export TIMEFORMAT="%R"

# Run the program with different values of N
for iter in $(seq 1 $num_iters); do
  for num_nodes in $all_num_nodes; do
    sleep 0.1
    echo "Running with num_nodes=$num_nodes, Iteration=$iter"
    time ./floyd_warshall_cuda $num_nodes
  done
done
