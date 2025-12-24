Return-Path: <linux-nfs+bounces-17292-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E13DCDB16D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 02:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33A0C301A1A7
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 01:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0F8191F94;
	Wed, 24 Dec 2025 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePqqLQzm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6615EC8CE
	for <linux-nfs@vger.kernel.org>; Wed, 24 Dec 2025 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540564; cv=none; b=SjlRIR/WCjEUhDsTam4Kmil8e0g64bKKnteOnvxYhS0QfnaQGw4I+uVM5RcZ21xIIzUQ9HM4Fr+o/veXQOEcDA1MMuxPXP0Musie5UCZS9w+9Uv408v6ftP2T+EYH66Zox9rEuRhEywcQHCvSFvb3Y4+HLCkobL/q6WXpZYQdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540564; c=relaxed/simple;
	bh=po9lTc5B+dqw4l8onhDEt4NoDEr9fcwpa99aUsDE/KI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dGsVDGBkvDfSSFKv8wLoTa4bdbSxY6QroR1nGp1PpvxiUgS7oqqcOtTJqCASu9xVBrzEOOHCqist4Phlw1XCSSBi0ZSg2bTWhaOxOBZEGMzvUrDzk+tawR06P/yPefQDAOgR8hgwu+3XTPxsNqYU1P8iP+bp9RgWf0o8GLwBeXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePqqLQzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E98C116C6;
	Wed, 24 Dec 2025 01:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766540564;
	bh=po9lTc5B+dqw4l8onhDEt4NoDEr9fcwpa99aUsDE/KI=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=ePqqLQzmxq0cxjqRbg2WED3iMtjgFZ5sV8LxC/zV18nv8yO/xJaY+BESwLaf3lYaD
	 Ly4SjpNJsYe1lc1A9MWLFOt29KI+D4g7UzYZM56FFxSD6F2sM8RTyPXqViWum7cgBI
	 yeXxt0UpqRyOOgeRo9xVuQh3PyRNNAd0OoStusIPq9f4gc49Ki//r0xyWFLrI3pO7p
	 KjyZ9tnlrw3NHrCohxwb8mK8atVOYj8YCE0AMpdHfAOv2Zh/iVzyDZAx4o7AXDOVzn
	 VLfIbuEhaMnpDGyYO+3atAM3Tv1868Q2ltZBuSg0y+R5P9EqLumoZt7isStWOgkioV
	 o7+rbpKZlrBfg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 18913F40068;
	Tue, 23 Dec 2025 20:42:43 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 23 Dec 2025 20:42:43 -0500
X-ME-Sender: <xms:E0VLac0JCChc_HWvmqV7wFzNz8PY407xO5tO5zyAeN9BbbSZ6CFWtQ>
    <xme:E0VLaR4uxe6F9xIcO01c2PdUbQ6ep5gi-DdTozTwAJSvDx6Ya5EWyn3biBVC6gXCM
    f2XWqEhG2GxVIre3CJV7c5dpfqdSzKdAZDzG5fqZBbWe-w3v_qf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ehgfdvteffudfgvddtteeiieduffeuhfelueffvdegudeuheffffevjeetuefhudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuggrihhrvgesughnvghgrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:E0VLaTh-TIZZpL7j6nkSvwJdz5EsPq07fF5T-wDvo2ur4L-Q9X33yw>
    <xmx:E0VLad9Wcvu3hftU4kbIMxb72ujCGPI7UxIxlKONFDuAMQMp1RKT-g>
    <xmx:E0VLaarUFSv9ItbjGF9YKoyb0jcE9XPVTFDZU74sfFZht1dmawHW7Q>
    <xmx:E0VLac8zrAt5MeqcsmH6hUPZTpr8q2wDcxzAzj20AhOTLO5u2P4ocQ>
    <xmx:E0VLaeW7Rs85tbncZUKvZpgyMNH9fsI6ujSXpAUxUsQNvtPZVssusEAy>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ED4F0780054; Tue, 23 Dec 2025 20:42:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9aTQCeeGJYs
Date: Tue, 23 Dec 2025 20:42:22 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Daire Byrne" <daire@dneg.com>, linux-nfs <linux-nfs@vger.kernel.org>
Message-Id: <f760b3a2-6e53-4143-9bb4-e56b030c6bba@app.fastmail.com>
In-Reply-To: 
 <CAPt2mGPafo29KgjW9Rb17OhBDLnB-3fZn18zFQEhYk7Eitf6BA@mail.gmail.com>
References: 
 <CAPt2mGPafo29KgjW9Rb17OhBDLnB-3fZn18zFQEhYk7Eitf6BA@mail.gmail.com>
Subject: Re: refcount_t underflow (nfsd4_sequence_done?) with v6.18 re-export
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Dec 23, 2025, at 6:25 PM, Daire Byrne wrote:
> Hi,
>
> We recently upgraded our NFS re-export servers from a heavily patched
> (but stable) v6.4 kernel to pretty virgin v6.18.0.
>
> But we have started to record a fairly infrequent (once every 2 weeks)
> crash of the form:
>
> [1235524.634962] ------------[ cut here ]------------
> [1235524.636805] refcount_t: underflow; use-after-free.
> [1235524.638522] WARNING: CPU: 21 PID: 5048 at lib/refcount.c:28
> refcount_warn_saturate+0xba/0x110
> [1235524.642158] Modules linked in: btrfs(E) blake2b_generic(E) xor(E)
> zstd_compress(E) raid6_pq(E) ufs(E) hfsplus(E) cdrom(E) msdos(E)
> 8021q(E) garp(E) mrp(E) rpcsec_gss_krb5(E) nfsv3(E) tcp_diag(E)
> inet_diag(E) nfs(E) xt_CHECKSUM(E) xt_MASQUERADE(E) xt_conntrack(E)
> ipt_REJECT(E) nf_reject_ipv4(E) nft_compat(E) nft_chain_nat(E)
> nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E)
> nf_tables(E) bonding(E) nfnetlink(E) tls(E) cachefiles(E) bridge(E)
> stp(E) llc(E) netfs(E) rfkill(E) vfat(E) fat(E) ext4(E) crc16(E)
> mbcache(E) jbd2(E) intel_rapl_msr(E) intel_rapl_common(E) rpcrdma(E)
> rdma_ucm(E) ib_srpt(E) ib_isert(E) iscsi_target_mod(E)
> target_core_mod(E) ib_iser(E) ib_umad(E) rdma_cm(E) iw_cm(E)
> ib_ipoib(E) libiscsi(E) kvm_amd(E) scsi_transport_iscsi(E) ib_cm(E)
> ccp(E) mlx5_vdpa(E) vringh(E) iTCO_wdt(E) vhost_iotlb(E) kvm(E)
> intel_pmc_bxt(E) vdpa(E) irqbypass(E) iTCO_vendor_support(E)
> polyval_clmulni(E) ghash_clmulni_intel(E) i2c_i801(E) mlx5_ib(E)
> joydev(E) i2c_smbus(E) ib_uverbs(E) ib_core(E) lpc_ich(E) nfsd(E)
> [1235524.642267]  auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)
> sch_fq(E) tcp_bbr(E) binfmt_misc(E) dm_mod(E) sunrpc(E) xfs(E)
> bochs(E) drm_client_lib(E) sd_mod(E) ahci(E) drm_shmem_helper(E) sg(E)
> drm_kms_helper(E) libahci(E) mlx5_core(E) mlxfw(E) libata(E) drm(E)
> serio_raw(E) virtio_blk(E) psample(E) virtio_scsi(E) fuse(E)
> [1235524.681918] CPU: 21 UID: 0 PID: 5048 Comm: nfsd Kdump: loaded
> Tainted: G            E       6.18.0-3.dneg.x86_64 #1
> PREEMPT(voluntary)
> [1235524.686112] Tainted: [E]=3DUNSIGNED_MODULE
> [1235524.687686] Hardware name: Red Hat dneg/RHEL, BIOS
> edk2-20241117-2.el9 11/17/2024
> [1235524.690523] RIP: 0010:refcount_warn_saturate+0xba/0x110
> [1235524.692572] Code: 01 01 e8 39 b6 a5 ff 0f 0b e9 fd 5a 8a ff 80 3d
> ee 98 8e 01 00 75 85 48 c7 c7 e0 56 93 a1 c6 05 de 98 8e 01 01 e8 16
> b6 a5 ff <0f> 0b e9 da 5a 8a ff 80 3d c9 98 8e 01 00 0f 85 5e ff ff ff
> 48 c7
> [1235524.699284] RSP: 0018:ff314a5f895efd80 EFLAGS: 00010286
> [1235524.701351] RAX: 0000000000000000 RBX: ff2971f27ea6e000 RCX:
> 0000000000000000
> [1235524.703999] RDX: ff2972d37f16a780 RSI: 0000000000000001 RDI:
> ff2972d37f15cd40
> [1235524.706589] RBP: ff29715e2ab4c000 R08: 0000000000000000 R09:
> 0000000000000003
> [1235524.709218] R10: ff314a5f895efc28 R11: ffffffffa23e04a8 R12:
> ff2971f27ea6e008
> [1235524.711976] R13: ff29715e2ab37298 R14: ff29715e2ab37240 R15:
> 000000000000002d
> [1235524.714573] FS:  0000000000000000(0000) GS:ff2972d3dc291000(0000)
> knlGS:0000000000000000
> [1235524.717486] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [1235524.719667] CR2: 00007f6564087780 CR3: 000001020c2f1003 CR4:
> 0000000000771ef0
> [1235524.722249] PKRU: 55555554
> [1235524.723471] Call Trace:
> [1235524.724964]  <TASK>
> [1235524.726034]  nfsd4_sequence_done+0x1d6/0x210 [nfsd]
> [1235524.727957]  nfs4svc_encode_compoundres+0x50/0x60 [nfsd]
> [1235524.729973]  nfsd_dispatch+0x111/0x210 [nfsd]
> [1235524.731750]  svc_process_common+0x4e7/0x6f0 [sunrpc]
> [1235524.733741]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> [1235524.735707]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> [1235524.737459]  svc_process+0x141/0x200 [sunrpc]
> [1235524.739176]  svc_handle_xprt+0x483/0x580 [sunrpc]
> [1235524.741066]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> [1235524.742784]  svc_recv+0xe0/0x1f0 [sunrpc]
> [1235524.744457]  nfsd+0x8b/0xe0 [nfsd]
> [1235524.745923]  kthread+0xfa/0x210
> [1235524.747343]  ? __pfx_kthread+0x10/0x10
> [1235524.748956]  ret_from_fork+0xee/0x110
> [1235524.750504]  ? __pfx_kthread+0x10/0x10
> [1235524.752078]  ret_from_fork_asm+0x1a/0x30
> [1235524.753695]  </TASK>
> [1235524.754738] ---[ end trace 0000000000000000 ]---
>
> Some of these servers are pretty heavily loaded and churn through lots
> of data (constant 50gbit) so I think this must be a pretty rare corner
> case.
>
> These re-export servers export many different NFS server mounts which
> include some Netapps mounted as NFSv3 and re-exported to Linux clients
> as NFSv4. Because these are the only filesystems that are re-exported
> NFSv4 (all our Linux NFS server are mounted and re-exported NFSv3),
> the Netapps must be the ones involved in this nfsd4_sequence_done
> stack trace.
>
> Having moved from v6.4 to v6.18, there is a lot of churn to get
> through to bisect, build, install and wait for a crash so any
> suggestions narrowing down where to look with this one would be
> greatly appreciated.
>
> Like I said, fairly rare for us atm and the brief outage and
> disruption is manageable so we have time to step through the bisect
> process if required.

Thanks for the detailed report.

Given the two-week reproduction window, bisecting would be painful,
especially because it=E2=80=99s difficult to tell if the problem is pres=
ent and just not
triggering. Instead, could you rebuild with these debugging options enab=
led?

  CONFIG_DEBUG_OBJECTS=3Dy
  CONFIG_DEBUG_OBJECTS_FREE=3Dy
  CONFIG_KFENCE=3Dy

If you're willing to accept some tracing overhead, these tracepoints wou=
ld
help narrow down the sequence of events:

  echo 1 > /sys/kernel/debug/tracing/events/nfsd/nfsd_slot_seqid_sequenc=
e/enable
  echo 1 > /sys/kernel/debug/tracing/events/nfsd/nfsd_mark_client_expire=
d/enable
  echo 1 > /sys/kernel/debug/tracing/events/nfsd/nfsd_clid_destroyed/ena=
ble

The nfsd_mark_client_expired tracepoint captures cl_rpc_users, which
is the client refcount that appears to be underflowing.

To automatically dump the trace buffer on oops:

  echo 1 > /proc/sys/kernel/ftrace_dump_on_oops

This writes recent trace events to the kernel log, so they'll appear
in dmesg output immediately following the oops. If the system remains
accessible after the warning, you can also extract the full buffer:

  cat /sys/kernel/debug/tracing/trace > /tmp/nfsd-trace.txt

Looking at changes between v6.4 and v6.18, the session slot handling
was significantly reworked (xarray storage, on-demand allocation,
shrinker support). If the next crash provides more context, that
would help focus the investigation, and could reduce the span of
commits that would need to be bisected.


--=20
Chuck Lever

