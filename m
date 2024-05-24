Return-Path: <linux-nfs+bounces-3366-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C930F8CE2B7
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 10:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11023B218B7
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 08:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF639475;
	Fri, 24 May 2024 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="Q9Qh08Pa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C12684E03
	for <linux-nfs@vger.kernel.org>; Fri, 24 May 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541187; cv=none; b=SaPUUtUkgSnEDtr+HUeIs1HdBBXPSkwaaEmn//o2U95a2D40YTDR9nbTIWhX1GdK9jX/BYltndT3oj+qX45v28/T91OWd38lpl24z43qkOxRIzUtdZXs6yvAM5fiAq0wwvhLNXOtWpvHm1a44mg3o2NSeIUxWC1PI9iagP/xWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541187; c=relaxed/simple;
	bh=wXdlyW732sWZwj/XFhCju5z0QkOCN26i67S10jpYgds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdxUeu1gGuDHbDli55Ye5CbOLdI8SOK/sEFKAjADzm6TTueGrTtDXKrjqgkfjOgODMQEI7n14AgFKKyb6eSyxmAizGLu6vc9x7jK9StZdUChoVqQ/1CIRzVvNb1qMAq/v2mRJG+G7GjFcdDAsmtXF0vJQuqG6E2RJEt09o6daMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=Q9Qh08Pa; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6269885572so94451966b.1
        for <linux-nfs@vger.kernel.org>; Fri, 24 May 2024 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1716541184; x=1717145984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5dygkVNl92QGx4hFIGJQAhgdkNeoSzmVeEwIx76Z5d4=;
        b=Q9Qh08Pa1F2kbFGZKXVkIVxJUh5IaaDRXlhKVsiONLm3Krgvu87RaN0cCEF1aD6bla
         el6UfnmhIbjr0XKxA8NtFeDs9IUfJKMo0kSXkTbHOzd4eee8F56A8ZpJWIuBoNBKaFpc
         /IlW8i/fbgf4PikGz0xXvV5wQv7TZg3faBQPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541184; x=1717145984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dygkVNl92QGx4hFIGJQAhgdkNeoSzmVeEwIx76Z5d4=;
        b=shpaUXMIhLRict5+2qWvJVF2N2w350WEec2ibiyjldY4lCk84M1AvpGNR7nprDFTFy
         6FFetp9sAdfJeU8/W0lBv8Yc85nlPXBaNfnmdUGtinhK8HgYjYQA130s145Wxhbxj2ac
         To5S8ucu8Er4LCL/pwWnqXIsUJm7V9moWdVq7JIfua715ZbOLcmYqYWCwhI7ajdUv4Se
         yM+Dl0Kf4IkUbe5IcyeA6nSGjnC4GMP/8SmUoGn0+0OFDZHHPxqfCw4uwKf+5A3QT7Cs
         JMDnqaY2rBl+D4Al98GJnLxd6ziV/GfJO4mlh/hWZ+xPugGgfiSKJrAETjHu0pqbOrsf
         L3aw==
X-Gm-Message-State: AOJu0YydoVzcZ7fO1+MySDxAzHwiCz25IceJfFpIOmgzGfTyu6KCwmwA
	N1tvVuttXb3tkUDfYwesH8yPMN/QwO0RpXSJfsjU0lz64sE8EUyMaZkBfoGQeOrh+zxlDaoIxrN
	KPn0Rg4X3ci+i9HsNC3fkIBUYCp07adrK7UNB
X-Google-Smtp-Source: AGHT+IGilVK5uR4w0u3EjvOZyd5tKDFwq8nfwac0iguA96VkXDo+DMtB43CXCag3ufvaeJMPHeOlJMrcEwWhPbm7tK0=
X-Received: by 2002:a17:906:1f06:b0:a59:f2d2:49b1 with SMTP id
 a640c23a62f3a-a6261f91570mr151929166b.9.1716541183776; Fri, 24 May 2024
 01:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ7rbh5o9XG1D5KAPSRyES-8W8AphxsLJXOWUFZK49i8fA@mail.gmail.com>
 <Zk39Sr6GmwQQ5NjS@tissot.1015granger.net> <CAK8fFZ4hPxecuCaV4T=bqZ39C0sJfXBn=rWdvPXVV_o037udfw@mail.gmail.com>
In-Reply-To: <CAK8fFZ4hPxecuCaV4T=bqZ39C0sJfXBn=rWdvPXVV_o037udfw@mail.gmail.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Fri, 24 May 2024 10:59:17 +0200
Message-ID: <CAK8fFZ74tt0cC3_Jm=nA0gv6OH-QM9s08hFVOBfCM_V_FqyyqA@mail.gmail.com>
Subject: Re: [regression] nfsstat/nfsd crash system "general protection fault,
 probably for non-canonical address ..." after 6.8.9->6.8.10 update
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Igor Raits <igor@gooddata.com>, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

>
> >
> > On Wed, May 22, 2024 at 04:36:57AM -0400, Jaroslav Pulchart wrote:
> > > Hello,
> > >
> > > I would like to report some issue causing a "general protection fault"
> > > crash (constantly) after we updated the kernel from 6.8.9 to 6.8.10.
> > > This is triggered when monitoring is using nfsstat on a server where
> > > nfsd is running.
> > >
> > > [ 3049.260633] general protection fault, probably for non-canonical
> > > address 0x66fb103e19e9cc89: 0000 [#1] PREEMPT SMP NOPTI
> > > [ 3049.261628] CPU: 22 PID: 74991 Comm: nfsstat Tainted: G
> > > E      6.8.10-1.gdc.el9.x86_64 #1
> > > [ 3049.262336] Hardware name: RDO OpenStack Compute/RHEL, BIOS
> > > edk2-20240214-2.el9 02/14/2024
> > > [ 3049.263003] RIP: 0010:_raw_spin_lock_irqsave+0x19/0x40
> > > [ 3049.263487] Code: cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> > > 90 0f 1f 44 00 00 41 54 9c 41 5c fa 65 ff 05 a6 92 f5 42 31 c0 ba 01
> > > 00 00 00 <f0> 0f b1 17 75 0a 4c 89 e0 41 5c c3 cc cc cc cc 89 c6 e8 d0
> > > 07 00
> > > [ 3049.264882] RSP: 0018:ffffb1bca6b9bd00 EFLAGS: 00010046
> > > [ 3049.265365] RAX: 0000000000000000 RBX: 66fb103e19e9c989 RCX: 0000000000000001
> > > [ 3049.265953] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 66fb103e19e9cc89
> > > [ 3049.266542] RBP: ffffffffc15df280 R08: 0000000000000001 R09: ffffa049a1785cb8
> > > [ 3049.267112] R10: ffffb1bca6b9bd70 R11: ffffa04964e49000 R12: 0000000000000246
> > > [ 3049.267702] R13: 66fb103e19e9cc89 R14: ffffa048445590a0 R15: 0000000000000001
> > > [ 3049.268278] FS:  00007fa3ddf03740(0000) GS:ffffa05703d00000(0000)
> > > knlGS:0000000000000000
> > > [ 3049.268928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 3049.269443] CR2: 00007fa3dddfca50 CR3: 0000000342d1e004 CR4: 0000000000770ef0
> > > [ 3049.270025] PKRU: 55555554
> > > [ 3049.270371] Call Trace:
> > > [ 3049.270723]  <TASK>
> > > [ 3049.271035]  ? die_addr+0x33/0x90
> > > [ 3049.271423]  ? exc_general_protection+0x1ea/0x450
> > > [ 3049.271879]  ? asm_exc_general_protection+0x22/0x30
> > > [ 3049.272344]  ? _raw_spin_lock_irqsave+0x19/0x40
> > > [ 3049.272803]  __percpu_counter_sum+0xd/0x70
> > > [ 3049.273219]  nfsd_show+0x4f/0x1d0 [nfsd]
> > > [ 3049.273666]  seq_read_iter+0x11d/0x4d0
> > > [ 3049.274073]  ? avc_has_perm+0x42/0xc0
> > > [ 3049.274489]  seq_read+0xfe/0x140
> > > [ 3049.274866]  proc_reg_read+0x56/0xa0
> > > [ 3049.275257]  vfs_read+0xa7/0x340
> > > [ 3049.275647]  ? __do_sys_newfstat+0x57/0x60
> > > [ 3049.276059]  ksys_read+0x5f/0xe0
> > > [ 3049.276439]  do_syscall_64+0x5e/0x170
> > > [ 3049.276836]  entry_SYSCALL_64_after_hwframe+0x78/0x80
> > > [ 3049.277296] RIP: 0033:0x7fa3ddcfd9b2
> > > [ 3049.277719] Code: c0 e9 b2 fe ff ff 50 48 8d 3d ea 1d 0c 00 e8 c5
> > > fd 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75
> > > 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89
> > > 54 24
> > > [ 3049.279139] RSP: 002b:00007ffd930672e8 EFLAGS: 00000246 ORIG_RAX:
> > > 0000000000000000
> > > [ 3049.279788] RAX: ffffffffffffffda RBX: 0000555ded47c2a0 RCX: 00007fa3ddcfd9b2
> > > [ 3049.280402] RDX: 0000000000000400 RSI: 0000555ded47c480 RDI: 0000000000000003
> > > [ 3049.281046] RBP: 00007fa3dddf75e0 R08: 0000000000000003 R09: 0000000000000077
> > > [ 3049.281673] R10: 000000000000005d R11: 0000000000000246 R12: 0000555ded47c2a0
> > > [ 3049.282307] R13: 0000000000000d68 R14: 00007fa3dddf69e0 R15: 0000000000000d68
> > > [ 3049.282928]  </TASK>
> > > [ 3049.283310] Modules linked in: mptcp_diag(E) xsk_diag(E)
> > > raw_diag(E) unix_diag(E) af_packet_diag(E) netlink_diag(E) udp_diag(E)
> > > tcp_diag(E) inet_diag(E) tun(E) br_netfilter(E) bridge(E) stp(E)
> > > llc(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E)
> > > nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) binfmt_misc(E)
> > > zram(E) tls(E) isofs(E) vfat(E) fat(E) intel_rapl_msr(E)
> > > intel_rapl_common(E) kvm_amd(E) ccp(E) kvm(E) irqbypass(E)
> > > virtio_net(E) i2c_i801(E) virtio_gpu(E) i2c_smbus(E) net_failover(E)
> > > virtio_balloon(E) failover(E) virtio_dma_buf(E) fuse(E) ext4(E)
> > > mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E) ahci(E) libahci(E)
> > > crct10dif_pclmul(E) crc32_pclmul(Ea) polyval_clmulni(E)
> > > polyval_generic(E) libata(E) ghash_clmulni_intel(E) sha512_ssse3(E)
> > > virtio_blk(E) serio_raw(E) btrfs(E) xor(E) zstd_compress(E)
> > > raid6_pq(E) libcrc32c(E) crc32c_intel(E) dm_mirror(E)
> > > dm_region_hash(E) dm_log(E) dm_mod(E)
> > > [ 3049.283345] Unloaded tainted modules: edac_mce_amd(E):1 padlock_aes(E)
> > >
> > > Any suggestion on how to fix it is appreciated.
> >
> > Bisect between v6.8.9 and v6.8.10 would give us the exact point
> > where the failures were introduced.
> >
> > I see that GregKH pulled in:
> >
> > 26a0ddb04230 ("nfsd: rename NFSD_NET_* to NFSD_STATS_*")
> > b7b05f98f3f0 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
> > abf5fb593c90 ("nfsd: make all of the nfsd stats per-network namespace")
> >
> > for v6.8.10 as a Stable-Dep-of: 18180a4550d0 ("NFSD: Fix nfsd4_encode_fattr4() crasher")
> >
> > Which is a little baffling, I don't see how those two change sets
> > are mechanically related to each other. But I suspect the culprit is
> > one of those three stat-related patches.
> >
> >
> > --
> > Chuck Lever
>
>
> Hello,
>
> I run bisecting. It was easy to reproduce, simple execution of
> "nfsstat" from terminal stuck the server:
>
> abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566 is the first bad commit
>
>
> $ git bisect bad
> abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566 is the first bad commit
> commit abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566 (HEAD)
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Fri Jan 26 10:39:47 2024 -0500
>
>     nfsd: make all of the nfsd stats per-network namespace
>
>     [ Upstream commit 4b14885411f74b2b0ce0eb2b39d0fffe54e5ca0d ]
>
>     We have a global set of counters that we modify for all of the nfsd
>     operations, but now that we're exposing these stats across all network
>     namespaces we need to make the stats also be per-network namespace.  We
>     already have some caching stats that are per-network namespace, so move
>     these definitions into the same counter and then adjust all the helpers
>     and users of these stats to provide the appropriate nfsd_net struct so
>     that the stats are maintained for the per-network namespace objects.
>
>     Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>     Reviewed-by: Jeff Layton <jlayton@kernel.org>
>     Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>     Stable-dep-of: 18180a4550d0 ("NFSD: Fix nfsd4_encode_fattr4() crasher")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>  fs/nfsd/cache.h     |  2 --
>  fs/nfsd/netns.h     | 17 +++++++++++++++--
>  fs/nfsd/nfs4proc.c  |  6 +++---
>  fs/nfsd/nfs4state.c |  3 ++-
>  fs/nfsd/nfscache.c  | 36 +++++++-----------------------------
>  fs/nfsd/nfsctl.c    | 12 +++---------
>  fs/nfsd/nfsfh.c     |  3 ++-
>  fs/nfsd/stats.c     | 26 ++++++++++++++------------
>  fs/nfsd/stats.h     | 54 +++++++++++++++++++-----------------------------------
>  fs/nfsd/vfs.c       |  6 ++++--
>  10 files changed, 69 insertions(+), 96 deletions(-)
>
> $ git bisect log
> git bisect start
> # status: waiting for both good and bad commits
> # good: [f3d61438b613b87afb63118bea6fb18c50ba7a6b] Linux 6.8.9
> git bisect good f3d61438b613b87afb63118bea6fb18c50ba7a6b
> # status: waiting for bad commit, 1 good commit known
> # bad: [a0c69a570e420e86c7569b8c052913213eef2b45] Linux 6.8.10
> git bisect bad a0c69a570e420e86c7569b8c052913213eef2b45
> # bad: [4aaed9dbe8acd2b6114458f0498a617283d6275b] hv_netvsc: Don't
> free decrypted memory
> git bisect bad 4aaed9dbe8acd2b6114458f0498a617283d6275b
> # bad: [ee190d04c2f99c8e557b00e997621c04592baed1] net: gro: add flush
> check in udp_gro_receive_segment
> git bisect bad ee190d04c2f99c8e557b00e997621c04592baed1
> # bad: [781e34b736014188ba9e46a71535237313dcda81] efi/unaccepted:
> touch soft lockup during memory accept
> git bisect bad 781e34b736014188ba9e46a71535237313dcda81
> # bad: [6a7b07689af6e4e023404bf69b1230f43b2a15bc] NFSD: Fix
> nfsd4_encode_fattr4() crasher
> git bisect bad 6a7b07689af6e4e023404bf69b1230f43b2a15bc
> # good: [e05194baae299f2148ab5f6bab659c6ce8d1f6d3] nfs: expose
> /proc/net/sunrpc/nfs in net namespaces
> git bisect good e05194baae299f2148ab5f6bab659c6ce8d1f6d3
> # good: [946ab150335d92f852288c1c6b0f0466b5d6e97f] power: supply:
> mt6360_charger: Fix of_match for usb-otg-vbus regulator
> git bisect good 946ab150335d92f852288c1c6b0f0466b5d6e97f
> # good: [b7b05f98f3f06fea3986b46e5c7fe2928676b02d] nfsd: expose
> /proc/net/sunrpc/nfsd in net namespaces
> git bisect good b7b05f98f3f06fea3986b46e5c7fe2928676b02d
> # bad: [0e8003af77879572dbc1df56860cbe2bfa8498f0] NFSD: add support
> for CB_GETATTR callback
> git bisect bad 0e8003af77879572dbc1df56860cbe2bfa8498f0
> # bad: [abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566] nfsd: make all of
> the nfsd stats per-network namespace
> git bisect bad abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566
> # first bad commit: [abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566] nfsd:
> make all of the nfsd stats per-network namespace

I built a full 6.8.10 with reverted single commit
"abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566". The server does not get
stuck when calling "nfsstat".

