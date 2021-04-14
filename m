Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D1535F638
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 16:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhDNOcC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 10:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhDNOcB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 10:32:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E11DF60E09;
        Wed, 14 Apr 2021 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618410700;
        bh=xekPjPBpj9ceIcymQoXIRAzrSY2OFuXS5l5fcWeXPSg=;
        h=From:To:Cc:Subject:Date:From;
        b=uOQMLLApb2UxWGGTaAIvErAx9mr79orz94YViqMPELUEjkfz+GTcjVI2Egm/uaCkD
         BBTdbZjniTiMX2+OtzUKbRRwXz+GkxpgRkXdWWD45AQw8gGUokMYgDwDVvy99ia7kp
         Xs8C7xhpM6rsggmTwU87nA0zQC6HuYILSiHZNLoOXBSGbf9GsPO0xze6eabJRqWNBW
         6J173RVUo/8Lj06xhb7q3IXwp+p5KHEeExMYnlKpW/8Nj8m6DtW0SoXvC0GyP1FkgB
         Df4yVpDxeFAdynfE/TvftUWZio557wLc3JbQSjr+tTm39h2rw/KWyNqo42w7wQuVZO
         A31Gp5XOOaijA==
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Olga Kornievskaia <kolga@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv42: Copy offload should update the file size when appropriate
Date:   Wed, 14 Apr 2021 10:31:37 -0400
Message-Id: <20210414143138.15192-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the result of a copy offload or clone operation is to grow the
destination file size, then we should update it. The reason is that when
a client holds a delegation, it is authoritative for the file size.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42proc.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 8d64eb953347..3875120ef3ef 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -269,6 +269,33 @@ static int process_copy_commit(struct file *dst, loff_t pos_dst,
 	return status;
 }
 
+/**
+ * nfs42_copy_dest_done - perform inode cache updates after clone/copy offload
+ * @inode: pointer to destination inode
+ * @pos: destination offset
+ * @len: copy length
+ *
+ * Punch a hole in the inode page cache, so that the NFS client will
+ * know to retrieve new data.
+ * Update the file size if necessary, and then mark the inode as having
+ * invalid cached values for change attribute, ctime, mtime and space used.
+ */
+static void nfs42_copy_dest_done(struct inode *inode, loff_t pos, loff_t len)
+{
+	loff_t newsize = pos + len;
+	loff_t end = newsize - 1;
+
+	truncate_pagecache_range(inode, pos, end);
+	spin_lock(&inode->i_lock);
+	if (newsize > i_size_read(inode))
+		i_size_write(inode, newsize);
+	nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE |
+					     NFS_INO_INVALID_CTIME |
+					     NFS_INO_INVALID_MTIME |
+					     NFS_INO_INVALID_BLOCKS);
+	spin_unlock(&inode->i_lock);
+}
+
 static ssize_t _nfs42_proc_copy(struct file *src,
 				struct nfs_lock_context *src_lock,
 				struct file *dst,
@@ -362,14 +389,8 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 			goto out;
 	}
 
-	truncate_pagecache_range(dst_inode, pos_dst,
-				 pos_dst + res->write_res.count);
-	spin_lock(&dst_inode->i_lock);
-	nfs_set_cache_invalid(
-		dst_inode, NFS_INO_REVAL_PAGECACHE | NFS_INO_REVAL_FORCED |
-				   NFS_INO_INVALID_SIZE | NFS_INO_INVALID_ATTR |
-				   NFS_INO_INVALID_DATA);
-	spin_unlock(&dst_inode->i_lock);
+	nfs42_copy_dest_done(dst_inode, pos_dst, res->write_res.count);
+
 	spin_lock(&src_inode->i_lock);
 	nfs_set_cache_invalid(src_inode, NFS_INO_REVAL_PAGECACHE |
 						 NFS_INO_REVAL_FORCED |
@@ -1055,8 +1076,10 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 
 	status = nfs4_call_sync(server->client, server, msg,
 				&args.seq_args, &res.seq_res, 0);
-	if (status == 0)
+	if (status == 0) {
+		nfs42_copy_dest_done(dst_inode, dst_offset, count);
 		status = nfs_post_op_update_inode(dst_inode, res.dst_fattr);
+	}
 
 	kfree(res.dst_fattr);
 	return status;
-- 
2.30.2

