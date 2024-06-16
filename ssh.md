# How To Work With Multiple Github Accounts on a single Machine

Let suppose I have two github accounts, `https:/github.com/name-office` and `https://github.com/name-personal`. Now i want to setup my mac to easily talk to both the github accounts.

> NOTE: This logic can be extended to more than two accounts also.

The setup can be done in 5 easy steps:
## Steps:
- [Step 1](#step-1) : Create a systemd service to start ssh-agent on login
- [Step 2](#step-2) : Create SSH keys for all accounts
- [Step 3](#step-3) : Add SSH keys to SSH Agent
- [Step 4](#step-4) : Add SSH public key to the Github
- [Step 5](#step-5) : Create a Config File and Make Host Entries
- [Step 6](#step-6) : Cloning GitHub repositories using different accounts

<br>

## Step 1
### Create a systemd service to start ssh-agent on login
Create a systemd user service, by putting the following to `~/.config/systemd/user/ssh-agent.service`:

```ini
[Unit]
Description=SSH key agent

[Service]
Type=simple
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK

[Install]
WantedBy=default.target
```

Setup shell to have an environment variable for the socket (`.bash_profile`, `.zshrc`, ...):

```bash
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
```

Enable the service, so it'll be started automatically on login, and start it:

```bash
systemctl --user enable ssh-agent
systemctl --user start ssh-agent
```

Add the following configuration setting to your local ssh config file `~/.ssh/config` (this works since SSH 7.2):

```
AddKeysToAgent  yes
```

This will instruct the ssh client to always add the key to a running agent, so there's no need to ssh-add it beforehand.

## Step 2
### Create SSH keys for all accounts
First make sure your current directory is your `.ssh` folder.

```bash
cd ~/.ssh
```
Syntax for generating unique ssh key for ann account is:

```bash
ssh-keygen -t rsa -C "your-email-address" -f "github-username"
```
here,

`-C` stands for comment to help identify your ssh key

`-f` stands for the file name where your ssh key get saved


#### Now generating SSH keys for my two accounts

```bash
ssh-keygen -t rsa -C "my_office_email@gmail.com" -f "github-name-office"
ssh-keygen -t rsa -C "my_personal_email@gmail.com" -f "github-name-personal"
```

Notice here `name-office` and `name-work` are the username of my github accounts corresponding to `my_office_email@gmail.com` and `my_personal_email@gmail.com` email ids respectively.

After entering the command the terminal will ask for passphrase, leave it empty and proceed.

> Now after adding keys , in your .ssh folder, a public key and a private will get generated.

>The public key will have an extention __.pub__ and private key will be there without any extention both having same name which you have passed after __-f__ option in the above command. (in my case __github-name-office__ and __github-name-personal__)

<br>

## Step 3
### Add SSH keys to SSH Agent
Now we have the keys but it cannot be used until we add them to the SSH Agent.

```bash
ssh-add -K ~/.ssh/github-name-office
ssh-add -K ~/.ssh/github-name-personal
```

You can read more about adding keys to SSH Agent [here.](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

<br>

## Step 4
### Add SSH public key to the Github
For the next step we need to add our public key (that we have generated in our previous step) and add it to corresponding github accounts.

For doing this we need to:

__1. Copy the public key__

We can copy the public key either by opening the `github-name-office.pub` file in vim and then copying the content of it.

```bash
vim ~/.ssh/github-name-office.pub
vim ~/.ssh/github-name-personal.pub
```

___OR___

We can directly copy the content of the public key file in the clipboard.

```bash
pbcopy < ~/.ssh/github-name-office.pub
pbcopy < ~/.ssh/github-name-personal.pub
```


__2. Paste the public key on Github__

* Sign in to Github Account
* Goto `Settings` > `SSH and GPG keys` > `New SSH Key`
* Paste your copied public key and give it a Title of your choice.

___OR___

* Sign in to Github 
* Paste this link in your browser (https://github.com/settings/keys) or click [here](https://github.com/settings/keys)
* Click on `New SSH Key` and paste your copied key.

<br>

## Step 5
### Create a Config File and Make Host Entries

The `~/.ssh/config` file allows us specify many config options for SSH.

If `config` file not already exists then create one (make sure you are in `~/.ssh` directory)

```bash
touch config
```

The commands below opens config in your default editor....Likely TextEdit, VS Code.

```bash
open config
```

Now we need to add these lines to the file, each block corresponding to each account we created earlier.

```
#name-office account
Host github.com-name-office
    HostName github.com
    User git
    IdentityFile ~/.ssh/github-name-office

#name-personal account
Host github.com-name-personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/github-name-personal
```

<br>

## Step 5
### Cloning GitHub repositories using different accounts

So we are done with our setups and now its time to see it in action. We will clone a repository using one of the account we have added.

Make a new project folder where you want to clone your repository and go to that directory from your terminal.

For Example:
I am making a repository on my personal github account and naming it `TestRepo`
Now for cloning the repo use the below command:

 ```bash
git clone git@github.com-{your-username}:{owner-user-name}/{the-repo-name}.git

[e.g.] git clone git@github.com-name-personal:name-personal/TestRepo.git
 ```

 <br>

 ## Finally

From now on, to ensure that our commits and pushes from each repository on the system uses the correct GitHub user — we will have to configure `user.email` and `user.name` in every repository freshly cloned or existing before.

To do this use the following commands.

```bash
git config user.email "my_office_email@gmail.com"
git config user.name "Name Surname"

git config user.email "my-personal-email@gmail.com"
git config user.name "Name Surname"
```
Pick the correct pair for your repository accordingly.


To push or pull to the correct account we need to add the remote origin to the project
```bash
git remote add origin git@github.com-name-personal:name-personal

git remote add origin git@github.com-name-office:name-office
```

Now you can use:
```bash
git push

git pull
```
