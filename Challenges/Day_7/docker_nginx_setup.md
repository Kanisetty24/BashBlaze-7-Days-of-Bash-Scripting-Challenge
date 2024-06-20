
# Update package index
sudo apt update

# Install dependencies for Docker repository
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker Engine, Docker CLI, and containerd
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Verify Docker installation by running hello-world container
sudo docker run hello-world

# Optional: Manage Docker as a non-root user
sudo usermod -aG docker $USER
echo "Log out and log back in to apply Docker group membership."

# Start Docker service if not already started
sudo systemctl start docker

# Optional: Enable Docker service to start on boot
sudo systemctl enable docker

# Build Docker image for Flask application
docker build -t my-flask-app-image ./flask-app

# Install Nginx
sudo apt update
sudo apt install -y nginx

# Create Nginx site configuration file for Flask app
sudo nano /etc/nginx/sites-available/my-flask-app

# Create symbolic link to enable the site configuration
sudo ln -s /etc/nginx/sites-available/my-flask-app /etc/nginx/sites-enabled/

# Check Nginx configuration for syntax errors
sudo nginx -t

# Restart Nginx to apply configuration changes
sudo systemctl restart nginx
