
# Raqeb - System Monitoring Application

Raqeb is a system monitoring application designed for Ubuntu that monitors CPU and GPU temperatures, usage, and disk and memory usage. It is specifically tailored to work with NVIDIA GPUs and requires the `nvidia-smi` utility for GPU monitoring.

![image](https://github.com/user-attachments/assets/b2363f9c-5dc9-4538-84db-389ad28a7566)

## Features

- Monitor CPU temperatures and usage
- Monitor GPU temperatures and usage (NVIDIA only)
- Monitor disk usage
- Monitor memory usage

## Requirements

- Ubuntu operating system
- NVIDIA GPU and drivers
- `nvidia-smi` utility

## Installation

### Setup Branch

To install a packaged version of Raqeb, follow these steps:

1. **Clone the Repository in HOME dir:**

    ```bash
    git clone -b setup https://github.com/Ali-Hossam/Raqeb-System-Monitor-App.git
    cd Raqeb
    ```

2. **Run the Setup Script:**

    ```bash
    sh install.sh
    ```

This script will copy the necessary files to the appropriate locations and create a desktop entry for Raqeb.

### Source Code Branch

To work with the source code and build Raqeb from scratch, follow these steps:

1. **Clone the Repository:**

    ```bash
    git clone -b main https://github.com/Ali-Hossam/Raqeb-System-Monitor-App.git
    cd raqeb
    ```

2. **Open the Project in Qt Creator:**

    - Launch Qt Creator.
    - Open the project by selecting the `raqeb.pro` file.
    - Configure the build settings as needed.
    - Build and run the project from within Qt Creator.

## Usage

After installation, you can launch Raqeb from the applications menu. Look for the Raqeb icon and click on it to start monitoring your system.

### Running from the Command Line

If you want to run Raqeb directly from the command line, navigate to the installation directory and execute the main script:

```bash
cd /path/to/raqeb
sh Raqeb.sh
```

## Troubleshooting

### Common Issues

1. **nvidia-smi not found:**

    Ensure that the NVIDIA drivers and `nvidia-smi` utility are installed and accessible from the command line:

    ```bash
    sudo apt install nvidia-driver-<version>
    sudo apt install nvidia-utils-<version>
    ```

2. **Application not appearing in the application menu:**

    Ensure the desktop entry was created correctly. You can manually copy the `.desktop` file to the appropriate directory:

    ```bash
    cp Raqeb.desktop ~/.local/share/applications/
    ```

## Contributing

Contributions are welcome! If you would like to contribute to Raqeb, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes.
4. Push your branch and create a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---
