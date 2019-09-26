Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0ADBEBEA
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2019 08:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfIZGW6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Sep 2019 02:22:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728905AbfIZGW6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 26 Sep 2019 02:22:58 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 10C935437E010F375E27;
        Thu, 26 Sep 2019 14:22:56 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Thu, 26 Sep 2019 14:22:48 +0800
From:   ZhangXiaoxu <zhangxiaoxu5@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     <zhangxiaoxu5@huawei.com>
Subject: [PATCH] nfs: Fix nfsi->nrequests count error on nfs_inode_remove_request
Date:   Thu, 26 Sep 2019 14:29:38 +0800
Message-ID: <1569479378-128669-1-git-send-email-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When xfstests testing, there are some WARNING as below:

WARNING: CPU: 0 PID: 6235 at fs/nfs/inode.c:122 nfs_clear_inode+0x9c/0xd8
Modules linked in:
CPU: 0 PID: 6235 Comm: umount.nfs
Hardware name: linux,dummy-virt (DT)
pstate: 60000005 (nZCv daif -PAN -UAO)
pc : nfs_clear_inode+0x9c/0xd8
lr : nfs_evict_inode+0x60/0x78
sp : fffffc000f68fc00
x29: fffffc000f68fc00 x28: fffffe00c53155c0
x27: fffffe00c5315000 x26: fffffc0009a63748
x25: fffffc000f68fd18 x24: fffffc000bfaaf40
x23: fffffc000936d3c0 x22: fffffe00c4ff5e20
x21: fffffc000bfaaf40 x20: fffffe00c4ff5d10
x19: fffffc000c056000 x18: 000000000000003c
x17: 0000000000000000 x16: 0000000000000000
x15: 0000000000000040 x14: 0000000000000228
x13: fffffc000c3a2000 x12: 0000000000000045
x11: 0000000000000000 x10: 0000000000000000
x9 : 0000000000000000 x8 : 0000000000000000
x7 : 0000000000000000 x6 : fffffc00084b027c
x5 : fffffc0009a64000 x4 : fffffe00c0e77400
x3 : fffffc000c0563a8 x2 : fffffffffffffffb
x1 : 000000000000764e x0 : 0000000000000001
Call trace:
 nfs_clear_inode+0x9c/0xd8
 nfs_evict_inode+0x60/0x78
 evict+0x108/0x380
 dispose_list+0x70/0xa0
 evict_inodes+0x194/0x210
 generic_shutdown_super+0xb0/0x220
 nfs_kill_super+0x40/0x88
 deactivate_locked_super+0xb4/0x120
 deactivate_super+0x144/0x160
 cleanup_mnt+0x98/0x148
 __cleanup_mnt+0x38/0x50
 task_work_run+0x114/0x160
 do_notify_resume+0x2f8/0x308
 work_pending+0x8/0x14

The nrequest should be increased/decreased only if PG_INODE_REF flag
was setted.

But in the nfs_inode_remove_request function, it maybe decrease when
no PG_INODE_REF flag, this maybe lead nrequests count error.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/nfs/write.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 85ca495..52cab65 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -786,7 +786,6 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_page *head;
 
-	atomic_long_dec(&nfsi->nrequests);
 	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
 		head = req->wb_head;
 
@@ -799,8 +798,10 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 		spin_unlock(&mapping->private_lock);
 	}
 
-	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags))
+	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
 		nfs_release_request(req);
+		atomic_long_dec(&nfsi->nrequests);
+	}
 }
 
 static void
-- 
2.7.4

