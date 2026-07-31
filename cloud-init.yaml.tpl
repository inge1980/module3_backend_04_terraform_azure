#cloud-config

package_update: true
package_upgrade: true

packages:
  - docker.io
  - docker-compose-v2
  - git
  - curl
  - ca-certificates
  - apt-transport-https
  - lsb-release
  - gnupg

runcmd:
  # Enable and start Docker
  - systemctl enable docker
  - systemctl start docker

  # Allow ${admin_username} to run docker without sudo
  - usermod -aG docker ${admin_username}

  # Create application directory
  - mkdir -p /home/${admin_username}/app

  # Set ownership
  - chown -R ${admin_username}:${admin_username} /home/${admin_username}/app

  # Verify installations
  - docker --version
  - docker compose version

  # Install Azure CLI for testing purposes
  - curl -sL https://aka.ms/InstallAzureCLIDeb | bash