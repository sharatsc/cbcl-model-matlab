# Introduction #

This code provides yet another matlab implementation for the computational model of the ventral stream developed by [CBCL](http://cbcl.mit.edu). The original matlab version written by Serre and Bileschi can be accessed [here](http://cbcl.mit.edu/software-datasets/standardmodel/index.html). The code is hard-wired to compute only upto 4 layers (S1,C1,S2,C2).

An alternate version was developed by Jim Mutch and can be found [here](http://www.mit.edu/~jmutch/fhlib). This is a much more flexible can be reconfigured to provide any number/type of layers. It supports many primitive operations (normalized dot-product, radial-basis etc). It is excellently engineered but requires a learning curve.

The goal of this project is to provide both flexibility and also legibility. Computational speed is sacrificed a little. However, it is 2.5x-3x times faster than the original matlab implementation.

# Getting the code #
Use the following to obtain the code (assuming you are under linux. Alternatively, use an svn client)
```
svn checkout http://cbcl-model-matlab.googlecode.com/svn/trunk/cbcl-model-matlab
```

# Details #

There are some technical differences between these three implementations.

  * In the original implementation (Serre et al.), different scales of the S1 layer is computed by filtering the same image using successively larger filters. This is done to conform to experimentally obtained tuning curves.
  * Jim Mutch's code uses a single sized filter, but convolves it with a image pyramid to yield similar but not identical results.
  * This project also uses a single filter on an image pyramid. For band limited filters, the operation $ (f(x) `*` I(x)) V n$ is equivalent to $1/n (I(x) V n) `*` f(x)$. Here `*` indicates convolution operation, `V` indicates downsampling operation.