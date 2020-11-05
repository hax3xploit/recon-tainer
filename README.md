# Recon-tainer



![GitHub](https://img.shields.io/github/license/hax3xploit/recon-taineR)
![GitHub closed issues](https://img.shields.io/github/issues-closed/hax3xploit/recon-taineR)
![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/hax3xploit/recon-taineR)
[![Twitter](https://img.shields.io/twitter/url/https/twitter.com/cloudposse.svg?style=social&label=%40hax.3xploit)](https://twitter.com/hax.3xploit)

A docker container which will enumerate subdomains and then filters out injection point parameters and much more.


## Building the docker image
You can build the docker image yourself using the following:

```bash
git clone https://github.com/hax3xploit/recon-tainer  && cd recon-tainer
docker build . -t hax3xploit/recon-tainer:v1.0 
docker run -it --rm hax3xploit/recon-tainer:v1.0 
```

## Using Image from Dockerhub
In case you don't want to build the image yourself, just execute the line below and you'll be done and dusted. 

```bash
docker run -it --rm hax3xploit/recon-tainer:v1.0
```

Mounting saved results
```bash
docker run -it --rm -v /home/<user>/results/:/root/results/ hax3xploit/recon-tainer:v1.0
```
## Add to .bashrc or .zshrc
Add this line to your .bashrc or .zshrc, so you dont have to write whole docker command every time.
```bash
alias recon-tainer="docker run -it --rm -v /root/subdomains/results/:/root/results/ hax3xploit/recon-tainer:v1.0"
```


## Tools
Currently integrated tools include:
* [Sublist3r](https://github.com/aboul3la/Sublist3r)
* [Subfinder](https://github.com/projectdiscovery/subfinder)
* [Amass](https://github.com/OWASP/Amass)
* [OneForAll](https://github.com/shmilylty/OneForAll/)
* [Asset Finder](https://github.com/tomnomnom/assetfinder)
* [Findomain](https://github.com/Edu4rdSHL/findomain)
* [MassDNS](https://github.com/blechschmidt/massdns)
* [GF Patterns](https://github.com/1ndianl33t/Gf-Patterns)
* [Gau](https://github.com/lc/gau)
* [HTTPX](https://github.com/projectdiscovery/httpx)
* [dirsearch](https://github.com/maurosoria/dirsearch)

