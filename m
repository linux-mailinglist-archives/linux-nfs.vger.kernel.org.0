Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203881909F5
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2020 10:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCXJus (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 05:50:48 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53017 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgCXJus (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Mar 2020 05:50:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TtVG.5A_1585043436;
Received: from localhost(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0TtVG.5A_1585043436)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Mar 2020 17:50:40 +0800
From:   Yihao Wu <wuyihao@linux.alibaba.com>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: fix race between cache_clean and cache_purge
Date:   Tue, 24 Mar 2020 17:49:28 +0800
Message-Id: <5eed50660eb13326b0fbf537fb58481ea53c1acb.1585043174.git.wuyihao@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2432.ga663e714
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

cache_purge should hold cache_list_lock as cache_clean does. Otherwise a cache
can be cache_put twice, which leads to a use-after-free bug.

To reproduce, run ltp. It happens rarely.  /opt/ltp/runltp run -f net.nfs

[14454.137661] ==================================================================
[14454.138863] BUG: KASAN: use-after-free in cache_purge+0xce/0x160 [sunrpc]
[14454.139822] Read of size 4 at addr ffff8883d484d560 by task nfsd/31993
[14454.140746]
[14454.140995] CPU: 1 PID: 31993 Comm: nfsd Kdump: loaded Not tainted 4.19.91-0.229.git.87bac30.al7.x86_64.debug #1
[14454.141002] Call Trace:
[14454.141014]  dump_stack+0xaf/0xfb[14454.141027]  print_address_description+0x6a/0x2a0
[14454.141037]  kasan_report+0x166/0x2b0[14454.141057]  ? cache_purge+0xce/0x160 [sunrpc]
[14454.141079]  cache_purge+0xce/0x160 [sunrpc]
[14454.141099]  nfsd_last_thread+0x267/0x270 [nfsd][14454.141109]  ? nfsd_last_thread+0x5/0x270 [nfsd]
[14454.141130]  nfsd_destroy+0xcb/0x180 [nfsd]
[14454.141140]  ? nfsd_destroy+0x5/0x180 [nfsd]
[14454.141153]  nfsd+0x1e4/0x2b0 [nfsd]
[14454.141163]  ? nfsd+0x5/0x2b0 [nfsd]
[14454.141173]  kthread+0x114/0x150
[14454.141183]  ? nfsd_destroy+0x180/0x180 [nfsd]
[14454.141187]  ? kthread_park+0xb0/0xb0
[14454.141197]  ret_from_fork+0x3a/0x50
[14454.141224]
[14454.141475] Allocated by task 20918:
[14454.142011]  kmem_cache_alloc_trace+0x9f/0x2e0
[14454.142027]  sunrpc_cache_lookup+0xca/0x2f0 [sunrpc]
[14454.142037]  svc_export_parse+0x1e7/0x930 [nfsd]
[14454.142051]  cache_do_downcall+0x5a/0x80 [sunrpc]
[14454.142064]  cache_downcall+0x78/0x180 [sunrpc]
[14454.142078]  cache_write_procfs+0x57/0x80 [sunrpc]
[14454.142083]  proc_reg_write+0x90/0xd0
[14454.142088]  vfs_write+0xc2/0x1c0
[14454.142092]  ksys_write+0x4d/0xd0
[14454.142098]  do_syscall_64+0x60/0x250
[14454.142103]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[14454.142106]
[14454.142344] Freed by task 19165:
[14454.142804]  kfree+0x114/0x300
[14454.142819]  cache_clean+0x2a4/0x2e0 [sunrpc]
[14454.142833]  cache_flush+0x24/0x60 [sunrpc]
[14454.142845]  write_flush.isra.19+0xbe/0x100 [sunrpc]
[14454.142849]  proc_reg_write+0x90/0xd0
[14454.142853]  vfs_write+0xc2/0x1c0
[14454.142856]  ksys_write+0x4d/0xd0
[14454.142860]  do_syscall_64+0x60/0x250
[14454.142865]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[14454.142867]
[14454.143095] The buggy address belongs to the object at ffff8883d484d540 which belongs to the cache kmalloc-256 of size 256
[14454.144842] The buggy address is located 32 bytes inside of  256-byte region [ffff8883d484d540, ffff8883d484d640)
[14454.146463] The buggy address belongs to the page:
[14454.147155] page:ffffea000f521300 count:1 mapcount:0 mapping:ffff888107c02e00 index:0xffff8883d484da40 compound_map count: 0
[14454.148712] flags: 0x17fffc00010200(slab|head)
[14454.149356] raw: 0017fffc00010200 ffffea000f4baf00 0000000200000002 ffff888107c02e00
[14454.150453] raw: ffff8883d484da40 0000000080190001 00000001ffffffff 0000000000000000
[14454.151557] page dumped because: kasan: bad access detected
[14454.152364]
[14454.152606] Memory state around the buggy address:
[14454.153300]  ffff8883d484d400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[14454.154319]  ffff8883d484d480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[14454.155324] >ffff8883d484d500: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
[14454.156334]                                                        ^
[14454.157237]  ffff8883d484d580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[14454.158262]  ffff8883d484d600: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[14454.159282] ==================================================================
[14454.160224] Disabling lock debugging due to kernel taint

Fixes: 471a930ad7d1(SUNRPC: Drop all entries from cache_detail when cache_purge())
Cc: stable@vger.kernel.org #v4.11+
Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
---
 net/sunrpc/cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index bd843a81afa0..3e523eefc47f 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -524,9 +524,11 @@ void cache_purge(struct cache_detail *detail)
 	struct hlist_node *tmp = NULL;
 	int i = 0;
 
+	spin_lock(&cache_list_lock);
 	spin_lock(&detail->hash_lock);
 	if (!detail->entries) {
 		spin_unlock(&detail->hash_lock);
+		spin_unlock(&cache_list_lock);
 		return;
 	}
 
@@ -541,6 +543,7 @@ void cache_purge(struct cache_detail *detail)
 		}
 	}
 	spin_unlock(&detail->hash_lock);
+	spin_unlock(&cache_list_lock);
 }
 EXPORT_SYMBOL_GPL(cache_purge);
 
-- 
2.20.1.2432.ga663e714

