#!/bin/bash
if echo "${1}" | grep -q '^/'; then
  output="${1}"
else
  output="$(pwd)/${1:-gentoo-build.sh}"
fi

cd "$(dirname $0)"

cat > $output <<-'EOF'
#!/bin/bash -e
dest=${1:-gentoo-build}
mkdir $dest
if ! sed --version 2>&1 | grep -q 'GNU sed'; then
  SEDCMD=gsed
else
  SEDCMD=sed
fi
$SEDCMD '0,/^exec /d' $0 | base64 --decode | tar xjf - -C $dest
cd $dest
exec ./build.sh
EOF

chmod +x $output

if base64 --help | grep -q 'GNU coreutils'; then
  tar cjf - --exclude=.git --exclude=packer/box --exclude=packer_cache --exclude=output-qemu . | base64 -w 80 >> $output
else
  tar cjf - --exclude=.git --exclude=packer/box --exclude=packer_cache --exclude=output-qemu . | base64 -b 80 >> $output
fi
