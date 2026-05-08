# recon.sh

A lightweight automated reconnaissance script for bug bounty and security testing. Built on Parrot OS using industry-standard open source tools.

-----

## What It Does

Runs a full recon pipeline against a target domain:

1. **Subdomain enumeration** — finds subdomains using `subfinder`
1. **Live host detection** — filters live hosts using `httpx`
1. **Vulnerability scanning** — scans live hosts using `nuclei`

All output is saved to a timestamped folder so multiple runs never overwrite each other.

-----

## Requirements

Make sure the following tools are installed before running:

- [subfinder](https://github.com/projectdiscovery/subfinder)
- [httpx](https://github.com/projectdiscovery/httpx)
- [nuclei](https://github.com/projectdiscovery/nuclei)

-----

## Usage

```bash
chmod +x recon.sh
./recon.sh target.com
```

-----

## Output

Results are saved to:

```
output/target.com_2026-05-08_14-30-00/
├── subd.txt      # discovered subdomains
├── live.txt      # live/responding hosts
└── vulns.txt     # nuclei scan results
```

-----

## Disclaimer

This tool is intended for authorized security testing only. Only run against targets you have explicit permission to test.