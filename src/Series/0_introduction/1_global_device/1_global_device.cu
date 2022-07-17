#include <stdio.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>

__device__ void say_hello()
{
    printf("hello!\n");
}

__global__ void kernel() {
    say_hello();
}

int main( int argc, char** argv )
{
    kernel<<<1,1>>>();
    cudaDeviceSynchronize();
    return 0;
}