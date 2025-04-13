# Official eufy-security-ws Home Assistant add-on repository

![Logo](eufy-security-ws/logo.png)

[![ci][ci-shield]][ci-url] ![Release][release-shield] ![Stars][stars-shield]

Join us on Discord:

<a target="_blank" href="https://discord.gg/5wjQ2asb64"><img src="https://dcbadge.limes.pink/api/server/5wjQ2asb64" alt="" /></a>

## Add-ons

This repository contains the following add-ons

### [eufy-security-ws add-on](./eufy-security-ws/README.md)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

## Installation

1. To add this repository to Home Assistant you have 2 options:

   1. Go to **Settings → Add-ons → Add-on store** and click **⋮ → Repositories**, fill in `https://github.com/bropat/hassio-eufy-security-ws` and click **Add → Close**
   2. click the **Add repository** button below, click **Add → Close** (You might need to enter the **internal IP address** of your Home Assistant instance first).

      [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fbropat%2Fhassio-eufy-security-ws)

2. To install an addon click on the relative addon link above to view the docs.

## Changelog

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/).

All notable changes to this project will be documented in the [CHANGELOG.md](eufy-security-ws/CHANGELOG.md) file.

Version for releases is based on [eufy-security-ws](https://github.com/bropat/eufy-security-ws) format: `X.Y.Z`.

Any changes on the addon that do not require a new version of [eufy-security-ws](https://github.com/bropat/eufy-security-ws) will use the format: `X.Y.Z-A` where `X.Y.Z` is fixed on the [eufy-security-ws](https://github.com/bropat/eufy-security-ws) release version and `A` is related to the addon.

## Issues

If you find any issues with the add-on, please check the [issue tracker](https://github.com/bropat/hassio-eufy-security-ws/issues) for similar issues before creating one. If your issue is regarding specific devices or, more generally, an issue that arises after eufy-security-ws has successfully started, it should likely be reported in the [eufy-security-ws issue tracker](https://github.com/bropat/eufy-security-ws/issues) or [eufy-security-client issue tracker](https://github.com/bropat/eufy-security-client/issues).

Feel free to create a PR for fixes and enhancements.

[ci-shield]: https://github.com/bropat/hassio-eufy-security-ws/workflows/Publish/badge.svg
[ci-url]: https://github.com/bropat/hassio-eufy-security-ws/actions?query=workflow%3APublish
[release-shield]: https://img.shields.io/github/v/release/bropat/hassio-eufy-security-ws.svg
[stars-shield]: https://img.shields.io/github/stars/bropat/hassio-eufy-security-ws.svg
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg

## Deployment

Instructions aimed at maintainers for deploying a new version: [Deployment](deployment.md)
