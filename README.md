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

Name: gentoo-20151222-5679bd41-d0f6-b4a0-ff7d-50aad1c0c5ad

- ap-northeast-1: [`ami-00b1856e`](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#launchAmi=ami-00b1856e)
- ap-southeast-1: [`ami-01cb0962`](https://console.aws.amazon.com/ec2/home?region=ap-southeast-1#launchAmi=ami-01cb0962)
- eu-central-1: [`ami-b6736cda`](https://console.aws.amazon.com/ec2/home?region=eu-central-1#launchAmi=ami-b6736cda)
- sa-east-1: [`ami-0300876f`](https://console.aws.amazon.com/ec2/home?region=sa-east-1#launchAmi=ami-0300876f)
- us-east-1: [`ami-83d680e9`](https://console.aws.amazon.com/ec2/home?region=us-east-1#launchAmi=ami-83d680e9)
- us-west-1: [`ami-b4345ed4`](https://console.aws.amazon.com/ec2/home?region=us-west-1#launchAmi=ami-b4345ed4)
- us-west-2: [`ami-bac8d6db`](https://console.aws.amazon.com/ec2/home?region=us-west-2#launchAmi=ami-bac8d6db)

<!-- :'<,'>s/\v^(.+): (.+)$/- \1: [`\2`](https:\/\/console.aws.amazon.com\/ec2\/home?region=\1#launchAmi=\2)/ -->

## Note

### Packer virtualbox support

- default user name is `vagrant`, and its password is `vagrant`
- NOPASSWD sudo access enabled for `wheel` group, which vagrant user belongs to.

### Packer EC2 support

- cloud-init has enabled
- default user name is `gentoo`
  - NOPASSWD sudo access enabled for the user
  - default user creation is done via cloud-init.
