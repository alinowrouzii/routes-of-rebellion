
# Network Traffic Routing Manager

This script is about managing network traffic routing on macOS by utilizing multiple network interfaces. It allows users to route specific network traffic through designated interfaces for better control and optimized network performance.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Future Development](#future-development)
- [Contributing](#contributing)
- [License](#license)

## Installation

### Prerequisites

- macOS (Darwin-based systems)
- Root privileges (for network configuration and `/etc/hosts` modifications)

### Setup

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/network-traffic-routing.git
    cd network-traffic-routing
    ```

## Usage

1. Run the `main.sh` script to automatically detect your OS and configure the routes. This script will call the platform-specific scripts based on the detected operating system.

    ```bash
    sudo ./main.sh
    ```

2. Follow the on-screen instructions. The script will:
    - Check if it's running with root privileges.
    - Add network routes for the specified subnets through the `en*X*` interface.
    - Modify the `/etc/hosts` file to ensure internal domains resolve correctly on your network.

### Example Output

```bash
Detected macOS. Executing mac-os.sh...
Route added: 10.100.0.0/16 via 192.168.1.1
Route added: 192.168.0.0/16 via 192.168.1.1
Updating /etc/hosts for internal domains...
Added: chat.internal.ir 10.100.0.10
Added: internal.service.local 192.168.1.5
Script execution completed.
```

## Future Development

- **Linux Support**: Extend the script to support routing on Linux-based systems.
- **Windows Subsystem for Linux (WSL)**: Add support for managing routes in WSL.
- **More Network Configuration Options**: Include additional routing rules and more advanced network management features.

## Contributing

We welcome contributions to improve and extend the functionality of this project. To contribute:

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request with a clear description of your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
