# .config-files

This repository is designed to manage Linux system and user configuration files using GNU Stow for consistent and straightforward deployment. Below, you'll find extended and detailed explanations about the tools, usage, and other essential aspects of this repository.

## Overview

This repository uses GNU Stow for managing dotfiles. It employs symlinks to maintain the separation between your config files and their deployment locations, offering greater flexibility and simplicity. Configurations are segregated into `home/`, `etc/`, and `usr/` directories to distinguish between user-level and system-level setups.

Employing this repository ensures that:
- Your configurations remain under version control.
- Maintenance and updates are simplified.
- Deployment is consistent across different systems.

## Tools

### Keyboard Mapping in Wayland
An integral part of this repository is managing custom keyboard mappings for Wayland sessions using **keyd**. Keyd is a powerful key remapping daemon that allows you to create flexible and complex keyboard mappings for your system.

More information, including installation instructions and examples, can be found on its [official GitHub page](https://github.com/rvaiya/keyd).

## Usage

### Deploying Your Configurations
To deploy configurations correctly, you can use the `./run-stow.sh` script located in the root of this repository. This script simplifies deployment while ensuring consistent behavior by performing the following:

1. **User-Level Configurations**: Files in the `home/` directory are symlinked to the `$HOME` directory of the user, enabling user-specific setups.
2. **System-Level Configurations**: Files in the `etc/` and `usr/` directories are targeted at `/etc` and `/usr` respectively. **Note**: Writing these configurations to system directories requires elevated privileges (`sudo`).

The script includes safeguards to preserve existing configurations:
- The `--adopt` flag integrates existing files into the repository if they aren’t already tracked.
- A `git stash` and `git reset` workflow ensures the repository remains the authoritative source of configuration data.

### Previewing Your Changes
Before making permanent changes to your configuration deployment, you can perform a dry run using the following command:
```bash
stow -nv --dir="$PWD" --target="$HOME" home
```
This will simulate the deployment process, showing the changes without applying them.

## Repository Structure

### Directory Organization
- **home/**: Stores user-specific configuration files symlinked to `$HOME`.
- **etc/**: Houses system-wide configuration files linked to `/etc`.
- **usr/**: Includes system resources meant for `/usr` (**currently unused** in this iteration).

### Ignore List
The `misc/` folder serves as a sandbox for temporary or non-critical data. It is excluded from Git tracking (`.gitignore`) and from the stow deployment.

## Miscellaneous Notes

- Ensure that the required tools, such as **GNU Stow** and **keyd**, are installed and properly configured on your machine before attempting to deploy the configurations.
- On multi-user systems, communicate with the system administrator to deploy system-wide configurations responsibly.

## Advantages of Using this Repository

1. **Version Control and Collaboration**: Track and revert changes easily, bringing the ability to collaborate on configurations with other users.
2. **Scalability Across Machines**: Seamlessly apply the same configurations to multiple machines or roll out changes without manual updates.
3. **Structured and Easy to Maintain**: The separation between system and user configurations makes identifying problematic or outdated configurations straightforward.

## Get Started

To clone the repository and initiate the setup, run the commands below on your terminal:

```bash
git clone /path/to/your-repo
cd .config-files
chmod +x run-stow.sh
./run-stow.sh
```

Ensure a consistent and trouble-free deployment with well-documented files to help you (or collaborators) manage the system effectively in future iterations.
