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

## Add secrets to the vault
To add new secret variables, put the vault password in the file `.vault_pass`, then for the variable `radius_client_secret` with the value `totallysecretvaluehere` encrypt it like this:

```
ansible-vault encrypt_string 'totallysecretvaluehere' --name 'radius_client_secret'
```
