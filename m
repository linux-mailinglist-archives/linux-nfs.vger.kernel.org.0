Return-Path: <linux-nfs+bounces-7627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674F29B9FD0
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Nov 2024 12:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267ED2828FB
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Nov 2024 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA99318733B;
	Sat,  2 Nov 2024 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="GoQDobAC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430B18BBA0
	for <linux-nfs@vger.kernel.org>; Sat,  2 Nov 2024 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548481; cv=none; b=twgZWsAjpJY6hXt/Enmj1N8fSpNAPLhyACVpZ6dx2MfnCHRizdEOzkYXIvb+w6VTB5mSL1M1QFen+iSrbjbqD/jQem9HpPBrosKl6v/4AGYi9dq09py8+GZnGC8uUeKrWbrCHZxVz68VNV/scWjFL6uCkXXklg4gNWZ6oqn/P3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548481; c=relaxed/simple;
	bh=KsN/p1xOgSC+P9fz2g/LnGFHEu0x4WRfYHOfzzfFVP8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RlM0xsYl9wLnmR/C9LOnz5UGxWXLGU6CBqNFTXywWAbS7NUPl3iRgast3K5Uw7DvVNT5Vypte+IEpS6cVyebv0THVlDGKKAM/Z0i06extqH3iMNm8sWVbtYkZxiyyhMPZ66icvDwROQix3UNjJ68vVHbVZrA9oD2r1FDoyWMVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=GoQDobAC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso1988037a91.0
        for <linux-nfs@vger.kernel.org>; Sat, 02 Nov 2024 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1730548475; x=1731153275; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MiJEgC7gcOk+/Ar2ekUFrB4IoBfJql2GeADyFh8W0No=;
        b=GoQDobACK3TCeK4j5bjK/02KrlES1XsMjuwchu2bHW7RDFZx63HWEBcqoUcXHqzGbv
         Bvyqn9qMmopuIimNSn2cE+T9gtFtrdjxtdOAXF4EiBy8kR+d/4UCMJK180lLivgknKrf
         Ojf0WZP84roiiygUYHyVDrJhdlFktnb39gFqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730548475; x=1731153275;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiJEgC7gcOk+/Ar2ekUFrB4IoBfJql2GeADyFh8W0No=;
        b=qu9dxL1rf0aknzP/EiFJ1PhCYP4fhpgaUf0R8kL1JB3n9c6eicEkHIWGmRNSz1ToAk
         gDZ5iA7WQKdwlKAA9xhZllRri1qHI/cz/3VdUis7UINFRHAxk5zmcVgOYbNjxnBc2xQF
         vgTMoExOovT9idaz7G4D3WFyAlSkhEzI+yEGMUoi7oUlI5MjlkHvNhLbdzvnJN31Sggq
         ncLWQ5qA4EbXDQcUfCNO6RmyHUokZVh69IfC4E5EWOzmlANtdb4mH/u5E7gjLC3kfUuf
         OGaNRqXKNU2zMnM9XI4+0CIHEkUEdnzbydqSq5kL14t4dWUZq/dlQT/a+zUN3WbVMkms
         MVDA==
X-Gm-Message-State: AOJu0Yx2ZNKKZDNbBfXhVQQZnnm1wQNNDRwr8/dkS9sDlWPJZN8ydNb8
	IOlPII3ox+vm54PKUxLgvbl+jGnYsUFtu5WMk7CTuRwUCQwr5LptKVDcqnmLuvTnMZ3Bkqk5mnM
	v61Py53Z9dzErUMw1a1bijOD2ymLoaMjvjAYh4PfBujQbUcSQ3A==
X-Google-Smtp-Source: AGHT+IFwoe3yDPbGYdxb+POM1MklJjU192RqwOdhKP2T/N1mblWDI5s/oNK8JWJE0zwW5tL04WHtvIrzFWVlgASxhSs=
X-Received: by 2002:a17:90b:2703:b0:2d3:c9bb:9cd7 with SMTP id
 98e67ed59e1d1-2e94c52aa1amr9648166a91.36.1730548475340; Sat, 02 Nov 2024
 04:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Igor Raits <igor@gooddata.com>
Date: Sat, 2 Nov 2024 12:54:22 +0100
Message-ID: <CA+9S74gER-UFWp7fV8GnsUKMV5T32-UiKDPq4dYtW9XzG3tstw@mail.gmail.com>
Subject: RIP: 0010:nfs_page_group_unlock+0x24/0x40 [nfs]
To: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello all,

Lately we have been upgrading our systems to 6.11 and multiple VMs
started to do soft lockups somewhere in the NFS code. Stack trace
below.
I don't have any specific reproducer apart from that those nodes use
NFS extensively and we get these soft lockups a few times a week from
different nodes that perform different workloads (but all of them
interact with NFS heavily).
Although the kernel version is our internal build, it does not contain
any patches to the kernel code.

I would appreciate any hint whether this was already fixed or patch
exists or if you would like me to test anything or provide more
information.
Thank you in advance!

track(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) binfmt_misc(E) tls(E)
isofs(E) intel_rapl_msr(E) intel_rapl_common(E) kvm_amd(E) ccp(E)
kvm(E) i2c_i801(E) virtio_net(E) i2c_smbus(E) virtio_gpu(E)
net_failover(E) virtio_balloon(E) failover(E) virtio_dma_buf(E)
vfat(E) fat(E) fuse(E) ext4(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E)
sg(E) ahci(E) libahci(E) libata(E) crct10dif_pclmul(E) crc32_pclmul(E)
polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E)
sha512_ssse3(E) virtio_blk(E) serio_raw(E) btrfs(E) xor(E)
zstd_compress(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) dm_mirror(E)
dm_region_hash(E) dm_log(E) dm_mod(E)
[526867.272474] Unloaded tainted modules: amd_atl(E):2
edac_mce_amd(E):1 padlock_aes(E):3
[526867.279710] CPU: 1 UID: 48 PID: 3370537 Comm: /usr/sbin/httpd
Tainted: G            EL     6.11.5-1.gdc.el9.x86_64 #1
[526867.280845] Tainted: [E]=UNSIGNED_MODULE, [L]=SOFTLOCKUP
[526867.281537] Hardware name: RDO OpenStack Compute/RHEL, BIOS
edk2-20240524-1.el9 05/24/2024
[526867.282456] RIP: 0010:nfs_page_group_unlock+0x24/0x40 [nfs]
[526867.283234] Code: 90 90 90 90 90 90 0f 1f 44 00 00 53 48 89 fb 48
8b 7f 50 48 39 df 74 05 e8 69 ff ff ff 48 8d 7b 38 f0 80 63 38 bf 48
8b 43 38 <f6> c4 10 75 06 5b c3 cc cc cc cc be 06 00 00 00 5b e9 76 bf
55 f1
[526867.285077] RSP: 0018:ffffa41206ed7a40 EFLAGS: 00000206
[526867.285782] RAX: 0000000000000027 RBX: ffff8b2e93eabf00 RCX:
0000000000000001
[526867.286625] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff8b2e93eabf38
[526867.287503] RBP: ffffea440d05e2c0 R08: ffff8b2e93eabf38 R09:
0000000000000007
[526867.288350] R10: 0000000000000024 R11: 0000000000000006 R12:
ffff8b2e93eabf00
[526867.289217] R13: ffffea440d05e2c0 R14: 0000000000000001 R15:
ffff8b2e93eabf00
[526867.290043] FS:  00007f0469724540(0000) GS:ffff8b31ebd00000(0000)
knlGS:0000000000000000
[526867.290947] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[526867.291723] CR2: 00007f26b2bbf4ac CR3: 0000000103420004 CR4:
0000000000770ef0
[526867.292529] PKRU: 55555554
[526867.293116] Call Trace:
[526867.293677]  <IRQ>
[526867.294173]  ? watchdog_timer_fn+0x3ce/0x530
[526867.294874]  ? __pfx_watchdog_timer_fn+0x10/0x10
[526867.295539]  ? __hrtimer_run_queues+0x10f/0x2a0
[526867.296225]  ? hrtimer_interrupt+0xff/0x240
[526867.296872]  ? __sysvec_apic_timer_interrupt+0x51/0x120
[526867.297558]  ? sysvec_apic_timer_interrupt+0x6c/0x90
[526867.298246]  </IRQ>
[526867.298760]  <TASK>
[526867.299256]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[526867.299955]  ? nfs_page_group_unlock+0x24/0x40 [nfs]
[526867.300590]  nfs_lock_and_join_requests+0x181/0x240 [nfs]
[526867.301268]  ? folio_clear_dirty_for_io+0x136/0x1a0
[526867.301936]  nfs_page_async_flush+0x1b/0x210 [nfs]
[526867.302600]  ? __pfx_nfs_writepages_callback+0x10/0x10 [nfs]
[526867.303318]  nfs_writepages_callback+0x2d/0x50 [nfs]
[526867.303969]  write_cache_pages+0x57/0xb0
[526867.304546]  nfs_writepages+0x117/0x2b0 [nfs]
[526867.305194]  ? check_heap_object+0x33/0x1a0
[526867.305797]  do_writepages+0xc9/0x230
[526867.306344]  ? filemap_dirty_folio+0x5c/0x80
[526867.306924]  filemap_fdatawrite_wbc+0x66/0x90
[526867.307537]  __filemap_fdatawrite_range+0x58/0x80
[526867.308147]  filemap_write_and_wait_range+0x3e/0xb0
[526867.308804]  nfs_wb_all+0x22/0x120 [nfs]
[526867.309422]  nfs4_file_flush+0x6b/0xb0 [nfsv4]
[526867.310055]  filp_flush+0x31/0x70
[526867.310581]  __x64_sys_close+0x2e/0x80
[526867.311120]  do_syscall_64+0x5b/0x170
[526867.311645]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[526867.312253] RIP: 0033:0x7f04698fe317
[526867.312772] Code: ff e8 2d f6 01 00 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 93 7e
f8 ff
[526867.314425] RSP: 002b:00007ffc7c5a74c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000003
[526867.315216] RAX: ffffffffffffffda RBX: 0000564f0aae12b8 RCX:
00007f04698fe317
[526867.316051] RDX: 00007f0469ad3440 RSI: 0000564f0aae12b8 RDI:
0000000000000010
[526867.316775] RBP: 0000000000000010 R08: 0000564f0ace66f8 R09:
0000564f05a3ee90
[526867.317498] R10: 0000000000000001 R11: 0000000000000246 R12:
0000000000000000
[526867.318190] R13: 0000564f05a39288 R14: 0000564f0aae13d0 R15:
0000564f0aaaabb0
[526867.318893]  </TASK>
[526895.266999] watchdog: BUG: soft lockup - CPU#1 stuck for 939s!
[/usr/sbin/httpd:3370537]
[526895.267990] CPU#1 Utilization every 4s during lockup:
[526895.268555] \t#1: 100% system,\t  1% softirq,\t  0% hardirq,\t  0% idle
[526895.269018] \t#2: 100% system,\t  0% softirq,\t  0% hardirq,\t  0% idle
[526895.269481] \t#3: 100% system,\t  0% softirq,\t  0% hardirq,\t  0% idle
[526895.269924] \t#4: 101% system,\t  0% softirq,\t  0% hardirq,\t  0% idle
[526895.270358] \t#5: 100% system,\t  0% softirq,\t  0% hardirq,\t  0% idle

