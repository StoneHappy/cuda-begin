#include <stdio.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include "helper_cuda.h"

__global__ void kernel0(int *arr, int n) {
    int i = threadIdx.x;
    arr[i] = i;
}

__global__ void kernel1(int *arr, int n) {
    for (int i = threadIdx.x; i < n; i += blockDim.x)
    {
        arr[i] = i;
    }
}

__global__ void kernel2(int *arr, int n) {
    for (int i = blockDim.x * blockIdx.x + threadIdx.x; i < n; i += blockDim.x * gridDim.x)
    {
        arr[i] = i;
    }
}

int main( int argc, char** argv )
{
    int n = 32;
    int *arr;

    // set fixed thread nums
    checkCudaErrors(cudaMallocManaged(&arr, n * sizeof(int)));
    kernel0<<<1,n>>>(arr, n);
    checkCudaErrors(cudaDeviceSynchronize());
    for (size_t i = 0; i< n; i++)
    {
        printf("arr0[%zd]: %d\n", i, arr[i]);
    }
    cudaFree(arr);

    // use blockDim auto get threadId
    checkCudaErrors(cudaMallocManaged(&arr, n * sizeof(int)));
    kernel1<<<1,4>>>(arr, n);
    checkCudaErrors(cudaDeviceSynchronize());
    for (size_t i = 0; i< n; i++)
    {
        printf("arr1[%zd]: %d\n", i, arr[i]);
    }
    cudaFree(arr);

    // use blockDim and gridDim auto get threadId
    checkCudaErrors(cudaMallocManaged(&arr, n * sizeof(int)));
    kernel2<<<2,16>>>(arr, n);
    checkCudaErrors(cudaDeviceSynchronize());
    for (size_t i = 0; i< n; i++)
    {
        printf("arr2[%zd]: %d\n", i, arr[i]);
    }
    cudaFree(arr);

    return 0;
}