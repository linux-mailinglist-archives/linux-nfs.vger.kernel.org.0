Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB6C125280
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 20:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfLRT7d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 14:59:33 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36423 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfLRT7d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 14:59:33 -0500
Received: by mail-yb1-f196.google.com with SMTP id i72so1265554ybg.3
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2019 11:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIf6rqwLEA+7NFOqofq6u1wV/J7xmGPdh1NpRCIQcrc=;
        b=u0TiZdrIxntQ6QAWg4E4xqV4M/tOD8ogECmRweyJLMj0bX02ul/JLE3eaq37diz/kj
         y2Vqkf26rldmENC1rcinCfVJgYW+wDGmTjQ0L4U8Eaj89hLJE8oXxyloLWdDUytWDqJ6
         OClppxmUnZ8mMWe6Ly3Jp52KdbPsI2DFRac5eheVDv6MuEJ9cqMO0K9BkSyyZdeg4wVj
         /AEI6ZJJlmZXPDLdYs9i9OmPkgy5YZ/UKpv8v7zWjtmhpYVXxOochhEwAap6QXu6GXKR
         w7HEHcCYLrip1YEj2kqVYUs0WH8fdZ3K6wXCHRUkyttUvWY6BA0f1aqiy1qwDvyPjXqE
         xppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIf6rqwLEA+7NFOqofq6u1wV/J7xmGPdh1NpRCIQcrc=;
        b=ftPMcPH7LbkOsEIGoBd5xAt2JjxXnp6A+Omc4g1W4SaEDd6uE6GNy0yA3Zmx37qwK9
         HeB0y/IW1BODgW9GiqO/JDTGbsy/nSGt+slfQq80B3yxF+BPVSrW/UEu8YaqksCcxUZm
         XmGhyhRZPb7FqFFrTQgdaMRKdCyBxWIq3UHsuQ4onnHyCOY+tnz1nNe55hZxGYPspY9l
         uqRqVaDdW4t/HrvHDe5QTjrSF5QUvGfeCoMrt7BjSi3X5Ww5Tn9GyAWnqOs7NnzuckNr
         9DH8KwTZwhpQi83pC0ZQQ+ftqgUtVKV7UBWUYchYkgr+zsekqYlieLgQXVawYia0Ck+V
         RUAw==
X-Gm-Message-State: APjAAAUKZ6EMSwos1xTgr10qpHpAaB9CRlxbrkuUd44lABnQ3ihdRjuh
        IigpgF/Qn/2w54gQhunntA==
X-Google-Smtp-Source: APXvYqzwXEASyYhI5YRYdh0qu+ZzSI3oeDdh+/1ubh5tbEgMdWRupWuVuEBsh/BSPD2101MWW+JMOw==
X-Received: by 2002:a25:e054:: with SMTP id x81mr3392166ybg.168.1576699172072;
        Wed, 18 Dec 2019 11:59:32 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l5sm1329275ywd.48.2019.12.18.11.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 11:59:31 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: Clone should commit src file metadata too
Date:   Wed, 18 Dec 2019 14:57:23 -0500
Message-Id: <20191218195723.395277-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

vfs_clone_file_range() can modify the metadata on the source file too,
so we need to commit that to stable storage as well.

Reported-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---

 v2: Reverse order of vfs_fsync_range()/commit_inode_metadata() for
     efficiency as suggested by Dave Chinner.

 fs/nfsd/vfs.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f0bca0e87d0c..82cf80dde5c7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -280,19 +280,25 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
  * Commit metadata changes to stable storage.
  */
 static int
-commit_metadata(struct svc_fh *fhp)
+commit_inode_metadata(struct inode *inode)
 {
-	struct inode *inode = d_inode(fhp->fh_dentry);
 	const struct export_operations *export_ops = inode->i_sb->s_export_op;
 
-	if (!EX_ISSYNC(fhp->fh_export))
-		return 0;
-
 	if (export_ops->commit_metadata)
 		return export_ops->commit_metadata(inode);
 	return sync_inode_metadata(inode, 1);
 }
 
+static int
+commit_metadata(struct svc_fh *fhp)
+{
+	struct inode *inode = d_inode(fhp->fh_dentry);
+
+	if (!EX_ISSYNC(fhp->fh_export))
+		return 0;
+	return commit_inode_metadata(inode);
+}
+
 /*
  * Go over the attributes and take care of the small differences between
  * NFS semantics and what Linux expects.
@@ -537,6 +543,9 @@ __be32 nfsd4_clone_file_range(struct file *src, u64 src_pos, struct file *dst,
 	if (sync) {
 		loff_t dst_end = count ? dst_pos + count - 1 : LLONG_MAX;
 		int status = vfs_fsync_range(dst, dst_pos, dst_end, 0);
+
+		if (!status)
+			status = commit_inode_metadata(file_inode(src));
 		if (status < 0)
 			return nfserrno(status);
 	}
-- 
2.23.0

