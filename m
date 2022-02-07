Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC604AB484
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 07:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243997AbiBGGPt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 01:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352085AbiBGEtC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Feb 2022 23:49:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC90C043181;
        Sun,  6 Feb 2022 20:49:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 136B61F37E;
        Mon,  7 Feb 2022 04:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644209341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwJWsWKAHR1izFzYRPVHxF5KD02ioN/att4BQUXt4ok=;
        b=sz1wvonUJnZOIzGF+QuZIo3wNsZGbbukf6KwBl8JLi/mdJzgN/XeIp0TF7n8p/LI9esb0m
        EY0JicYakn6JS/QO7pzsdsGFM/oCJlwBltgIhvZUiPS3RZxLEy4KFVi1LKxYoP3wYcROhf
        KhBa9TRRcd11eO9EB7rpX2jA40FKh3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644209341;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwJWsWKAHR1izFzYRPVHxF5KD02ioN/att4BQUXt4ok=;
        b=IbYQw1WEfmd3EdeiUL3S5rCqI3og24Anje/7B22P1GrYriZCFWzQrYiQlyfnM17v053Lbd
        yARR1Vb5UxkDklBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31A8A1330E;
        Mon,  7 Feb 2022 04:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WPFKOLmkAGKUNQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 07 Feb 2022 04:48:57 +0000
Subject: [PATCH 19/21] NFS: rename nfs_direct_IO and use as ->swap_rw
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
Message-ID: <164420916124.29374.1697475326428179041.stgit@noble.brown>
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

The nfs_direct_IO() exists to support SWAP IO, but hasn't worked for a
while.  We now need a ->swap_rw function which behaves slightly
differently, returning zero for success rather than a byte count.

So modify nfs_direct_IO accordingly, rename it, and use it as the
->swap_rw function.

Note: it still won't work - that will be fixed in later patches.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index 81fe996c6272..7d42117b210d 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -490,10 +490,6 @@ static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	struct rpc_clnt *clnt = NFS_CLIENT(inode);
 	struct nfs_client *cl = NFS_SERVER(inode)->nfs_client;
 
-	if (!file->f_mapping->a_ops->swap_rw)
-		/* Cannot support swap */
-		return -EINVAL;
-
 	spin_lock(&inode->i_lock);
 	blocks = inode->i_blocks;
 	isize = inode->i_size;
@@ -549,6 +545,7 @@ const struct address_space_operations nfs_file_aops = {
 	.error_remove_page = generic_error_remove_page,
 	.swap_activate = nfs_swap_activate,
 	.swap_deactivate = nfs_swap_deactivate,
+	.swap_rw = nfs_swap_rw,
 };
 
 /*
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index ff8b3820409c..58807406aff6 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -506,7 +506,7 @@ static inline const struct cred *nfs_file_cred(struct file *file)
 /*
  * linux/fs/nfs/direct.c
  */
-extern ssize_t nfs_direct_IO(struct kiocb *, struct iov_iter *);
+int nfs_swap_rw(struct kiocb *, struct iov_iter *);
 extern ssize_t nfs_file_direct_read(struct kiocb *iocb,
 			struct iov_iter *iter);
 extern ssize_t nfs_file_direct_write(struct kiocb *iocb,


