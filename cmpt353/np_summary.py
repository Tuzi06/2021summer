from typing import no_type_check


import numpy as np
import pandas 
data = np.load('monthdata.npz')
totals = data['totals']
counts = data['counts']
