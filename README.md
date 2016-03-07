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

### Vagrant virtualbox

https://atlas.hashicorp.com/sorah/boxes/gentoo

### AWS EC2 AMI

Name: gentoo-20160307-56dd9d6a-9c3c-6b70-0654-acc1decfb75b

- ap-northeast-1: [`ami-3d898653`](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#launchAmi=ami-3d898653)
- ap-southeast-1: [`ami-7221e911`](https://console.aws.amazon.com/ec2/home?region=ap-southeast-1#launchAmi=ami-7221e911)
- eu-central-1: [`ami-66e20609`](https://console.aws.amazon.com/ec2/home?region=eu-central-1#launchAmi=ami-66e20609)
- sa-east-1: [`ami-0fda5763`](https://console.aws.amazon.com/ec2/home?region=sa-east-1#launchAmi=ami-0fda5763)
- us-east-1: [`ami-7028121a`](https://console.aws.amazon.com/ec2/home?region=us-east-1#launchAmi=ami-7028121a)
- us-west-1: [`ami-9c6310fc`](https://console.aws.amazon.com/ec2/home?region=us-west-1#launchAmi=ami-9c6310fc)
- us-west-2: [`ami-21e00f41`](https://console.aws.amazon.com/ec2/home?region=us-west-2#launchAmi=ami-21e00f41)

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
