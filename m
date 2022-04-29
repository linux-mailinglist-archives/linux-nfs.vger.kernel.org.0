Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F3F513FB0
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 02:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352954AbiD2AsJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 20:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbiD2AsJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 20:48:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3596BB902;
        Thu, 28 Apr 2022 17:44:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B2C411F37F;
        Fri, 29 Apr 2022 00:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651193091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iDTLraYqnWApa1mXlMLLgzsQSZO/JsdcUgftlr7aovM=;
        b=bXzdo1Li8rr31MrGP07OcLcXDfd+rqubbWEqzYmjFEDlXdbtGc0KLHhGyJjrU0cnYqWm40
        IqBCEwDGvwIoA/HnKTxK7aOaSLe1o1TNZc0f5qPWLHCDXC9s1sriGavJJP/8mMHSq77gDx
        9qLBQP+jKfuTloZX4Igjg5LrB92+6Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651193091;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iDTLraYqnWApa1mXlMLLgzsQSZO/JsdcUgftlr7aovM=;
        b=1wMQN6a64l7rZ/v4UXE8U90xh7OGxjydYxyu1kmSUBId/NHpwcPt6Mw4IPLABKipjSx/M9
        35I2hF4rrmhDshCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A17E13491;
        Fri, 29 Apr 2022 00:44:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id blhJFgE1a2IzSgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 29 Apr 2022 00:44:49 +0000
Subject: [PATCH 2/2] NFS: rename nfs_direct_IO and use as ->swap_rw
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:43:34 +1000
Message-ID: <165119301493.15698.7491285551903597618.stgit@noble.brown>
In-Reply-To: <165119280115.15698.2629172320052218921.stgit@noble.brown>
References: <165119280115.15698.2629172320052218921.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be> (on Renesas RSK+RZA1 with 32 MiB of SDRAM)
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/direct.c        |   23 ++++++++++-------------
 fs/nfs/file.c          |    5 +----
 include/linux/nfs_fs.h |    2 +-
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 11c566d8769f..4eb2a8380a28 100644
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
-		return nfs_file_direct_read(iocb, iter, true);
-	return nfs_file_direct_write(iocb, iter, true);
+		ret = nfs_file_direct_read(iocb, iter, true);
+	else
+		ret = nfs_file_direct_write(iocb, iter, true);
+	if (ret < 0)
+		return ret;
+	return 0;
 }
 
 static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index e1d10a3e086a..bfb4b707b07e 100644
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
@@ -550,6 +546,7 @@ const struct address_space_operations nfs_file_aops = {
 	.error_remove_page = generic_error_remove_page,
 	.swap_activate = nfs_swap_activate,
 	.swap_deactivate = nfs_swap_deactivate,
+	.swap_rw = nfs_swap_rw,
 };
 
 /*
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index b48b9259e02c..fd5543486a3f 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -507,7 +507,7 @@ static inline const struct cred *nfs_file_cred(struct file *file)
 /*
  * linux/fs/nfs/direct.c
  */
-extern ssize_t nfs_direct_IO(struct kiocb *, struct iov_iter *);
+int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter);
 ssize_t nfs_file_direct_read(struct kiocb *iocb,
 			     struct iov_iter *iter, bool swap);
 ssize_t nfs_file_direct_write(struct kiocb *iocb,


