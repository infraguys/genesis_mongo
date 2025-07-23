# Genesis Mongo Element

The MongoDB element of the Genesis project.

The project is powered by [Genesis Core](https://github.com/infraguys).

# 🛠️ Build

You need [DevTools](https://github.com/infraguys/genesis_devtools) to build the image. See the [install](https://github.com/infraguys/genesis_devtools?tab=readme-ov-file#install) section for details.


Run the build command:

```bash
genesis build -i ~/.ssh/key.pub -f .
```

Where `~/.ssh/key.pub` is your public key for the image.

Also you may set the `GEN_USER_PASSWD` environment variable to change the default user password.

```bash
export GEN_USER_PASSWD=secret
genesis build -i ~/.ssh/key.pub -f .
```

# 🚀 Usage

Upload the image to your repository. Using API, CLI or web interface create a node with the image.

```bash
curl --location 'http://10.20.0.2:11010/v1/nodes/' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer ****' \
--data '{
    
    "name": "vm",
    "project_id": "f1f14cf1-1639-40dc-b725-757506a202b4",
    "root_disk_size": 15,
    "cores": 1,
    "ram": 1024,
    
    "image": "http://10.20.0.1:8080/genesis-mongo.raw"
}'
```

# 📃 Bootstrap scripts

For next images in hierarchy you can add scripts that are executed at the very first boot of the node. Actually it can be any executable file and not only bash scripts. Put your scripts in the `/var/lib/genesis/bootstrap/scripts` directory and they will be executed in the order of the files in the directory.
