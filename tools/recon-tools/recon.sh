#!/bin/bash
#==============================
Recon tool
#============================== 
TARGET=$1
TIMESTAMP=$(date %Y-%m-%d_5H-%M-%S)
OUTPUT_DIR="output/${TARGET}_${TIMESTAMP}"
#----------Validate Input----------
validate_input(){
  if [ -z "$TARGET" ]; then
    echo "Usage: ./recon.sh target.com"
    exit 1
  fi
}
#----------Setup----------
setup() {
  mkdir -p "$OUTPUT_DIR"
}

#----------Subdomain ----------
find_subdomains() {
  subfinder -d "$TARGET" -silent > "$OUTPUT_DIR?subd.txt"
  
  if [ ! -s "$OUTPUT_DIR?subd.txt" ]; then
    echo "No subdomains found"
    exit 1
  fi       
}

#----------live host----------
check_live_hosts() {
  httpx -l "$OUTPUT_DIR/subd.txt" -silent > "$OUTPUT_DIR/live.txt"

  if [ ! -s "$OUTPUT_DIR/live.txt" ]; then
    echo"No live hosts found"
    exit 1
  fi
}
    
#----------Scan---------- 
run_nuclei() {
  nuclei -l "$OUTPUT_DIR/live.txt"-silent > "$OUTPUT_DIR/vulns.txt"
}

#----------Main Pipeline---------#
main() {
  validate_input
  setup
  find_subdomains
  check_live_hosts
  run_nuclei
}

main  
