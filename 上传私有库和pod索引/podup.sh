#!/bin/bash


project_path=$(pwd)
project_name="${project_path##*/}"

reponame="WQSpec"
now_tag=$1
msg=$2
old_tag=$3
#清除tag
if [ $old_tag ]
then
pod cache clean --all && git tag -d $old_tag && git push origin :$old_tag
else
old_tag=$now_tag
pod cache clean --all && git tag -d $old_tag && git push origin :$old_tag
fi
#建立新tag
if [ $now_tag ]
then
git add . 
if [ $msg ]
then 
git commit -m $msg
else
git commit -m '默认提交'
fi
git push && git tag $now_tag && git push --tags && pod repo push $reponame $project_name.podspec
echo '已推送到'${reponame}'索引库'
else
echo "请输入git 的tag标签"
fi

