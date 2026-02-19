Return-Path: <linux-nfs+bounces-19034-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPksA3kdl2ktuwIAu9opvQ
	(envelope-from <linux-nfs+bounces-19034-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 15:26:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BD815F768
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 15:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 918C030090A4
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564333EAF9;
	Thu, 19 Feb 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HR+WAXCu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89C633374F;
	Thu, 19 Feb 2026 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511158; cv=none; b=qQTYupguZeHxG8ma62Udewt93faCeYn6932r/v4m8Vsc2A5OCwNrPV1wTApcnMqn+YeY+oGH4c0W77DLkrMtDc/zqPamUqRSvdGhLqfCrW/pms1NOdBGUQtvJYB+/VGDp/MvLCe+s4Z6jncw1Z3kNhbcef9w8XwhyWdCwwnwc6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511158; c=relaxed/simple;
	bh=Vom8qQQVRwFoAqxqbAbqqlZUyub95CMvw/x846Ikc+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyhwMTD/g+xUr6xic9fBejB1vhlJsJVRaW7DR2E7xxBmbX3T+ey+1qCpg7UtFx1f+5NN+sfdgN6+BjNDAKkrvolbm4c/GvaUzc2C0TCzRJ4TZKlD+7+ckvnAYepB4WDw5UUX54ouVR55eLsAMzQD0XOVpyV5xclvU3AVTD19cO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HR+WAXCu; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VTd3XJOUd7b7Rgm6VukM2jGm90ePJf3f3gtcehqct7g=; b=HR+WAXCuo/Loa03Yr3qdhZE5b5
	yy3OkYkeZvDBHMU+qfnxCcXq37G/N0bAWXyCWqpoAh/EkwdDqLSDF+tXv5Q1WbVyPnsj/jyctHegJ
	/F2+Vjq3CB7l9bY7zdSU/hXwnIasnDqndgj4LFB9BShSWodYe7gUkdzr6k6WO6HobyF/uz3kcMKgH
	fkX7vZH8g8dqJv+DXc/v1pFeX6sjWlrM0RopCJ9o9C0bgA43b17e9pwnjyYcUM8zHveBH5Q9RMtj3
	yA8siBaxY0RCcH/c2oXcOcaMfSCUO1WRSMBjiOdXtReUg61hyzLHZpl7mo7ZjJFj/6maSxkUrZ+/d
	Q+xY0vNA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1vt4Uf-005vWy-JM; Thu, 19 Feb 2026 13:55:00 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id E0CE8BE2DE0; Thu, 19 Feb 2026 14:54:58 +0100 (CET)
Date: Thu, 19 Feb 2026 14:54:58 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	"Dr. Hannes Reinecke" <hare@suse.de>,
	Benjamin Coddington <bcodding@redhat.com>,
	Olga Kornievskaia <aglo@netapp.com>,
	Scott Mayhew <smayhew@redhat.com>,
	Norbert Zentai <norbert.zentai@unibas.ch>
Cc: 1126957@bugs.debian.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Bug#1126957: kernel panic when repeatedly trying to mount an
 nfsv4 share with mtls and failing
Message-ID: <177150923798.685104.7049795383788483707@eldamar.lan>
References: <fdf293f1-ad7c-42c7-87b8-a2b4d338907a@unibas.ch>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf293f1-ad7c-42c7-87b8-a2b4d338907a@unibas.ch>
X-Debian-User: carnil
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	TAGGED_FROM(0.00)[bounces-19034-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36BD815F768
X-Rspamd-Action: no action

Control: forwarded -1 https://lore.kernel.org/linux-nfs/177150923798.685104.7049795383788483707@eldamar.lan

Hi

Norbert Zentai reported in Debian at https://bugs.debian.org/1126957

On Wed, Feb 04, 2026 at 04:59:10PM +0100, Norbert Zentai wrote:
> Package: linux-image-amd64
> Version: 6.17.13-1~bpo13+1
> 
> When I repeatedly mount an NFSv4 share using the following command:
> mount -t nfs4 -o xprtsec=mtls nfs-server.local:/rpool/demo-share /mnt
> 
> and the command fails with one of the following:
> mount.nfs4: access denied by server while mounting
> nfs-server.local:/rpool/demo-share
> OR
> mount.nfs4: Broken pipe for nfs-server.local:/rpool/demo-share on /mnt
> 
> after a couple of tries I receive the following kernel panic:
> 
> [   39.161785] kernel BUG at mm/slub.c:563!
> [   39.164131] Oops: invalid opcode: 0000 [#1] SMP PTI
> [   39.166674] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
> 6.17.13+deb13-amd64 #1 PREEMPT(lazy)  Debian 6.17.13-1~bpo13+1
> [   39.172472] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [   39.178438] RIP: 0010:__slab_free+0x152/0x310
> [   39.180996] Code: 00 4c 89 ff e8 df 95 9c 00 48 8b 14 24 48 8b 4c 24 20
> 48 89 44 24 08 48 8b 03 48 c1 e8 09 83 e0 01 88 44 24 13 e9 71 ff ff ff <0f>
> 0b 66 41 f7 44 24 08 87 04 75 b3 eb a9 66 41 f7 44 24 08 87 04
> [   39.190660] RSP: 0018:ffffd19100003dc0 EFLAGS: 00010246
> [   39.193455] RAX: ffff8bf903e9f150 RBX: fffff9e7c00fa7c0 RCX:
> 000000000010000c
> [   39.197106] RDX: ffff8bf903e9f100 RSI: fffff9e7c00fa7c0 RDI:
> ffffd19100003e30
> [   39.200820] RBP: ffffd19100003e60 R08: 0000000000000001 R09:
> ffffffffab62d068
> [   39.204472] R10: 0000000000000002 R11: ffffffffad208100 R12:
> ffff8bf9011fe900
> [   39.208167] R13: ffff8bf903e9f100 R14: ffff8bf9011fe900 R15:
> ffffffffab62d068
> [   39.211793] FS:  0000000000000000(0000) GS:ffff8bf9cfdb6000(0000)
> knlGS:0000000000000000
> [   39.215868] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   39.219011] CR2: 00007f7dfcbb71a0 CR3: 0000000008b12000 CR4:
> 00000000000006f0
> [   39.222866] Call Trace:
> [   39.224294]  <IRQ>
> [   39.225436]  ? rcu_do_batch+0x1c8/0x570
> [   39.227443]  kmem_cache_free+0x3a3/0x450
> [   39.229579]  ? free_uid+0x3c/0xc0
> [   39.231375]  rcu_do_batch+0x1c8/0x570
> [   39.233332]  ? rcu_do_batch+0x167/0x570
> [   39.235461]  rcu_core+0x175/0x350
> [   39.237280]  handle_softirqs+0xdf/0x320
> [   39.239381]  __irq_exit_rcu+0xbc/0xe0
> [   39.241366]  sysvec_apic_timer_interrupt+0x71/0x90
> [   39.243928]  </IRQ>
> [   39.245097]  <TASK>
> [   39.246375]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   39.249011] RIP: 0010:pv_native_safe_halt+0xf/0x20
> [   39.251544] Code: 20 d0 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 55 92 1a 00 fb f4 <e9>
> 3c 2a 01 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> [   39.262235] RSP: 0018:ffffffffad203e70 EFLAGS: 00000212
> [   39.265355] RAX: 0000000000000000 RBX: ffffffffad213080 RCX:
> ffff8bf90390b320
> [   39.269527] RDX: 4000000000000000 RSI: 0000000000000000 RDI:
> 000000000001979c
> [   39.273714] RBP: 0000000000000000 R08: 000000091e153ed8 R09:
> 0000000000000001
> [   39.277877] R10: 0000000000000000 R11: ffff8bf97dc1cd00 R12:
> 0000000000000000
> [   39.282054] R13: 0000000000000000 R14: 0000000000000000 R15:
> 000000000008a000
> [   39.286400]  default_idle+0x9/0x20
> [   39.287579]  default_idle_call+0x29/0x100
> [   39.288952]  do_idle+0x1f8/0x240
> [   39.290106]  cpu_startup_entry+0x29/0x30
> [   39.291428]  rest_init+0xe7/0xf0
> [   39.292561]  start_kernel+0x776/0x780
> [   39.293848]  x86_64_start_reservations+0x24/0x30
> [   39.295443]  x86_64_start_kernel+0x126/0x130
> [   39.297322]  common_startup_64+0x13e/0x141
> [   39.299047]  </TASK>
> [   39.300130] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolver nfs
> lockd grace netfs cfg80211 rfkill 8021q garp stp llc mrp binfmt_misc
> aesni_intel pcspkr virtio_balloon button joydev evdev sg auth_rpcgss
> efi_pstore sunrpc configfs nfnetlink vsock_loopback
> vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci
> qemu_fw_cfg ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
> crc32c_cryptoapi hid_generic usbhid hid sr_mod cdrom uhci_hcd bochs
> ata_generic ehci_pci drm_client_lib sd_mod drm_shmem_helper ata_piix
> ehci_hcd drm_kms_helper usbcore virtio_net libata psmouse drm virtio_scsi
> net_failover scsi_mod i2c_piix4 failover i2c_smbus serio_raw usb_common
> scsi_common floppy
> [   39.321098] ---[ end trace 0000000000000000 ]---
> [   39.322977] RIP: 0010:__slab_free+0x152/0x310
> [   39.324762] Code: 00 4c 89 ff e8 df 95 9c 00 48 8b 14 24 48 8b 4c 24 20
> 48 89 44 24 08 48 8b 03 48 c1 e8 09 83 e0 01 88 44 24 13 e9 71 ff ff ff <0f>
> 0b 66 41 f7 44 24 08 87 04 75 b3 eb a9 66 41 f7 44 24 08 87 04
> [   39.331380] RSP: 0018:ffffd19100003dc0 EFLAGS: 00010246
> [   39.333381] RAX: ffff8bf903e9f150 RBX: fffff9e7c00fa7c0 RCX:
> 000000000010000c
> [   39.335985] RDX: ffff8bf903e9f100 RSI: fffff9e7c00fa7c0 RDI:
> ffffd19100003e30
> [   39.338598] RBP: ffffd19100003e60 R08: 0000000000000001 R09:
> ffffffffab62d068
> [   39.341237] R10: 0000000000000002 R11: ffffffffad208100 R12:
> ffff8bf9011fe900
> [   39.343830] R13: ffff8bf903e9f100 R14: ffff8bf9011fe900 R15:
> ffffffffab62d068
> [   39.346460] FS:  0000000000000000(0000) GS:ffff8bf9cfdb6000(0000)
> knlGS:0000000000000000
> [   39.349343] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   39.351503] CR2: 00007f7dfcbb71a0 CR3: 0000000008b12000 CR4:
> 00000000000006f0
> [   39.354071] Kernel panic - not syncing: Fatal exception in interrupt
> [   39.356640] Kernel Offset: 0x2a200000 from 0xffffffff81000000 (relocation
> range: 0xffffffff80000000-0xffffffffbfffffff)
> [   39.360273] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---
> 
> I originally tried this with the trixie kernel 6.12.63+deb13-amd64 and then
> with the backport to see if this bug has been resolved.
> 
> Output of uname -a:
> Linux nfs-client.local 6.17.13+deb13-amd64 #1 SMP PREEMPT_DYNAMIC Debian
> 6.17.13-1~bpo13+1 (2025-12-28) x86_64 GNU/Linux
> 
> This bug is reproducible and you only need to try to mount less than 10
> times.
> 
> I found a similar kernel bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=24302
> 
> I am using the nfs-utils and ktls-utils package to set up NFS over mutual
> TLS. I was testing the system by providing a valid but not trusted client
> side TLS certificate and expecting the NFS server to not let me in.

I was able to trigger the kernel panic with a somehow pathological
case derived from our test in the ktls-utils package, with client with
a valid self-signed certificate with the following reproducing script
(requisite to have on Debian nfs-kernel-server ktls-utils installed):

----cut---------cut---------cut---------cut---------cut---------cut-----
#!/bin/sh

# base directory for configuration
TLSHDDIR='/etc/tlshd'

# Create CA private key and certificate
openssl genrsa -out "$TLSHDDIR/ca.key.priv.pem" 2048
cat >"$TLSHDDIR/ca.openssl.cnf" <<EOF
[ req ]
distinguished_name = req_dn
string_mask = utf8only
prompt = no
x509_extensions = req_ext

[ req_dn ]
commonName = ktls-utils test CA

[ req_ext ]
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer:always
basicConstraints = critical, CA:true
EOF

openssl req -new -key "$TLSHDDIR/ca.key.priv.pem" \
        -utf8 -nodes -batch -x509 \
        -outform PEM -out "$TLSHDDIR/ca.x509.pem" \
        -config "$TLSHDDIR/ca.openssl.cnf"

# cleanup comments
sed -i '/^\[authenticate\.client\]/,$ { /=/d }' \
    /etc/tlshd/config

# Create certificate for server role signed with CA
# Create private key and certificate for role
openssl genrsa -out "$TLSHDDIR/server.key.priv.pem" 2048
cat >"$TLSHDDIR/server.openssl.cnf" <<EOF
[ req ]
distinguished_name = req_dn
string_mask = utf8only
prompt = no
x509_extensions = req_ext

[ req_dn ]
commonName = server.internal

[ req_ext ]
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer:always
basicConstraints = critical, CA:false
extendedKeyUsage = critical, serverAuth
EOF

openssl req -new -key "$TLSHDDIR/server.key.priv.pem" \
	-out "$TLSHDDIR/server.req.pem" \
	-config "$TLSHDDIR/server.openssl.cnf"
openssl req -in "$TLSHDDIR/server.req.pem" \
	-copy_extensions copy \
	-CA "$TLSHDDIR/ca.x509.pem" \
	-CAkey "$TLSHDDIR/ca.key.priv.pem" \
	-utf8 -nodes -batch -x509 \
	-outform PEM -out "$TLSHDDIR/server.x509.pem"

# Create certificate for client role (self-signed)
cat > "$TLSHDDIR/client.openssl.cnf" <<EOF
[ req ]
distinguished_name = req_dn
string_mask = utf8only
prompt = no
x509_extensions = req_ext

[ req_dn ]
commonName = client.internal

[ req_ext ]
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer:always
basicConstraints = critical, CA:false
extendedKeyUsage = critical, clientAuth
EOF

openssl req -noenc -x509 -newkey rsa -pkeyopt rsa_keygen_bits:2048 \
	-keyout "$TLSHDDIR/client.key.priv.pem" \
	-out "$TLSHDDIR/client.x509.pem" \
	-config "$TLSHDDIR/client.openssl.cnf"

# Update tlshd config
for role in server client ; do
    sed -i '/^\[authenticate\.'$role'\]/a\
x509.truststore='"$TLSHDDIR/ca.x509.pem"'\
x509.certificate='"$TLSHDDIR/$role.x509.pem"'\
x509.private_key='"$TLSHDDIR/$role.key.priv.pem" \
        /etc/tlshd/config
done

# Make server name resolvable
if ! grep -qw 'server\.internal' /etc/hosts; then
    cat >>/etc/hosts <<EOF
::1     server.internal client.internal
EOF
fi

# Restart tlshd with new config
systemctl restart tlshd.service

# Configure export
export_dir=/srv/server.internal
mkdir -p "$export_dir"
mkdir -p "/etc/exports.d"
cat > /etc/exports.d/server.internal.exports <<EOF
$export_dir localhost(no_root_squash,rw,xprtsec=mtls)
EOF
exportfs -a

# Try to mount
mount_dir=/media/server.internal
mkdir -p "$mount_dir"
! mountpoint "$mount_dir" || umount "$mount_dir"

# Trigger #1126957
while true ; do
	mount -t nfs -o nodev,nosuid,xprtsec=mtls "server.internal:$export_dir" "$mount_dir"
done
----cut---------cut---------cut---------cut---------cut---------cut-----

Before the kernel-panic there are at least the follwing seen with some
higher CPU usage:

   8982 root      20   0   36776   6256   3284 S  20.0   0.3   0:00.76 (udev-worker)
    321 root      20   0   36772  11748   8808 R  10.0   0.6   0:02.00 systemd-udevd
   3486 root      20   0    2944   2424   2244 S  10.0   0.1   0:00.13 rpc.idmapd
   8987 root      20   0   36776   6256   3284 S  10.0   0.3   0:00.48 (udev-worker)

It takes for me many mor ecycles to actuall trigger the problem:

1126957 login: [   14.614240] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   14.615519] #PF: supervisor instruction fetch in kernel mode
[   14.616647] #PF: error_code(0x0010) - not-present page
[   14.617673] PGD 0 P4D 0
[   14.618272] Oops: Oops: 0010 [#1] SMP NOPTI
[   14.619170] CPU: 0 UID: 0 PID: 2393 Comm: tlshd Not tainted 6.18.12+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.18.12-1
[   14.621129] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   14.622857] RIP: 0010:0x0
[   14.623442] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   14.624662] RSP: 0000:ffffcf544270be08 EFLAGS: 00010296
[   14.625659] RAX: 0000000000000001 RBX: 0000000000000003 RCX: 0000000000000001
[   14.626979] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8ee042711d68
[   14.628305] RBP: ffff8ee045825040 R08: 0000000000000000 R09: ffffcf544270bb50
[   14.629702] R10: ffffffff880db948 R11: 00000000ffffefff R12: ffff8ee0bdc32700
[   14.631087] R13: ffffcf544270be38 R14: 0000000000000002 R15: 0000000000000000
[   14.632464] FS:  00007f599c117540(0000) GS:ffff8ee134fcc000(0000) knlGS:0000000000000000
[   14.634029] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.634994] CR2: ffffffffffffffd6 CR3: 0000000014823000 CR4: 0000000000350ef0
[   14.636162] Call Trace:
[   14.636649]  <TASK>
[   14.637084]  rcu_do_batch+0x1bc/0x560
[   14.637751]  rcu_core+0x17d/0x380
[   14.638390]  handle_softirqs+0xd7/0x310
[   14.639081]  __irq_exit_rcu+0xbc/0xe0
[   14.639742]  sysvec_apic_timer_interrupt+0x3d/0x90
[   14.640570]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   14.641440] RIP: 0033:0x7f599c33f7e7
[   14.642094] Code: 48 11 c3 49 11 d2 4b 8b 44 dd 10 48 f7 e5 4a 01 5c de 18 41 be 00 00 00 00 4c 89 f3 49 11 c2 4b 8b 44 dd 18 4d 89 f1 49 11 d1 <48> f7 e5 49 83 c3 04 78 a0 4c 01 16 49 11 c1 4c 11 f2 4c 01 4e 08
[   14.644927] RSP: 002b:00007ffda2557a78 EFLAGS: 00000282
[   14.645910] RAX: a0e9cf6957c36d02 RBX: 0000000000000000 RCX: 000000000000000e
[   14.647108] RDX: 875700694ec78907 RSI: 000055aeff8a8730 RDI: 000055aeff8a7530
[   14.648273] RBP: a567282e76938167 R08: 8f1016cb1ccb2b5b R09: 875700694ec78907
[   14.649603] R10: dd72055cb22ee176 R11: fffffffffffffff8 R12: fffffffffffffff0
[   14.650939] R13: 000055aeff89a8d0 R14: 0000000000000000 R15: 7e6c175b4ee29829
[   14.652274]  </TASK>
[   14.652776] Modules linked in: nfsv3 tls rpcsec_gss_krb5 nfsv4 dns_resolver nfs netfs binfmt_misc intel_rapl_msr intel_rapl_common kvm_amd ccp kvm irqbypass ghash_clmulni_intel aesni_intel vga16fb vgastate pcspkr virtio_balloon button joydev evdev nfsd auth_rpcgss nfs_acl lockd grace sunrpc drm efi_pstore configfs nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci qemu_fw_cfg virtio_rng autofs4 ext4 crc16 mbcache jbd2 crc32c_cryptoapi dm_mod iTCO_wdt intel_pmc_bxt ahci iTCO_vendor_support libahci watchdog libata virtio_net psmouse xhci_pci scsi_mod xhci_hcd virtio_blk i2c_i801 i2c_smbus scsi_common net_failover serio_raw lpc_ich failover usbcore usb_common
[   14.663515] CR2: 0000000000000000
[   14.664218] ---[ end trace 0000000000000000 ]---

Regards,
Salvatore

