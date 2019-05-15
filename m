Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23AD1FAFB
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2019 21:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEOTe4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 May 2019 15:34:56 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:36074 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfEOTez (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 May 2019 15:34:55 -0400
Received: by mail-vs1-f54.google.com with SMTP id l20so719694vsp.3
        for <linux-nfs@vger.kernel.org>; Wed, 15 May 2019 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=aJWKiEvo9ZP1e3hi7MW4Lwv8Irr04YxhTFdP1jCSSX4=;
        b=rtONiShdkX5jnG3OA4N4pc0QnmLhtIE5zzWocF/Jys6iF/GiGa9Ai6EXRyRptd26ud
         LB0tfvKOsUpR1RRJMKzGTJowCxyVOP0M0i6PXmESdqzkNkTfu6jTPzCTNBAI5sijOhIT
         y1qF5kdXB+4lo1gf12YzQEfDKeaUSXlpNSa2gilobfksCVXCn03trTRRSWAbOi0HC9mZ
         JcX4fhL9zmDdpwAXNnb27LNRIFEZsmPS3e9yCw04c7qq030FozQ38P379Odb/rbAiWPR
         UTpxglsFdLf8bzHlpjdhqFQNrQ6tJT1D5sm9/ptzwqdaEx8rTppzY7OLyd6+uyy6fmPk
         ahYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aJWKiEvo9ZP1e3hi7MW4Lwv8Irr04YxhTFdP1jCSSX4=;
        b=qkIC2Nh3iqf7Gu7vKRSHlS1REPCGHqB3pM23rqYkb4PxXdw/m5/GMw+YnMiB99gVZo
         Ot9QXz2HWJXiqzzZZNq1/EOn7E5cFil26ddSzsW7Zi/B8YezqukR7Uvtc2CIUwMvW7wb
         4TwlQBv3SAfuMv1+ieY1CtQq/Y9EZhGex6PL0+ifhdnCTX9lONmR/faHSKbONvclqc25
         pE619SLUftNKqp46Okuwf16ORD43avPyzSd5w1TJW9ngYMUmC0iwRZapJL9nfbkxCSSA
         QgvIGe6rMRDvatiD91DrHt5tzXCRcQq8dyaE0ewY36KLYFEaZlzuSY7dFmIJKzMwF8uc
         lPHQ==
X-Gm-Message-State: APjAAAWF9UK79IfAxcglXyqFYSaHSsX2/uxgDRB0NLTjMFfecUagYf7h
        GVkOcPrs0qx6cGBxfgl0utKmszxZLFBvnV2W73+tdirg
X-Google-Smtp-Source: APXvYqzbuVpr40okRy5pVE9BN4BLBoB5j9o28cpZjA6qLPX4zgI3W1tn4H8P2kdxYPTs7l1cEC/UFRbnqcW1kD47xiI=
X-Received: by 2002:a67:fc4:: with SMTP id 187mr239976vsp.215.1557948894353;
 Wed, 15 May 2019 12:34:54 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 15 May 2019 15:34:43 -0400
Message-ID: <CAN-5tyFGd+OGOkBL_9R3xHv9Np_DQWmUau8=up6wRmx8p7qkWA@mail.gmail.com>
Subject: 5.1 sunrpc kernel oops
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sounds like we can't do:
        const struct rpc_timeout *to = req->rq_task->tk_client->cl_timeout;

Perhaps:
const struct rpc_timeout *to;
and check that if (!req->rq_task || !req->rq_task->tk_client) return 0;

Just a guess. Thoughts?

[37247.291617] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000098
[37247.296200] #PF error: [normal kernel read fault]
[37247.298110] PGD 0 P4D 0
[37247.299264] Oops: 0000 [#1] SMP PTI
[37247.300729] CPU: 1 PID: 23870 Comm: kworker/u256:1 Not tainted 5.1.0+ #172
[37247.303547] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[37247.311770] Workqueue: rpciod rpc_async_schedule [sunrpc]
[37247.313958] RIP: 0010:xprt_adjust_timeout+0x9/0x110 [sunrpc]
[37247.316220] Code: c7 c7 20 0d 50 c0 31 c0 e8 68 00 e2 fc 41 c7 45
04 f4 ff ff ff eb c9 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41
54 55 53 <48> 8b 87 98 00 00 00 48 89 fb 4c 8b 27 48 8b 80 a8 00 00 00
48 8b
[37247.323625] RSP: 0018:ffffb0ab84f5fd68 EFLAGS: 00010207
[37247.325676] RAX: 00000000fffffff5 RBX: ffff9e0ff1042800 RCX: 0000000000000003
[37247.328433] RDX: ffff9e0ff11baac0 RSI: 00000000fffffe01 RDI: 0000000000000000
[37247.331206] RBP: ffff9e0fe20cb200 R08: ffff9e0ff11baac0 R09: ffff9e0ff11baac0
[37247.334038] R10: ffff9e0ff11baab8 R11: 0000000000000003 R12: ffff9e1039b55050
[37247.337098] R13: ffff9e0ff1042830 R14: 0000000000000000 R15: 0000000000000001
[37247.339966] FS:  0000000000000000(0000) GS:ffff9e103bc40000(0000)
knlGS:0000000000000000
[37247.343261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[37247.345669] CR2: 0000000000000098 CR3: 000000007603a002 CR4: 00000000001606e0
[37247.348564] Call Trace:
[37247.351034]  rpc_check_timeout+0x1d/0x140 [sunrpc]
[37247.353005]  call_decode+0x13e/0x1f0 [sunrpc]
[37247.354893]  ? rpc_check_timeout+0x140/0x140 [sunrpc]
[37247.357143]  __rpc_execute+0x7e/0x3d0 [sunrpc]
[37247.359104]  rpc_async_schedule+0x29/0x40 [sunrpc]
[37247.362565]  process_one_work+0x16b/0x370
[37247.365598]  worker_thread+0x49/0x3f0
[37247.367164]  kthread+0xf5/0x130
[37247.368453]  ? max_active_store+0x80/0x80
[37247.370087]  ? kthread_bind+0x10/0x10
[37247.372505]  ret_from_fork+0x1f/0x30
[37247.374695] Modules linked in: nfsv3 cts rpcsec_gss_krb5 nfsv4
dns_resolver nfs rfcomm fuse ip6t_rpfilter ipt_REJECT nf_reject_ipv4
ip6t_REJECT nf_reject_ipv6 xt_conntrack nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ebtable_nat ebtable_broute bridge stp llc
ip6table_mangle ip6table_security ip6table_raw iptable_mangle
iptable_security iptable_raw ebtable_filter ebtables ip6table_filter
ip6_tables iptable_filter bnep snd_seq_midi snd_seq_midi_event
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
crypto_simd cryptd glue_helper vmw_balloon snd_ens1371 snd_ac97_codec
uvcvideo ac97_bus snd_seq pcspkr btusb btrtl btbcm videobuf2_vmalloc
snd_pcm videobuf2_memops btintel videobuf2_v4l2 videodev bluetooth
snd_timer snd_rawmidi vmw_vmci snd_seq_device rfkill videobuf2_common
snd ecdh_generic i2c_piix4 soundcore nfsd nfs_acl lockd auth_rpcgss
grace sunrpc ip_tables xfs libcrc32c sr_mod cdrom sd_mod ata_generic
pata_acpi vmwgfx drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops
[37247.389774]  ttm crc32c_intel drm serio_raw ahci ata_piix libahci
libata mptspi scsi_transport_spi e1000 mptscsih mptbase i2c_core
dm_mirror dm_region_hash dm_log dm_mod
[37247.437859] CR2: 0000000000000098
[37247.462263] ---[ end trace 0d9a85f0df2cef9e ]---
