Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8568C124F8D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 18:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfLRRkC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 12:40:02 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40896 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLRRkC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 12:40:02 -0500
Received: by mail-yw1-f67.google.com with SMTP id i126so1085336ywe.7
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2019 09:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMkgV2G9QgOA41OrQho9E7HHPfwqgw18i9MVPxRyowI=;
        b=G/FTGstxJh0vTG/zBoxb6VvG7A+kZidzRFmWfOmnIEhNN9h81BVAo6nuuTu8Wp90VG
         C6c+MPblVRyrjZWk496Mh14t01O5FhIRShvxKRha/RB77HGHuRVcGgYEEnQpACs4h8lN
         wjMcLSlQ2WjdJMc0zGPUu/p3JKVGkyQuo1J+7Ee5lmhYBV6qi9m+L+Wp6bguDt9xs0zF
         he3K70NHNrUHL0O1GWc0Iyrozg7yGprW8jcxcdHvXyOewnJj+X52gt8MvdVWHkiMDfeI
         Un4dcjdktI6sobvjt5EH0adAWxFo8GCDqzFFzuoIA1FHu5Bj0Sz7GA1GNC6Nthl7INJD
         KRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMkgV2G9QgOA41OrQho9E7HHPfwqgw18i9MVPxRyowI=;
        b=loiqkaqcU9/82aEiMIOWDth3IcTTXR+3Qj6Ci5fUv07qzWj8ateyHBvwYPt/Xg4xGR
         a9Mv2eMdavJ/b2eYz1omdc70wA3ufQ19Puo5NtoRfhBraE47QtaKiI+ASoCHX4a9Itu7
         NFmu5gdU6zTXZ1FUuCReazBks9a8DG2Wvo+x8iDtsaLqVk8qSHoNvucl+SW4Lo990tPr
         WT8LE8MtPGWMaeU22ku/7JQ/j//HKNUpvtJIBSzFnZJSe3JvTQjGzkNeXAypW6fEJn5M
         8Q2BHSo8KNp6CLi9etm6al48xkGpnVSKSzqyunO2m6PEr3ANy8Hr/tPXxPhyNzKdn4EW
         kWsQ==
X-Gm-Message-State: APjAAAXTkjSRk5kPTUztS6T2Ru26bIrO9tXNwqkCacv5M3GRy57aSYT7
        fAXSX2N16T8I5YhRxRjyjw==
X-Google-Smtp-Source: APXvYqyDRFd/P17Z+l5lwOZ5Kel3LN4NTB0yp2KHH2wjXE2kUffpUMJX6y5wVtjynX9sPp8m50zlMA==
X-Received: by 2002:a81:a6d7:: with SMTP id d206mr3129285ywh.324.1576690800856;
        Wed, 18 Dec 2019 09:40:00 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id a189sm1272144ywh.92.2019.12.18.09.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:40:00 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Clone should commit src file metadata too
Date:   Wed, 18 Dec 2019 12:37:52 -0500
Message-Id: <20191218173752.81645-1-trond.myklebust@hammerspace.com>
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
 fs/nfsd/vfs.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f0bca0e87d0c..bc7f330c2a79 100644
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
@@ -536,7 +542,10 @@ __be32 nfsd4_clone_file_range(struct file *src, u64 src_pos, struct file *dst,
 		return nfserrno(-EINVAL);
 	if (sync) {
 		loff_t dst_end = count ? dst_pos + count - 1 : LLONG_MAX;
-		int status = vfs_fsync_range(dst, dst_pos, dst_end, 0);
+		int status = commit_inode_metadata(file_inode(src));
+
+		if (!status)
+			status = vfs_fsync_range(dst, dst_pos, dst_end, 0);
 		if (status < 0)
 			return nfserrno(status);
 	}
-- 
2.23.0

