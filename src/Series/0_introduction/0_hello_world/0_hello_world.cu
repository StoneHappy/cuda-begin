#include <stdio.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>

__global__ void kernel(){
    printf("Hi Cuda World");
}

int main( int argc, char** argv )
{
    kernel<<<1,1>>>();
    cudaDeviceSynchronize();
    return 0;
}