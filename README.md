# ansible for the infrastructure of chaos.jetzt

This is a set of ansible roles used for the servers of [chaos.jetzt](https://chaos.jetzt).

## Usage
Make sure to initialize/update the submodules before deploying!

If neccessary, change the hostnames in the `hosts` file. Put the vault password in the `.vault_pass` file.

Run ansible:

```
make
```

## Initial serversetup
To install the base-configuration on a completely onconfigured server, e.g. without sudo and that stuff installed (but with a ssh-server accption login with root and a password/key) run:

```
make initial
```


## Use the password-store
To specify the path, from within the passwords shall be taken, use `PASSWORD_STORE_DIR=~/.password-store/chaos/jetzt` in front of the `make`/`ansible-playbook` command.
