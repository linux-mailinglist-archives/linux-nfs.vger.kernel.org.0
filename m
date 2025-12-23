Return-Path: <linux-nfs+bounces-17291-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E52FDCDAD59
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 00:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22BB830026B5
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 23:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7759C289378;
	Tue, 23 Dec 2025 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="UAU5xDBh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7C27FD71
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766532396; cv=none; b=BZXk/AMrKOyatT4lnxNytSBoeNgGvoL6uo69pzJ2/ZPWQObBRwHD2UTNnKGvTrR1qggwpJ4k4fIGUp5W8vW6fcY4kBbvWLomdEpY2/DgO18ooSh1t7FEw6G6jPUwHk9UNVlzR+r320jEU3n323Nfdy5FUpSd8KK3+MgEkvUey3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766532396; c=relaxed/simple;
	bh=Y2nESXAiR+A67nCiQcbqvC2ZGhnVN2X0yqm8zKsHdBE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oCINxutKRTJAsfXqWkAhcQIOfzxDZHLHdaJbp9wW1LY3RbtII8PdVjYnNCDqCjMML4wMgai6ntcu7UnYo/b0Gk3iHndM6E9OgQfxMIA0ee/PeeWnHn8wEBJxaYKstGn82/3VIkiB61cmD7ToxApwPTw6I2ssLpAvbmA9TTygaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=UAU5xDBh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7277324204so859142866b.0
        for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 15:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1766532392; x=1767137192; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2U7b/Z17KRGS2oyXvkrSl14SI7zVF5W7FiFJsVl65mk=;
        b=UAU5xDBhUm3ut75/5wXahzvOaWwwma6Foq0zUHw21k8XrIbl4G4ytfE6dIz+y2h1aR
         vUweVW1P0LnP4nsNrW3J41VHAOZZFeHk7VUsbDMiLuFJ3Q9P3KiNFD13nXu1E8UlKLsR
         9IOWqLagnSbyQK99KihGTTP1T/9jzHGLyy/v+KMqIcH76NpKl19ivHmHOd6Epqsqn51P
         xFdKPYu0O4mVBLcxvGpWERrfdAK7i6KaU2e7eDbdoFvkwxQyDYKVtalcxc0PCyRK/gZy
         2ZQnxefOhYQIUE1bA9Wdv+IefXMFgM+nZ3ltOa+yRDgrQJPNWk6rENXxLpCPnLnegMX4
         4u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766532392; x=1767137192;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2U7b/Z17KRGS2oyXvkrSl14SI7zVF5W7FiFJsVl65mk=;
        b=U+n3SyqZZtZk6z6FUU66k+ptGj2KlZF6W9y8Stjsya0R36MmDNFdEMYJEl/e2nG0F/
         4rcDj6VZyED0dTfMVgmKGpBXbZ/7k4RWGch2bczX2ea26PPQYni55QTVubSp7ZwBvd63
         s2GAOIxvvtD8/MnbQxi5M5xcqGwtvuimKRR1U+XRTznjXKJaC4H6HzRyVl32CzIbkuOa
         l9mt/pZhxH6207LOjjzCHa1mX/00OVKCb1IEppYwk83lMMpi7+aSbrVPQ/LdQqbAMGN3
         bttnlRyU5p3BQXIokzeQ+N9PKEjqaIYAhWPIEghyQTpDAkqHxQU7oTtrRPU50U3MiUAH
         zNjw==
X-Gm-Message-State: AOJu0YxScFUzCQnqqPPStqtLXcm9eaCRT6itY26UNAXysfWqCc5xTXjS
	AmaKsW73CulsvUFiuVyvOr3/aMpK3pJKPaapfTFIxj6O/iDmSTRWNk6dpsZkE/cxxznOyo9UM8b
	bIZVWb4hjElN62eSXdvjsrMfiuBhXnusjMblgdiS0YXVCKGp1WC22jEkszg==
X-Gm-Gg: AY/fxX6eu9NGKDpQ3SbKDzZcY03L51VTjpjILL5dWkhLt+gdeJEGXo7buPbOWW2Lr0A
	ykPQ07Z8byVgcPJ5ZnfMI1Mi80eJZtuOPJktDKhHztKOXklBDhQsIOgt0ud1oY05FjIdEqw7fP4
	4T6okpZwnGrCr3MuSNI0NiRZZ9Yit6n1FURgK4o0TtameOEI2NaYftliuGKmNbZL9jAQEplrEWP
	0D0ygsmBuC0V7szoZI1GuRcG9Dmh1UwmTgBfm4/3URgybYBbWlpEQao/D37VDYMOmj9GA==
X-Google-Smtp-Source: AGHT+IFmSUR7KfgpZmpfPtcdcCAF/FQ5SzMFHCDTZtBKNIVsPw5Ba8E+Y0u7GCrBtC74sr3xXaT/KY2vtu4tcpK3dIE=
X-Received: by 2002:a17:906:9fd2:b0:b73:42df:27a with SMTP id
 a640c23a62f3a-b8036f2fa8fmr1556592566b.1.1766532391653; Tue, 23 Dec 2025
 15:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daire Byrne <daire@dneg.com>
Date: Tue, 23 Dec 2025 23:25:54 +0000
X-Gm-Features: AQt7F2rI1Ls0_1BZ6BYYzbwNDDA4x4Lx950Vc7VhQoXlS9SCpo3zbCDLLc_U3p0
Message-ID: <CAPt2mGPafo29KgjW9Rb17OhBDLnB-3fZn18zFQEhYk7Eitf6BA@mail.gmail.com>
Subject: refcount_t underflow (nfsd4_sequence_done?) with v6.18 re-export
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

We recently upgraded our NFS re-export servers from a heavily patched
(but stable) v6.4 kernel to pretty virgin v6.18.0.

But we have started to record a fairly infrequent (once every 2 weeks)
crash of the form:

[1235524.634962] ------------[ cut here ]------------
[1235524.636805] refcount_t: underflow; use-after-free.
[1235524.638522] WARNING: CPU: 21 PID: 5048 at lib/refcount.c:28
refcount_warn_saturate+0xba/0x110
[1235524.642158] Modules linked in: btrfs(E) blake2b_generic(E) xor(E)
zstd_compress(E) raid6_pq(E) ufs(E) hfsplus(E) cdrom(E) msdos(E)
8021q(E) garp(E) mrp(E) rpcsec_gss_krb5(E) nfsv3(E) tcp_diag(E)
inet_diag(E) nfs(E) xt_CHECKSUM(E) xt_MASQUERADE(E) xt_conntrack(E)
ipt_REJECT(E) nf_reject_ipv4(E) nft_compat(E) nft_chain_nat(E)
nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E)
nf_tables(E) bonding(E) nfnetlink(E) tls(E) cachefiles(E) bridge(E)
stp(E) llc(E) netfs(E) rfkill(E) vfat(E) fat(E) ext4(E) crc16(E)
mbcache(E) jbd2(E) intel_rapl_msr(E) intel_rapl_common(E) rpcrdma(E)
rdma_ucm(E) ib_srpt(E) ib_isert(E) iscsi_target_mod(E)
target_core_mod(E) ib_iser(E) ib_umad(E) rdma_cm(E) iw_cm(E)
ib_ipoib(E) libiscsi(E) kvm_amd(E) scsi_transport_iscsi(E) ib_cm(E)
ccp(E) mlx5_vdpa(E) vringh(E) iTCO_wdt(E) vhost_iotlb(E) kvm(E)
intel_pmc_bxt(E) vdpa(E) irqbypass(E) iTCO_vendor_support(E)
polyval_clmulni(E) ghash_clmulni_intel(E) i2c_i801(E) mlx5_ib(E)
joydev(E) i2c_smbus(E) ib_uverbs(E) ib_core(E) lpc_ich(E) nfsd(E)
[1235524.642267]  auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)
sch_fq(E) tcp_bbr(E) binfmt_misc(E) dm_mod(E) sunrpc(E) xfs(E)
bochs(E) drm_client_lib(E) sd_mod(E) ahci(E) drm_shmem_helper(E) sg(E)
drm_kms_helper(E) libahci(E) mlx5_core(E) mlxfw(E) libata(E) drm(E)
serio_raw(E) virtio_blk(E) psample(E) virtio_scsi(E) fuse(E)
[1235524.681918] CPU: 21 UID: 0 PID: 5048 Comm: nfsd Kdump: loaded
Tainted: G            E       6.18.0-3.dneg.x86_64 #1
PREEMPT(voluntary)
[1235524.686112] Tainted: [E]=UNSIGNED_MODULE
[1235524.687686] Hardware name: Red Hat dneg/RHEL, BIOS
edk2-20241117-2.el9 11/17/2024
[1235524.690523] RIP: 0010:refcount_warn_saturate+0xba/0x110
[1235524.692572] Code: 01 01 e8 39 b6 a5 ff 0f 0b e9 fd 5a 8a ff 80 3d
ee 98 8e 01 00 75 85 48 c7 c7 e0 56 93 a1 c6 05 de 98 8e 01 01 e8 16
b6 a5 ff <0f> 0b e9 da 5a 8a ff 80 3d c9 98 8e 01 00 0f 85 5e ff ff ff
48 c7
[1235524.699284] RSP: 0018:ff314a5f895efd80 EFLAGS: 00010286
[1235524.701351] RAX: 0000000000000000 RBX: ff2971f27ea6e000 RCX:
0000000000000000
[1235524.703999] RDX: ff2972d37f16a780 RSI: 0000000000000001 RDI:
ff2972d37f15cd40
[1235524.706589] RBP: ff29715e2ab4c000 R08: 0000000000000000 R09:
0000000000000003
[1235524.709218] R10: ff314a5f895efc28 R11: ffffffffa23e04a8 R12:
ff2971f27ea6e008
[1235524.711976] R13: ff29715e2ab37298 R14: ff29715e2ab37240 R15:
000000000000002d
[1235524.714573] FS:  0000000000000000(0000) GS:ff2972d3dc291000(0000)
knlGS:0000000000000000
[1235524.717486] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1235524.719667] CR2: 00007f6564087780 CR3: 000001020c2f1003 CR4:
0000000000771ef0
[1235524.722249] PKRU: 55555554
[1235524.723471] Call Trace:
[1235524.724964]  <TASK>
[1235524.726034]  nfsd4_sequence_done+0x1d6/0x210 [nfsd]
[1235524.727957]  nfs4svc_encode_compoundres+0x50/0x60 [nfsd]
[1235524.729973]  nfsd_dispatch+0x111/0x210 [nfsd]
[1235524.731750]  svc_process_common+0x4e7/0x6f0 [sunrpc]
[1235524.733741]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[1235524.735707]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[1235524.737459]  svc_process+0x141/0x200 [sunrpc]
[1235524.739176]  svc_handle_xprt+0x483/0x580 [sunrpc]
[1235524.741066]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[1235524.742784]  svc_recv+0xe0/0x1f0 [sunrpc]
[1235524.744457]  nfsd+0x8b/0xe0 [nfsd]
[1235524.745923]  kthread+0xfa/0x210
[1235524.747343]  ? __pfx_kthread+0x10/0x10
[1235524.748956]  ret_from_fork+0xee/0x110
[1235524.750504]  ? __pfx_kthread+0x10/0x10
[1235524.752078]  ret_from_fork_asm+0x1a/0x30
[1235524.753695]  </TASK>
[1235524.754738] ---[ end trace 0000000000000000 ]---

Some of these servers are pretty heavily loaded and churn through lots
of data (constant 50gbit) so I think this must be a pretty rare corner
case.

These re-export servers export many different NFS server mounts which
include some Netapps mounted as NFSv3 and re-exported to Linux clients
as NFSv4. Because these are the only filesystems that are re-exported
NFSv4 (all our Linux NFS server are mounted and re-exported NFSv3),
the Netapps must be the ones involved in this nfsd4_sequence_done
stack trace.

Having moved from v6.4 to v6.18, there is a lot of churn to get
through to bisect, build, install and wait for a crash so any
suggestions narrowing down where to look with this one would be
greatly appreciated.

Like I said, fairly rare for us atm and the brief outage and
disruption is manageable so we have time to step through the bisect
process if required.

Also happy to open a bugzilla if that is a better place for this.

Cheers,

Daire

