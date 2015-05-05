#!/bin/bash
output="$(pwd)/${1:-gentoo-build.sh}"

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
$SEDCMD '0,/^exit$/d' $0 | base64 --decode | tar xjf - -C $dest 
exit
EOF

chmod +x $output

if base64 --help | grep -q 'GNU coreutils'; then
  tar cjf - --exclude=.git . | base64 -w 80 >> $output
else
  tar cjf - --exclude=.git . | base64 -b 80 >> $output
fi
