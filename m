Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE8282EE5
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 11:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbfHFJlP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 05:41:15 -0400
Received: from mail1.windriver.com ([147.11.146.13]:63123 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfHFJlP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 05:41:15 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x769f7SV000779
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 6 Aug 2019 02:41:07 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Tue, 6 Aug 2019 02:41:07 -0700
From:   <zhe.he@windriver.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH] nfsd4: Fix kernel crash when reading proc file reply_cache_stats
Date:   Tue, 6 Aug 2019 17:41:04 +0800
Message-ID: <1565084464-248436-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

reply_cache_stats uses wrong parameter as seq file private structure and
thus causes the following kernel crash when users read
/proc/fs/nfsd/reply_cache_stats

BUG: kernel NULL pointer dereference, address: 00000000000001f9
PGD 0 P4D 0
Oops: 0000 [#3] SMP PTI
CPU: 6 PID: 1502 Comm: cat Tainted: G      D           5.3.0-rc3+ #1
Hardware name: Intel Corporation Broadwell Client platform/Basking Ridge, BIOS BDW-E2R1.86C.0118.R01.1503110618 03/11/2015
RIP: 0010:nfsd_reply_cache_stats_show+0x3b/0x2d0
Code: 41 54 49 89 f4 48 89 fe 48 c7 c7 b3 10 33 88 53 bb e8 03 00 00 e8 88 82 d1 ff bf 58 89 41 00 e8 eb c5 85 00 48 83 eb 01 75 f0 <41> 8b 94 24 f8 01 00 00 48 c7 c6 be 10 33 88 4c 89 ef bb e8 03 00
RSP: 0018:ffffaa520106fe08 EFLAGS: 00010246
RAX: 000000cfe1a77123 RBX: 0000000000000000 RCX: 0000000000291b46
RDX: 000000cf00000000 RSI: 0000000000000006 RDI: 0000000000291b28
RBP: ffffaa520106fe20 R08: 0000000000000006 R09: 000000cfe17e55dd
R10: ffffa424e47c0000 R11: 000000000000030b R12: 0000000000000001
R13: ffffa424e5697000 R14: 0000000000000001 R15: ffffa424e5697000
FS:  00007f805735f580(0000) GS:ffffa424f8f80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000001f9 CR3: 00000000655ce005 CR4: 00000000003606e0
Call Trace:
 seq_read+0x194/0x3e0
 __vfs_read+0x1b/0x40
 vfs_read+0x95/0x140
 ksys_read+0x61/0xe0
 __x64_sys_read+0x1a/0x20
 do_syscall_64+0x4d/0x120
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f805728b861
Code: fe ff ff 50 48 8d 3d 86 b4 09 00 e8 79 e0 01 00 66 0f 1f 84 00 00 00 00 00 48 8d 05 d9 19 0d 00 8b 00 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 48 83 ec 28 48 89 54
RSP: 002b:00007ffea1ce3c38 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f805728b861
RDX: 0000000000020000 RSI: 00007f8057183000 RDI: 0000000000000003
RBP: 00007f8057183000 R08: 00007f8057182010 R09: 0000000000000000
R10: 0000000000000022 R11: 0000000000000246 R12: 0000559a60e8ff10
R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
Modules linked in:
CR2: 00000000000001f9
---[ end trace 01613595153f0cba ]---
RIP: 0010:nfsd_reply_cache_stats_show+0x3b/0x2d0
Code: 41 54 49 89 f4 48 89 fe 48 c7 c7 b3 10 33 88 53 bb e8 03 00 00 e8 88 82 d1 ff bf 58 89 41 00 e8 eb c5 85 00 48 83 eb 01 75 f0 <41> 8b 94 24 f8 01 00 00 48 c7 c6 be 10 33 88 4c 89 ef bb e8 03 00
RSP: 0018:ffffaa52004b3e08 EFLAGS: 00010246
RAX: 0000002bab45a7c6 RBX: 0000000000000000 RCX: 0000000000291b4c
RDX: 0000002b00000000 RSI: 0000000000000004 RDI: 0000000000291b28
RBP: ffffaa52004b3e20 R08: 0000000000000004 R09: 0000002bab1c8c7a
R10: ffffa424e5500000 R11: 00000000000002a9 R12: 0000000000000001
R13: ffffa424e4475000 R14: 0000000000000001 R15: ffffa424e4475000
FS:  00007f805735f580(0000) GS:ffffa424f8f80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000001f9 CR3: 00000000655ce005 CR4: 00000000003606e0
Killed

Fixes: 3ba75830ce17 ("nfsd4: drc containerization")
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 fs/nfsd/nfscache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 26ad75a..96352ab 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -571,7 +571,7 @@ nfsd_cache_append(struct svc_rqst *rqstp, struct kvec *data)
  */
 static int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 {
-	struct nfsd_net *nn = v;
+	struct nfsd_net *nn = m->private;
 
 	seq_printf(m, "max entries:           %u\n", nn->max_drc_entries);
 	seq_printf(m, "num entries:           %u\n",
-- 
2.7.4

