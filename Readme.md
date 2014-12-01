Gitolite mirroring
==================

WARNING: procedure not complete yet

This image aims to ease test and usage of gitolite3 mirroring

How to use
----------

Based on gitolite tuto http://gitolite.com/gitolite/mirroring.html, we will create two servers: phobos and mars.

First, create a data container to persist your data:

    $> docker run --name=mars-data -v /data busybox true
    $> docker run --name=phobos-data -v /data busybox true

Then, run the initialization of the containers:

    $> docker run -ti --rm --volumes-from mars-data -e SSH_ADMIN_KEY="$(cat ~/.ssh/id_rsa.pub)" -e HOSTNAME=mars g3

    $> docker run -ti --rm --volumes-from phobos-data -e SSH_ADMIN_KEY="$(cat ~/.ssh/id_rsa.pub)" -e HOSTNAME=phobos g3

When running the init, you will get 2 public ssh keys, you need to add them in each admin repository (see details in gitolite doc).

Finally run the containers:

    $> docker run -d --name=mars --volumes-from mars-data g3
    $> docker run -d --name=phobos --volumes-from phobos-data g3

Exchange ssh keys

    $> git clone gitolite3@<mars ip address>:gitolite-admin mars
    $> git clone gitolite3@<phobos ip address>:gitolite-admin phobos
    $> docker run --rm --volumes-from mars-data busybox cat /data/gitolite3/.ssh/id_rsa.pub > phobos/keydir/server-mars.pub
    $> docker run --rm --volumes-from phobos-data busybox cat /data/gitolite3/.ssh/id_rsa.pub > mars/keydir/server-phobos.pub
    # then commit and push in each repo

Generate the ssh config:

    $> docker inspect -f '{{.NetworkSettings.IPAddress}}' mars
    $> docker inspect -f '{{.NetworkSettings.IPAddress}}' phobos
    host mars
        hostname <mars ip address>
    host phobos
        hostname <mars ip address>

