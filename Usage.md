# Usage #
**The ventral stream model is organized as a hierarchy of layers. 'S' layers consist of feature detectors that provide specificity. 'C' layers provide invariance to position and scale. The level of specificity and invariances increase along the hierarchy.**

# Details #
The code consists of generic S and C layer implementations that can be stacked to generate the hierarchy. In contrast, the original matlab implementation is hard-wired for S1,C1,S2,C2 computation.

### S Layer ###
The code provides different kinds of feature detectors.
  * **s\_norm\_filter.m**:This implements a normalized dot-product with the prototype                     (used for S1)
  * **s\_rbf.m**:This provides a gaussian tuning around the prototype (used for S2)

### C Layer ###
  * **c\_local.m** : This provides local pooling across position and scale. (used for C1)
  * **c\_global.m**: This provides pooling across all positions and scale.  (used for C2)

### Filters/Prototypes ###
Each S layer (S_{n}) acts as a feature detector that computes the similarity of the previous layer (C_{n-1}) to a given set or prototypes (P_{i},i=1..n)_

  * **get\_c\_patches.m** : This function provides a way to generate the prototypes. Given a cell-array of C_{n-1} outputs, it randomly samples patches to generate the prototypes P_{i} used to compute S_{n}
  * **learn\_c\_patches.m**: This function provides a way to 'learn' the patches instead of sampling them. This generates far fewer prototypes for a desired level of accuracy. The learning follows scheme mentioned in Fukushima._

### Compatibility ###
Due to the different ways in which S layers are computed, the output is 'similar' but not 'identical' to the previous matlab implmentation (found [here](http://cbcl.mit.edu/software-datasets/standardmodel/index.html)).
  * **compare\_versions.m** : This function compares the output and timing of the two matlab versions using the same image and prototypes.