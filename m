Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273C58BB89
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2019 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfHMOaQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Aug 2019 10:30:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32785 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfHMOaQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Aug 2019 10:30:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so20302901otl.0
        for <linux-nfs@vger.kernel.org>; Tue, 13 Aug 2019 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dodPeBHiTvXQpNHuEhbNlONL9Drrpvmy/8YMtOGC/4E=;
        b=ORA9DuNIXC3zPuUm1/0HhV3KegzLJGzA2q0tprr3zARJ4vWYGMrEcA7ozf3C3GmA+5
         vxBbaCrlh2dd4yykKOK2/YO89S3e5QUjgxN9uf1EWj2xy4Mo281M2dYSxe5abyLr5g1m
         uV2jG1YiIt81/yLwPg1M+UHnsSzV6rLuAqGiy8BEpNi/IJHZWwRDu5bv4ehRRigBco33
         bHpNkUSjD4fept7dmEODnTsOcaqG3Lsg/DD/ZYGKjG2/2KT7s4u8YXMdyb7Yjq2XJuD3
         62qbANrJjPjvPRHH3jS7VlbBuXPWhklmUt91M+806rsIctWk9jpjk2gPkWrse10zDxfe
         sf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dodPeBHiTvXQpNHuEhbNlONL9Drrpvmy/8YMtOGC/4E=;
        b=fhUyPwtgLPyfizSUy4UOJigWgJVwqh/CcGI0DRC5TXW7LVi9bw62DPfYitM/FA+Mt4
         QYe+mkNVKBcM7KQX+nKclFOEvafnhwxKBlX5xMGcI7ISKYVKKx1IcS1UL+63w72VWl6s
         qgnLTNp6rFLJ8Y3fbfeGj2dV/Sdjc1MUcKRvd8rbpu0YxXlFkw3/f7Z+o+ATGNXwiBOX
         jMcaFrsYsolzx1FxNeQ42z7Ufg97KRRtFSS8Oq3PiCjLGpqNRMNyD1XXPcHz66P4xt8K
         fXXQvLm+3vBFwa0MlssTc93sOPUDVXVEGGdXPrDX1fO5Yw66NarhbkBXYBEsmypazdck
         C6DA==
X-Gm-Message-State: APjAAAWOS3wJJLNyPhMLWoq+y+oAuljtACXLzKmqzsbmkgSw/kxVb5QE
        imi1hjxTurTwDq3FugElOvZo7xg=
X-Google-Smtp-Source: APXvYqw325CEAjBNw8aQXAQFUqP4+xvF8Y8TWqsiQFDf8d0iOGzGBerIqYfEAwRaXxgyOMD1MiCwxQ==
X-Received: by 2002:a02:c916:: with SMTP id t22mr42779652jao.24.1565706614624;
        Tue, 13 Aug 2019 07:30:14 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o6sm9429161ioh.22.2019.08.13.07.30.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 07:30:14 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] NFS: Don't refresh attributes with mounted-on-file information
Date:   Tue, 13 Aug 2019 10:28:02 -0400
Message-Id: <20190813142806.123268-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we've been given the attributes of the mounted-on-file, then do not
use those to check or update the attributes on the application-visible
inode.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 8a1758200b57..c764cfe456e5 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1403,12 +1403,21 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
 		return 0;
 
+	/* No fileid? Just exit */
+	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID))
+		return 0;
 	/* Has the inode gone and changed behind our back? */
-	if ((fattr->valid & NFS_ATTR_FATTR_FILEID) && nfsi->fileid != fattr->fileid)
+	if (nfsi->fileid != fattr->fileid) {
+		/* Is this perhaps the mounted-on fileid? */
+		if ((fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID) &&
+		    nfsi->fileid == fattr->mounted_on_fileid)
+			return 0;
 		return -ESTALE;
+	}
 	if ((fattr->valid & NFS_ATTR_FATTR_TYPE) && (inode->i_mode & S_IFMT) != (fattr->mode & S_IFMT))
 		return -ESTALE;
 
+
 	if (!nfs_file_has_buffered_writers(nfsi)) {
 		/* Verify a few of the more important attributes */
 		if ((fattr->valid & NFS_ATTR_FATTR_CHANGE) != 0 && !inode_eq_iversion_raw(inode, fattr->change_attr))
@@ -1768,18 +1777,6 @@ int nfs_post_op_update_inode_force_wcc(struct inode *inode, struct nfs_fattr *fa
 EXPORT_SYMBOL_GPL(nfs_post_op_update_inode_force_wcc);
 
 
-static inline bool nfs_fileid_valid(struct nfs_inode *nfsi,
-				    struct nfs_fattr *fattr)
-{
-	bool ret1 = true, ret2 = true;
-
-	if (fattr->valid & NFS_ATTR_FATTR_FILEID)
-		ret1 = (nfsi->fileid == fattr->fileid);
-	if (fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
-		ret2 = (nfsi->fileid == fattr->mounted_on_fileid);
-	return ret1 || ret2;
-}
-
 /*
  * Many nfs protocol calls return the new file attributes after
  * an operation.  Here we update the inode to reflect the state
@@ -1810,7 +1807,15 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			nfs_display_fhandle_hash(NFS_FH(inode)),
 			atomic_read(&inode->i_count), fattr->valid);
 
-	if (!nfs_fileid_valid(nfsi, fattr)) {
+	/* No fileid? Just exit */
+	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID))
+		return 0;
+	/* Has the inode gone and changed behind our back? */
+	if (nfsi->fileid != fattr->fileid) {
+		/* Is this perhaps the mounted-on fileid? */
+		if ((fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID) &&
+		    nfsi->fileid == fattr->mounted_on_fileid)
+			return 0;
 		printk(KERN_ERR "NFS: server %s error: fileid changed\n"
 			"fsid %s: expected fileid 0x%Lx, got 0x%Lx\n",
 			NFS_SERVER(inode)->nfs_client->cl_hostname,
-- 
2.21.0

