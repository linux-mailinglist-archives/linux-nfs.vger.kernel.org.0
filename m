Return-Path: <linux-nfs+bounces-8453-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A669E92FE
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 12:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845531636EF
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01F72236E3;
	Mon,  9 Dec 2024 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqVGfwBD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97A4221D9F
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745294; cv=none; b=sRzaPF2viG77f4alwwXxElShz5/udvtjOpyr4/ktdnZtvzFwyTszOtUmDT43AwtKfk0u9luOFJeV65iyxnzGiYYi4niTuDyi2bdAg85YCcHnbjQjuR1nhqgvEENPwSoyVd0+RXICVKBUvbdVepPZTzqzVaJSpHa7g6kJtan4Aj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745294; c=relaxed/simple;
	bh=+FeSddHzKJoeNYOnyzGHyy4JAUUPqDLIK7WE7uK1qc4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=R3OCiviBB6WNr3WQQ9+TD2+RPGzBQFEE9C0gV3FnSm/GGRCENwfN/SsE2K1Qp0Nk/TiJYm7HWdyG2r43ZepE6D0lhb/3StoEy63hKATHp7mj/HWcMXVu6R90ZiApt5nM696VX/HflC+rZlWhxfoD8cpiK6g+uKnY894nPQckmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqVGfwBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6215BC4CED1;
	Mon,  9 Dec 2024 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733745294;
	bh=+FeSddHzKJoeNYOnyzGHyy4JAUUPqDLIK7WE7uK1qc4=;
	h=From:Date:To:Subject:From;
	b=gqVGfwBDk10xLydOlWpdmAwq0P3eRg6ejv4Jf+opKTelNj473pVcRn26kNcRrrCbW
	 8vl3RBClPWcJ/a2nbF/P+7vtcnmnP0fUXRSKe8WIWbRpTYtQVFd1ySxNskvFE1izih
	 DOsaXX/+3CRV+fdtTH5INNwidKihJefiUmC/W5IwG/bQOdAtNeNSCDooda3fVslMDg
	 3mL//LJ7W3NZiwQS+/Pk2NY9C5fr0rud3sI6CHO1NgrJFNiW072qhVMTn+5g8q+DOy
	 Is7qgDB4GkU8/+/DfSqNMnltTjbWlcr4gDi51YShYd1wU1UlzdT0gNO8CjrFQPJR5l
	 2dW4aSVTtsbyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13DA380A95E;
	Mon,  9 Dec 2024 11:55:10 +0000 (UTC)
From: Jur van der Burg via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 09 Dec 2024 11:55:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jlayton@kernel.org, trondmy@kernel.org, cel@kernel.org, 
 linux-nfs@vger.kernel.org, anna@kernel.org
Message-ID: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
Subject: kernel BUG at fs/nfsd/nfs4recover.c:534 Oops: invalid opcode: 0000
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jur van der Burg writes via Kernel.org Bugzilla:

I've got an instant crash when starting the nfs server on kernel 6.12.2. Previous kernels (at least up to 6.6.56) were fine:

Dec  9 12:51:15 hostx kernel: [   66.833082] RPC: Registered named UNIX socket transport module.
Dec  9 12:51:15 hostx kernel: [   66.833088] RPC: Registered udp transport module.
Dec  9 12:51:15 hostx kernel: [   66.833089] RPC: Registered tcp transport module.
Dec  9 12:51:15 hostx kernel: [   66.833090] RPC: Registered tcp-with-tls transport module.
Dec  9 12:51:15 hostx kernel: [   66.833091] RPC: Registered tcp NFSv4.1 backchannel transport module.
Dec  9 12:51:17 hostx kernel: [   68.010707] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
Dec  9 12:51:17 hostx kernel: [   68.010740] NFSD: Using legacy client tracking operations.
Dec  9 12:51:17 hostx kernel: [   68.010744] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
Dec  9 12:51:17 hostx kernel: [   68.010790] ------------[ cut here ]------------
Dec  9 12:51:17 hostx kernel: [   68.010792] kernel BUG at fs/nfsd/nfs4recover.c:534!
Dec  9 12:51:17 hostx kernel: [   68.010808] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
Dec  9 12:51:17 hostx kernel: [   68.011526] CPU: 3 UID: 0 PID: 5020 Comm: rpc.nfsd Not tainted 6.12.2-0.1-vtserver #1
Dec  9 12:51:17 hostx kernel: [   68.011921] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
Dec  9 12:51:17 hostx kernel: [   68.012320] RIP: 0010:nfsd4_legacy_tracking_init+0x20b/0x260 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.012843] Code: 48 8b 1c d8 e8 c6 e1 68 e0 48 8b bb 30 01 00 00 48 85 ff 74 10 e8 c5 81 8f e0 48 c7 83 30 01 00 00 00 00 00 00 44 89 e3 eb 8b <0f> 0b 48 c7 c6 80 97 ae a0 48 c7 c7 b8 de b3 a0 e8 70 62 66 e0 8b
Dec  9 12:51:17 hostx kernel: [   68.013647] RSP: 0018:ffffc900009bbce8 EFLAGS: 00010282
Dec  9 12:51:17 hostx kernel: [   68.014043] RAX: 0000000000000049 RBX: 000000000000000b RCX: 0000000000000000
Dec  9 12:51:17 hostx kernel: [   68.014437] RDX: 0000000000000000 RSI: ffffffff824792fb RDI: 00000000ffffffff
Dec  9 12:51:17 hostx kernel: [   68.014825] RBP: ffff888115dda000 R08: 00000000ffff7fff R09: 0000000000000058
Dec  9 12:51:17 hostx kernel: [   68.015214] R10: 00000000ffff7fff R11: ffffffff82852f00 R12: ffff888115dda000
Dec  9 12:51:17 hostx kernel: [   68.015602] R13: ffff888115dda000 R14: ffff888115dda000 R15: ffff8881172b9e40
Dec  9 12:51:17 hostx kernel: [   68.015989] FS:  00007f99b2cb1740(0000) GS:ffff888237cc0000(0000) knlGS:0000000000000000
Dec  9 12:51:17 hostx kernel: [   68.016383] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec  9 12:51:17 hostx kernel: [   68.016791] CR2: 00007f0f31eef190 CR3: 000000013f422003 CR4: 00000000001706f0
Dec  9 12:51:17 hostx kernel: [   68.017237] Call Trace:
Dec  9 12:51:17 hostx kernel: [   68.017640]  <TASK>
Dec  9 12:51:17 hostx kernel: [   68.018024]  ? die+0x43/0xb0
Dec  9 12:51:17 hostx kernel: [   68.018415]  ? do_trap+0x119/0x150
Dec  9 12:51:17 hostx kernel: [   68.018798]  ? nfsd4_legacy_tracking_init+0x20b/0x260 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.019294]  ? do_error_trap+0x87/0xc0
Dec  9 12:51:17 hostx kernel: [   68.019692]  ? nfsd4_legacy_tracking_init+0x20b/0x260 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.020179]  ? exc_invalid_op+0x53/0x70
Dec  9 12:51:17 hostx kernel: [   68.020560]  ? nfsd4_legacy_tracking_init+0x20b/0x260 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.021031]  ? asm_exc_invalid_op+0x16/0x20
Dec  9 12:51:17 hostx kernel: [   68.021410]  ? nfsd4_legacy_tracking_init+0x20b/0x260 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.021894]  ? nfsd4_legacy_tracking_init+0xc4/0x260 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.022367]  nfsd4_client_tracking_init+0x1a5/0x1e0 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.022862]  nfs4_state_start_net+0x2d1/0x440 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.023347]  nfsd_svc+0x1c5/0x330 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.023827]  ? simple_strntoull+0xa8/0xc0
Dec  9 12:51:17 hostx kernel: [   68.024203]  write_threads+0xc8/0x1a0 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.024684]  ? preempt_count_add+0x69/0xa0
Dec  9 12:51:17 hostx kernel: [   68.025065]  ? _copy_from_user+0x25/0x60
Dec  9 12:51:17 hostx kernel: [   68.025449]  ? _raw_spin_unlock+0x15/0x30
Dec  9 12:51:17 hostx kernel: [   68.025850]  ? simple_transaction_get+0xcb/0xe0
Dec  9 12:51:17 hostx kernel: [   68.026233]  ? __pfx_write_threads+0x10/0x10 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.026724]  nfsctl_transaction_write+0x51/0xa0 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.027219]  vfs_write+0x136/0x480
Dec  9 12:51:17 hostx kernel: [   68.027610]  ksys_write+0x71/0x100
Dec  9 12:51:17 hostx kernel: [   68.027990]  do_syscall_64+0x4b/0x110
Dec  9 12:51:17 hostx kernel: [   68.028371]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec  9 12:51:17 hostx kernel: [   68.028779] RIP: 0033:0x7f99b2679be4
Dec  9 12:51:17 hostx kernel: [   68.029162] Code: 84 00 00 00 00 00 48 8b 05 09 84 20 00 c3 0f 1f 84 00 00 00 00 00 8b 05 0a c8 20 00 48 63 ff 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 55 53 48 89 d5 48 89 f3 48 83
Dec  9 12:51:17 hostx kernel: [   68.029994] RSP: 002b:00007ffdd307a0d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Dec  9 12:51:17 hostx kernel: [   68.030427] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f99b2679be4
Dec  9 12:51:17 hostx kernel: [   68.030857] RDX: 0000000000000002 RSI: 0000000000608600 RDI: 0000000000000003
Dec  9 12:51:17 hostx kernel: [   68.031291] RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
Dec  9 12:51:17 hostx kernel: [   68.031748] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
Dec  9 12:51:17 hostx kernel: [   68.032181] R13: 0000000000000001 R14: 0000000000000000 R15: 00007ffdd307bde6
Dec  9 12:51:17 hostx kernel: [   68.032610]  </TASK>
Dec  9 12:51:17 hostx kernel: [   68.033015] Modules linked in: nfsd auth_rpcgss nfs_acl lockd grace sunrpc iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi target_core_mod usbip_host vhci_hcd usbip_core vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock veth bridge stp llc crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl vmwgfx drm_ttm_helper ttm drm_kms_helper drm pata_acpi cpuspeed vmw_balloon uhci_hcd sr_mod psmouse e1000e serio_raw pcspkr vmxnet3 ehci_pci e1000 vmw_vmci cdrom ehci_hcd vmw_pvscsi i2c_piix4 i2c_smbus ac button usbhid xhci_pci xhci_hcd usbcore usb_common dm_multipath dm_mod dax nvme nvme_core virtio_net net_failover failover virtio_scsi virtio_blk virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring virtio ata_generic pata_atiixp fan thermal
Dec  9 12:51:17 hostx kernel: [   68.035844] ---[ end trace 0000000000000000 ]---
Dec  9 12:51:17 hostx kernel: [   68.036353] RIP: 0010:nfsd4_legacy_tracking_init+0x20b/0x260 [nfsd]
Dec  9 12:51:17 hostx kernel: [   68.036946] Code: 48 8b 1c d8 e8 c6 e1 68 e0 48 8b bb 30 01 00 00 48 85 ff 74 10 e8 c5 81 8f e0 48 c7 83 30 01 00 00 00 00 00 00 44 89 e3 eb 8b <0f> 0b 48 c7 c6 80 97 ae a0 48 c7 c7 b8 de b3 a0 e8 70 62 66 e0 8b
Dec  9 12:51:17 hostx kernel: [   68.037974] RSP: 0018:ffffc900009bbce8 EFLAGS: 00010282
Dec  9 12:51:17 hostx kernel: [   68.038509] RAX: 0000000000000049 RBX: 000000000000000b RCX: 0000000000000000
Dec  9 12:51:17 hostx kernel: [   68.039021] RDX: 0000000000000000 RSI: ffffffff824792fb RDI: 00000000ffffffff
Dec  9 12:51:17 hostx kernel: [   68.039562] RBP: ffff888115dda000 R08: 00000000ffff7fff R09: 0000000000000058
Dec  9 12:51:17 hostx kernel: [   68.040074] R10: 00000000ffff7fff R11: ffffffff82852f00 R12: ffff888115dda000
Dec  9 12:51:17 hostx kernel: [   68.040618] R13: ffff888115dda000 R14: ffff888115dda000 R15: ffff8881172b9e40
Dec  9 12:51:17 hostx kernel: [   68.041135] FS:  00007f99b2cb1740(0000) GS:ffff888237cc0000(0000) knlGS:0000000000000000
Dec  9 12:51:17 hostx kernel: [   68.041692] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec  9 12:51:17 hostx kernel: [   68.042230] CR2: 00007f0f31eef190 CR3: 000000013f422003 CR4: 00000000001706f0

I found one reference to the same issue but no solution:

https://www.mail-archive.com/debian-kernel@lists.debian.org/msg139065.html

This is 100% reproducable at will.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219580#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


