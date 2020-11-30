Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2A2C8FFB
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbgK3VZm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:25:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388485AbgK3VZm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 16:25:42 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ED032085B;
        Mon, 30 Nov 2020 21:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606771502;
        bh=6Wkoko3T6iKFrQnvzxYSsbpSNJuFjaoGL9TGAsIyUt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VVxz2627/JPVDgYy92aiiTfyqrsnHjFJg4DVe/Eokv1enRY3+KStxNszKrucRr3UO
         Oub6NExTWkn8Za+jyW/lk6wjUfUCb8Flse9C0j8Boc/rY3TCGDtNVTU+nHvawbvirX
         NOKiXhqGh/1gh78GGkP51Jba8QZc0gvC5Xxs+N48=
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/6] nfsd: allow filesystems to opt out of subtree checking
Date:   Mon, 30 Nov 2020 16:24:51 -0500
Message-Id: <20201130212455.254469-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130212455.254469-2-trondmy@kernel.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

When we start allowing NFS to be reexported, then we have some problems
when it comes to subtree checking. In principle, we could allow it, but
it would mean encoding parent info in the filehandles and there may not
be enough space for that in a NFSv3 filehandle.

To enforce this at export upcall time, we add a new export_ops flag
that declares the filesystem ineligible for subtree checking.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 Documentation/filesystems/nfs/exporting.rst | 14 +++++++++++++-
 fs/nfs/export.c                             |  2 +-
 fs/nfsd/export.c                            |  6 ++++++
 include/linux/exportfs.h                    |  1 +
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index a3e3805833d1..960be64446cb 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -176,7 +176,7 @@ contains a "flags" field that allows the filesystem to communicate to nfsd
 that it may want to do things differently when dealing with it. The
 following flags are defined:
 
-  EXPORT_OP_NOWCC
+  EXPORT_OP_NOWCC - disable NFSv3 WCC attributes on this filesystem
     RFC 1813 recommends that servers always send weak cache consistency
     (WCC) data to the client after each operation. The server should
     atomically collect attributes about the inode, do an operation on it,
@@ -190,3 +190,15 @@ following flags are defined:
     this on filesystems that have an expensive ->getattr inode operation,
     or when atomicity between pre and post operation attribute collection
     is impossible to guarantee.
+
+  EXPORT_OP_NOSUBTREECHK - disallow subtree checking on this fs
+    Many NFS operations deal with filehandles, which the server must then
+    vet to ensure that they live inside of an exported tree. When the
+    export consists of an entire filesystem, this is trivial. nfsd can just
+    ensure that the filehandle live on the filesystem. When only part of a
+    filesystem is exported however, then nfsd must walk the ancestors of the
+    inode to ensure that it's within an exported subtree. This is an
+    expensive operation and not all filesystems can support it properly.
+    This flag exempts the filesystem from subtree checking and causes
+    exportfs to get back an error if it tries to enable subtree checking
+    on it.
diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 8f4c528865c5..b9ba306bf912 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -171,5 +171,5 @@ const struct export_operations nfs_export_ops = {
 	.encode_fh = nfs_encode_fh,
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
-	.flags = EXPORT_OP_NOWCC,
+	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK,
 };
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 21e404e7cb68..81e7bb12aca6 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -408,6 +408,12 @@ static int check_export(struct inode *inode, int *flags, unsigned char *uuid)
 		return -EINVAL;
 	}
 
+	if (inode->i_sb->s_export_op->flags & EXPORT_OP_NOSUBTREECHK &&
+	    !(*flags & NFSEXP_NOSUBTREECHECK)) {
+		dprintk("%s: %s does not support subtree checking!\n",
+			__func__, inode->i_sb->s_type->name);
+		return -EINVAL;
+	}
 	return 0;
 
 }
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index e7de0103a32e..2fcbab0f6b61 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -214,6 +214,7 @@ struct export_operations {
 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
 			     int nr_iomaps, struct iattr *iattr);
 #define	EXPORT_OP_NOWCC		(0x1)	/* Don't collect wcc data for NFSv3 replies */
+#define	EXPORT_OP_NOSUBTREECHK	(0x2)	/* Subtree checking is not supported! */
 	unsigned long	flags;
 };
 
-- 
2.28.0

