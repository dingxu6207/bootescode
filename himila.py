# -*- coding: utf-8 -*-
"""
Created on Fri Jun  7 10:19:13 2019

@author: dingxu
"""

from astropy.io import fits
from skimage import io
hdulist = fits.open('E:/BOOTES4/pytest/one.fits')
hdulist.info()
print(hdulist[0].header)
dataimage = hdulist[1].data
lenthimage = len(dataimage)
print(dataimage)
io.imshow(dataimage/27225)