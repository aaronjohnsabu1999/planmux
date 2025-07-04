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

Ns=$(get_yaml_array N)
threads=$(get_yaml_array num_threads)
num_iters=$(grep "^num_iters:" "$config" | awk '{print $2}')

# Compile
module load compiler/intel/2018.2.199
g++ dijkstra_openmp.cpp -o dijkstra_openmp -std=c++17 -fopenmp

for num_threads in $threads
do
  sleep 0.1
  export OMP_NUM_THREADS=$num_threads
  rm USA_NY_out.txt
  rm USA_NY_parallel_out.txt
  ./dijkstra_openmp
done
