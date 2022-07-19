#-------------------------------------------------
# This script installs the necessary packages to
# run perform the ECS calculations
#-------------------------------------------------

repos = getOption('repos')
repos['CRAN'] <- 'https://cran.us.r-project.org'
options(repos=repos, timeout=800)

#install required packages
install.packages(c(
                   'tidyverse',
                   'plyr',
                   'assertthat',
                   'pracma',
                   'parallel',
                   'ggplot2',
                   'ggmap',
                   'mgcv'
                   ),
                 dependencies=TRUE
)



