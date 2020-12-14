# terraform

A demonstration of terraform capabilites:
- aws: a hardcoded amazon web services deployment example
- azure: a hardcoded azure deployment example
- azure-improved: an azure deployment example demonstrating a remote backend, variables, and modules
- tieredApp: a multicloud (aws and azure) deployment example demonstrating nested modules and workspaces
- modules: example modules used for example deployments

To run the full demo, you need both an aws and an azure account with networking and compute privileges. All resources deployed fall within the free tier category for both cloud providers.

Install the following:
- aws cli
- azure cli
- terraform

Configure your cli instances to point to your account
- aws configure
- az login

For the remote backend demos (azure-improved, tieredApp), you will need to create a storage account and container in your azure environment. Update the backend.tfvars file in the root directory with your storage account information.

Please note, this code does not provide user access to the VMs that are deployed as part of the demonstration. No public IPs or security groups are configured so no one can reach the VMs over the network.
