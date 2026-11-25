# Expire-dialog API

PHP API with an expiry-check endpoint, packaged for Docker-based hosting on Render.

## Deploy on Render

1. In Render, create a **Web Service** from this GitHub repository.
2. Choose **Docker** as the runtime and set the Dockerfile path to `./Dockerfile`.
3. Deploy. The container listens on Render's `PORT` environment variable (default `10000`).
4. Test the expiry endpoint at `https://<your-service>.onrender.com/index.php?v=1.0` or `https://<your-service>.onrender.com/expire?v=1.0`.

The expiry date and redirect URL are currently set in `index.php` to November 26, 2026 at 23:59:59 Pakistan time and the supplied WhatsApp channel. You can override them in Render's environment settings with `APP_EXPIRES_AT` and `APP_REDIRECT_URL`.

## Persistent access-key storage

The expiry-check endpoint is stateless. The access-key endpoints write a local store file. Without a persistent disk, those records can be lost when the service restarts or redeploys.

To preserve them, attach a Render persistent disk mounted at `/var/data`, then set `KEY_STORAGE_DIR=/var/data` in the service environment. Render persistent disks are available on paid services. Without a disk, the container uses temporary storage under `/tmp/expire-dialog-storage`.
