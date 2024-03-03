# Parameters

| Parameter             | Description                                                                                         |
| --------------------- | --------------------------------------------------------------------------------------------------- |
| `username`            | Eufy Account Username (required)                                                                    |
| `password`            | Eufy Account Password (required)                                                                    |
| `country`             | ISO 3166-1 Alpha-2 country code (required)                                                          |
| `event_duration`      | Duration in seconds before an event is reset E.g. motion event (default: 10 sec.)                   |
| `polling_interval`    | Polling intervall for data refresh from Eufy Cloud in minutes (default: 10 min.)                    |
| `accept_invitations`  | Automatically accept device invitations (default: false)                                            |
| `port`                | Listening port on host (default: 3000)                                                              |
| `stations`            | Suggested IP addresses or broadcast addresses for stations (optional)                               |
| `trusted_device_name` | Label of the trusted devices (viewable with 2fa activated in Eufy App; default: random device name) |
| `debug`               | Activates debug mode (default: false)                                                               |
| `ipv4first`           | Forces the dns result order on Node.js to return IPv4 addresses first (default: false)              |

## Parameter `stations`

With this parameter you can speed up finding the unit in the local network. If this parameter is not set, an attempt is made to find the device in the local subnet of this service by means of a local broadcast. If this also leads to no result or this parameter is set incorrectly, the cloud discovery mechanism is used as fallback.

### Format

```yaml
stations:
  - serial_number: <serial_number>
    ip_address: <ip_address or broadcast address>
```

### Example

```yaml
stations:
  - serial_number: T8010XXXXXXXXXXX
    ip_address: 192.168.0.100 # ip address
  - serial_number: T8410XXXXXXXXXXX
    ip_address: 192.168.0.255 # broadcast address
```

## Parameter `ipv4first`

Starting with v17, [Node.js no longer orders IPv4 addresses before IPv6 addresses](https://nodejs.org/api/cli.html#--dns-result-orderorder) when resolving domain names. The endpoint used for push notifications (`firebaseinstallations.googleapis.com`) unfortunately resolves to a number of different IPv6 addresses that are not reachable from some connections.

If you stop receiving push notifications (and are seeing `create push credentials error` messages in the log that repeat endlessly), try setting this to `true`.

## Example configuration in YAML

```yaml
username: mail@address.com
password: password
country: US
port: 3000
polling_interval: 10
accept_invitations: true
debug: false
ipv4first: false
event_duration: 10
stations:
  - serial_number: T8010XXXXXXXXXXX
    ip_address: 192.168.0.100
  - serial_number: T8410XXXXXXXXXXX
    ip_address: 192.168.0.255
```
