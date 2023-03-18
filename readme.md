# MDaemon with Caddy

- [1. Overview](#1-overview)
- [2. Goal](#2-goal)
- [3. Bugs, Troubleshooting, Support](#3-bugs-troubleshooting-support)
- [4. Context](#4-context)
- [5. Installation](#5-installation)
  - [5.1. Configuring Caddy](#51-configuring-caddy)
  - [5.2. Copying the scripts](#52-copying-the-scripts)
  - [5.3. Configuring MDaemon](#53-configuring-mdaemon)
    - [5.3.1. Configuring MDaemon Web Services](#531-configuring-mdaemon-web-services)
    - [5.3.2. Configuring MDaemon SSL/TLS](#532-configuring-mdaemon-ssltls)
  - [5.4. Configuring the Task Manager](#54-configuring-the-task-manager)
    - [5.4.1. Copying the script](#541-copying-the-script)
    - [5.4.2. Schedule the execution of the script](#542-schedule-the-execution-of-the-script)
- [6. Legal notes](#6-legal-notes)
- [7. License](#7-license)

> ---
> THIS IS A WORK IN PROGRESS
> ---
> **PLEASE** DO NOT USE IT UNTIL THIS NOTE APPEARS HERE
> ---

## 1. Overview

MDaemon is a mail and collaboration server for Microsoft Windows written
in C/C++.

Caddy 2 is a powerful, cross-platform, enterprise-ready, open source web
server with automatic HTTPS written in Go.

## 2. Goal

Make the configuration of MDaemon's web services easily reproducible and
back-up processable, also using free SSL/TLS certificates from the Let's
Encrypt project.

> Caddy can request/renew **Let's Encrypt** and **ZeroSSL**
> certificates, but the proposed configuration is for the former,
> since MDaemon provides this same mechanism for creating certificates.

## 3. Bugs, Troubleshooting, Support

Unfortunately, it is not possible to provide support for the
configuration and use of these scripts.

Please report any problems in the
[issues section on GitHub](https://github.com/ealib/mdaemon-with-caddy/issues).

You can find the author and other users of MDaemon in
[this room where MDaemon is discussed](https://matrix.to/#/#mdaemon:matrix.org)
(Matrix federation).

## 4. Context

In the remainder of this paper, we will assume that:

- MDaemon is installed in the *default* directory `C:\MDAEMON`:
  - download the MDaemon setup from
    [this page](https://mdaemon.com/pages/downloads-mdaemon-mail-server-free-trial);
  - run the setup and install MDaemon: if you choose to change the
    installation path, remember to also change it where the default one
    is mentioned.
  - primary and default domain is `example.com`
  - MDaemon public host name is `mx1.example.com`
  - MDaemon public host name for mail protocols is `mail.example.com`
- Caddy is installed in the directory `C:\Program Files\Caddy`:
  - create the `C:\Program Files\Caddy` directory;
  - download the Caddy binary archive from
    [this page](https://caddyserver.com/download);
  - unzip the Caddy binary archive in `C:\Program Files\Caddy`;
  - open a command line with elevated privileges ("DOS prompt") and
    [install Caddy as a Windows service](https://caddyserver.com/docs/running#windows-service);
  - possibly define a local user under which Caddy will run and set the
    relevant service to log in under that name; for complete security,
    set the ACLs of the directories used by Caddy so that only that user
    and users in the `.\Administrators` group can access them.

## 5. Installation

Two sets of files are provided. One for MDaemon that manages only one
`example.com` domain and one for MDaemon that manages three mail domains
`example.com`, `example1.com`, and `example2.com`.

### 5.1. Configuring Caddy

As a best practice, we will keep Caddy's binary files in
`C:\Program Files\Caddy` separate from the configuration and accessory
files, which will be found in `C:\ProgramData\Caddy`.

Open a command line with elevated privileges ("DOS prompt") and execute
the following commands:

    mkdir C:\ProgramData\Caddy
    mkdir C:\ProgramData\Caddy\Log

### 5.2. Copying the scripts

Depending on whether MDaemon manages a **single mail domain**, or
**multiple mail domains**, copy the pair of files respectively in

- `assets`
  - `scripts`
    - `single-mail-domain`
      - `CaddyFile`
      - `maintenance.html`
    - `multiple-mail-domains`
      - `CaddyFile`
      - `maintenance.html`

to `C:\ProgramData\Caddy`.

Finally, since the *Caddy* process searches, at start-up, for the file
`CaddyFile` in the same directory as the program file, it will be
necessary to create a link to the configuration file, from a command
line with elevated privileges ("DOS prompt"):

    cd /D "C:\Program Files\Caddy"
    mklink CaddyFile C:\ProgramData\Caddy\CaddyFile

Depending on whether MDaemon manages a single domain, or multiple
domains, change all occurrences of the example domain names
`example.com`, `example1.com`, and `example2.com` in the `CaddyFile`
and `maintenance.html` files to those used by MDaemon itself.

### 5.3. Configuring MDaemon

#### 5.3.1. Configuring MDaemon Web Services

- [x] use internal web server
- [x] bind to 127.0.0.1

#### 5.3.2. Configuring MDaemon SSL/TLS

- **disable** Let's Encrypt request/renew scheduler

### 5.4. Configuring the Task Manager

Use of the task manager is required to renew TLS/SSL certificates by
Let's Encrypt used by MDaemon for mail sessions (SMTP/IMAP4/POP3).

All site certificates will instead be managed independently by Caddy.

#### 5.4.1. Copying the script

Depending on whether MDaemon manages a **single mail domain**, or
**multiple mail domains**, copy the script respectively in

- `assets`
  - `scripts`
    - `single-mail-domain`
      - `scheduled-renew.cmd`
    - `multiple-mail-domains`
      - `scheduled-renew.cmd`

to `C:\MDaemon\LetsEncrypt`.

#### 5.4.2. Schedule the execution of the script

Schedule the execution of the `C:\MDaemon\LetsEncrypt\scheduled-renew.cmd`
script with the preferred frequency. However, it is suggested not to
deviate too much from Let's Encrypt's recommendation of [no more than 60-day
between renewal attempts](https://letsencrypt.org/docs/faq/).

## 6. Legal notes

[**MDaemon**](https://mdaemon.com/) is copyright © 1996-2023 [MDaemon Technologies Ltd.](https://mdaemon.com/pages/about-us).

[**Caddy**](https://caddyserver.com/) is © 2023 [Stack Holdings](https://zerossl.com/privacy/). All rights reserved. Caddy® is a registered trademark of [Stack Holdings GmbH](https://zerossl.com/privacy/).

[**Let's Encrypt**](https://letsencrypt.org) is © 2023 [Internet Security Research Group](https://www.abetterinternet.org/trademarks/).

[**ZeroSSL**](https://zerossl.com/) is © 2023 ZeroSSL™, a product of [Stack Holdings](https://zerossl.com/privacy/). All Rights Reserved. ZeroSSL™ is a trademark of [Stack Holdings GmbH](https://zerossl.com/privacy/) in the USA, EU & UK.

## 7. License

    ISC License

    Copyright (c) 2023 Emanuele Aliberti, MTKA

    Permission to use, copy, modify, and/or distribute this software for any
    purpose with or without fee is hereby granted, provided that the above
    copyright notice and this permission notice appear in all copies.

    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
