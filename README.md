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

Name: gentoo-20160514-5737a92e-acfc-9027-dab9-a405205660d2

- ap-northeast-1: [`ami-3f34d25e`](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#launchAmi=ami-3f34d25e)
- ap-southeast-1: [`ami-601acc03`](https://console.aws.amazon.com/ec2/home?region=ap-southeast-1#launchAmi=ami-601acc03)
- eu-central-1: [`ami-1ba74b74`](https://console.aws.amazon.com/ec2/home?region=eu-central-1#launchAmi=ami-1ba74b74)
- sa-east-1: [`ami-11961e7d`](https://console.aws.amazon.com/ec2/home?region=sa-east-1#launchAmi=ami-11961e7d)
- us-east-1: [`ami-b3957cde`](https://console.aws.amazon.com/ec2/home?region=us-east-1#launchAmi=ami-b3957cde)
- us-west-1: [`ami-3a0a725a`](https://console.aws.amazon.com/ec2/home?region=us-west-1#launchAmi=ami-3a0a725a)
- us-west-2: [`ami-d5ca36b5`](https://console.aws.amazon.com/ec2/home?region=us-west-2#launchAmi=ami-d5ca36b5)

<!-- s/\v^(.+): (.+)$/- \1: [`\2`](https:\/\/console.aws.amazon.com\/ec2\/home?region=\1#launchAmi=\2)/ -->

## Note

### Packer virtualbox support

- default user name is `vagrant`, and its password is `vagrant`
- NOPASSWD sudo access enabled for `wheel` group, which vagrant user belongs to.

### Packer EC2 support

- cloud-init has enabled
- default user name is `gentoo`
  - NOPASSWD sudo access enabled for the user
  - default user creation is done via cloud-init.
