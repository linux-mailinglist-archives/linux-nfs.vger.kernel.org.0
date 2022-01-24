Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2B54977E1
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbiAXDx0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:53:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56942 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbiAXDx0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:53:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53FD221997;
        Mon, 24 Jan 2022 03:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qDluxkEK7zAySAVPGR4jtj1uxF720K50iXEZFn4nZw=;
        b=eRwoWwRXnjPsBO3djnZMjJjfXy7qs9WlcJ/U05UJ1Htu0k9+tgoiUkWgFyIO6B29ShV8Yc
        szunxTaUFtRfKqDvTWQ1CP0bwDLnhzYjrT2DHHgKivyIQXwYAw+bq1VYPIavB6tidNPxQL
        Q6Kgu0EqJEJ3nwRSiUDhQ6OnJfKo13c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996405;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qDluxkEK7zAySAVPGR4jtj1uxF720K50iXEZFn4nZw=;
        b=H1ZRzb7v9Zn/6SXSWIyscE0WL4iA877N13xXsuRAChNlPO7SX2B7wqhNzPSC5fHJHx4tGG
        0dT3+we+sNrn/2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BDE613305;
        Mon, 24 Jan 2022 03:53:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xu0DBrAi7mGsRQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:53:20 +0000
Subject: [PATCH 13/23] NFS: rename nfs_direct_IO and use as ->swap_rw
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
Message-ID: <164299611281.26253.6497855219394305186.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
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
index eabfdab543c8..b929dd5b0c3a 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -153,28 +153,25 @@ nfs_direct_count_bytes(struct nfs_direct_req *dreq,
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
index 4d4750738aeb..91ff9ed05b06 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -489,10 +489,6 @@ static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	struct rpc_clnt *clnt = NFS_CLIENT(file->f_mapping->host);
 	struct inode *inode = file->f_mapping->host;
 
-	if (!file->f_mapping->a_ops->swap_rw)
-		/* Cannot support swap */
-		return -EINVAL;
-
 	spin_lock(&inode->i_lock);
 	blocks = inode->i_blocks;
 	isize = inode->i_size;
@@ -540,6 +536,7 @@ const struct address_space_operations nfs_file_aops = {
 	.error_remove_page = generic_error_remove_page,
 	.swap_activate = nfs_swap_activate,
 	.swap_deactivate = nfs_swap_deactivate,
+	.swap_rw = nfs_swap_rw,
 };
 
 /*
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 00835bacd236..29a5e579f26f 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -509,7 +509,7 @@ static inline const struct cred *nfs_file_cred(struct file *file)
 /*
  * linux/fs/nfs/direct.c
  */
-extern ssize_t nfs_direct_IO(struct kiocb *, struct iov_iter *);
+extern int nfs_swap_rw(struct kiocb *, struct iov_iter *);
 extern ssize_t nfs_file_direct_read(struct kiocb *iocb,
 			struct iov_iter *iter);
 extern ssize_t nfs_file_direct_write(struct kiocb *iocb,


