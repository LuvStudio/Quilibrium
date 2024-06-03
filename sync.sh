git remote add upstream https://source.quilibrium.com/quilibrium/ceremonyclient.git
git fetch --all
# 获取所有本地分支的列表
branches=$(git branch --list | sed 's/\*//')

# 循环处理每个分支
for branch in $branches; do
    # 获取本地分支的远程跟踪分支
    upstream=$(git rev-parse --abbrev-ref ${branch}@{upstream} 2>/dev/null)
    if [ -n "$upstream" ]; then
        echo "Syncing branch $branch with upstream $upstream"
        # 切换到本地分支
        git checkout $branch
        # 拉取远程分支的更新
        git pull upstream $branch
    else
        echo "No upstream branch found for $branch"
    fi
done

git checkout main
git push --all --force origin
git push --tags --force origin
