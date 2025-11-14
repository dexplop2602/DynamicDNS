Of course, here is a README for your project in English.

# Dynamic DNS (DDNS) Lab with Vagrant

This project sets up a virtual lab environment to demonstrate the functionality of Dynamic DNS (DDNS) using Vagrant, VirtualBox, BIND9 for DNS, and ISC DHCP Server.

The environment consists of three virtual machines:
*   `dns`: An Ubuntu 20.04 server running the BIND9 DNS server.
*   `dhcp`: An Ubuntu 20.04 server running the ISC DHCP server, configured to send updates to the DNS server.
*   `c1`: An Ubuntu 20.04 client machine that gets its IP address from the DHCP server and automatically registers its hostname with the DNS server.

## Prerequisites

*   [Vagrant](https://www.vagrantup.com/downloads)
*   [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## How to Use

1.  **Clone the repository:**
    ```bash
    git clone [<repository-url>](https://github.com/dexplop2602/DynamicDNS)
    cd [<repository-url>](https://github.com/dexplop2602/DynamicDNS)
    ```

2.  **Start the virtual environment:**
    ```bash
    vagrant up
    ```
    This command will create and provision the three virtual machines as defined in the `Vagrantfile`. The provisioning process will:
    *   Set up the BIND9 DNS server on the `dns` machine.
    *   Generate a `tsig-keygen` for secure communication between the DHCP and DNS servers.
    *   Configure the ISC DHCP server on the `dhcp` machine to handle IP address allocation for the `192.168.58.0/24` network and to update the DNS records.
    *   Configure the `c1` client to obtain an IP address via DHCP.

3.  **Access the client machine:**
    ```bash
    vagrant ssh c1
    ```

4.  **Test the DDNS setup:**
    Once inside the client `c1`, you can verify that the DNS is working correctly by using `dig` or `nslookup`. For example, you can query the DNS server for the IP address of the `dhcp` server or the client `c1` itself:
    ```bash
    dig c1.example.test @192.168.58.10
    ```
    This should return the IP address assigned by the DHCP server to the `c1` machine.

5.  **Clean up the environment:**
    To stop and delete the virtual machines, run the following command from the project's root directory:
    ```bash
    vagrant destroy -f
    ```

## Project Structure

*   `Vagrantfile`: Defines the virtual machines, their network configurations, and the provisioning scripts to be executed.
*   `dns-provision.sh`: The script to install and configure BIND9 on the `dns` server.
*   `dhcp-provision.sh`: The script to install and configure the ISC DHCP server on the `dhcp` server.
*   `client-provision.sh`: The script to configure the network on the `c1` client machine.
*   `configs/`: A directory containing all the necessary configuration files for BIND9 and DHCP.
    *   `named.conf.options`: BIND9 options file, including the key for DDNS updates.
    *   `named.conf.local`: Defines the DNS zones.
    *   `db.example.test`: The forward zone file for `example.test`.
    *   `db.192`: The reverse zone file for the `192.168.58.0/24` network.
    *   `dhcpd.conf`: Configuration file for the DHCP server, enabling DDNS updates.
    *   `dhclient.conf`: Configuration file for the DHCP client.
