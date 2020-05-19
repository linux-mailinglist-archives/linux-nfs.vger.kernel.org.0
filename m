Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95981D9335
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2020 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgESJU4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 May 2020 05:20:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbgESJUz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 19 May 2020 05:20:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 764DE1071376E6F135F1;
        Tue, 19 May 2020 17:20:53 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 19 May 2020
 17:20:45 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH] nfs: always force a full attribute revalidation after NFSv4 writes
Date:   Tue, 19 May 2020 17:27:53 +0800
Message-ID: <20200519092753.13658-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use the following command to test nfsv4(size of file1M is 1MB):
mount -t nfs -o vers=4.0,actimeo=60 127.0.0.1/dir1 /mnt
cp file1M /mnt
du -h /mnt/file1M  -->0 within 60s, then 1M

When write is done(cp file1M /mnt), will call this:
nfs_writeback_done
  nfs4_write_done
    nfs4_write_done_cb
      nfs_writeback_update_inode
        nfs_post_op_update_inode_force_wcc_locked(change, ctime, mtime
nfs_post_op_update_inode_force_wcc_locked
   nfs_set_cache_invalid
   nfs_refresh_inode_locked
     nfs_update_inode

nfsd write response contains change, ctime, mtime, the flag will be
clear after nfs_update_inode. Howerver, write response does not contain
space_used, previous open response contains space_used whose value is 0,
so inode->i_blocks is still 0.

nfs_getattr  -->called by "du -h"
  do_update |= force_sync || nfs_attribute_cache_expired -->false in 60s
  cache_validity = READ_ONCE(NFS_I(inode)->cache_validity)
  do_update |= cache_validity & (NFS_INO_INVALID_ATTR    -->false
  if (do_update) {
	__nfs_revalidate_inode
  }

Within 60s, does not send getattr request to nfsd, thus "du -h /mnt/file1M"
is 0.

Fixes: 16e143751727 ("NFS: More fine grained attribute tracking")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 fs/nfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b9d0921cb4fe..bdfb98d5f45b 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1764,7 +1764,8 @@ int nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct nfs_fa
 	status = nfs_post_op_update_inode_locked(inode, fattr,
 			NFS_INO_INVALID_CHANGE
 			| NFS_INO_INVALID_CTIME
-			| NFS_INO_INVALID_MTIME);
+			| NFS_INO_INVALID_MTIME
+			| NFS_INO_INVALID_OTHER);
 	return status;
 }

--
2.26.0.106.g9fadedd

