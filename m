Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6839C422F7C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 19:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhJER6k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 13:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbhJER6j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 13:58:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8645C061749
        for <linux-nfs@vger.kernel.org>; Tue,  5 Oct 2021 10:56:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g8so1984593edt.7
        for <linux-nfs@vger.kernel.org>; Tue, 05 Oct 2021 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=218NRyOyRFKtCFj3gDuOfozvWcyKdnQ+nBSX2i7aiMU=;
        b=GfQBbJlonBPnL0L7zpcmSeXLOpQgLViJ1VmudXCHNwClkodk8YDvq9HkXdVq/QkGHk
         Er/QiCOZy5FASNIERtPQyoPdk2YNTUZB2NZFuvKgt0MkBxV3zL2tKzU0tlXx5mhzklBp
         bSHwgMwEBpy9QrMGUXibBs0+kygEzm4GdmY7/z4fgIbb0hZWrZhIpOmCdBVWE3n0aO7i
         MJubtdQFj1jUNoQtrqmjniyeFDp058zgrPsZzUhwhwo1OV7XXrkb9wCVhC/DYYsmorkN
         ztYkhhAyAh/aB9do35uXdiR+Pk0bF2eGTrErhSL5kmuNKA5RLSvS2uu+2g1i4E6NrQNQ
         dtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=218NRyOyRFKtCFj3gDuOfozvWcyKdnQ+nBSX2i7aiMU=;
        b=HuTPgOPt2wSzaPJm8FxLyov3H5X5k7rmTJSj+G3ia4ZsmUGwUyET2pXE9jsjBWsbB2
         MaOsPjl2CcSZWXUr+/aM14sw9W4ZFM5aM9xSVaP1sU9zBExKZPKTKCZYKYggU568MkaI
         8LJfxlW7mXgQ8/YVmBgRZe2Tg0xfPtQdlbGdiqu60+2FR9twmpG4ahecgl1OXD2ZNai5
         HU2gJ6Mi7b9lXeBZYLtipg/lexTJwGl5NzHtbjTIWeeFeZQy3IYF6eGzghAW/CPlX5Jn
         hFg5qNkl0L1noMCl7sxo88xcRQnfs6sDG/yf9cqB0sviBJqECbBotX0kDLagMj+wE1/F
         zS9w==
X-Gm-Message-State: AOAM531HAmT2XXgAN03YILeQ9ZvSZi0HG3kLWFJLfZ/5SW4oAwbBU1ee
        kPKxlBN7lD0tsC8SEKNKx+sG/RUJdKOXx9ZuRvXBPsSaSF14lA==
X-Google-Smtp-Source: ABdhPJxMuKESBw7DV8Xvrai3VWtkzf2tELqRRQf2CAGn/e9d6Bd21Pzv+itkSbWLiasfkzxPFdi0lu0HWOKp2eAEfqY=
X-Received: by 2002:a17:906:64a:: with SMTP id t10mr27620748ejb.5.1633456607322;
 Tue, 05 Oct 2021 10:56:47 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 5 Oct 2021 13:56:36 -0400
Message-ID: <CAN-5tyEbhw8YZeG6-7oahuRpKmGhjmxyeq8-cevU-2PZLSR9cg@mail.gmail.com>
Subject: 5.15-rc4 kernel oops
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

During bakeathon, while running nfstest_dio test ran into the following panic.

[94215.223603] PGD 8000000115647067 P4D 8000000115647067 PUD 115649067 PMD 0 ^M
[94215.224449] Oops: 0000 [#1] SMP PTI^M
[94215.224888] CPU: 1 PID: 234186 Comm: kworker/u8:1 Not tainted
5.15.0-rc4+ #4^M
[94215.225798] Hardware name: Red Hat KVM/RHEL-AV, BIOS
1.13.0-2.module+el8.3.0+7353+9de0a3cc 04/01/2014^M
[94215.226981] Workqueue: nfsiod rpc_async_release [sunrpc]^M
[94215.227777] RIP: 0010:nfs_mark_request_commit+0x12/0x30 [nfs]^M
[94215.228583] Code: ff ff be 03 00 00 00 e8 ac 34 83 eb e9 29 ff ff
ff e8 22 bc d7 eb 66 90 0f 1f 44 00 00 48 85 f6 74 16 48 8b 42 10 48
8b 40 18 <48> 8b 40 18 48 85 c0 74 05 e9 70 fc 15 ec 48 89 d6 e9 68 ed
ff ff^M
[94215.230879] RSP: 0018:ffffa82f0159fe00 EFLAGS: 00010286^M
[94215.231522] RAX: 0000000000000000 RBX: ffff8f3393141880 RCX:
0000000000000000^M
[94215.232392] RDX: ffffa82f0159fe08 RSI: ffff8f3381252500 RDI:
ffff8f3393141880^M
[94215.233266] RBP: ffff8f33ac317c00 R08: 0000000000000000 R09:
ffff8f3487724cb0^M
[94215.234139] R10: 0000000000000008 R11: 0000000000000001 R12:
0000000000000001^M
[94215.235000] R13: ffff8f3485bccee0 R14: ffff8f33ac317c10 R15:
ffff8f33ac317cd8^M
[94215.235872] FS:  0000000000000000(0000) GS:ffff8f34fbc80000(0000)
knlGS:0000000000000000^M
[94215.236862] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
[94215.237567] CR2: 0000000000000018 CR3: 0000000122120006 CR4:
0000000000770ee0^M
[94215.238441] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000^M
[94215.239331] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400^M
[94215.240204] PKRU: 55555554^M
[94215.240546] Call Trace:^M
[94215.240862]  nfs_direct_write_completion+0x13b/0x250 [nfs]^M
[94215.241567]  rpc_free_task+0x39/0x60 [sunrpc]^M
[94215.242174]  rpc_async_release+0x29/0x40 [sunrpc]^M
[94215.242803]  process_one_work+0x1ce/0x370^M
[94215.243336]  worker_thread+0x30/0x380^M
[94215.243795]  ? process_one_work+0x370/0x370^M
[94215.244310]  kthread+0x11a/0x140^M
[94215.244746]  ? set_kthread_struct+0x40/0x40^M
[94215.245278]  ret_from_fork+0x22/0x30^M
[94215.248281] Modules linked in: nfs_layout_flexfiles nfsv3 nfs_acl
nfs_layout_nfsv41_files rpcsec_gss_krb5 nfsv4 dns_resolver nfs lockd
grace fscache netfs ib_core uinput xt_CHECKSUM xt_MASQUERADE
xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_counter
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
nf_tables nfnetlink bridge stp llc tun rfkill intel_rapl_msr
intel_rapl_common isst_if_common nfit libnvdimm kvm_intel kvm
snd_hda_codec_generic ledtrig_audio snd_hda_intel irqbypass
crct10dif_pclmul snd_intel_dspcfg crc32_pclmul snd_intel_sdw_acpi
snd_hda_codec iTCO_wdt ghash_clmulni_intel snd_hda_core
iTCO_vendor_support rapl snd_hwdep snd_seq snd_seq_device snd_pcm
joydev snd_timer pcspkr snd virtio_balloon i2c_i801 lpc_ich i2c_smbus
soundcore auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod cdrom sg
qxl drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect
sysimgblt fb_sys_fops drm ahci libahci libata crc32c_intel serio_raw
virtio_blk virtio_net virtio_console^M
[94215.248481]  net_failover failover dm_mirror dm_region_hash dm_log
dm_mod fuse^M
[94215.260317] CR2: 0000000000000018^M
[94215.260761] ---[ end trace e77f9f8c7d405e9a ]---^M
[94215.261343] RIP: 0010:nfs_mark_request_commit+0x12/0x30 [nfs]^M
[94215.262079] Code: ff ff be 03 00 00 00 e8 ac 34 83 eb e9 29 ff ff
ff e8 22 bc d7 eb 66 90 0f 1f 44 00 00 48 85 f6 74 16 48 8b 42 10 48
8b 40 18 <48> 8b 40 18 48 85 c0 74 05 e9 70 fc 15 ec 48 89 d6 e9 68 ed
ff ff^M
[94215.264346] RSP: 0018:ffffa82f0159fe00 EFLAGS: 00010286^M
[94215.264991] RAX: 0000000000000000 RBX: ffff8f3393141880 RCX:
0000000000000000^M
[94215.265867] RDX: ffffa82f0159fe08 RSI: ffff8f3381252500 RDI:
ffff8f3393141880^M
[94215.266742] RBP: ffff8f33ac317c00 R08: 0000000000000000 R09:
ffff8f3487724cb0^M
[94215.267603] R10: 0000000000000008 R11: 0000000000000001 R12:
0000000000000001^M
[94215.268478] R13: ffff8f3485bccee0 R14: ffff8f33ac317c10 R15:
ffff8f33ac317cd8^M
[94215.269347] FS:  0000000000000000(0000) GS:ffff8f34fbc80000(0000)
knlGS:0000000000000000^M
[94215.270348] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
[94215.271058] CR2: 0000000000000018 CR3: 0000000122120006 CR4:
0000000000770ee0^M
[94215.271970] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000^M
[94215.272869] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400^M
[94215.273773] PKRU: 55555554^M
[94215.274132] Kernel panic - not syncing: Fatal exception^M
[94215.275074] Kernel Offset: 0x2b000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)^M
