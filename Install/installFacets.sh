#!/bin/bash

# Installing the facets package gives the following error:
# make: gfortran-4.8: No such file or directory
# To fix this error, run:

curl -O http://r.research.att.com/libs/gfortran-4.8.2-darwin13.tar.bz2
sudo tar fvxz gfortran-4.8.2-darwin13.tar.bz2 -C /

# Install package
R CMD INSTALL facets_0.5.0.tar.gz 
