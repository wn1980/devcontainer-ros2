#FROM ros:foxy-ros-core-focal
FROM ros:humble-ros-core-jammy

LABEL maintainer="Waipot Ngamsaad <waipotn@hotmail.com>"

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive

RUN  apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN sed -i -e 's/http:\/\/archive/mirror:\/\/mirrors/' -e 's/http:\/\/security/mirror:\/\/mirrors/' -e 's/\/ubuntu\//\/mirrors.txt/' /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    apt-transport-https \
    build-essential \
    bash-completion \
    curl \
    git \
    wget \
    sudo \
    nano \
    terminator \
    evince \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' && \
    curl -L http://packages.osrfoundation.org/gazebo.key | apt-key add -

RUN apt-get update --fix-missing && apt-get upgrade -y
RUN apt-get install -y \
    ros-${ROS_DISTRO}-urdf \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-rviz2 \
    ros-${ROS_DISTRO}-rqt-graph \
    ros-${ROS_DISTRO}-robot-state-publisher \
    ros-${ROS_DISTRO}-joint-state-publisher \
    ros-${ROS_DISTRO}-joint-state-publisher-gui \
    # ros-${ROS_DISTRO}-slam-toolbox \
    # ros-${ROS_DISTRO}-nav2-bringup \
    # ros-${ROS_DISTRO}-turtlebot3-simulations \
    # ros-${ROS_DISTRO}-turtlebot3-teleop \
    # ros-${ROS_DISTRO}-turtlebot3-navigation2 \
    ros-${ROS_DISTRO}-urdf-tutorial \
    ros-${ROS_DISTRO}-plotjuggler-ros \
    libpython3-dev \
    python3-pip \
    python3-colcon-common-extensions \
    python3-rosdep \
    openscad \
    meshlab \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# update pip and install some packages
RUN curl https://bootstrap.pypa.io//get-pip.py | python3 - && \
    pip install -U argcomplete \
    echo "DONE"

RUN rm -f /etc/ros/rosdep/sources.list.d/20-default.list && \
    rosdep init

# install Miniconda3
RUN curl -L -o ~/condafile.sh -O https://repo.anaconda.com/miniconda/Miniconda3-latest-$(uname)-$(uname -m).sh && \
    bash ~/condafile.sh -b -p /opt/conda && \
    rm ~/condafile.sh && \
    /opt/conda/bin/conda update conda -y

RUN mkdir -p /workspace

# setup user
RUN useradd -m developer && \
    usermod -aG sudo developer && \
    usermod --shell /bin/bash developer && \
    chown -R developer:developer /workspace && \
    ln -sfn /workspace /home/developer/workspace && \
    echo developer ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer

ENV USER=developer

ENV HOME /home/developer

ENV SHELL /bin/bash

USER $USER

WORKDIR /home/developer

# init rosdep
RUN rosdep fix-permissions && \
    rosdep update

# init ros2 workspace
RUN mkdir -p /workspace/src && \
    cd /workspace/src && \
    colcon build

# set conda environment path
ENV PATH /opt/conda/bin:$PATH

RUN conda init bash && conda config --set auto_activate_base false

# create specific conda env
RUN conda create --name Onshape python

SHELL ["conda", "run", "-n", "Onshape", "/bin/bash", "-c"]

RUN pip install onshape-to-robot urdf2webots

# clean
RUN conda clean -ya && \
    sudo apt-get -y autoremove

# enable bash completion
RUN echo "source /usr/share/bash-completion/bash_completion" >> ~/.bashrc && \
    echo "source ~/.bashrc" >> ~/.bash_profile 

RUN echo "export PROMPT_COMMAND='history -a'" >> ~/.bashrc && \ 
    echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc && \
    echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc && \
    echo "source /workspace/install/setup.bash" >> ~/.bashrc && \
    echo "export TURTLEBOT3_MODEL=waffle_pi" >> ~/.bashrc && \
    echo "DONE"
