#include <stdio.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>

__global__ void kernel1() {
    printf("Thread %d of %d\n", threadIdx.x, blockDim.x);
}

__global__ void kernel2() {
    printf("Block %d of %d, Thread %d of %d\n", blockIdx.x, gridDim.x, threadIdx.x, blockDim.x);
}

__global__ void kernel3() {
    unsigned  int tid  = blockDim.x * blockIdx.x + threadIdx.x;
    unsigned  int tnum = blockDim.x * gridDim.x;
    printf("Flattened Thread %d of %d\n", tid, tnum);
}

int main( int argc, char** argv )
{
    kernel1<<<1,3>>>();
    cudaDeviceSynchronize();
    kernel2<<<2,3>>>();
    cudaDeviceSynchronize();
    kernel3<<<2,3>>>();
    cudaDeviceSynchronize();
    return 0;
}