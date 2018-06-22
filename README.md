# systemd-recipes
An assorted selection of SystemD units to ease administration and traceability

## Why systemd units?

- [Why systemd is *great* for configuration management](https://medium.com/treehouse-engineering/why-systemd-is-great-for-configuration-management-cb3172e0a1d1)
- [Introducción a systemd](https://github.com/mxabierto/hackea-el-sistema/wiki/Introducci%C3%B3n-a-systemd)
- [Path Units Are Easy!](https://blog.andrewkeech.com/posts/170809_path.html)

## Examples of use

### wp_db_export@.

For daily backup of the host `example.com` with the WordPress instance running in `/var/www/vhosts/example.com/httpdocs`
you enable the timer, that calls the service with:

    systemctl enable wp_db_export@example.timer
  
You could call by hand the service for testing, with:

    systemctl start wp_db_export@example.service
  
Essential aspects can be customized by drop-in files, i.e., the host `coool.com` has its WP instance running on
`/var/www/vhosts/coool.com/wordpress/public/cms`, then you should have the directory `wp_db_export@coool.d` with `custom.conf` file in it, with this content:

```systemd
[Service]
Environment=PUBLIC_PATH=wordpress/public
```

Running your backups on a different path? No worries? Just add to the drop-in file `custom.conf`:

```systemd
Environment=DB_DUMPS=media/dbdumps
```
  
Or whatever applies to your custom path.

### wp_rsync@.

The path unit monitors dumps, then launches a loop to gzip the .sql files found, then launches rsync to backup all the files.

For host `example.com`, you enable the path unit with: `systemctl enable --now wp_rsync@example.com.path`

You can customize the paths, remote hosting ssh parameters (port, user, etc).



