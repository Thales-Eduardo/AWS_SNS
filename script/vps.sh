export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""

git clone https://github.com/Thales-Eduardo/AWS_SNS.git app && \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash && source ~/.bashrc \
  && nvm --version && nvm install 20.9.0 && node -v && npm i -g yarn && sudo apt update && \
  npm install && npm run start

#36
