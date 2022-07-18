#include <stdio.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include "helper_cuda.h"
__global__ void kernel(int *pret) {
    *pret = 42;
}

int main( int argc, char** argv )
{
    // cudaMalloc
    int *pret;
    checkCudaErrors(cudaMalloc(&pret, sizeof(int)));
    kernel<<<1,1>>>(pret);
    checkCudaErrors(cudaDeviceSynchronize());
    int ret;
    checkCudaErrors(cudaMemcpy(&ret, pret, sizeof(int), cudaMemcpyDeviceToHost));
    printf("ret: %d\n", ret);
    cudaFree(pret);

    // cudaMallocManaged
    checkCudaErrors(cudaMallocManaged(&pret, sizeof(int)));
    kernel<<<1,1>>>(pret);
    checkCudaErrors(cudaDeviceSynchronize());
    printf("pret: %d\n", *pret);
    cudaFree(pret);
    return 0;
}