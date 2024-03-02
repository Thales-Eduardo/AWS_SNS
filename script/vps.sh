export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""

#36
# add docker nginx

git clone https://github.com/Thales-Eduardo/AWS_SNS.git app && cd app/microservice2

sudo apt install apt-transport-https ca-certificates curl software-properties-common \
  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
  && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
  && sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io \
  && sudo usermod -aG docker $USER
  && docker --version

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
 && sudo chmod +x /usr/local/bin/docker-compose && docker-compose --version

sudo docker-compose up -d

sudo docker logs node1 && sudo docker logs node2 && sudo docker logs nginx-proxy
