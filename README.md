<h2 id="quickstart">⚡️ Initial Setup</h2>

1. Clone repository

   ```bash
   dotfiles link https://github.com/askwakhid/ssl-expiration-alert.git
   ```
1. Edit domain.text and replace with the domain you want to monitor
    ```bash
    expired.badssl.com
    wrong.host.badssl.com
    untrusted-root.badssl.com
    ```

1. Create cron jobs for automate the tasks

    ```bash
    0 4 * * *  /usr/bin/sh ssl-expiration-alert.sh
    ```