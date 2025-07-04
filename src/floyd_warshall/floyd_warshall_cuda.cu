#include <cuda_runtime.h>
#include <omp.h>
#include <vector>
#include <fstream>
#include <iostream>
#include <cstdlib>
#include <cstdio>

#define	INFTY	1e8

using namespace std;

__global__ void calcH(int V, int mid, int *g, int *h)
{
  int start = threadIdx.y + blockIdx.y * blockDim.y;
  int end   = threadIdx.x + blockIdx.x * blockDim.x;
  
  if (start < V && end < V) {
    h[start*V + end] = min(g[start*V + end], g[start*V + mid] + g[mid*V + end]);
  }
}


__global__ void calcG(int V, int *g, int *h)
{
  int start = threadIdx.y + blockIdx.y * blockDim.y;
  int end   = threadIdx.x + blockIdx.x * blockDim.x;
  
  if (start < V && end < V) {
    g[start*V + end] = h[start*V + end];
  }
}

int main(int argv, char **argc)
{
  // Check if the number of arguments is correct
  if (argv != 2) {
    fprintf(stderr, "Usage: %s <number_of_vertices>\n", argc[0]);
    return 1;
  }
  // Define the number of vertices and edges
  int V = strtol(argc[1], (char **)NULL, 10), E = 0;
  int *g, *h;
  
  // Allocate memory for the graph and the intermediate results
  cudaMallocManaged(&g, V*V*sizeof(int));
  cudaMallocManaged(&h, V*V*sizeof(int));
  
  // Initialize the graph with random weights
  for (int start = 0; start < V; start++)
    for (int end = 0; end < V; end++)
      if (rand()%((V*V)/(3*V)))
	  {
	    g[start*V + end] = rand()%500 + 1;
        E++;
      }
      else
        g[start*V + end] = INFTY;
  
  // Initialize the intermediate results
  int threads = 10;
  int blocks  = (V + threads - 1) / threads;
  dim3 THREADS (threads, threads);
  dim3 BLOCKS  ( blocks,  blocks);
  
  for (int mid = 0; mid < V; mid++)
  {
    calcH<<<BLOCKS, THREADS>>>(V, mid, g, h);
    cudaDeviceSynchronize();
    calcG<<<BLOCKS, THREADS>>>(V, g, h);
    cudaDeviceSynchronize();
  }
  
  printf("Time taken for CUDA implementation with (V = %d) = ", V);
  return 0;
}