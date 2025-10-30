# Dockerfile for Overleaf GitHub Runner

FROM ubuntu:22.04

# Install LaTeX and dependencies
# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt-get update && \
#     apt-get install -y tzdata && \
#     ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
#     dpkg-reconfigure --frontend noninteractive tzdata && \
#     apt-get install -y \
#         curl git sudo make latexmk texlive-full wget unzip && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*


# Create a non-root user
RUN useradd -m runner && echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER runner
WORKDIR /home/runner


# Download GitHub Actions runner (use explicit version)
ENV RUNNER_VERSION=2.319.1
RUN curl -L -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Allow running as root inside container
ENV RUNNER_ALLOW_RUNASROOT=1

# Default command
CMD ["/bin/bash"]
