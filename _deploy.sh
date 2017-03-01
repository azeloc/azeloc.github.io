set -e

[ -z "${GITHUB_PAT}" ] && exit 0
[ "${TRAVIS_BRANCH}" != "content" ] && exit 0

git config --global user.email "fptcorrea@gmail.com"
git config --global user.name "azeloc"

git clone -b master https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git blog-output
cd blog-output
git rm -rf .
cp -r ../public/* ./
git add --all *
git commit -m "Atualiza o blog" || true
git push -q origin master
