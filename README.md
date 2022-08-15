# A depressively ruminating RBM

RBM based on Dr.Hinton's guide: https://www.cs.toronto.edu/~hinton/absps/guideTR.pdf 

## Functions / Usage
Going line-by-line through rumination.m (which can be run directly) as an example, this flow details the core functions of this model.

* loadData.m loads the MNIST dataset, splitting it into training and test images and their respective labels.
* rbm.m initializes the RBM, and trains it on the training data via rbm_train.m, it also plots the training error and energies per epoch (1 iteration through the full training data), and plots the hidden unit weights as an image - the features learned.
* rbm_train.m shuffles the training data, then applies stochastic weight updating via rbm_contrastive_divergence.m. It also tracks energy via get_energy.m, computes the learning gradient via rbm_gradient.m, and updates weights and biases appropriately. It returns the mean error and energy associated with each update and prints this to the terminal.
* rbm_contrastive_divergence.m performs traditional RBM mechanics, implementing clamping, positing, and negative phases, to discover the updated hidden and visible units.
* rbm_gradient.m calculates the Hebbian learning update by comparing the clamped and reconstructed matrices.
* test_input.m and test_unclamped.m modify rbm_contrastive_divergence.m slightly to test ~ associative recall (AR) and free recall (FR), with the attentional breadth differences, plotting the memory reconstruction.
* We plot the energies and errors involved across the control and experimental cases of AR and FR.
* mood.m attempts to label inputs with valence and predict them, with "label" equivalents to many of the prior functions included.
