Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEB04CEECE
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Mar 2022 00:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiCFXwb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 18:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiCFXw2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 18:52:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46775BE47;
        Sun,  6 Mar 2022 15:51:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7292F210FC;
        Sun,  6 Mar 2022 23:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646610689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jngo5Bo3wdO5HfY7AV8JY8HyvrejXGQE08t8AS2N2u8=;
        b=o76x26hRbop+hpVl403EUUo0cauluLPNSFM2EanEoHzXyzQfETFljvGNrE5Qah1yS8yw8n
        E05yj1qD5ql2TZwKU0exOLTo5sUI/Rj5st/x+0u8thYsgrjCMR75sZxk7F4Pqf7oQ8ePZD
        sj+yZUqAVFcFxTcmW5w6YDNjkfkGn+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646610689;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jngo5Bo3wdO5HfY7AV8JY8HyvrejXGQE08t8AS2N2u8=;
        b=qFIjiF7B1wCrUJ7fBCa5eULbdwu+RoMUAao0whugh1kKTS42VudmOSs9jqS3c84MQOTSgs
        5CofiHuu8HrRzxCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BFC7134CD;
        Sun,  6 Mar 2022 23:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3XryDf9IJWKBWgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 06 Mar 2022 23:51:27 +0000
Subject: [PATCH 10/10] VFS: Add FMODE_CAN_ODIRECT file flag
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Mar 2022 10:49:38 +1100
Message-ID: <164661057808.13454.4020322316652952783.stgit@noble.brown>
In-Reply-To: <164661047081.13454.11679636335222534920.stgit@noble.brown>
References: <164661047081.13454.11679636335222534920.stgit@noble.brown>
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

Currently various places test if direct IO is possible on a file by
checking for the existence of the direct_IO address space operation.
This is a poor choice, as the direct_IO operation may not be used - it is
only used if the generic_file_*_iter functions are called for direct IO
and some filesystems - particularly NFS - don't do this.

Instead, introduce a new f_mode flag: FMODE_CAN_ODIRECT and change the
various places to check this (avoiding pointer dereferences).
do_dentry_open() will set this flag if ->direct_IO is present, so
filesystems do not need to be changed.

NFS *is* changed, to set the flag explicitly and discard the direct_IO
entry in the address_space_operations for files.

Other filesystems which currently use noop_direct_IO could usefully be
changed to set this flag instead.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/block/loop.c |    4 ++--
 fs/fcntl.c           |    9 ++++-----
 fs/nfs/file.c        |    3 ++-
 fs/open.c            |    9 ++++-----
 fs/overlayfs/file.c  |   13 ++++---------
 include/linux/fs.h   |    3 +++
 6 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 19fe19eaa50e..59166c7bbcc0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -185,8 +185,8 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	 */
 	if (dio) {
 		if (queue_logical_block_size(lo->lo_queue) >= sb_bsize &&
-				!(lo->lo_offset & dio_align) &&
-				mapping->a_ops->direct_IO)
+		    !(lo->lo_offset & dio_align) &&
+		    (file->f_mode & FMODE_CAN_ODIRECT))
 			use_dio = true;
 		else
 			use_dio = false;
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9c6c6a3e2de5..11e665242a76 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -56,11 +56,10 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
 		   arg |= O_NONBLOCK;
 
 	/* Pipe packetized mode is controlled by O_DIRECT flag */
-	if (!S_ISFIFO(inode->i_mode) && (arg & O_DIRECT)) {
-		if (!filp->f_mapping || !filp->f_mapping->a_ops ||
-			!filp->f_mapping->a_ops->direct_IO)
-				return -EINVAL;
-	}
+	if (!S_ISFIFO(inode->i_mode) &&
+	    (arg & O_DIRECT) &&
+	    !(filp->f_mode & FMODE_CAN_ODIRECT))
+		return -EINVAL;
 
 	if (filp->f_op->check_flags)
 		error = filp->f_op->check_flags(arg);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 3dbef2c31567..9e2def045111 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -74,6 +74,8 @@ nfs_file_open(struct inode *inode, struct file *filp)
 		return res;
 
 	res = nfs_open(inode, filp);
+	if (res == 0)
+		filp->f_mode |= FMODE_CAN_ODIRECT;
 	return res;
 }
 
@@ -535,7 +537,6 @@ const struct address_space_operations nfs_file_aops = {
 	.write_end = nfs_write_end,
 	.invalidatepage = nfs_invalidate_page,
 	.releasepage = nfs_release_page,
-	.direct_IO = nfs_direct_IO,
 #ifdef CONFIG_MIGRATION
 	.migratepage = nfs_migrate_page,
 #endif
diff --git a/fs/open.c b/fs/open.c
index 9ff2f621b760..76ddf9014499 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -834,17 +834,16 @@ static int do_dentry_open(struct file *f,
 	if ((f->f_mode & FMODE_WRITE) &&
 	     likely(f->f_op->write || f->f_op->write_iter))
 		f->f_mode |= FMODE_CAN_WRITE;
+	if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
+		f->f_mode |= FMODE_CAN_ODIRECT;
 
 	f->f_write_hint = WRITE_LIFE_NOT_SET;
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
 
-	/* NB: we're sure to have correct a_ops only after f_op->open */
-	if (f->f_flags & O_DIRECT) {
-		if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
-			return -EINVAL;
-	}
+	if ((f->f_flags & O_DIRECT) && !(f->f_mode & FMODE_CAN_ODIRECT))
+		return -EINVAL;
 
 	/*
 	 * XXX: Huge page cache doesn't support writing yet. Drop all page
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index fa125feed0ff..9d69b4dbb8c4 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -82,11 +82,8 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 	if (((flags ^ file->f_flags) & O_APPEND) && IS_APPEND(inode))
 		return -EPERM;
 
-	if (flags & O_DIRECT) {
-		if (!file->f_mapping->a_ops ||
-		    !file->f_mapping->a_ops->direct_IO)
-			return -EINVAL;
-	}
+	if ((flags & O_DIRECT) && !(file->f_mode & FMODE_CAN_ODIRECT))
+		return -EINVAL;
 
 	if (file->f_op->check_flags) {
 		err = file->f_op->check_flags(flags);
@@ -306,8 +303,7 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	ret = -EINVAL;
 	if (iocb->ki_flags & IOCB_DIRECT &&
-	    (!real.file->f_mapping->a_ops ||
-	     !real.file->f_mapping->a_ops->direct_IO))
+	    !(real.file->f_mode & FMODE_CAN_ODIRECT))
 		goto out_fdput;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
@@ -367,8 +363,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	ret = -EINVAL;
 	if (iocb->ki_flags & IOCB_DIRECT &&
-	    (!real.file->f_mapping->a_ops ||
-	     !real.file->f_mapping->a_ops->direct_IO))
+	    !(real.file->f_mode & FMODE_CAN_ODIRECT))
 		goto out_fdput;
 
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 57e3b387cb17..c34c53267415 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -161,6 +161,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File is stream-like */
 #define FMODE_STREAM		((__force fmode_t)0x200000)
 
+/* File supports DIRECT IO */
+#define	FMODE_CAN_ODIRECT	((__force fmode_t)0x400000)
+
 /* File was opened by fanotify and shouldn't generate fanotify events */
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
 


