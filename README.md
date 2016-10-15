# gentoo-build

shell scripts that builds systemd based gentoo box for x86_64 platform.

## Usage

### Basic

```
$ cp ./variables{.sample,}.sh
$ vi ./variables.sh
$ ./minify.sh /tmp/gentoo-build.sh
$ scp /tmp/gentoo-build.sh installer:/tmp/gentoo-build.sh
$ ssh installer /tmp/gentoo-build.sh
```

### Packer (virtualbox-iso, amazon-ebs)

```
$ packer build --var 'subnet_id=subnet-XXX' --var 'vpc_id=vpc-XXX' packer/gentoo.json
$ packer build --only=virtualbox-iso --var 'subnet_id=' --var 'vpc_id=' packer/gentoo.json
```

packer build should be run in the repository root directory.

## Built images using packer

You can use these if you can trust me. Note that the images are provided w/o any warranty. And the images can be removed w/o any notices.
If you want persistent copy, build by your own.

### Vagrant (virtualbox, qemu, aws)

https://atlas.hashicorp.com/sorah/boxes/gentoo

Not frequently updated

### AWS EC2 AMI

<!-- s/\v^(.+): (.+)$/- \1: [`\2`](https:\/\/console.aws.amazon.com\/ec2\/home?region=\1#launchAmi=\2)/ -->

gentoo-20161008-57f97153-669e-5a0e-b227-de1825257a12

- ap-northeast-1: [`ami-8ca17aed`](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#launchAmi=ami-8ca17aed)
- ap-southeast-1: [`ami-4b8e2928`](https://console.aws.amazon.com/ec2/home?region=ap-southeast-1#launchAmi=ami-4b8e2928)
- eu-central-1: [`ami-9dbc42f2`](https://console.aws.amazon.com/ec2/home?region=eu-central-1#launchAmi=ami-9dbc42f2)
- sa-east-1: [`ami-8f1785e3`](https://console.aws.amazon.com/ec2/home?region=sa-east-1#launchAmi=ami-8f1785e3)
- us-east-1: [`ami-26f0be31`](https://console.aws.amazon.com/ec2/home?region=us-east-1#launchAmi=ami-26f0be31)
- us-west-1: [`ami-84d891e4`](https://console.aws.amazon.com/ec2/home?region=us-west-1#launchAmi=ami-84d891e4)
- us-west-2: [`ami-2e68b04e`](https://console.aws.amazon.com/ec2/home?region=us-west-2#launchAmi=ami-2e68b04e)

## Note

### Packer virtualbox support

- default user name is `vagrant`, and its password is `vagrant`
- NOPASSWD sudo access enabled for `wheel` group, which vagrant user belongs to.

### Packer EC2 support

- cloud-init has enabled
- default user name is `gentoo`
  - NOPASSWD sudo access enabled for the user
  - default user creation is done via cloud-init.
