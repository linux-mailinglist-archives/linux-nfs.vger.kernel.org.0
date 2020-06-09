Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA9D1F3AAE
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2020 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgFIMbz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jun 2020 08:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgFIMbx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Jun 2020 08:31:53 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC28C05BD1E
        for <linux-nfs@vger.kernel.org>; Tue,  9 Jun 2020 05:31:52 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d15so3695507edm.10
        for <linux-nfs@vger.kernel.org>; Tue, 09 Jun 2020 05:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:from:to:subject:date:mime-version
         :content-transfer-encoding:importance;
        bh=I6LymYNuinseEm/hzSofXB4qfAvN2jqhbREFC36oWI0=;
        b=jHw+k7ZyUgS995xCeZ8M1rJGkV0rrNR3yzE1v59aLg2rxsHWax2HPyKqJkaxV1Bnq/
         QFe/7AkCL3agUhx9OirqDbTej92gmVlOjTR6fJLugSWgaWO24erj21SHlzF1y6Myv2CV
         Z2NPDQH6wdYc8U/Ybho0tGm84XVzf7R35y7zOEf5NzS9XRQKmDizX/HwRtBETCUEH8tR
         4/WtT8kPRSgQX9/NUQNeHHGYEOiroARFglXUGju7KhcBdYwNkzOZY00LcdFsXf1cPeS8
         abBR7Y14yQ6OxMTZIsAiieP74EdRvt8LL9eu20IYARVVQV/7TaB2gGn12BkdFSsHb3Qw
         +eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:subject:date:mime-version
         :content-transfer-encoding:importance;
        bh=I6LymYNuinseEm/hzSofXB4qfAvN2jqhbREFC36oWI0=;
        b=NfsXMeBvsEn5swL9X5XKs+2ywDfLJBd+qMRwq7lC0hehtwv4kFFqVeaeDBdLelpe/v
         4tKjRNG2u99uiuHBTNzbFJbyMO1UFvR0YM8XPGjjtu2CrBUZ7XHWA75Y1zTqOfsdAt43
         sdH433IQzH2DmWgm7wFu/sy3ZvYBhtt01CmgS/L2hrTHC2kHMk6Ng3+mGT8RPBl+X71p
         1oGmonU9lNLJdCL8uoRHF7z8Z00WG3JinKD/KI39TzbsmXj0vYBQu5+C4rLDAK16Axh3
         nMpDiBmouchvkO26QBrqd9xFAdFK0ZxmAVS7QLqUoB4jfGfbfOqaqO/i1g03T0dMGyYF
         gPYg==
X-Gm-Message-State: AOAM531blql3s1QBBs36OUOxNAlKysVlb65NHqtMj3w1se+LzV4k4LqW
        eoGH+MnsPF+nCPd9o/IT4rto5DWZaTxe5Q==
X-Google-Smtp-Source: ABdhPJyOSPUQEsXKAsTQmtE7RXFlw0yAkHBTl4e8dX2HbMoLMg/NCv7llX7Hbomsa0EfLyncGGZUwQ==
X-Received: by 2002:a05:6402:a42:: with SMTP id bt2mr19001808edb.42.1591705909850;
        Tue, 09 Jun 2020 05:31:49 -0700 (PDT)
Received: from alyakaslap ([82.166.81.77])
        by smtp.gmail.com with ESMTPSA id d11sm10283758edy.79.2020.06.09.05.31.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 05:31:48 -0700 (PDT)
Message-ID: <76C32636621C40EC87811F625761F2AF@alyakaslap>
From:   "Alex Lyakas" <alex@zadara.com>
To:     <linux-nfs@vger.kernel.org>
Subject: nfsd: radix tree warning in nfs4_put_stid and kernel panic
Date:   Tue, 9 Jun 2020 15:31:21 +0300
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3528.331
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3528.331
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Greetings,

We had a kernel panic, which started with radix-tree warning as part of 
nfs4_put_stid() call. The stack trace is [1]. This happened on a mainline 
kernel 4.14.99.

Looking further this is caused by nfsd4_run_cb_work running in 
nfsd4_callbacks queue, executing a delegation recall with 
nfsd4_cb_recall_ops.

An identical issue has been reported via 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1840650 with kernel 
4.15 (ubuntu kernel),
and according to that description, apparently resolved in kernel 5.3.

Can anybody please advise on how to debug this further?

Thanks,
Alex.

[1]
[1306517.042794] WARNING: CPU: 5 PID: 31004 at lib/radix-tree.c:784 
delete_node+0x84/0x1f0
[1306517.042795] Modules linked in: binfmt_misc rpcsec_gss_krb5 xfrm_user 
xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key xfrm_algo 8021q garp 
mrp stp llc sd_mod sg xt_multiport bonding nf_conntrack_ipv4 nf_defrag_ipv4 
iptable_filter xt_tcpudp nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack 
nf_conntrack ip6table_filter ip6_tables isert_scst(OE) iscsi_scst(OE) 
scst_utgt(OE) scst_vdisk(OE) scst(OE) dlm nls_iso8859_1 dm_zcache(OE) 
xfs(OE) btrfs(OE) zstd_compress dm_crypt(OE) raid456(OE) async_raid6_recov 
async_memcpy libcrc32c async_pq async_xor xor async_tx raid6_pq raid1(OE) 
md_mod(OE) rdma_ucm(OE) ib_uverbs(OE) dm_iostat(OE) dm_zerror(OE) dm_mod(OE) 
zadara_utils(OE) mlx4_ib(OE) mlx4_en(OE) ptp pps_core joydev kvm_intel 
overlay kvm irqbypass mlx4_core(OE) devlink input_leds mac_hid serio_raw
[1306517.042861]  sch_fq_codel ib_iser(OE) rdma_cm(OE) nfsd(OE) iw_cm(OE) 
ib_cm(OE) auth_rpcgss ib_core(OE) mlx_compat(OE) nfs_acl iscsi_tcp(OE) 
libiscsi_tcp(OE) lockd libiscsi(OE) scsi_transport_iscsi(OE) grace i6300esb 
sunrpc ip_tables x_tables autofs4 ata_generic pata_acpi ttm crct10dif_pclmul 
crc32_pclmul drm_kms_helper ghash_clmulni_intel syscopyarea pcbc sysfillrect 
sysimgblt fb_sys_fops drm aesni_intel psmouse virtio_net aes_x86_64 ata_piix 
crypto_simd glue_helper libata cryptd virtio_blk scsi_mod(OE) i2c_piix4
[1306517.042905] CPU: 5 PID: 31004 Comm: kworker/u12:3 Tainted: G        W 
OE   4.14.99-zadara02 #1
[1306517.042907] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[1306517.042926] Workqueue: nfsd4_callbacks nfsd4_run_cb_work [nfsd]
[1306517.042929] task: ffff9f47c16bdc40 task.stack: ffffaf388cfdc000
[1306517.042932] RIP: 0010:delete_node+0x84/0x1f0
[1306517.042934] RSP: 0018:ffffaf388cfdfde0 EFLAGS: 00010287
[1306517.042936] RAX: ffff9f43dbb7a250 RBX: ffff9f43dbb7a238 RCX: 
0000000000000000
[1306517.042938] RDX: 0000000000000000 RSI: ffff9f434ab4fd98 RDI: 
ffff9f434ab4fdb0
[1306517.042939] RBP: ffff9f48414a1840 R08: 0000000000000000 R09: 
000000000000003a
[1306517.042940] R10: ffff9f434ab4fdc0 R11: 000000000000003b R12: 
0000000000000000
[1306517.042942] R13: 0000000000000000 R14: ffffffff81a96520 R15: 
0000000000000000
[1306517.042944] FS:  0000000000000000(0000) GS:ffff9f49ffd40000(0000) 
knlGS:0000000000000000
[1306517.042945] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1306517.042947] CR2: 00007f3aeefc9030 CR3: 000000031620a003 CR4: 
00000000003606e0
[1306517.042951] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[1306517.042953] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[1306517.042954] Call Trace:
[1306517.042961]  __radix_tree_delete+0x7c/0x90
[1306517.042965]  radix_tree_delete_item+0x69/0xc0
[1306517.042977]  nfs4_put_stid+0x38/0x90 [nfsd]
[1306517.042983]  process_one_work+0x1d1/0x410
[1306517.042986]  worker_thread+0x2b/0x3d0
[1306517.042989]  ? process_one_work+0x410/0x410
[1306517.042992]  kthread+0x11a/0x130
[1306517.042995]  ? kthread_create_on_node+0x70/0x70
[1306517.043011]  ret_from_fork+0x1f/0x40
[1306517.043013] Code: 85 db 75 c2 8b 45 00 a9 00 00 00 02 75 08 25 ff ff ff 
03 89 45 00 48 c7 45 08 00 00 00 00 48 8b 46 18 48 39 f8 0f 84 28 01 00 00 
<0f> 0b 4c 89 f6 e8 12 05 86 ff 48 85 db 75 ae 41 bf 01 00 00 00
[1306517.043055] ---[ end trace 01a6e6fbaf68d09a ]---
[1306517.054054] kernel tried to execute NX-protected page - exploit 
attempt? (uid: 0)
[1306517.055023] BUG: unable to handle kernel paging request at 
ffff9f434ab4fdb0
[1306517.055023] IP: 0xffff9f434ab4fdb0
[1306517.055023] PGD 316981067 P4D 316981067 PUD 316982067 PMD 
800000000aa001e3
[1306517.055023] Oops: 0011 [#1] PREEMPT SMP NOPTI
[1306517.055023] Modules linked in: binfmt_misc rpcsec_gss_krb5 xfrm_user 
xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key xfrm_algo 8021q garp 
mrp stp llc sd_mod sg xt_multiport bonding nf_conntrack_ipv4 nf_defrag_ipv4 
iptable_filter xt_tcpudp nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack 
nf_conntrack ip6table_filter ip6_tables isert_scst(OE) iscsi_scst(OE) 
scst_utgt(OE) scst_vdisk(OE) scst(OE) dlm nls_iso8859_1 dm_zcache(OE) 
xfs(OE) btrfs(OE) zstd_compress dm_crypt(OE) raid456(OE) async_raid6_recov 
async_memcpy libcrc32c async_pq async_xor xor async_tx raid6_pq raid1(OE) 
md_mod(OE) rdma_ucm(OE) ib_uverbs(OE) dm_iostat(OE) dm_zerror(OE) dm_mod(OE) 
zadara_utils(OE) mlx4_ib(OE) mlx4_en(OE) ptp pps_core joydev kvm_intel 
overlay kvm irqbypass mlx4_core(OE) devlink input_leds mac_hid serio_raw
[1306517.063019]  sch_fq_codel ib_iser(OE) rdma_cm(OE) nfsd(OE) iw_cm(OE) 
ib_cm(OE) auth_rpcgss ib_core(OE) mlx_compat(OE) nfs_acl iscsi_tcp(OE) 
libiscsi_tcp(OE) lockd libiscsi(OE) scsi_transport_iscsi(OE) grace i6300esb 
sunrpc ip_tables x_tables autofs4 ata_generic pata_acpi ttm crct10dif_pclmul 
crc32_pclmul drm_kms_helper ghash_clmulni_intel syscopyarea pcbc sysfillrect 
sysimgblt fb_sys_fops drm aesni_intel psmouse virtio_net aes_x86_64 ata_piix 
crypto_simd glue_helper libata cryptd virtio_blk scsi_mod(OE) i2c_piix4
[1306517.063019] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G        W  OE 
4.14.99-zadara02 #1
[1306517.063019] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[1306517.063019] task: ffff9f49e1f1bd80 task.stack: ffffaf38031a0000
[1306517.063019] RIP: 0010:0xffff9f434ab4fdb0
[1306517.063019] RSP: 0018:ffff9f49ffd43f08 EFLAGS: 00010296
[1306517.063019] RAX: ffff9f434ab4fdb0 RBX: ffff9f49ffd62900 RCX: 
ffff9f470619ed58
[1306517.087016] RDX: ffff9f434ab4fdb0 RSI: ffff9f49ffd43f18 RDI: 
ffff9f434ab4fdb0
[1306517.087016] RBP: ffffffff8245d2c0 R08: ffff9f4767a6ce18 R09: 
ffff9f49e182c200
[1306517.087016] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff9f49ffd62938
[1306517.087016] R13: 000000000000000a R14: 7fffffffffffffff R15: 
0000000000000202
[1306517.087016] FS:  0000000000000000(0000) GS:ffff9f49ffd40000(0000) 
knlGS:0000000000000000
[1306517.087016] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1306517.087016] CR2: ffff9f434ab4fdb0 CR3: 000000031620a003 CR4: 
00000000003606e0
[1306517.087016] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[1306517.087016] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[1306517.087016] Call Trace:
[1306517.087016]  <IRQ>
[1306517.087016]  ? rcu_process_callbacks+0x1b2/0x500
[1306517.087016]  ? __do_softirq+0xe3/0x2f9
[1306517.087016]  ? irq_exit+0xbd/0xd0
[1306517.087016]  ? smp_apic_timer_interrupt+0x78/0x160
[1306517.087016]  ? apic_timer_interrupt+0x7d/0x90
[1306517.087016]  </IRQ>
[1306517.087016]  ? __cpuidle_text_start+0x8/0x8
[1306517.087016]  ? native_safe_halt+0x2/0x10
[1306517.087016]  ? default_idle+0x1a/0x130
[1306517.087016]  ? do_idle+0x167/0x1e0
[1306517.087016]  ? cpu_startup_entry+0x6f/0x80
[1306517.087016]  ? start_secondary+0x1a6/0x1e0
[1306517.087016]  ? secondary_startup_64+0xa5/0xb0
[1306517.087016] Code: 00 00 00 00 00 00 00 00 00 00 00 99 04 67 59 59 4d 5a 
99 00 3c 00 00 00 00 00 00 38 a2 b7 db 43 9f ff ff 40 18 4a 41 48 9f ff ff 
<b0> fd b4 4a 43 9f ff ff b0 fd b4 4a 43 9f ff ff 00 00 00 00 00
[1306517.087016] RIP: 0xffff9f434ab4fdb0 RSP: ffff9f49ffd43f08
[1306517.087016] CR2: ffff9f434ab4fdb0
[1306517.087016] ---[ end trace 01a6e6fbaf68d09b ]--- 

