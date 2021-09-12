import numpy as np

x = np.arange(100).reshape(10, 10)
np.save("dummy_output.npy", x)