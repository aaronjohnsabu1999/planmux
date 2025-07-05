# Parallel Path Planning Algorithms

This repository provides serial and parallel implementations of three classical shortest path algorithms — **Dijkstra**, **Bellman-Ford**, and **Floyd-Warshall** — using **OpenMP** (CPU parallelism) and **CUDA** (GPU acceleration). The algorithms are tested on both real-world and synthetic graph data to evaluate performance scalability.

---

## Project Structure

```
planmux/
├── assets/                         # Algorithm-specific result assets (plots, charts)
│   ├── bellman_ford/
│   ├── dijkstra/
│   └── floyd_warshall/
├── config/                         # Runtime configuration files
│   └── default.yaml
├── results/                        # Benchmarking outputs
│   ├── jobs/                       # SLURM or local job output logs
│   ├── results.pdf                 # Consolidated result visualizations
│   └── results.xlsx                # Raw performance data
├── src/                            # All source code and executables
│   ├── main.cpp                    # Entry point for general testing
│   ├── USA-road-d_NY.txt           # Real-world graph dataset
│   ├── bellman_ford/
│   │   ├── bellman_ford_cuda.cu
│   │   └── bellman_ford_openmp.cpp
│   ├── dijkstra/
│   │   ├── dijkstra_openmp.cpp
│   │   └── dijkstra_openmp.sh
│   └── floyd_warshall/
│       ├── floyd_warshall_cuda.cu
│       ├── floyd_warshall_cuda.sh
│       ├── floyd_warshall_openmp.cpp
│       └── floyd_warshall_openmp.sh
├── .gitignore                      # Git ignored files and folders
├── LICENSE                         # Project license (MIT)
├── presentation.pdf                # Presentation (PDF version)
├── presentation.pptx               # Presentation (PPTX version)
├── report.pdf                      # Final technical report
└── README.md                       # Project documentation (you are here)
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

- **C++ Compiler**: g++ with OpenMP support (`-fopenmp`)
- **GPU Support**: NVIDIA GPU + CUDA Toolkit (`nvcc`)
- **Shell Environment**: Bash (Linux, WSL, or Git Bash on Windows)
- If on Windows, ensure Visual Studio Build Tools are installed and properly configured
- For CUDA builds on Windows, you must provide the correct path to `cl.exe` via `-ccbin`

### Compilation Examples

#### Dijkstra (OpenMP)
```bash
g++ ./src/dijkstra/dijkstra_openmp.cpp -o dijkstra_openmp -fopenmp -std=c++17
./dijkstra_openmp <num_nodes> <num_threads>
```

#### Bellman-Ford (OpenMP)
```bash
g++ ./src/bellman_ford/bellman_ford_openmp.cpp -o bellman_ford_openmp -fopenmp -std=c++17
./bellman_ford_openmp <num_nodes> <num_threads>
```

#### Bellman-Ford (CUDA)
```bash
nvcc ./src/bellman_ford/bellman_ford_cuda.cu -o bellman_ford_cuda -ccbin "C:/Path/To/cl.exe/Folder"
./bellman_ford_cuda <num_nodes>
```

#### Floyd-Warshall (OpenMP)
```bash
g++ ./src/floyd_warshall/floyd_warshall_openmp.cpp -o floyd_warshall_openmp -fopenmp -std=c++17
./floyd_warshall_openmp <num_nodes> <num_threads>
```

#### Floyd-Warshall (CUDA)
```bash
nvcc ./src/floyd_warshall/floyd_warshall_cuda.cu -o floyd_warshall_cuda -ccbin "C:/Path/To/cl.exe/Folder"
./floyd_warshall_cuda <num_nodes>
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
