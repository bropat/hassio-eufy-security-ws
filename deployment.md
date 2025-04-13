# Deployment instructions

## eufy-security-client

[Instructions and dependency tree](https://github.com/bropat/eufy-security-client/tree/develop/docs/deployment.md).

## eufy-security-ws

[Instructions](https://github.com/bropat/eufy-security-ws/tree/develop/docs/deployment.md).

## hassio-eufy-security-ws

How to deploy a new version of hassio-eufy-security-ws:

1. Update all the npm dependencies and bring in the [eufy-security-ws npm package](https://www.npmjs.com/package/eufy-security-client) latest published version.
2. Review and merge into the [develop](https://github.com/bropat/hassio-eufy-security-ws/tree/develop) branch the PRs that should be included in the next release.
3. Submit a PR to the `develop` branch containing these changes:
   1. Update eufy-security-ws/build.yaml so that the `EUFY_SECURITY_WS_VERSION` variable points to the latest published version of the eufy-security-ws npm package.
   2. Update eufy-security-ws/config.yaml so that the `version` variable points to the same number.
   3. Update eufy-security-ws/CHANGELOG.md to include a new entry at the top describing the latest batch of changes.
4. Merge everything from `develop` into [master](https://github.com/bropat/hassio-eufy-security-ws/tree/master).
5. Publish a new [release and tag](https://github.com/bropat/eufy-security-ws/releases/new) out of the latest changes merged into `master`.
6. Using that new release from `master`, publish a new [eufy-security-ws Docker image version](https://hub.docker.com/r/bropat/eufy-security-ws).

