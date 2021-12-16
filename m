Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DBF4780E8
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhLPXxY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:53:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47170 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhLPXxY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:53:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E93BD210F3;
        Thu, 16 Dec 2021 23:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kpl2jhqFYtBPH8hemOIlub9wC0sJNCcBfsh7RJkLRQ=;
        b=iOl4wvM/gflYZn4MNaCgunUkf12J/Gfmgfwn4fBrZINfWum99Qs1+squ/b9R6LCBvkJ8M7
        WCs2rwbCBIZ6vzWkpxQcAg/kZYdRtriwwA2I4Q/vdFY9EmH/r0KXZpnYPA0zM1ugeHIy1s
        xqR+A2jSbvRfP2QfPxFZHPdMaYxRjM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kpl2jhqFYtBPH8hemOIlub9wC0sJNCcBfsh7RJkLRQ=;
        b=SegEJcOQ20Ku1P67FToIP20sJeTSt7+DFqh0f122yYH9LOYiWr8r7coVtW24i1Aqd93gw+
        KumwwDO5BNv6D4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16FD413EFD;
        Thu, 16 Dec 2021 23:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LFfJMW/Ru2GTWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:53:19 +0000
Subject: [PATCH 09/18] NFS: rename nfs_direct_IO and use as ->swap_rw
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
Date:   Fri, 17 Dec 2021 10:48:23 +1100
Message-ID: <163969850310.20885.11800649164871080105.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nfs_direct_IO() exists to support SWAP IO, but hasn't worked for a
while.  We now need a ->swap_rw function which behaves slightly
differently, returning zero for success rather than a byte count.

So modify nfs_direct_IO accordingly, rename it, and use it as the
->swap_rw function.

Note: it still won't work - that will be fixed in later patches.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/direct.c        |   23 ++++++++++-------------
 fs/nfs/file.c          |    5 +----
 include/linux/nfs_fs.h |    2 +-
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 9cff8709c80a..f1e169f3050a 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -152,28 +152,25 @@ nfs_direct_count_bytes(struct nfs_direct_req *dreq,
 }
 
 /**
- * nfs_direct_IO - NFS address space operation for direct I/O
+ * nfs_swap_rw - NFS address space operation for swap I/O
  * @iocb: target I/O control block
  * @iter: I/O buffer
  *
- * The presence of this routine in the address space ops vector means
- * the NFS client supports direct I/O. However, for most direct IO, we
- * shunt off direct read and write requests before the VFS gets them,
- * so this method is only ever called for swap.
+ * Perform IO to the swap-file.  This is much like direct IO.
  */
-ssize_t nfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct inode *inode = iocb->ki_filp->f_mapping->host;
-
-	/* we only support swap file calling nfs_direct_IO */
-	if (!IS_SWAPFILE(inode))
-		return 0;
+	ssize_t ret;
 
 	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
 
 	if (iov_iter_rw(iter) == READ)
-		return nfs_file_direct_read(iocb, iter);
-	return nfs_file_direct_write(iocb, iter);
+		ret = nfs_file_direct_read(iocb, iter);
+	else
+		ret = nfs_file_direct_write(iocb, iter);
+	if (ret < 0)
+		return ret;
+	return 0;
 }
 
 static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 60842b774b56..b620fe697158 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -493,10 +493,6 @@ static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	struct rpc_clnt *clnt = NFS_CLIENT(file->f_mapping->host);
 	struct inode *inode = file->f_mapping->host;
 
-	if (!file->f_mapping->a_ops->swap_rw)
-		/* Cannot support swap */
-		return -EINVAL;
-
 	spin_lock(&inode->i_lock);
 	blocks = inode->i_blocks;
 	isize = inode->i_size;
@@ -544,6 +540,7 @@ const struct address_space_operations nfs_file_aops = {
 	.error_remove_page = generic_error_remove_page,
 	.swap_activate = nfs_swap_activate,
 	.swap_deactivate = nfs_swap_deactivate,
+	.swap_rw = nfs_swap_rw,
 };
 
 /*
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 05f249f20f55..6329e6958718 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -510,7 +510,7 @@ static inline const struct cred *nfs_file_cred(struct file *file)
 /*
  * linux/fs/nfs/direct.c
  */
-extern ssize_t nfs_direct_IO(struct kiocb *, struct iov_iter *);
+extern int nfs_swap_rw(struct kiocb *, struct iov_iter *);
 extern ssize_t nfs_file_direct_read(struct kiocb *iocb,
 			struct iov_iter *iter);
 extern ssize_t nfs_file_direct_write(struct kiocb *iocb,


