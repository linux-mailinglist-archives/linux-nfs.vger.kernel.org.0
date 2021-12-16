Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB64780E6
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhLPXxQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:53:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47146 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhLPXxO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:53:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9C16F210F3;
        Thu, 16 Dec 2021 23:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSBaI+WJMPR2UaOVoOuh6lltzGMEJfvZoUMkmtYG78A=;
        b=ISsxbwes6/ZB/yDvYIHG7lMdDFOR58vto/MC+nAnO0T0IEStc9DU+lw7/Zrr0uFsIo0a/c
        ZYMhmIKSSywGCGIkj1abWRi7ezaABsnRXOW4aCfUGsJn0dLz5WlsjUDqnUe0EYz+gu5f0B
        jjRTXQtcyc/6vssYAAzRWl6awaswjHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698793;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSBaI+WJMPR2UaOVoOuh6lltzGMEJfvZoUMkmtYG78A=;
        b=A4J6D6XG/va34XBqqJDjRBVuozm+NertzXGyBIO4/iqbF1cRjdXFKRayPv7sIlEhRX0bqA
        Ij9DczSGyXjcZbCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A54B13EFD;
        Thu, 16 Dec 2021 23:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2/YkFWbRu2GJWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:53:10 +0000
Subject: [PATCH 08/18] MM: Add AS_CAN_DIO mapping flag
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
Message-ID: <163969850302.20885.17124747377211907111.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently various places test if direct IO is possible on a file by
checking for the existence of the direct_IO address space operation.
This is a poor choice, as the direct_IO operation may not be used - it is
only used if the generic_file_*_iter functions are called for direct IO
and some filesystems - particularly NFS - don't do this.

Instead, introduce a new mapping flag: AS_CAN_DIO and change the various
places to check this (avoiding a pointer dereference).
unlock_new_inode() will set this flag if ->direct_IO is present, so
filesystems do not need to be changed.

NFS *is* changed, to set the flag explicitly and discard the direct_IO
entry in the address_space_operations for files.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/block/loop.c    |    4 ++--
 fs/fcntl.c              |    5 +++--
 fs/inode.c              |    3 +++
 fs/nfs/file.c           |    1 -
 fs/nfs/inode.c          |    1 +
 fs/open.c               |    2 +-
 fs/overlayfs/file.c     |   10 ++++------
 include/linux/fs.h      |    2 +-
 include/linux/pagemap.h |    3 ++-
 9 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c3a36cfaa855..ab4dee6c0fc3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -184,8 +184,8 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	 */
 	if (dio) {
 		if (queue_logical_block_size(lo->lo_queue) >= sb_bsize &&
-				!(lo->lo_offset & dio_align) &&
-				mapping->a_ops->direct_IO)
+		    !(lo->lo_offset & dio_align) &&
+		    test_bit(AS_CAN_DIO, &mapping->flags))
 			use_dio = true;
 		else
 			use_dio = false;
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9c6c6a3e2de5..fcbf2dc44273 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -26,6 +26,7 @@
 #include <linux/memfd.h>
 #include <linux/compat.h>
 #include <linux/mount.h>
+#include <linux/pagemap.h>
 
 #include <linux/poll.h>
 #include <asm/siginfo.h>
@@ -57,9 +58,9 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
 
 	/* Pipe packetized mode is controlled by O_DIRECT flag */
 	if (!S_ISFIFO(inode->i_mode) && (arg & O_DIRECT)) {
-		if (!filp->f_mapping || !filp->f_mapping->a_ops ||
-			!filp->f_mapping->a_ops->direct_IO)
-				return -EINVAL;
+		if (!filp->f_mapping ||
+		    !test_bit(AS_CAN_DIO, &filp->f_mapping->flags))
+			return -EINVAL;
 	}
 
 	if (filp->f_op->check_flags)
diff --git a/fs/inode.c b/fs/inode.c
index 6b80a51129d5..bae65ccecdb1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1008,6 +1008,9 @@ EXPORT_SYMBOL(lockdep_annotate_inode_mutex_key);
 void unlock_new_inode(struct inode *inode)
 {
 	lockdep_annotate_inode_mutex_key(inode);
+	if (inode->i_mapping->a_ops &&
+	    inode->i_mapping->a_ops->direct_IO)
+		set_bit(AS_CAN_DIO, &inode->i_mapping->flags);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW & ~I_CREATING;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 0d33c95eefb6..60842b774b56 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -536,7 +536,6 @@ const struct address_space_operations nfs_file_aops = {
 	.write_end = nfs_write_end,
 	.invalidatepage = nfs_invalidate_page,
 	.releasepage = nfs_release_page,
-	.direct_IO = nfs_direct_IO,
 #ifdef CONFIG_MIGRATION
 	.migratepage = nfs_migrate_page,
 #endif
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index fda530d5e764..e9d1097170b1 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -496,6 +496,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		if (S_ISREG(inode->i_mode)) {
 			inode->i_fop = NFS_SB(sb)->nfs_client->rpc_ops->file_ops;
 			inode->i_data.a_ops = &nfs_file_aops;
+			set_bit(AS_CAN_DIO, &inode->i_data.flags);
 			nfs_inode_init_regular(nfsi);
 		} else if (S_ISDIR(inode->i_mode)) {
 			inode->i_op = NFS_SB(sb)->nfs_client->rpc_ops->dir_inode_ops;
diff --git a/fs/open.c b/fs/open.c
index f732fb94600c..ff58874acd10 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -840,7 +840,7 @@ static int do_dentry_open(struct file *f,
 
 	/* NB: we're sure to have correct a_ops only after f_op->open */
 	if (f->f_flags & O_DIRECT) {
-		if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
+		if (!test_bit(AS_CAN_DIO, &f->f_mapping->flags))
 			return -EINVAL;
 	}
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index fa125feed0ff..21754edf5b62 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/pagemap.h>
 #include "overlayfs.h"
 
 struct ovl_aio_req {
@@ -83,8 +84,7 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 		return -EPERM;
 
 	if (flags & O_DIRECT) {
-		if (!file->f_mapping->a_ops ||
-		    !file->f_mapping->a_ops->direct_IO)
+		if (!test_bit(AS_CAN_DIO, &file->f_mapping->flags))
 			return -EINVAL;
 	}
 
@@ -306,8 +306,7 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	ret = -EINVAL;
 	if (iocb->ki_flags & IOCB_DIRECT &&
-	    (!real.file->f_mapping->a_ops ||
-	     !real.file->f_mapping->a_ops->direct_IO))
+	    !test_bit(AS_CAN_DIO, &real.file->f_mapping->flags))
 		goto out_fdput;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
@@ -367,8 +366,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	ret = -EINVAL;
 	if (iocb->ki_flags & IOCB_DIRECT &&
-	    (!real.file->f_mapping->a_ops ||
-	     !real.file->f_mapping->a_ops->direct_IO))
+	    !test_bit(AS_CAN_DIO, &real.file->f_mapping->flags))
 		goto out_fdput;
 
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index deaaf359cc49..1e954756b093 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -448,7 +448,7 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
  * @nrpages: Number of page entries, protected by the i_pages lock.
  * @writeback_index: Writeback starts here.
  * @a_ops: Methods.
- * @flags: Error bits and flags (AS_*).
+ * @flags: Error bits and flags (AS_*). (enum mapping_flags)
  * @wb_err: The most recent error which has occurred.
  * @private_lock: For use by the owner of the address_space.
  * @private_list: For use by the owner of the address_space.
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 605246452305..ceb599b6ba8b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -81,10 +81,11 @@ enum mapping_flags {
 	AS_ENOSPC	= 1,	/* ENOSPC on async write */
 	AS_MM_ALL_LOCKS	= 2,	/* under mm_take_all_locks() */
 	AS_UNEVICTABLE	= 3,	/* e.g., ramdisk, SHM_LOCK */
-	AS_EXITING	= 4, 	/* final truncate in progress */
+	AS_EXITING	= 4,	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
 	AS_LARGE_FOLIO_SUPPORT = 6,
+	AS_CAN_DIO	= 7,	/* DIO is supported */
 };
 
 /**


