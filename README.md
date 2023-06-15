# TrueNAS ACME shell DNS-Authenticator
ACME DNS-Authenticator shell scripts for TrueNAS

## Copyright & License
* GNU GENERAL PUBLIC LICENSE, v3
* Copyright (C) 2023, Switzer Business Solutions, LLC, all rights reserved
* https://www.sbsroc.com

## Description
Acme_DreamHost.sh can be uploaded stand-alone to your TrueNAS system and allow you to create ACME certificates with Let's Encrypt even if you don't use an internally supported DNS provider.

## Instructions
* Modify Acme_DreamHost.sh to include your DreamHost API key
* Upload it to your TrueNAS system
* Add an Authenticator under Credentials --> Certificates --> ACME DNS-Authenticators

### Example DNS-Authenticator Configuration
<img src="./DNS%20Authenticator%20Configuration.png" width="350" alt="Example Configuration"/>
