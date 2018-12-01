# Use an official Python runtime as a parent image
FROM continuumio/miniconda as keras

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# switch shell to bash
SHELL ["/bin/bash", "-c"]

# Install any needed packages specified in requirements.txt
RUN  apt-get update && apt-get install -y git curl locales mc tmux vim git curl default-jre && conda env create -f conda_env_keras.yml  -n keras&& echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && source activate keras && jupyter notebook --generate-config && echo "c.NotebookApp.password = u'sha1:16dbb1e5de38:9607c740a34a2dedb397b090da3496c429e908dc'" >> /root/.jupyter/jupyter_notebook_config.py && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen && cd && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && git clone https://github.com/mnorayr/nor_vim_dot_files.git ~/nor_vim_dot_files && touch .vimrc && echo "source ~/nor_vim_dot_files/vimrc" >> .vimrc 

# Make port 8888 available to the world outside this container
EXPOSE 8888 54321

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["mkdir /mdb && source activate keras && jupyter notebook --generate-config"] 

####### 
# adding cuda 
FROM nvcr.io/nvidia/cuda:9.0-cudnn7.2-devel-ubuntu16.04 as cuda

# Set the working directory to /app
WORKDIR /

# Copy the currena directory contents into the container at /app
COPY --from=keras . .

####
# adding pytorch
#FROM nvcr.io/nvidia/pytorch:18.11-py3 as pt3

# Set the working directory to /app
#WORKDIR /

# Copy the current directory contents into the container at /app
#COPY --from=cuda . .

# add the env variables 
RUN echo "export CUDA_PATH=/usr/local/cuda" >> /root/.bashrc && echo "export LD_LIBRARY_PATH=$CUDA_PATH/lib64:$LD_LIBRARY_PATH">> /root/.bashrc    


