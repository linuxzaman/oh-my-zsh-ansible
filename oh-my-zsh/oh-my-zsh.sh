#!/bin/bash
# Function to setup oh-my-zsh on instance
function ohmyzsh {
	rm -rf ~/.oh-my-zsh ~/.zshrc
	yes|sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' ~/.zshrc
	sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/g' ~/.zshrc
	echo source $(find / -name "zsh-syntax-highlighting.zsh"|grep ".zsh") >>~/.zshrc
	echo 'PROMPT="%{$fg[yellow]%}[%D{%f/%m/%y} %D{%L:%M:%S}] "$PROMPT' >>~/.zshrc
	#sed -i "s:/root\:/bin/bash:/root\:/bin/zsh:g" /etc/passwd
	sed -i "s:/$(whoami)\:/bin/bash:/$(whoami)\:/bin/zsh:g" /etc/passwd
	update-alternatives --install /usr/bin/editor editor /usr/bin/vim 100;
	
}

os=`cat /etc/*-release|grep ubuntu`
if [ $? -eq 0 ]; then

	echo "###########################"
	echo "UBUNTU/DEBIAN FAMILY FOUND"
	echo "###########################"
	apt update;apt install -y git zsh zsh-syntax-highlighting
	ohmyzsh
else

	echo "###########################"
	echo "CENTOS/REDHAT FAMILY FOUND"
	echo "###########################"
	yum update;yum install -y epel-release;yum install -y git zsh zsh-syntax-highlighting
	ohmyzsh
fi
