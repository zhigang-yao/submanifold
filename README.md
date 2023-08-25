# Principal Submanifold Algorithm
This is a repository of principal submanifold proposed in Yao, Z., Li, B., Tran, D., and Zhang, Z. (2023).
## 1. The principal submanifold algorithm
This demo showcases the principal submanifold function, which is designed to process sample data based on the specified manifold type. The algorithm iteratively refines the sample points based on the local vector field, determined by the scale parameter h.
The core part of the algorithm is contained in the following four Matlab source files:

1. **submanifold.m**: The submanifold function refines sample points on specified manifolds ("cylinder" or "sphere")  to get the principal submanifold through iterative processes, adjusting each point based on local vector fields and neighborhood relationships.

2. **submanifold_irregular.m**: The submanifold_irregular.m function is similar with submanifold.m, but it is more suitable for dealing with irregular noise.


3. **submanifold_hypersphere.m**:  The submanifold_hypersphere.m function is similar with submanifold.m, but it is more suitable for dealing with high dimensional data set in a hypersphere.

## 2. Synthetic Data Studies
Add all files in the path, and Run "Demo_simulation.m".

![1](https://github.com/zhigang-yao/submanifold/blob/main/Images/Demo_simulation.png)

## 3. Seismological Data
Add all files in the path, and Run "Demo_earth.m".

![1](https://github.com/zhigang-yao/submanifold/blob/main/Images/Demo_earthquake.png)

## 4. CMU-PIE data set
Add all files in the path, and Run "Demo_pie.m".

![1](https://github.com/zhigang-yao/submanifold/blob/main/Images/Demo_pie.png)


