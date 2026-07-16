Move nixos config into home with:

```console
sudo mv /etc/nixos ~/nixos
# don't forget to change <your_user> and <your_group>
sudo chown -R <your_user>:<your_group> ~/nixos
sudo ln -s ~/nixos /etc/nixos
```
