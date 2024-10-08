#include <cuda.h>
#include <cuda_runtime.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/scan.h>
#include "common.h"
#include "thrust.h"

namespace StreamCompaction {
    namespace Thrust {
        using StreamCompaction::Common::PerformanceTimer;
        PerformanceTimer& timer()
        {
            static PerformanceTimer timer;
            return timer;
        }
        /**
         * Performs prefix-sum (aka scan) on idata, storing the result into odata.
         */
        void scan(int n, int *odata, const int *idata) {
            thrust::device_vector<int> input_data(idata, idata + n);
            timer().startGpuTimer();
            thrust::exclusive_scan(input_data.begin(), input_data.end(), input_data.begin());
            timer().endGpuTimer();
            thrust::copy(input_data.begin(), input_data.end(), odata);
        }
    }
}
