# Parallel Path Planning Algorithms

This repository provides serial and parallel implementations of three classical shortest path algorithms — **Dijkstra**, **Bellman-Ford**, and **Floyd-Warshall** — using **OpenMP** (CPU parallelism) and **CUDA** (GPU acceleration). The algorithms are tested on both real-world and synthetic graph data to evaluate performance scalability.

---

## Project Structure

```
planmux/
├── assets/                         # Input datasets (by algorithm)
│   ├── bellman_ford/
│   ├── dijkstra/
│   └── floyd_warshall/
├── results/                        # Benchmarking results and analysis
│   ├── results.pdf
│   └── results.xlsx
├── src/                            # Source code and job logs
│   ├── main.cpp                    # Optional driver/main entry
│   ├── USA-road-d_NY.txt           # Real-world NY road graph dataset
│   ├── bellman_ford/
│   │   ├── Bellman_Ford_GPU.cu
│   │   └── Bellman_Ford_OpenMP.cpp
│   ├── dijkstra/
│   │   ├── Dijkstra.cpp
│   │   └── DijkstraOpenMP.sh
│   ├── floyd_warshall/
│   │   ├── jobs/                   # Output logs from Floyd-Warshall runs
│   │   ├── FloydWarshall.cu
│   │   ├── FloydWarshall.cpp
│   │   └── FloydWarshallOpenMP.cpp
├── presentation.pdf/pptx           # Final presentation slides
├── report.pdf                      # Full project report
├── LICENSE                         # License file (MIT)
└── README.md                       # Project documentation
```

---

## Algorithms Implemented

| Algorithm       | Serial | OpenMP | CUDA |
|-----------------|--------|--------|------|
| Dijkstra        | ✅    | ✅     | ❌  |
| Bellman-Ford    | ✅    | ✅     | ✅  |
| Floyd-Warshall  | ✅    | ✅     | ✅  |

---

## Build & Run

### Prerequisites

- **Compiler**: `g++` with OpenMP support
- **GPU Support**: NVIDIA GPU with CUDA Toolkit
- Linux or WSL recommended for shell scripts

### Compilation Examples

#### Dijkstra (OpenMP)

```bash
g++ -fopenmp src/dijkstra/Dijkstra.cpp -o dijkstra_omp
./dijkstra_omp
```

#### Bellman-Ford (CUDA)

```bash
nvcc src/bellman_ford/Bellman_Ford_GPU.cu -o bellman_gpu
./bellman_gpu
```

#### Floyd-Warshall (CUDA)

```bash
nvcc src/floyd_warshall/FloydWarshall.cu -o floyd_gpu
./floyd_gpu
```

---

## Dataset Information

- **USA-road-d_NY.txt**: New York road network from the [DIMACS Challenge Dataset](http://users.diag.uniroma1.it/challenge9/download.shtml)
- **Synthetic graphs**: Randomly generated with controlled node/edge parameters (see `assets/`)

---

## Results

Results are summarized in the following files:

- `results/results.pdf`: Performance graphs and discussion
- `results/results.xlsx`: Raw benchmarking data (execution time, speed-up, etc.)

Performance was evaluated on:

- Execution time (serial vs. OpenMP vs. CUDA)
- Varying graph sizes (sparse to dense)
- Real vs. synthetic graphs

---

## Documentation

- `report.pdf`: Complete technical report with algorithm details and experimental results
- `presentation.pptx`: Final presentation slides

---

##  Authors

- **Aaron John Sabu** – [@aaronjohnsabu1999](https://github.com/aaronjohnsabu1999)  
- **Athul CD** – [@athulcd](https://github.com/athulcd)  
- **Ayan Sharma** – [@ayan-2004](https://github.com/ayan-2004)  
- **Vaibhav Malviya** – [@Vaibhav110](https://github.com/Vaibhav110)

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
