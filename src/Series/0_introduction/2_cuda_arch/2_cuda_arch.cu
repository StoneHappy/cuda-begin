#include <stdio.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>

__device__ void show_cuda_arch()
{
#ifdef __CUDA_ARCH__
    printf("cuda_arch: %d\n", __CUDA_ARCH__);
#endif
}

__global__ void test() {
    show_cuda_arch();
}

int main( int argc, char** argv )
{
    test<<<1,1>>>();
    cudaDeviceSynchronize();
    return 0;
}