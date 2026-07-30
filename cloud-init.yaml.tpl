#cloud-config

package_update: true
package_upgrade: true

packages:
  - docker.io
  - docker-compose-v2
  - git
  - curl

runcmd:
  # Enable and start Docker
  - systemctl enable docker
  - systemctl start docker

  # Allow ${admin_username} to run docker without sudo
  - usermod -aG docker ${admin_username}

  # Verify installations
  - docker --version
  - docker compose version