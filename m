Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008122C907B
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 23:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgK3WEF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 17:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgK3WEE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 17:04:04 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74284C0613D3
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:03:24 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id e60so9472575qtd.3
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SX9w/B7ZmUEuS3n1/Q9UVgaFC7LsMsGrCACvmakKut0=;
        b=hdkW4bQLIONH2Bp5gXSvpXQqgK2vMoanFy65AqK/wW8WOBpBoNqTUraEHYrPb3/hig
         oFhKYtOvXrbtQ2V+w0Hd93U7OBJJnE00U1Xhd+QXJ68McspcXK/cc7eov3xfsCSamiSp
         yEF4Ujo5/wLhuObD2Pswwc1bAYw7ezgJtGcDPTUAgt+okeNMf7EMz4w9m5jdHEnF/rX5
         3qYrS66AVfz3WBb1UIBMgwu5uOmF58kUmSwil0SnES8u0+miN3zUB461ZquQqy/v7cy3
         qt768dq9eWvRgdlHs3c2ThjIGFocFOdFCIAlHHQMNai6pabFsRbuwVtknCjxjl5wieKk
         aUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SX9w/B7ZmUEuS3n1/Q9UVgaFC7LsMsGrCACvmakKut0=;
        b=TWT2NFqSDoIJR8Wn3as2YTDU3NWjIOBvlQi9o6xF+Ij6u00XFQq5DVIifnHR2Hbh6m
         c1udihzMxgoIpPtx/51rWw480ojjHptJ80umQcVq02hC3xNy3HcQRVRcFhlS1yPBq7N6
         Y9jPql+XZxA2UQ/6suEFk6gkhDEJJah6YlSYIiRwjNYz9hHMSjkka1+BA8mEqHZ6hRu6
         E+/mBAa6kfzM2nyDDRZqSMlK5JDyiPqHeL5vIqNviCRddPUAjLvuiY5DVCJjdX5i6T0O
         x50Gv1mHeC6INs9YEi4oIYBWHWCZzCUP7hKv7p8zbkjrgMbZZC8f8i13gEe3P0SkQXv8
         5Uqw==
X-Gm-Message-State: AOAM532TXnzAEU87eRUicwcfpeFFNtINnkqzUHSJsAppHiLa7Z8KpkTv
        TWweTu5P8khdgLqg5JOnocOKw5ki/w==
X-Google-Smtp-Source: ABdhPJySYt0uazG9/SFDL9zz6y2XWvJwZyvCht+1T4NUVkPS3v/HAMAC5d7HSDG1IriRVcyZ+4LLvg==
X-Received: by 2002:ac8:6ed9:: with SMTP id f25mr10015149qtv.227.1606773803605;
        Mon, 30 Nov 2020 14:03:23 -0800 (PST)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id q62sm17642886qkf.86.2020.11.30.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:03:22 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/6] nfsd: allow filesystems to opt out of subtree checking
Date:   Mon, 30 Nov 2020 17:03:15 -0500
Message-Id: <20201130220319.501064-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130220319.501064-2-trond.myklebust@hammerspace.com>
References: <20201130220319.501064-1-trond.myklebust@hammerspace.com>
 <20201130220319.501064-2-trond.myklebust@hammerspace.com>
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
 Documentation/filesystems/nfs/exporting.rst | 12 ++++++++++++
 fs/nfs/export.c                             |  2 +-
 fs/nfsd/export.c                            |  6 ++++++
 include/linux/exportfs.h                    |  1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index cbe542ad5233..960be64446cb 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
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

