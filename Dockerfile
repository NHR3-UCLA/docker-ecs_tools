# Use jupyter/r-notebook Docker container as a starting container
# Includes Jupyter with support for Python and R 
# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html

FROM jupyter/r-notebook:latest

# Install system dependencies
USER root
# ffmpeg for matplotlib anim & dvipng+cm-super for latex labels
RUN apt-get update --yes && \
	apt-get install --yes --no-install-recommends \
        ffmpeg dvipng cm-super vim && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install R dependencies
USER ${NB_UID}
# R dependencies:
#   
#   mamba:
#     r-base, r-essentials, 
#     r-rgeos, r-rgdal, r-sp


RUN mamba install --quiet --yes \
        'r-essentials' \
        'r-base' \
        'r-rgeos' \
        'r-rgdal' \
        'r-sp' \
        && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install R dependencies
COPY scripts/install_R_dependencies.R "/home/${NB_USER}/"
RUN Rscript install_R_dependencies.R && rm install_R_dependencies.R


