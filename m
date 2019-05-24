Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE9729EFA
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2019 21:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391455AbfEXTWc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 May 2019 15:22:32 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38504 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391360AbfEXTWc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 May 2019 15:22:32 -0400
Received: by mail-it1-f195.google.com with SMTP id i63so15355768ita.3
        for <linux-nfs@vger.kernel.org>; Fri, 24 May 2019 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SGTkzvnka2M4K1Vk7hETMJqxVjL9Yky1m0UAf1wGVhw=;
        b=jk/sYoMygUyQHX0QFU5c0byQINV1RpgOur6HfGdrgYuTYo6lxnlw3IHx620qPa0O8A
         Cem/oz7qtd88rrAnn237lmNlQTkKLn3NL5G9gl6/o/nDDBa4U1C7F28ROCzhEgTwL4MZ
         hNnOm0TUw7njzyb6R6i9qywXphp0yADS/N9A/aYLPff226VKzaH+68x2PXmyMfJ1SEN0
         nheJYumlABMTUWkUe/KwqcRG5oUytUHsB3PyJ5zRPY0JMMq2Z0x3LpyRFEUIqki/qcW3
         gY4KbSyXIUBH8I0dLWoFLxBEaCVbAQBQZZN7EjDseU2aIYzWQK/6ITJrSGj/h9ed2erU
         EXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SGTkzvnka2M4K1Vk7hETMJqxVjL9Yky1m0UAf1wGVhw=;
        b=PI9gVmWCnKL8N3rFe8XTZHRw5gT/iOKeVeb2ZT3IUQK+FXQxWp1TjIgo+6ALaAk8w8
         Ee2OEOihU6DDkLlPXyyAg5EF6b8G6BeoczhELUvtdbYwaIEvGcOu2pejbz4wktBOApfV
         EC06y0r5x98zbjo5r64+LrVwFRvj47oHiJAZ6A0wkEPTljJOxXM38ugqdpErNaTJZ/Zz
         o+FqnuOJi7IE4V2aPiMHqXHq1BLyGY8HMV6xbhD2NxE884P/TKsgZ/sLjPKrEX1cYlzt
         LHE1dx/oOWL5BdZ/j3iJ4ml9rrMvrMn/oUDFeICS4V+rTWFBzSpZLOlOvTjV8eDIrYjV
         X6jA==
X-Gm-Message-State: APjAAAUPor8pW1KFoaMvvbXi6NqZEpFPpqFK1s/PZQ9j3CJQILK2Y0h7
        3JqfGKMR9Rx7mve7/7viZyKKLZMP
X-Google-Smtp-Source: APXvYqysPWG5xRR2vAPZ4qQqp0/Pb26hY0W8RFDIP+36i5ms7aOIJrC+fE6NnwdWfEhzA5KgPkEXzA==
X-Received: by 2002:a24:680c:: with SMTP id v12mr18661914itb.67.1558725750910;
        Fri, 24 May 2019 12:22:30 -0700 (PDT)
Received: from Olgas-MBP-195.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id c22sm1213387ioa.41.2019.05.24.12.22.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 24 May 2019 12:22:30 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC: don't retry a gss destroy rpc if task was killed
Date:   Fri, 24 May 2019 15:22:38 -0400
Message-Id: <20190524192238.20719-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

It's possible that on an umount we send a NULL call to destroy
a gss context and a failure occurs on the reply. Since it's possible
that in that case the rpc client and auth structure are going away
don't retry. Otherwise, the kernel hits the following oops.

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

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/clnt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 8ff11dc..8928f93 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2487,7 +2487,7 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
 
 out_garbage:
 	clnt->cl_stats->rpcgarbage++;
-	if (task->tk_garb_retry) {
+	if (task->tk_garb_retry && !(task->tk_flags & RPC_TASK_KILLED)) {
 		task->tk_garb_retry--;
 		task->tk_action = call_encode;
 		return -EAGAIN;
@@ -2541,7 +2541,7 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
 	case rpc_autherr_badcred:
 	case rpc_autherr_badverf:
 		/* possibly garbled cred/verf? */
-		if (!task->tk_garb_retry)
+		if (!task->tk_garb_retry || task->tk_flags & RPC_TASK_KILLED)
 			break;
 		task->tk_garb_retry--;
 		trace_rpc__bad_creds(task);
-- 
1.8.3.1

