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

gentoo-20170130-588f5cc4-4ad5-a61a-2be6-5f4766962dfb

- ap-northeast-1: [`ami-c8d397af`](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#launchAmi=ami-c8d397af)
- ap-south-1: [`ami-ef0f7e80`](https://console.aws.amazon.com/ec2/home?region=ap-south-1#launchAmi=ami-ef0f7e80)
- ap-southeast-1: [`ami-ba3f8ad9`](https://console.aws.amazon.com/ec2/home?region=ap-southeast-1#launchAmi=ami-ba3f8ad9)
- ca-central-1: [`ami-0bc8756f`](https://console.aws.amazon.com/ec2/home?region=ca-central-1#launchAmi=ami-0bc8756f)
- eu-central-1: [`ami-8f74bae0`](https://console.aws.amazon.com/ec2/home?region=eu-central-1#launchAmi=ami-8f74bae0)
- eu-west-2: [`ami-fd534699`](https://console.aws.amazon.com/ec2/home?region=eu-west-2#launchAmi=ami-fd534699)
- sa-east-1: [`ami-a70f6bcb`](https://console.aws.amazon.com/ec2/home?region=sa-east-1#launchAmi=ami-a70f6bcb)
- us-east-1: [`ami-09f40b1f`](https://console.aws.amazon.com/ec2/home?region=us-east-1#launchAmi=ami-09f40b1f)
- us-east-2: [`ami-f33f1a96`](https://console.aws.amazon.com/ec2/home?region=us-east-2#launchAmi=ami-f33f1a96)
- us-west-1: [`ami-544f1234`](https://console.aws.amazon.com/ec2/home?region=us-west-1#launchAmi=ami-544f1234)
- us-west-2: [`ami-4b5ae22b`](https://console.aws.amazon.com/ec2/home?region=us-west-2#launchAmi=ami-4b5ae22b)

## Note

### Packer virtualbox support

- default user name is `vagrant`, and its password is `vagrant`
- NOPASSWD sudo access enabled for `wheel` group, which vagrant user belongs to.

### Packer EC2 support

- cloud-init has enabled
- default user name is `gentoo`
  - NOPASSWD sudo access enabled for the user
  - default user creation is done via cloud-init.
