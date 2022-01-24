Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371614977E4
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbiAXDxg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:53:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56970 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbiAXDxg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:53:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 264F721997;
        Mon, 24 Jan 2022 03:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x65zmmwMPjQQ4i8377MUZFK2DfVNQk3gdsKgnDdhJOY=;
        b=VeD+Dk1LlTNVRdYGmbcLCv0OBI0ELzcGtVOsx0LIjbyDi03Cjm9yXGwJ6FTiAGOd4RLtI4
        mLcsr+9eexpa30sTypMVUyZmtuYBQSi+Y2IOseEc7tg/BSPhlAVTgcdh1ICdThARjc5mIu
        v4s0Y2iOY1w9iI8kjTfffqBN0y151+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996415;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x65zmmwMPjQQ4i8377MUZFK2DfVNQk3gdsKgnDdhJOY=;
        b=874/rP8Dzx/B+xlfhQzuKKwZ1zuCwD/Niwj0KCkxxJc144dr93O+VhDoe4pyId5LWaTLcg
        tR6rwsuRD+WQjiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B1B713305;
        Mon, 24 Jan 2022 03:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a1wwNrsi7mG5RQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:53:31 +0000
Subject: [PATCH 14/23] NFS: swap IO handling is slightly different for
 O_DIRECT IO
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jan 2022 14:48:32 +1100
Message-ID: <164299611281.26253.15560926531007295753.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
 fs/nfs/direct.c        |   30 +++++++++++++++++++++---------
 fs/nfs/file.c          |    4 ++--
 include/linux/nfs_fs.h |    4 ++--
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index b929dd5b0c3a..43a956d7fd62 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -166,9 +166,9 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
 
 	if (iov_iter_rw(iter) == READ)
-		ret = nfs_file_direct_read(iocb, iter);
+		ret = nfs_file_direct_read(iocb, iter, true);
 	else
-		ret = nfs_file_direct_write(iocb, iter);
+		ret = nfs_file_direct_write(iocb, iter, true);
 	if (ret < 0)
 		return ret;
 	return 0;
@@ -422,6 +422,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
  * nfs_file_direct_read - file direct read operation for NFS files
  * @iocb: target I/O control block
  * @iter: vector of user buffers into which to read data
+ * @swap: flag indicating this is swap IO, not O_DIRECT IO
  *
  * We use this function for direct reads instead of calling
  * generic_file_aio_read() in order to avoid gfar's check to see if
@@ -437,7 +438,8 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
  * client must read the updated atime from the server back into its
  * cache.
  */
-ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter)
+ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
+			     bool swap)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
@@ -479,12 +481,14 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter)
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
@@ -873,6 +877,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
  * nfs_file_direct_write - file direct write operation for NFS files
  * @iocb: target I/O control block
  * @iter: vector of user buffers from which to write data
+ * @swap: flag indicating this is swap IO, not O_DIRECT IO
  *
  * We use this function for direct writes instead of calling
  * generic_file_aio_write() in order to avoid taking the inode
@@ -889,7 +894,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
  * Note that O_APPEND is not supported for NFS direct writes, as there
  * is no atomic O_APPEND write facility in the NFS protocol.
  */
-ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
+ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
+			      bool swap)
 {
 	ssize_t result, requested;
 	size_t count;
@@ -903,7 +909,11 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	dfprintk(FILE, "NFS: direct write(%pD2, %zd@%Ld)\n",
 		file, iov_iter_count(iter), (long long) iocb->ki_pos);
 
-	result = generic_write_checks(iocb, iter);
+	if (!swap)
+		result = generic_write_checks(iocb, iter);
+	else
+		/* bypass generic checks */
+		result =  iov_iter_count(iter);
 	if (result <= 0)
 		return result;
 	count = result;
@@ -934,7 +944,8 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 		dreq->iocb = iocb;
 	pnfs_init_ds_commit_info_ops(&dreq->ds_cinfo, inode);
 
-	nfs_start_io_direct(inode);
+	if (!swap)
+		nfs_start_io_direct(inode);
 
 	requested = nfs_direct_write_schedule_iovec(dreq, iter, pos);
 
@@ -943,7 +954,8 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 					      pos >> PAGE_SHIFT, end);
 	}
 
-	nfs_end_io_direct(inode);
+	if (!swap)
+		nfs_end_io_direct(inode);
 
 	if (requested > 0) {
 		result = nfs_direct_wait(dreq);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 91ff9ed05b06..04ba56f223d3 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -159,7 +159,7 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 	ssize_t result;
 
 	if (iocb->ki_flags & IOCB_DIRECT)
-		return nfs_file_direct_read(iocb, to);
+		return nfs_file_direct_read(iocb, to, false);
 
 	dprintk("NFS: read(%pD2, %zu@%lu)\n",
 		iocb->ki_filp,
@@ -625,7 +625,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 		return result;
 
 	if (iocb->ki_flags & IOCB_DIRECT)
-		return nfs_file_direct_write(iocb, from);
+		return nfs_file_direct_write(iocb, from, false);
 
 	dprintk("NFS: write(%pD2, %zu@%Ld)\n",
 		file, iov_iter_count(from), (long long) iocb->ki_pos);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 29a5e579f26f..aba38dc4fd29 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -511,9 +511,9 @@ static inline const struct cred *nfs_file_cred(struct file *file)
  */
 extern int nfs_swap_rw(struct kiocb *, struct iov_iter *);
 extern ssize_t nfs_file_direct_read(struct kiocb *iocb,
-			struct iov_iter *iter);
+				    struct iov_iter *iter, bool swap);
 extern ssize_t nfs_file_direct_write(struct kiocb *iocb,
-			struct iov_iter *iter);
+				     struct iov_iter *iter, bool swap);
 
 /*
  * linux/fs/nfs/dir.c


