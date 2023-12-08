FROM ubuntu

ARG TERRAGRUNT_VERSION=0.53.6
ARG USER=coder

# Install general packages
RUN apt-get update \
	&& apt-get install -y \
	curl \
	git \
	gnupg \
	golang \
	nano \
	software-properties-common \
	sudo \
	vim \
	wget \
	&& rm -rf /var/lib/apt/lists/*

# Install Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
	gpg --dearmor | \
	tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
	&& echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
		https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
		tee /etc/apt/sources.list.d/hashicorp.list \
	&& apt update \
	&& apt-get -y install \
		terraform \
	&& terraform -help \
	&& rm -rf /var/lib/apt/lists/*

# Install Terragrunt
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 \
    && wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/SHA256SUMS \
    && grep terragrunt_linux_amd64 SHA256SUMS | sha256sum -c \
    && mv terragrunt_linux_amd64 /usr/local/bin/terragrunt \
    && chmod +x /usr/local/bin/terragrunt \
    && rm SHA256SUMS

# Install Ansible
RUN apt update \
  && add-apt-repository --yes --update ppa:ansible/ansible \
  && apt-get -y install \
    ansible \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}

USER ${USER}
WORKDIR /home/${USER}

SHELL ["/bin/bash", "--login", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
RUN source ~/.nvm/nvm.sh \
	&& nvm install 16 \
	&& nvm install 18 \
	&& nvm install 20 \
	&& nvm alias default 18 \
	&& nvm use default
	