# RethoughtOS


# How to build ISO

### Install build dependencies

```
sudo pacman -S archiso git squashfs-tools sbsigntools grub --needed
```
It is recommended to reboot after these changes.

##### Build

~~~
sudo ./mkarchiso -v "."
~~~
