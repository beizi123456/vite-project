# Simple workflow for deploying static content to GitHub page
name: Deploy static content to page

on:
  #仅在推动到默认分支时运行
  push:
    branches:['master']

  #这个项目可以使你手动在Action tab 页面触发工作流
  workflow_dispatch:

  #设置 GITHUB_TOKEN 的权限，以允许部署到 GitHub Pages
  permission:
    contents:read
    pages:write
    id-token:write

  #允许一个并发的部署
  concurrrency:
    group:'pages'
    cancel=in-progress:true

  jobs:
  #单次部署的工作描述
    deploy:
    environment:
      name:github-pages
      url:${{ steps.deployment.outputs.page_url }}
    runs-on:ubuntu-latest
    steps:
      - name:Checkout
        uses:actions/checkout@v3
      - name Set up Node
        uses:actions/setup-node@v3
       with:
        node-version: 18
        cache:'npm'
      - name: Install dependencies
        run: npm install
      _ name: Build
        run: npm run build
      - name: Setup Pages
        uses: actions/configure-pages@v3
      - name: Upload artiface
        uses: actions/upload-pages-artifact@v1
        with:
          #Upload dist repository
          path: './dist'
      - name: Deploy to Github Pages
        id: deployment
        uses:actions/deploy-pages@v1
        



