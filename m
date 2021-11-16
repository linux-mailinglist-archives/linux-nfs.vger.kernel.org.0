Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41B45280A
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 03:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbhKPCxU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 21:53:20 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37460 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350532AbhKPCuc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 21:50:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C08E01FD6E;
        Tue, 16 Nov 2021 02:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637030812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilqBwRNcKCWrWikYfICWiUGsbiDnIfpp6dIzn05L/u0=;
        b=bxOgH2KDZq5WM3FoP6Hh8QNS3dDmYdj+VdHSkOCn5TaCua9nhQnZJ5j0OMTAs7i9ksqJfQ
        7r2QXkHt7QPW4DPKehojOONQMslkVY3Bs2DqimQIn7QxwvcxtVtGafL9N0oUEMggYfIW6e
        induzPCcnkKaCwsfjr5mBC7mqtYGRSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637030812;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilqBwRNcKCWrWikYfICWiUGsbiDnIfpp6dIzn05L/u0=;
        b=J6AaypphTXdJwcS+m7MJGN9qLmx78KXfjbO2OjSvoBgV5QKOlL2pGzUnKSOEtDgXjBZvFh
        JDE7foDThmS2U/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A52913B70;
        Tue, 16 Nov 2021 02:46:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t4CfCpobk2EmCQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 02:46:50 +0000
Subject: [PATCH 11/13] NFS: swap-out must always use STABLE writes.
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 13:44:04 +1100
Message-ID: <163703064457.25805.5324231084334985723.stgit@noble.brown>
In-Reply-To: <163702956672.25805.16457749992977493579.stgit@noble.brown>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The commit handling code is not safe against memory-pressure deadlocks
when writing to swap.  In particular, nfs_commitdata_alloc() blocks
indefinitely waiting for memory, and this can consume all available
workqueue threads.

swap-out most likely uses STABLE writes anyway as COND_STABLE indicates
that a stable write should be used if the write fits in a single
request, and it normally does.  However if we ever swap with a small
wsize, or gather unusually large numbers of pages for a single write,
this might change.

For safety, make it explicit in the code that direct writes use for swap
must always use FLUSH_COND_STABLE.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/direct.c        |   12 +++++++-----
 fs/nfs/file.c          |    2 +-
 include/linux/nfs_fs.h |    3 ++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 1e80d243ba25..8d3b12402725 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -173,7 +173,7 @@ ssize_t nfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	if (iov_iter_rw(iter) == READ)
 		return nfs_file_direct_read(iocb, iter);
-	return nfs_file_direct_write(iocb, iter);
+	return nfs_file_direct_write(iocb, iter, FLUSH_STABLE);
 }
 
 static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
@@ -789,7 +789,7 @@ static const struct nfs_pgio_completion_ops nfs_direct_write_completion_ops = {
  */
 static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 					       struct iov_iter *iter,
-					       loff_t pos)
+					       loff_t pos, int ioflags)
 {
 	struct nfs_pageio_descriptor desc;
 	struct inode *inode = dreq->inode;
@@ -797,7 +797,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 	size_t requested_bytes = 0;
 	size_t wsize = max_t(size_t, NFS_SERVER(inode)->wsize, PAGE_SIZE);
 
-	nfs_pageio_init_write(&desc, inode, FLUSH_COND_STABLE, false,
+	nfs_pageio_init_write(&desc, inode, ioflags, false,
 			      &nfs_direct_write_completion_ops);
 	desc.pg_dreq = dreq;
 	get_dreq(dreq);
@@ -875,6 +875,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
  * nfs_file_direct_write - file direct write operation for NFS files
  * @iocb: target I/O control block
  * @iter: vector of user buffers from which to write data
+ * @ioflags: flags for nfs_pageio_init_write()
  *
  * We use this function for direct writes instead of calling
  * generic_file_aio_write() in order to avoid taking the inode
@@ -891,7 +892,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
  * Note that O_APPEND is not supported for NFS direct writes, as there
  * is no atomic O_APPEND write facility in the NFS protocol.
  */
-ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
+ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
+			      int ioflags)
 {
 	ssize_t result, requested;
 	size_t count;
@@ -935,7 +937,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 
 	nfs_start_io_direct(inode);
 
-	requested = nfs_direct_write_schedule_iovec(dreq, iter, pos);
+	requested = nfs_direct_write_schedule_iovec(dreq, iter, pos, ioflags);
 
 	if (mapping->nrpages) {
 		invalidate_inode_pages2_range(mapping,
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 59c271f42ea5..878a6a510a5e 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -630,7 +630,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 		result = generic_write_checks(iocb, from);
 		if (result <= 0)
 			return result;
-		return nfs_file_direct_write(iocb, from);
+		return nfs_file_direct_write(iocb, from, FLUSH_COND_STABLE);
 	}
 
 	dprintk("NFS: write(%pD2, %zu@%Ld)\n",
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 5a605e51f4b1..ca312aea6bec 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -509,7 +509,8 @@ extern ssize_t nfs_direct_IO(struct kiocb *, struct iov_iter *);
 extern ssize_t nfs_file_direct_read(struct kiocb *iocb,
 			struct iov_iter *iter);
 extern ssize_t nfs_file_direct_write(struct kiocb *iocb,
-			struct iov_iter *iter);
+				     struct iov_iter *iter,
+				     int ioflags);
 
 /*
  * linux/fs/nfs/dir.c


