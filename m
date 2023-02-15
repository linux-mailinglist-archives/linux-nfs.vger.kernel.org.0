Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3885A697B31
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Feb 2023 12:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjBOLyQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Feb 2023 06:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjBOLyM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Feb 2023 06:54:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70A737716
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 03:53:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DCB8B81C17
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 11:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7905C433EF;
        Wed, 15 Feb 2023 11:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676462036;
        bh=7N0L1UWJLDh3XsG82dyGSQb//qbqJez84P23holi2/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=s7laeeVD6iMkLG67cGtqI6qvYfmsKX6ML9tKmq+fe/EwAzGVni96rltVpfhZMp1H7
         hlb94eAoSfYWMYW1UsHVQPn/K7ti9dV6MZ6Ws1kcV1caDaqplnblpPg8DoXOxi6LPD
         9XHyihHA+Td4rLSsRfm+Z+VDR51EhxPrEAVIM0nRIsm9UJ30FFaJpmWItIdhZmfbcT
         lskZqV6/QOzxvUmJs8PAzRvhDubq2uQ8suF2Oo9L6E8uB9u2ursOj/I2IsVOdYoaB1
         SXHLsJHtzmPtPwqP+Zppg0bJ7qbIQcGYehX9jq0v4/P2nIN3vHPIDW//8OQl8gO/BZ
         ZHgKyrI1Xx5ug==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: allow reaping files still under writeback
Date:   Wed, 15 Feb 2023 06:53:54 -0500
Message-Id: <20230215115354.14907-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On most filesystems, there is no reason to delay reaping an nfsd_file
just because its underlying inode is still under writeback. nfsd just
relies on client activity or the local flusher threads to do writeback.

The main exception is NFS, which flushes all of its dirty data on last
close. Add a new EXPORT_OP_FLUSH_ON_CLOSE flag to allow filesystems to
signal that they do this, and only skip closing files under writeback on
such filesystems.

Also, remove a redundant NULL file pointer check in
nfsd_file_check_writeback, and clean up nfs's export op flag
definitions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/export.c          |  9 ++++++---
 fs/nfsd/filecache.c      | 11 ++++++++++-
 include/linux/exportfs.h |  1 +
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 0a5ee1754d50..102a454e27c9 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -156,7 +156,10 @@ const struct export_operations nfs_export_ops = {
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
 	.fetch_iversion = nfs_fetch_iversion,
-	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
-		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
-		EXPORT_OP_NOATOMIC_ATTR,
+	.flags = EXPORT_OP_NOWCC		|
+		 EXPORT_OP_NOSUBTREECHK 	|
+		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
+		 EXPORT_OP_REMOTE_FS		|
+		 EXPORT_OP_NOATOMIC_ATTR	|
+		 EXPORT_OP_FLUSH_ON_CLOSE,
 };
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e6617431df7c..98e1ab013ac0 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -302,8 +302,17 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 	struct file *file = nf->nf_file;
 	struct address_space *mapping;
 
-	if (!file || !(file->f_mode & FMODE_WRITE))
+	/* File not open for write? */
+	if (!(file->f_mode & FMODE_WRITE))
 		return false;
+
+	/*
+	 * Some filesystems (e.g. NFS) flush all dirty data on close.
+	 * On others, there is no need to wait for writeback.
+	 */
+	if (!(file_inode(file)->i_sb->s_export_op->flags & EXPORT_OP_FLUSH_ON_CLOSE))
+		return false;
+
 	mapping = file->f_mapping;
 	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index fe848901fcc3..218fc5c54e90 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -221,6 +221,7 @@ struct export_operations {
 #define EXPORT_OP_NOATOMIC_ATTR		(0x10) /* Filesystem cannot supply
 						  atomic attribute updates
 						*/
+#define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 	unsigned long	flags;
 };
 
-- 
2.39.1

