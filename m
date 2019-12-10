Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3EC4118F1C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2019 18:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfLJReb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Dec 2019 12:34:31 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39966 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfLJReb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Dec 2019 12:34:31 -0500
Received: by mail-ua1-f67.google.com with SMTP id v18so2935359uaq.7
        for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2019 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+lFJuZrXerzJweYXnL+x/ut8CKa9LeuUfKYSQKYrcRE=;
        b=DvANJH74iuwV/cgi7T3kYN2CN229x+4Kui7n7qHxNY8Gx5fN+4bcq9s4lLgXsdYHwE
         Xr1OoERa2nWEK5bQ+sxxv5ggLs4yiTEQYF9PwVHV4y3AzdDp3tdY9doelr86V7SNeNuQ
         8kqtK2KY/iWP4+CHrTXva8jaOY2NrMQArx7U/e0oz0p2c3copdmanSL1YO/Tf4bOD11h
         4Hc50lvkq5a4V6wYypTehNie0cYxBmfSsYMsoyHofSRgr/tQTbA+UcoTCO2B6N0y75uv
         qIbRZgkk5vBfttFwDGZS3Bwxyc2+8ckv86AO6j8BMQIL3nKRbd45nfuoUWWg/iLnICH5
         SZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+lFJuZrXerzJweYXnL+x/ut8CKa9LeuUfKYSQKYrcRE=;
        b=EXz3m+rlGHrT78dX++W2btesZYs6jmoNRl/hOMIL3rv+sUdyL1ZSmFThyuVJc6bnhq
         t8HDNivUXnHqAJErYVYQ07GlEM1B0OmxiwG2aYKBt4cM1H/w8P0xNmuDKvsYwxbTXbGG
         waHB58Nhbgef2vxaJO+MSVLBjTNgmuah5eXKhc1juYQoFJGo7cJw5EKglcBkNc4JfnoY
         VUzyEFQhalY2J5FMn6ANX/9kV9wZARUNfoDuN5y8Jc+8Xaw1Qz3WXlNNoLGsgfUucXv6
         wq4KUob2m+y2RXGU/V7JkhGL9J/Em+RjIki2xo683GFc0pMkLHb5YcmheYfDSuahtHl6
         Ui3A==
X-Gm-Message-State: APjAAAXud68OxifHGKublhZxFe9xVLFO3Mt/fw9TyPq81vGHwR6aSkp6
        fEhyfWWDLX0/4/BaWvag6oszCg7UgQ2zasDu4puAMlh4
X-Google-Smtp-Source: APXvYqxnoiSHHNtmSdeRbQOSqveQSBiDg6exMsPQJlv/v+p4UZpyFOl65W2T0ht+KOjG6zQmR4wl1RJCXqH9jq3lY0w=
X-Received: by 2002:ab0:3381:: with SMTP id y1mr26731981uap.93.1575999269459;
 Tue, 10 Dec 2019 09:34:29 -0800 (PST)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 10 Dec 2019 12:34:18 -0500
Message-ID: <CAN-5tyFxPbQru_VWSx0zSwOTUHqneJYX_=i=eeyH=sAmiJks=w@mail.gmail.com>
Subject: oops in 5.4 on rdma
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

Is this known? Running your cel/testing from commit
37e235c0128566e9d97741ad1e546b44f324f108

I started generic/013 and test hung for long time, got this but then
test ran successfully.

[  153.452029] ------------[ cut here ]------------
[  153.507281] WARNING: CPU: 14 PID: 975 at
drivers/infiniband/core/cq.c:310 ib_free_cq_user+0xea/0x100 [ib_core]
[  153.626988] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver
nfs fscache rdma_rxe ip6_udp_tunnel udp_tunnel nfsd auth_rpcgss
nfs_acl lockd grace xt_CHECKSUM xt_MASQUERADE tun bridge stp llc
ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6
xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle
iptable_security iptable_raw ebtable_filter ebtables ip6table_filter
ip6_tables iptable_filter ib_isert iscsi_target_mod ib_srpt
target_core_mod ib_srp scsi_transport_srp rpcrdma sunrpc
intel_rapl_msr intel_rapl_common rdma_ucm x86_pkg_temp_thermal ib_iser
intel_powerclamp coretemp rdma_cm kvm_intel iw_cm ib_umad ib_ipoib
libiscsi kvm scsi_transport_iscsi ib_cm irqbypass crct10dif_pclmul
mlx5_ib crc32_pclmul iTCO_wdt ipmi_ssif ghash_clmulni_intel
iTCO_vendor_support aesni_intel ib_uverbs crypto_simd ipmi_si cryptd
ipmi_devintf pcspkr ib_core
[  153.627026]  glue_helper i2c_i801 sg lpc_ich ipmi_msghandler wmi
acpi_power_meter ip_tables xfs libcrc32c sd_mod mgag200 drm_kms_helper
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_vram_helper ttm isci
mlx5_core libsas igb drm ahci qla2xxx libahci scsi_transport_sas
libata dca crc32c_intel i2c_algo_bit i2c_core scsi_transport_fc
pci_hyperv_intf dm_mirror dm_region_hash dm_log dm_mod
[  155.086407] CPU: 14 PID: 975 Comm: kworker/u52:0 Not tainted 5.4.0+ #1
[  155.164520] Hardware name: FUJITSU PRIMERGY RX200 S7/D3032-A1, BIOS
V4.6.5.3 R2.29.0 for D3032-A1x 06/18/2018
[  155.283237] Workqueue: xprtiod xprt_autoclose [sunrpc]
[  155.344725] RIP: 0010:ib_free_cq_user+0xea/0x100 [ib_core]
[  155.410365] Code: d7 48 8b 03 48 85 c0 75 e8 e9 6a ff ff ff 48 8d
7f 40 e8 89 9a 52 d6 e9 57 ff ff ff 48 8d 7f 40 e8 0b de 86 d6 e9 49
ff ff ff <0f> 0b 5b 5d 41 5c c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00
00 00
[  155.635114] RSP: 0018:ffff98e4c6aebda0 EFLAGS: 00010202
[  155.697624] RAX: 0000000000000001 RBX: ffff8b85efdb8000 RCX: 0000000000000000
[  155.783015] RDX: ffff8b861516ae80 RSI: 0000000000000000 RDI: ffff8b8df0087000
[  155.868404] RBP: ffff8b8df0087000 R08: 0000000000000001 R09: 0000000000000000
[  155.953795] R10: ffff8b8e1724b000 R11: ffffffffffffffa6 R12: ffff8b85efdb8000
[  156.039186] R13: 0000000000000000 R14: ffff8b86071cb000 R15: ffff8b85efdb8448
[  156.124577] FS:  0000000000000000(0000) GS:ffff8b861fa00000(0000)
knlGS:0000000000000000
[  156.221405] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  156.290157] CR2: 00007fde99d85000 CR3: 000000025f20a003 CR4: 00000000000606e0
[  156.375548] Call Trace:
[  156.404805]  rpcrdma_ep_destroy+0x43/0x70 [rpcrdma]
[  156.463171]  rpcrdma_ep_disconnect+0xf2/0x1c0 [rpcrdma]
[  156.525683]  ? __switch_to_asm+0x34/0x70
[  156.572589]  ? __switch_to_asm+0x40/0x70
[  156.619500]  ? __switch_to_asm+0x34/0x70
[  156.666409]  ? __switch_to_asm+0x40/0x70
[  156.713321]  ? __switch_to_asm+0x34/0x70
[  156.760238]  xprt_rdma_close+0x49/0xc0 [rpcrdma]
[  156.815481]  xprt_autoclose+0x50/0xb0 [sunrpc]
[  156.868635]  process_one_work+0x171/0x380
[  156.916584]  worker_thread+0x49/0x3f0
[  156.960375]  kthread+0xf8/0x130
[  156.997926]  ? max_active_store+0x80/0x80
[  157.045875]  ? kthread_bind+0x10/0x10
[  157.089665]  ret_from_fork+0x35/0x40
[  157.132416] ---[ end trace dcd41693526c20ae ]---

Var log also had this:
Dec 10 12:37:03 localhost kolga: run xfstest generic/013
Dec 10 12:37:03 localhost journal: run fstests generic/013 at
2019-12-10 12:37:03
Dec 10 12:39:54 localhost kernel: INFO: task kworker/6:2:295 blocked
for more than 122 seconds.
Dec 10 12:39:54 localhost kernel:      Tainted: G        W         5.4.0+ #1
Dec 10 12:39:54 localhost kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 10 12:39:55 localhost kernel: kworker/6:2     D    0   295      2 0x80004000
Dec 10 12:39:55 localhost kernel: Workqueue: events xprt_destroy_cb [sunrpc]
Dec 10 12:39:55 localhost kernel: Call Trace:
Dec 10 12:39:55 localhost kernel: ? __schedule+0x2d1/0x6c0
Dec 10 12:39:55 localhost kernel: schedule+0x39/0xa0
Dec 10 12:39:55 localhost kernel: schedule_timeout+0x1c8/0x290
Dec 10 12:39:55 localhost kernel: ? tracing_is_on+0x11/0x30
Dec 10 12:39:55 localhost kernel: ? trace_save_cmdline+0x68/0xd0
Dec 10 12:39:55 localhost kernel: wait_for_completion+0x123/0x190
Dec 10 12:39:55 localhost kernel: ? wake_up_q+0x70/0x70
Dec 10 12:39:55 localhost kernel: __flush_work.isra.35+0x11e/0x1a0
Dec 10 12:39:55 localhost kernel: ? get_work_pool+0x40/0x40
Dec 10 12:39:55 localhost kernel: __cancel_work_timer+0x103/0x190
Dec 10 12:39:55 localhost kernel: xprt_rdma_destroy+0x22/0xb0 [rpcrdma]
Dec 10 12:39:55 localhost kernel: process_one_work+0x171/0x380
Dec 10 12:39:55 localhost kernel: worker_thread+0x49/0x3f0
Dec 10 12:39:55 localhost kernel: kthread+0xf8/0x130
Dec 10 12:39:55 localhost kernel: ? max_active_store+0x80/0x80
Dec 10 12:39:55 localhost kernel: ? kthread_bind+0x10/0x10
Dec 10 12:39:55 localhost kernel: ret_from_fork+0x35/0x40
