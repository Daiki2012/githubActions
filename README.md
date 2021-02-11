# GitHub Actions with XServer

GitHub Actions with XServer create CI/CD pipeline with GitHub actions via
connecting to XServer (rental hosting server). with SSH, and upload the latest 
code to the public_html holder for faster / automatic deployment. No need to use 
FTP app such as FileZilla. Jenkins or CircleCI could be the alternative, but GitHub
actions support similar CI/CD functions.

* When GitHub push occurs, it execute the GitHub Actions.
* Automatically connect to your XServer over SSH.
* The shell script clean up the unnecessary files.
* Upload the latest raect project files to the public_html folder.

<p align="center">
  <img src="./img/example.png" alt="Size Limit CLI" width="738">
</p>

With **[GitHub Actions]** the above tasks are executed automatically, so no manual process
is required.



## How It Works

1. Update deploy.xml under .github/workflows/
2. update cleanup.sh under scripts

## Usage

### setup github secrets

Setup github secrets for the XServer user, passwords, host name.

### setup deplooy.xml

github actions is based on the yaml file stored under .github/workflows

1. Install and configure the below yaml with your XServer or hosting service credentials.


```yaml
on: push
name: Deploy website on push
jobs:
  web-deploy:
    name: Deploy
    runs-on: ubuntu-latest
    steps:
    - name: Get latest code
      uses: actions/checkout@v2.3.2

    - name: Build
      uses: actions/setup-node@v1
    - run: npm install && npm run build

    - name: Upload files
      uses: SamKirkland/FTP-Deploy-Action@4.0.0

      with: 
        server: ${{ secrets.ftp_server }}
        username: ${{ secrets.ftp_username }}
        password: ${{ secrets.ftp_password }}
        server-dir: xxxx.xsrv.jp/public_html/
        local-dir: ./build/
```


## execute unix commands

You can execute unix commands via below yaml example. if you try to remove a file that does not exist, it gives an error, and the github actions stop. So, add || true at the end, so that it ignores the error

```yaml
- name: Remove files via ssh
  uses: fifsky/ssh-action@master
  with:
		command: |
    	ls -a
      cd xxxx.xsrv.jp/public_html/
      ls -a
      rm precache-manifest* || true
      rm -r static || true
      host: {{ secrets.ftp_server }}
      port: 10022
      user: {{ secrets.ftp_username }}
      key: ${{ secrets.ssh_private_key }}
```

