Description of the content of IHLT-eval-framework

- accuracy-rejection-acceptance.ipynb: is a Jupyter notebook with a python progthat computes three measures to evaluate text similarity: accuracy, rejection (precission over negative examples) and acceptance (precision over positive examples).

- train: corpus for developing a paraphrase detector. It can be used to tune the acceptance threshold of a paraphrase detector as well. It consists of the following files:

* msr_paraphrase_train_input.txt: a pair of sentences per line
* msr_paraphrase_train_gs.txt: a bit per line, being 1 when the pair of sentences in the corresponding line of msr_paraphrase_train_input.txt is a paraphrase, and being 0 otherwise.

- test: corpus for testing a paraphrase detector. It consists of files msr_paraphrase_test_input.txt and msr_paraphrase_test_gx.tst.
