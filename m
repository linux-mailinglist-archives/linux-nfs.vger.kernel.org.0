Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2FD4CEEA9
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Mar 2022 00:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiCFXoM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 18:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiCFXoK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 18:44:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6200F3FBCD
        for <linux-nfs@vger.kernel.org>; Sun,  6 Mar 2022 15:43:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 22AFF1F37D;
        Sun,  6 Mar 2022 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646610196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSKA1IHXo4VvQyQ5fH9dw1FECLVlW8bwiYH7bPlSBvI=;
        b=yH+RBocUV7uauCqG+iXhdj/WWHeSAeRMXuX/LuRFj/O9u+lSsU5SqsWSSEh4IiBZUd1Iu+
        iigUk6pbBkYsfom8YLnSpEJnHeSlegWH9Xc2BPDXL5AFf0xqLzVY2vwZaQrNdG2TlDRHfG
        /fTJrE/XMalLqrH17ee9/3c107Pxe44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646610196;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSKA1IHXo4VvQyQ5fH9dw1FECLVlW8bwiYH7bPlSBvI=;
        b=atBWnF8qKAxnVRncDkW/qCfU8IACYl9ibeg2uTQcgYcHgvrUxQvKPlnM+Yd9C5lVZKiV1l
        CsDAO/0TNf7OV+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 144BC134CD;
        Sun,  6 Mar 2022 23:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UgkUMRJHJWJFWAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 06 Mar 2022 23:43:14 +0000
Subject: [PATCH 09/11] NFS: swap IO handling is slightly different for
 O_DIRECT IO
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 07 Mar 2022 10:41:44 +1100
Message-ID: <164661010498.31054.17793708550077989003.stgit@noble.brown>
In-Reply-To: <164660993703.31054.17075972410545449555.stgit@noble.brown>
References: <164660993703.31054.17075972410545449555.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

1/ Taking the i_rwsem for swap IO triggers lockdep warnings regarding
   possible deadlocks with "fs_reclaim".  These deadlocks could, I believe,
   eventuate if a buffered read on the swapfile was attempted.

   We don't need coherence with the page cache for a swap file, and
   buffered writes are forbidden anyway.  There is no other need for
   i_rwsem during direct IO.  So never take it for swap_rw()

2/ generic_write_checks() explicitly forbids writes to swap, and
   performs checks that are not needed for swap.  So bypass it
   for swap_rw().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/direct.c        |   42 ++++++++++++++++++++++++++++--------------
 fs/nfs/file.c          |    4 ++--
 include/linux/nfs_fs.h |    8 ++++----
 3 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index eabfdab543c8..04aaf39a05cb 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -173,8 +173,8 @@ ssize_t nfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
 
 	if (iov_iter_rw(iter) == READ)
-		return nfs_file_direct_read(iocb, iter);
-	return nfs_file_direct_write(iocb, iter);
+		return nfs_file_direct_read(iocb, iter, true);
+	return nfs_file_direct_write(iocb, iter, true);
 }
 
 static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
@@ -425,6 +425,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
  * nfs_file_direct_read - file direct read operation for NFS files
  * @iocb: target I/O control block
  * @iter: vector of user buffers into which to read data
+ * @swap: flag indicating this is swap IO, not O_DIRECT IO
  *
  * We use this function for direct reads instead of calling
  * generic_file_aio_read() in order to avoid gfar's check to see if
@@ -440,7 +441,8 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
  * client must read the updated atime from the server back into its
  * cache.
  */
-ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter)
+ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
+			     bool swap)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
@@ -482,12 +484,14 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter)
 	if (iter_is_iovec(iter))
 		dreq->flags = NFS_ODIRECT_SHOULD_DIRTY;
 
-	nfs_start_io_direct(inode);
+	if (!swap)
+		nfs_start_io_direct(inode);
 
 	NFS_I(inode)->read_io += count;
 	requested = nfs_direct_read_schedule_iovec(dreq, iter, iocb->ki_pos);
 
-	nfs_end_io_direct(inode);
+	if (!swap)
+		nfs_end_io_direct(inode);
 
 	if (requested > 0) {
 		result = nfs_direct_wait(dreq);
@@ -876,6 +880,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
  * nfs_file_direct_write - file direct write operation for NFS files
  * @iocb: target I/O control block
  * @iter: vector of user buffers from which to write data
+ * @swap: flag indicating this is swap IO, not O_DIRECT IO
  *
  * We use this function for direct writes instead of calling
  * generic_file_aio_write() in order to avoid taking the inode
@@ -892,7 +897,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
  * Note that O_APPEND is not supported for NFS direct writes, as there
  * is no atomic O_APPEND write facility in the NFS protocol.
  */
-ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
+ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
+			      bool swap)
 {
 	ssize_t result, requested;
 	size_t count;
@@ -906,7 +912,11 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	dfprintk(FILE, "NFS: direct write(%pD2, %zd@%Ld)\n",
 		file, iov_iter_count(iter), (long long) iocb->ki_pos);
 
-	result = generic_write_checks(iocb, iter);
+	if (swap)
+		/* bypass generic checks */
+		result =  iov_iter_count(iter);
+	else
+		result = generic_write_checks(iocb, iter);
 	if (result <= 0)
 		return result;
 	count = result;
@@ -937,16 +947,20 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 		dreq->iocb = iocb;
 	pnfs_init_ds_commit_info_ops(&dreq->ds_cinfo, inode);
 
-	nfs_start_io_direct(inode);
+	if (swap) {
+		requested = nfs_direct_write_schedule_iovec(dreq, iter, pos);
+	} else {
+		nfs_start_io_direct(inode);
 
-	requested = nfs_direct_write_schedule_iovec(dreq, iter, pos);
+		requested = nfs_direct_write_schedule_iovec(dreq, iter, pos);
 
-	if (mapping->nrpages) {
-		invalidate_inode_pages2_range(mapping,
-					      pos >> PAGE_SHIFT, end);
-	}
+		if (mapping->nrpages) {
+			invalidate_inode_pages2_range(mapping,
+						      pos >> PAGE_SHIFT, end);
+		}
 
-	nfs_end_io_direct(inode);
+		nfs_end_io_direct(inode);
+	}
 
 	if (requested > 0) {
 		result = nfs_direct_wait(dreq);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index e82f78e256e5..f2a32ef90e22 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -157,7 +157,7 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 	ssize_t result;
 
 	if (iocb->ki_flags & IOCB_DIRECT)
-		return nfs_file_direct_read(iocb, to);
+		return nfs_file_direct_read(iocb, to, false);
 
 	dprintk("NFS: read(%pD2, %zu@%lu)\n",
 		iocb->ki_filp,
@@ -623,7 +623,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 		return result;
 
 	if (iocb->ki_flags & IOCB_DIRECT)
-		return nfs_file_direct_write(iocb, from);
+		return nfs_file_direct_write(iocb, from, false);
 
 	dprintk("NFS: write(%pD2, %zu@%Ld)\n",
 		file, iov_iter_count(from), (long long) iocb->ki_pos);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 582f2eedbf55..8215fca12e1a 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -508,10 +508,10 @@ static inline const struct cred *nfs_file_cred(struct file *file)
  * linux/fs/nfs/direct.c
  */
 extern ssize_t nfs_direct_IO(struct kiocb *, struct iov_iter *);
-extern ssize_t nfs_file_direct_read(struct kiocb *iocb,
-			struct iov_iter *iter);
-extern ssize_t nfs_file_direct_write(struct kiocb *iocb,
-			struct iov_iter *iter);
+ssize_t nfs_file_direct_read(struct kiocb *iocb,
+			     struct iov_iter *iter, bool swap);
+ssize_t nfs_file_direct_write(struct kiocb *iocb,
+			      struct iov_iter *iter, bool swap);
 
 /*
  * linux/fs/nfs/dir.c


