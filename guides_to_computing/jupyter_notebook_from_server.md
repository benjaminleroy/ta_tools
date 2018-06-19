# Jupter Notebooks via Server

From: https://coderwall.com/p/ohk6cg/remote-access-to-ipython-notebooks-via-ssh

Initialize notebook server on the remote server:

```{bash}
remote_server$ jupyter notebook --no-browser --port=8889
```

Then on your local machine:

```{bash}
local$ ssh -N -f -L localhost:8888:localhost:8889 user_id@remote_server
```

Next, look at your server terminal and look for something like:

```
Copy/paste this URL into your browser when you connect for the first time,
to login with a token:
    http://localhost:8889/?token=13cc54b4a3e13877cb07211346a363f9147a8cf2109263f1&token=13cc54b4a3e13877cb07211346a363f9147a8cf2109263f1

```

Copy this address but substitute `8889` with `8888` on your local machine's web server. If you want to make this easier in the future try `localhost:8888` and follow recommendations (I have not done this - maybe also make some comments and send them to me).

## Jupyter Notebook Extensions

I really like jupyter notebook extensions. Follow the brief instructions on [github](https://github.com/ipython-contrib/jupyter_contrib_nbextensions) to set it up. This [site](http://jupyter-contrib-nbextensions.readthedocs.io/en/latest/) has a description of the add-ons. I personally find `Scratchpad` very useful.
