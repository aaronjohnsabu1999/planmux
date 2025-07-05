#!/bin/bash
#SBATCH -N 1
#SBATCH --ntasks-per-node=16
#SBATCH --time=06:00:00
#SBATCH --job-name=planmux
#SBATCH --error=job.%J.err_node_40
#SBATCH --output=job.%J.out_node_40
#SBATCH --partition=hm

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
g++ floyd_warshall_openmp.cpp -o floyd_warshall_openmp -fopenmp -std=c++17

# Check if compilation was successful
if [ $? -ne 0 ]; then
  echo "Compilation failed. Exiting."
  exit 1
fi

# Set the time format to seconds
export TIMEFORMAT="%R"

# Run the program with different number of nodes and number of threads
export OMP_NUM_THREADS=1  # Default to 1 thread, will be overridden in the loop
for num_nodes in $all_num_nodes; do
  for iter in $(seq 1 $num_iters); do
    for num_threads in $all_num_threads; do
      sleep 0.1
      ./floyd_warshall_openmp $num_nodes $num_threads
  	done
  done
done
