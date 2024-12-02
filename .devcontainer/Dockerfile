FROM debian:bookworm-slim

COPY install-deps.sh /install.sh
RUN chmod +x /install.sh && \ 
    /install.sh && \
    rm -rf /install.sh

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# install a few tools for more convenient developing
# ---- user setup ----
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt install -y sudo bash-completion nano clang-format \
    && echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/sudo-nopasswd \
    && usermod -aG sudo,plugdev $USERNAME

