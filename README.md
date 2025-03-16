<!-- PROJECT SHIELDS -->

<!-- PROJECT LOGO -->
<br />

<p align="center">  <a href="https://github.com/7emotions/fuwari/">
  <img src="https://github.com/user-attachments/assets/22fd6aa5-6299-4e6d-961f-ea2bd7f93724" alt="Logo" >
  </a>
  <h3 align="center">Fuwari</h3>
  <p align="center">
    <br />
    <a href="https://github.com/7emotions/fuwari"><strong>探索本项目的文档 »</strong></a><br />
    <br />
    <a href="https://github.com/7emotions/fuwari/releases">查看发布</a>
    ·
    <a href="https://github.com/7emotions/fuwari/issues">报告Bug</a>
    ·
    <a href="https://github.com/7emotions/fuwari/issues">提出新特性</a>
  </p>
</p>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

# 前言

手动部署以及博客配置参考[国内自动化静态博客搭建](https://7emotions.atomgit.net/blog/posts/blog-guide/)。


# 准备

##  AtomGit

[AtomGit](https://atomgit.com/)是国内由开放原子基金会运营的`Git`托管平台，它支持`Pages`服务，并且具有良好的访问速度。

1. **一个账号与一个空仓库**

你需要先在`AtomGit`上注册一个账号，并创建一个**空仓库**，用于部署静态博客的站点构建文件。

2. **Pages服务申请**

该仓库需要开启`Pages`服务。参考[AtomGit Pages](https://docs.atomgit.com/app/pageshelp)。

- [点击此处申请Pages服务](https://atomgit.com/atomgit_operate/feedback/issues/create?name=3.Apply_Pages&dirType=1&page=issueTemplate)
- [点击此处安装Pages应用](https://atomgit.com/marketplace/pages?ref_app_id=4005817059772432)

> 开启Pages服务后，AtomGit会自动为你的仓库分配一个uri，例如`https://<username>.atomgit.net/<repo-name>`。你可以通过这个url来访问你的静态博客。

3. **访问令牌**

你需要创建一个访问令牌（`Personal Access Token`，`PAT`），用于`Github Action`访问你的仓库。[点击此处生成](https://atomgit.com/-/profile/tokens)。

> **注意**: 访问令牌需要勾选`repo`权限，否则`Github Action`无法访问你的仓库。

## Github

1. **一个账号**
你需要一个`Github`账号，并且需要创建一个仓库，用于存放静态博客的源文件。这个仓库不需要开启`Pages`服务。从该仓库中，你可以通过`Github Action`来生成静态博客的站点文件，并将其部署到`AtomGit`上。


# Github Action 部署

## 1. Fork 7emotions/Fuwari

首先，你需要Fork 我的[Fuwari](https://github.com/7emotions/fuwari) 到你的Github账号下。

- [如何Fork仓库](https://docs.github.com/zh/get-started/quickstart/fork-a-repo)

## 2. 配置Secret
在Fork后的仓库中，点击`Settings`，然后点击`Secrets and variables`，选择`Actions`，点击`New repository secret`，添加以下三个`Secret`。

- `TOKEN`：AtomGit的访问令牌(`PAT`)，用于`Github Action`访问你的AtomGit仓库。
- `USER`：AtomGit的用户名，用于`Github Action`访问你的AtomGit仓库。
- `REPO`：AtomGit的仓库名，用于`Github Action`访问你的AtomGit仓库。

> 例如，我的AtomGit仓库的uri为`https://atomgit.com/<username>/<repo-name>`，那么`USER`为`<username>`，`REPO`为`<repo-name>`。

## 3. 启用Actions

在`Github`仓库中，点击`Actions`，选择`Deploy Pages`，点击`Run workflow`，选择分支为`main`，点击`Run workflow`。

![image](https://github.com/user-attachments/assets/c52c0097-046b-414c-9fa2-2955b4bb8dfd)


刷新页面，可以看到`Github Action`正在运行。

![image](https://github.com/user-attachments/assets/c7180760-f7d5-4757-b8f0-17a57f8c3c17)


约莫1分钟后，出现如下提示，说明`Github Action`运行完成。

![image](https://github.com/user-attachments/assets/87f2afe5-2e09-4bfb-bf59-234642c01284)


当`Github Action`运行完成后，你可以访问`https://<username>.atomgit.net/<repo-name>`查看你的静态博客。

> 例如，我的AtomGit仓库的uri为`https://atomgit.com/7emotions/blog`，那么我的静态博客的访问地址为`https://7emotions.atomgit.net/blog`。

# Docker 部署

## 1. Fork 7emotions/Fuwari

首先，你需要Fork 我的[Fuwari](https://github.com/7emotions/fuwari) 到你的Github账号下。

- [如何Fork仓库](https://docs.github.com/zh/get-started/quickstart/fork-a-repo)

## 2. Clone 仓库

在本地，使用`git clone`命令克隆你的Fork仓库。

```bash
git clone https://github.com/<username>/fuwari.git
```

## 3. 配置环境变量

在`fuwari`目录下，创建一个`.env`文件，并添加以下内容。

```bash
TOKEN=<AtomGit-Token>
USER=<username>
REPO=<repo-name>
GIT_DOMAIN=atomgit.com
BRANCH=pages
```

> 文中`<AtomGit-Token>`、`<username>`、`<repo-name>`分别代表AtomGit的访问令牌(`PAT`)、AtomGit的用户名、AtomGit的仓库名。


## 4. 构建与运行

在`fuwari`目录下，使用以下命令构建与运行。

```bash
docker-compose up -d
```

## 5. 访问博客

当`Docker`容器运行完成后，你可以访问`https://<username>.atomgit.net/<repo-name>`查看你的静态博客。

# 博文发布

无论是`Github Action`部署还是`Docker`部署，每次向远端推送博文，会自动触发`Github Action`，生成静态博客的站点文件，并将其部署到`AtomGit`上。

[your-project-path]:7emotions/fuwari
[contributors-shield]: https://img.shields.io/github/contributors/7emotions/fuwari.svg?style=flat-square
[contributors-url]: https://github.com/7emotions/fuwari/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/7emotions/fuwari.svg?style=flat-square
[forks-url]: https://github.com/7emotions/fuwari/network/members
[stars-shield]: https://img.shields.io/github/stars/7emotions/fuwari.svg?style=flat-square
[stars-url]: https://github.com/7emotions/fuwari/stargazers
[issues-shield]: https://img.shields.io/github/issues/7emotions/fuwari.svg?style=flat-square
[issues-url]: https://img.shields.io/github/issues/7emotions/fuwari.svg
[license-shield]: https://img.shields.io/github/license/7emotions/fuwari.svg?style=flat-square
[license-url]: https://github.com/7emotions/fuwari/blob/master/LICENSE.txt
