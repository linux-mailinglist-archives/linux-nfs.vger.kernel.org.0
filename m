Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16B34AB48A
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 07:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244830AbiBGGPw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 01:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352089AbiBGEtJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Feb 2022 23:49:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62D2C043181;
        Sun,  6 Feb 2022 20:49:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8AA5A1F37E;
        Mon,  7 Feb 2022 04:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644209347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E23xUbeV6J41TMiR7CnKzUTjVG3PkIHbIUyHUCQmcCM=;
        b=DQV/jOLzgYJmX7dA9MU+4JDWUtKP8wz/wJe6qbSqgmBqKXJ6eVZAKFYVip7GuG3sg3fBnQ
        wt0TvsfTYlMLV3dbF5dMYc5ZEX9gzSfjTgeezWXv4hUdUHsL3igXaq8oMjAR1ciTFq16Ub
        rpL6oOaWIQv/kuuLWh8qWX1+NkAVKl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644209347;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E23xUbeV6J41TMiR7CnKzUTjVG3PkIHbIUyHUCQmcCM=;
        b=m4KQ4C12YdWdLAG1uGn6XelqJS2eHedV7cweGciC7jVETHpTpXYPuIhUbod3bEBp5S2QN9
        dDhBtSiePirgGlBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A523B1330E;
        Mon,  7 Feb 2022 04:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TKTZGMCkAGKaNQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 07 Feb 2022 04:49:04 +0000
Subject: [PATCH 20/21] NFS: swap IO handling is slightly different for
 O_DIRECT IO
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Feb 2022 15:46:01 +1100
Message-ID: <164420916125.29374.6888726725038584805.stgit@noble.brown>
In-Reply-To: <164420889455.29374.17958998143835612560.stgit@noble.brown>
References: <164420889455.29374.17958998143835612560.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
index b929dd5b0c3a..c5c53219beeb 100644
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
+	if (swap)
+		/* bypass generic checks */
+		result =  iov_iter_count(iter);
+	else
+		result = generic_write_checks(iocb, iter);
 	if (result <= 0)
 		return result;
 	count = result;
@@ -934,16 +944,20 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
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
index 7d42117b210d..ceacae8e7a38 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -159,7 +159,7 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 	ssize_t result;
 
 	if (iocb->ki_flags & IOCB_DIRECT)
-		return nfs_file_direct_read(iocb, to);
+		return nfs_file_direct_read(iocb, to, false);
 
 	dprintk("NFS: read(%pD2, %zu@%lu)\n",
 		iocb->ki_filp,
@@ -634,7 +634,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 		return result;
 
 	if (iocb->ki_flags & IOCB_DIRECT)
-		return nfs_file_direct_write(iocb, from);
+		return nfs_file_direct_write(iocb, from, false);
 
 	dprintk("NFS: write(%pD2, %zu@%Ld)\n",
 		file, iov_iter_count(from), (long long) iocb->ki_pos);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 58807406aff6..22aa5c08e3ed 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -507,10 +507,10 @@ static inline const struct cred *nfs_file_cred(struct file *file)
  * linux/fs/nfs/direct.c
  */
 int nfs_swap_rw(struct kiocb *, struct iov_iter *);
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


