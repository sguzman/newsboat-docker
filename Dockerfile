# Use the official Arch Linux base image
FROM archlinux:latest

# Set environment variables to avoid interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Update the system and install necessary packages

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm --needed git base-devel fish jq yt-dlp sqlite newsboat

# Create a non-root user
RUN useradd -m builduser && echo "builduser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to the non-root user
USER builduser
WORKDIR /home/builduser

RUN git clone https://aur.archlinux.org/yay.git
WORKDIR yay
RUN makepkg -si --noconfirm
RUN yay -S --noconfirm pgloader

# Switch back to root user
USER root

# Create a working directory
WORKDIR /root

# Create a directory for Newsboat configuration and data
RUN mkdir -p /root/.newsboat

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

