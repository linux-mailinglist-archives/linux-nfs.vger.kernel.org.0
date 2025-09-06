Return-Path: <linux-nfs+bounces-14100-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA21B474E5
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534ED1BC3E49
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B60225784B;
	Sat,  6 Sep 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDNVRAOU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D9257837
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176941; cv=none; b=Buv6N4irY31IuoGv1AeQ1dKZA0blwe1fZvKnKCsN/cpicvlicaMEQkfgI5ht8j/yTvkOIoYZzZp5715l2ckAwpi6jBdaCgPpYCeE1DUIPy7fULVjjL1KLymnAi6apCaKdg5SDlzUNkfj5hQt6prOMN/qzBwEScgNR9uQwYXEw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176941; c=relaxed/simple;
	bh=36OU2ow5ZVHW/uxyF9K0UCX8insygABB50j7pai09OU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPJwJUAQwYIYELPEm4AIdUbyZqQfhEc7qLowMGeKAuQkKHZyNxBq42G8231jpnGQ6JuxxzdPFvBLtvu3h4tnnOHjbILgs727AM3RdAyj8kIaV6meP4Yhw6trc0fDsvACpOPHlpZgL8E8XJujq9pUdQsmEAuxJjEsM1f6qHwPp0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDNVRAOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B25C4CEF7
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757176939;
	bh=36OU2ow5ZVHW/uxyF9K0UCX8insygABB50j7pai09OU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bDNVRAOUDep8XSoZEQBtMPA+HDtN84vOlFduual5Owq32pFTEyj3r5XuFt5SN+RSb
	 DwRH/6Ljl95TQUGT/4CUUz2gpEhL/m7LM/Vax4caRBn3HMhAeMPYqmjYKwwAMgi08J
	 Pe+jHqWTyEAyNOcODBlrNJrJ9iMwWD1fpOPvjxWltX6OZrruHuItwNwpSvS0Yhvgno
	 3KRE9SEdcxthiam5F40Df+AJb51hGPGTkgL2LiSjxYAPvc7pjDPBuEATEiqb4sadbi
	 8qb4KnyEkWjJ+ZGd6QOGAOkHMuxRVx3/7ybXvgsBYWqiHteqXkza1bxHfns7eHgQ8V
	 GzFrd7QCLPbzQ==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/8] NFSv4.2: Protect copy offload and clone against 'eof page pollution'
Date: Sat,  6 Sep 2025 12:42:10 -0400
Message-ID: <24f906a2f9b8858f30cc1796906e7bc3e1a2ca9c.1757176392.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757176392.git.trond.myklebust@hammerspace.com>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com> <cover.1757176392.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The NFSv4.2 copy offload and clone functions can also end up extending
the size of the destination file, so they too need to call
nfs_truncate_last_folio().

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42proc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 4420b8740e2f..e2fea37c5348 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -362,22 +362,27 @@ static int process_copy_commit(struct file *dst, loff_t pos_dst,
 
 /**
  * nfs42_copy_dest_done - perform inode cache updates after clone/copy offload
- * @inode: pointer to destination inode
+ * @file: pointer to destination file
  * @pos: destination offset
  * @len: copy length
+ * @oldsize: length of the file prior to clone/copy
  *
  * Punch a hole in the inode page cache, so that the NFS client will
  * know to retrieve new data.
  * Update the file size if necessary, and then mark the inode as having
  * invalid cached values for change attribute, ctime, mtime and space used.
  */
-static void nfs42_copy_dest_done(struct inode *inode, loff_t pos, loff_t len)
+static void nfs42_copy_dest_done(struct file *file, loff_t pos, loff_t len,
+				 loff_t oldsize)
 {
+	struct inode *inode = file_inode(file);
+	struct address_space *mapping = file->f_mapping;
 	loff_t newsize = pos + len;
 	loff_t end = newsize - 1;
 
-	WARN_ON_ONCE(invalidate_inode_pages2_range(inode->i_mapping,
-				pos >> PAGE_SHIFT, end >> PAGE_SHIFT));
+	nfs_truncate_last_folio(mapping, oldsize, pos);
+	WARN_ON_ONCE(invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
+						   end >> PAGE_SHIFT));
 
 	spin_lock(&inode->i_lock);
 	if (newsize > i_size_read(inode))
@@ -410,6 +415,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 	struct nfs_server *src_server = NFS_SERVER(src_inode);
 	loff_t pos_src = args->src_pos;
 	loff_t pos_dst = args->dst_pos;
+	loff_t oldsize_dst = i_size_read(dst_inode);
 	size_t count = args->count;
 	ssize_t status;
 
@@ -483,7 +489,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 			goto out;
 	}
 
-	nfs42_copy_dest_done(dst_inode, pos_dst, res->write_res.count);
+	nfs42_copy_dest_done(dst, pos_dst, res->write_res.count, oldsize_dst);
 	nfs_invalidate_atime(src_inode);
 	status = res->write_res.count;
 out:
@@ -1250,6 +1256,7 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 	struct nfs42_clone_res res = {
 		.server	= server,
 	};
+	loff_t oldsize_dst = i_size_read(dst_inode);
 	int status;
 
 	msg->rpc_argp = &args;
@@ -1284,7 +1291,7 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 		/* a zero-length count means clone to EOF in src */
 		if (count == 0 && res.dst_fattr->valid & NFS_ATTR_FATTR_SIZE)
 			count = nfs_size_to_loff_t(res.dst_fattr->size) - dst_offset;
-		nfs42_copy_dest_done(dst_inode, dst_offset, count);
+		nfs42_copy_dest_done(dst_f, dst_offset, count, oldsize_dst);
 		status = nfs_post_op_update_inode(dst_inode, res.dst_fattr);
 	}
 
-- 
2.51.0


