#!/usr/bin/env bash
# backup.sh — Copy live configuration files from dustoff into this repo.
# Run from the repo root as root (or with sudo).
# After running: git add -A && git commit -m "..." && git push

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "==> Backing up configs into: ${REPO_DIR}"

# ── Safety check: refuse to copy passwords.yml ──────────────────────────────
if [[ "${1:-}" == "--include-passwords" ]]; then
    echo "ERROR: passwords.yml must never be committed to a public repo." >&2
    echo "       Store it in a password manager or encrypted backup separately." >&2
    exit 1
fi

copy_file() {
    local src="$1"
    local dest="${REPO_DIR}/$2"
    if [[ -f "${src}" ]]; then
        mkdir -p "$(dirname "${dest}")"
        cp "${src}" "${dest}"
        echo "  Copied: ${src} to ${dest}"
    else
        echo "  WARNING: ${src} not found — skipping"
    fi
}

# ── Kolla ────────────────────────────────────────────────────────────────────
copy_file /etc/kolla/globals.yml                                        etc/kolla/globals.yml
copy_file /etc/kolla/config/neutron/openvswitch_agent.ini               etc/kolla/config/neutron/openvswitch_agent.ini
copy_file /etc/kolla/config/cinder/cinder-volume/cinder.conf            etc/kolla/config/cinder/cinder-volume/cinder.conf
copy_file /etc/kolla/config/cinder/nfs_shares                           etc/kolla/config/cinder/nfs_shares
copy_file /etc/kolla/config/horizon/custom_local_settings               etc/kolla/config/horizon/custom_local_settings

# ── Network ──────────────────────────────────────────────────────────────────
copy_file /etc/netplan/50-netcfg.yaml                                   etc/netplan/50-netcfg.yaml
copy_file /etc/resolv.conf                                              etc/resolv.conf
copy_file /etc/hosts                                                    etc/hosts
copy_file /etc/exports                                                  etc/exports

# ── systemd services ─────────────────────────────────────────────────────────
copy_file /etc/systemd/system/br-ex-ip.service                         etc/systemd/system/br-ex-ip.service
copy_file /etc/systemd/system/ovs-cleanup.service                      etc/systemd/system/ovs-cleanup.service

echo ""
echo "==> Backup complete."
echo "    Review changes with: git diff"
echo "    Then commit:         git add -A && git commit -m 'Update configs' && git push"
echo ""
echo "    NOTE: /etc/kolla/passwords.yml was intentionally NOT copied."
echo "          Back it up separately in a password manager or encrypted store."
