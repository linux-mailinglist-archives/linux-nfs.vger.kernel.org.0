Return-Path: <linux-nfs+bounces-17293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC58DCDC1A1
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 12:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9E4F30169A1
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 11:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D56917C211;
	Wed, 24 Dec 2025 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="n2pDdO4m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18DC7082D
	for <linux-nfs@vger.kernel.org>; Wed, 24 Dec 2025 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766575169; cv=none; b=gX5NaCyXbYCkgeDOGAnllFOmZjr80o3S7lvMqvDrfW1k5wkbp8vSbzzIDAaGFZfFelD1d21PSyezle6aL40JJJOkd72GJxoP7/tdVD/hO0mrjZ/ObqVMTWV+j/F+RaoQYIG7tQ8D1fOLJ1Kti0GET+R+DyXqh4NZ1QNb3BqpSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766575169; c=relaxed/simple;
	bh=057pkpG2bQMIkRQtLCoA5gQpMi29IggfoHFgOFnHnLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=In6UTu2S6xl4zbxVh1o/d4fMAZq35xTcN2WoRS7jcKhGus+dlnfFZW9Yaj7SW4GjRav02dTfqAfn1CTRduAcKc/ByuY6MZGpsvJh7AHA8yI3QZXKdb/dekMXmW9XtB6iOKJnEVf7Bj5TS7CiRJ0yZf7Jt6ffgLWyQ122IpVtEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=n2pDdO4m; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b736ffc531fso1057039466b.1
        for <linux-nfs@vger.kernel.org>; Wed, 24 Dec 2025 03:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1766575165; x=1767179965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZMbX2LCZoY+nLY3fQleQES08dId+2dZlnXXFGZDULk=;
        b=n2pDdO4mEMtwMavSOIx/IbhwF5gY8wupmT/OT5/AtzJ933EwZuFuBE5oYXoi5Jnws6
         9YY0o5wh+2kmBUyLNb0Yfm9sQVF9Oyit0vuSASAku4tnm9Lcu/JR4Fg/AJHxCu7VkBv9
         Liti6DoeswNCem9jhPc/IpviDH4OKoztfEYEQEjbPkFXgO1Ed0chI/iiYPlpw56C4g5h
         TFPS79EVif1eZXD5Fossi93A13NoV3+PeYVhp2Ve21khUk1Q6joZMlgLC0XSyix4sI77
         3aD1Pp/EtrMmNUJI6AgT17nE1c6WXrTgyZ+wDJUITpIQjTmf52xmhy5IS90jcb/k+Cq7
         lsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766575165; x=1767179965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZMbX2LCZoY+nLY3fQleQES08dId+2dZlnXXFGZDULk=;
        b=YWUrltMzi6iDym6pAq2JV6KlQCJqZfEZcsCZfLsT56bvZ7QUvKS1l533+/oxGtLwe2
         iLTMSuIXTUrWYqeK3pMYQVpWTez+osHScPWux3fuRlMhMDuiHCfbULjtcw3n+azUk+zA
         lCnWdOsC2q+dnQzA1YIe4d6gQfr5snx0qJjbZUa2JjxvMac7iWGBPlWEIRGAf3q/KMBK
         qpXTdeJMIgj2h16RHC8lat04X2/SzrZjjqMNZE07vxs0+aZo5fVK5Qmqxk/U4bGqj2ZT
         McG7TRu7ul2ptnIvx0ldHh2ysojLTvKiza+GACWqjPwC3+fUpADyg9p9qQhj5zKkwdtG
         VDFQ==
X-Gm-Message-State: AOJu0YyvpFdkIll4QmX1/ETcqMWQlDuIcCbua3QPHaDbvWZdybXDJvQA
	9vombkHYIRuic+opKkTU1ZLqKGm1EwutQ9J2fxE6KIlIjsy9aSk26h/NwjM1SXvcWWcW3WnOpDJ
	iNVljxqUuT1I9hRmP5SsY+pSxyEHUgvGP++q4eAPrTw==
X-Gm-Gg: AY/fxX7ZcCg3nv06uzHBLqVgfg+7PMKs8Z72qMY0g8Ev8sfHdisSamvskk1/kKLe3RR
	c1l+A/l8t+9TxB4V6NkUP9sClRws4M+xaBXlaGVggE5qBYjFxxJIGonaQOxTF0iiu9OYW2X8elT
	4ujNPivFYDASyvY7n7Qg+SJvSQZdRuCE1YEdmD0CTslmE3/8X4+OSfHqa3C2yQbDlg6ueZ6KFc9
	jzeykj+fhDM5IrMsY1wC4uUfXlxcWkz77qmRkvXzWxsHjeEWPcWBdyTVDbGRCCO+2Kadw==
X-Google-Smtp-Source: AGHT+IGkAjV1iW3A25IYFNEk+NafM5dfNXX3OaBuEKrY50vh0WyRaHS0e+D1KnPS0P/XsTjeBSpeg1ZRAn3UDOY17f8=
X-Received: by 2002:a17:907:7fa3:b0:b73:57eb:688 with SMTP id
 a640c23a62f3a-b803719d46fmr1940197866b.53.1766575164889; Wed, 24 Dec 2025
 03:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPt2mGPafo29KgjW9Rb17OhBDLnB-3fZn18zFQEhYk7Eitf6BA@mail.gmail.com>
 <f760b3a2-6e53-4143-9bb4-e56b030c6bba@app.fastmail.com>
In-Reply-To: <f760b3a2-6e53-4143-9bb4-e56b030c6bba@app.fastmail.com>
From: Daire Byrne <daire@dneg.com>
Date: Wed, 24 Dec 2025 11:18:48 +0000
X-Gm-Features: AQt7F2ronsjpv74xpY3aPQW_D_b2Fy9WTKzWLxAwPOi4JoOd5IRtufakTfp6YAo
Message-ID: <CAPt2mGOy+ThM7tJDddrWRqFPq5Ljt1hhu==ydArdT7RYK82OBw@mail.gmail.com>
Subject: Re: refcount_t underflow (nfsd4_sequence_done?) with v6.18 re-export
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the pointers!

I have put this all in place so now we wait...

Hopefully we'll net something more useful over the next couple of
weeks with our production workloads.

Cheers,

Daire


On Wed, 24 Dec 2025 at 01:42, Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Tue, Dec 23, 2025, at 6:25 PM, Daire Byrne wrote:
> > Hi,
> >
> > We recently upgraded our NFS re-export servers from a heavily patched
> > (but stable) v6.4 kernel to pretty virgin v6.18.0.
> >
> > But we have started to record a fairly infrequent (once every 2 weeks)
> > crash of the form:
> >
> > [1235524.634962] ------------[ cut here ]------------
> > [1235524.636805] refcount_t: underflow; use-after-free.
> > [1235524.638522] WARNING: CPU: 21 PID: 5048 at lib/refcount.c:28
> > refcount_warn_saturate+0xba/0x110
> > [1235524.642158] Modules linked in: btrfs(E) blake2b_generic(E) xor(E)
> > zstd_compress(E) raid6_pq(E) ufs(E) hfsplus(E) cdrom(E) msdos(E)
> > 8021q(E) garp(E) mrp(E) rpcsec_gss_krb5(E) nfsv3(E) tcp_diag(E)
> > inet_diag(E) nfs(E) xt_CHECKSUM(E) xt_MASQUERADE(E) xt_conntrack(E)
> > ipt_REJECT(E) nf_reject_ipv4(E) nft_compat(E) nft_chain_nat(E)
> > nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E)
> > nf_tables(E) bonding(E) nfnetlink(E) tls(E) cachefiles(E) bridge(E)
> > stp(E) llc(E) netfs(E) rfkill(E) vfat(E) fat(E) ext4(E) crc16(E)
> > mbcache(E) jbd2(E) intel_rapl_msr(E) intel_rapl_common(E) rpcrdma(E)
> > rdma_ucm(E) ib_srpt(E) ib_isert(E) iscsi_target_mod(E)
> > target_core_mod(E) ib_iser(E) ib_umad(E) rdma_cm(E) iw_cm(E)
> > ib_ipoib(E) libiscsi(E) kvm_amd(E) scsi_transport_iscsi(E) ib_cm(E)
> > ccp(E) mlx5_vdpa(E) vringh(E) iTCO_wdt(E) vhost_iotlb(E) kvm(E)
> > intel_pmc_bxt(E) vdpa(E) irqbypass(E) iTCO_vendor_support(E)
> > polyval_clmulni(E) ghash_clmulni_intel(E) i2c_i801(E) mlx5_ib(E)
> > joydev(E) i2c_smbus(E) ib_uverbs(E) ib_core(E) lpc_ich(E) nfsd(E)
> > [1235524.642267]  auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)
> > sch_fq(E) tcp_bbr(E) binfmt_misc(E) dm_mod(E) sunrpc(E) xfs(E)
> > bochs(E) drm_client_lib(E) sd_mod(E) ahci(E) drm_shmem_helper(E) sg(E)
> > drm_kms_helper(E) libahci(E) mlx5_core(E) mlxfw(E) libata(E) drm(E)
> > serio_raw(E) virtio_blk(E) psample(E) virtio_scsi(E) fuse(E)
> > [1235524.681918] CPU: 21 UID: 0 PID: 5048 Comm: nfsd Kdump: loaded
> > Tainted: G            E       6.18.0-3.dneg.x86_64 #1
> > PREEMPT(voluntary)
> > [1235524.686112] Tainted: [E]=3DUNSIGNED_MODULE
> > [1235524.687686] Hardware name: Red Hat dneg/RHEL, BIOS
> > edk2-20241117-2.el9 11/17/2024
> > [1235524.690523] RIP: 0010:refcount_warn_saturate+0xba/0x110
> > [1235524.692572] Code: 01 01 e8 39 b6 a5 ff 0f 0b e9 fd 5a 8a ff 80 3d
> > ee 98 8e 01 00 75 85 48 c7 c7 e0 56 93 a1 c6 05 de 98 8e 01 01 e8 16
> > b6 a5 ff <0f> 0b e9 da 5a 8a ff 80 3d c9 98 8e 01 00 0f 85 5e ff ff ff
> > 48 c7
> > [1235524.699284] RSP: 0018:ff314a5f895efd80 EFLAGS: 00010286
> > [1235524.701351] RAX: 0000000000000000 RBX: ff2971f27ea6e000 RCX:
> > 0000000000000000
> > [1235524.703999] RDX: ff2972d37f16a780 RSI: 0000000000000001 RDI:
> > ff2972d37f15cd40
> > [1235524.706589] RBP: ff29715e2ab4c000 R08: 0000000000000000 R09:
> > 0000000000000003
> > [1235524.709218] R10: ff314a5f895efc28 R11: ffffffffa23e04a8 R12:
> > ff2971f27ea6e008
> > [1235524.711976] R13: ff29715e2ab37298 R14: ff29715e2ab37240 R15:
> > 000000000000002d
> > [1235524.714573] FS:  0000000000000000(0000) GS:ff2972d3dc291000(0000)
> > knlGS:0000000000000000
> > [1235524.717486] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [1235524.719667] CR2: 00007f6564087780 CR3: 000001020c2f1003 CR4:
> > 0000000000771ef0
> > [1235524.722249] PKRU: 55555554
> > [1235524.723471] Call Trace:
> > [1235524.724964]  <TASK>
> > [1235524.726034]  nfsd4_sequence_done+0x1d6/0x210 [nfsd]
> > [1235524.727957]  nfs4svc_encode_compoundres+0x50/0x60 [nfsd]
> > [1235524.729973]  nfsd_dispatch+0x111/0x210 [nfsd]
> > [1235524.731750]  svc_process_common+0x4e7/0x6f0 [sunrpc]
> > [1235524.733741]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> > [1235524.735707]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> > [1235524.737459]  svc_process+0x141/0x200 [sunrpc]
> > [1235524.739176]  svc_handle_xprt+0x483/0x580 [sunrpc]
> > [1235524.741066]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> > [1235524.742784]  svc_recv+0xe0/0x1f0 [sunrpc]
> > [1235524.744457]  nfsd+0x8b/0xe0 [nfsd]
> > [1235524.745923]  kthread+0xfa/0x210
> > [1235524.747343]  ? __pfx_kthread+0x10/0x10
> > [1235524.748956]  ret_from_fork+0xee/0x110
> > [1235524.750504]  ? __pfx_kthread+0x10/0x10
> > [1235524.752078]  ret_from_fork_asm+0x1a/0x30
> > [1235524.753695]  </TASK>
> > [1235524.754738] ---[ end trace 0000000000000000 ]---
> >
> > Some of these servers are pretty heavily loaded and churn through lots
> > of data (constant 50gbit) so I think this must be a pretty rare corner
> > case.
> >
> > These re-export servers export many different NFS server mounts which
> > include some Netapps mounted as NFSv3 and re-exported to Linux clients
> > as NFSv4. Because these are the only filesystems that are re-exported
> > NFSv4 (all our Linux NFS server are mounted and re-exported NFSv3),
> > the Netapps must be the ones involved in this nfsd4_sequence_done
> > stack trace.
> >
> > Having moved from v6.4 to v6.18, there is a lot of churn to get
> > through to bisect, build, install and wait for a crash so any
> > suggestions narrowing down where to look with this one would be
> > greatly appreciated.
> >
> > Like I said, fairly rare for us atm and the brief outage and
> > disruption is manageable so we have time to step through the bisect
> > process if required.
>
> Thanks for the detailed report.
>
> Given the two-week reproduction window, bisecting would be painful,
> especially because it=E2=80=99s difficult to tell if the problem is prese=
nt and just not
> triggering. Instead, could you rebuild with these debugging options enabl=
ed?
>
>   CONFIG_DEBUG_OBJECTS=3Dy
>   CONFIG_DEBUG_OBJECTS_FREE=3Dy
>   CONFIG_KFENCE=3Dy
>
> If you're willing to accept some tracing overhead, these tracepoints woul=
d
> help narrow down the sequence of events:
>
>   echo 1 > /sys/kernel/debug/tracing/events/nfsd/nfsd_slot_seqid_sequence=
/enable
>   echo 1 > /sys/kernel/debug/tracing/events/nfsd/nfsd_mark_client_expired=
/enable
>   echo 1 > /sys/kernel/debug/tracing/events/nfsd/nfsd_clid_destroyed/enab=
le
>
> The nfsd_mark_client_expired tracepoint captures cl_rpc_users, which
> is the client refcount that appears to be underflowing.
>
> To automatically dump the trace buffer on oops:
>
>   echo 1 > /proc/sys/kernel/ftrace_dump_on_oops
>
> This writes recent trace events to the kernel log, so they'll appear
> in dmesg output immediately following the oops. If the system remains
> accessible after the warning, you can also extract the full buffer:
>
>   cat /sys/kernel/debug/tracing/trace > /tmp/nfsd-trace.txt
>
> Looking at changes between v6.4 and v6.18, the session slot handling
> was significantly reworked (xarray storage, on-demand allocation,
> shrinker support). If the next crash provides more context, that
> would help focus the investigation, and could reduce the span of
> commits that would need to be bisected.
>
>
> --
> Chuck Lever

