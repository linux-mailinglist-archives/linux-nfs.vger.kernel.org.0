Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802443B4F5F
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jun 2021 18:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFZQHy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Jun 2021 12:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFZQHy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Jun 2021 12:07:54 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00C1C061766
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:05:29 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id y29so20962521qky.12
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZKap+aSulr1zEHb3v+Lz/056KVKxsolNEqajHS8Sv5c=;
        b=QDR4/r0syzVdDGGHvR+m7FjVWijsOrzTN05SuahBaoT4eZNsaz72HzF2roedLt78QM
         xC1i/O7sQX8kWuotGVHf9ApqxYcWs+CRQbd/n0J9OivaSFOG7dTcuDAcfvy6j+Li9KNx
         X8btbUKaRR1WG+0RwdLzWGr5JUfECXMMpzg5jEclDFqefaNFnGyuegEjcwEApzsAyUqG
         7Z0bYga3Rfy+rMilqj9TTFNYiLYeHj+2A0V6d5Chv3fFJFBZ3+E44PXRcVKrLENGWOMJ
         hwThoB51ixil7/PKydWwhkKw2bCqbveco/pA1qANyQAcW52WfnQzGM4/Tt48kr5JgvNB
         dfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKap+aSulr1zEHb3v+Lz/056KVKxsolNEqajHS8Sv5c=;
        b=BOhcAUxZZyMISAuX/tbClNsIWIRQLsu4yIkYjZBeJzqm2Pz1RZDwthQBArTSyp/ltL
         gJ4Hdozrcb7Fi5qDekkC0Tb99Ep9c/PMOSebt3gqBccnAZfNXcpDxsMuorJyE29V6vKP
         UQKd3C01U1mu2PM3P833x2Bdww/HECeKiRGEi72MeI88mEObFLIKRtt+zC2a29CcMvfQ
         vQDdXUa1TnKHOLV94sFxiuFsxho9WeG6pHc8oF7/TkT/C8af+G5R3fVLmUSb1iURpYzG
         3+RG/tnZaxE8wHzpX11DutNTcpsB+6ivdHWdowIxswCxe+fLZUKjTCW77Ldaxir4qfX6
         PuhQ==
X-Gm-Message-State: AOAM532vTlcp/pv/H+P8NBqlR+9yar8NOd6c4u7IeV1fgEzsk5Y9Q9xD
        /0a1mdHOt2FGRm26aD5+MbSxsn+5ybhc
X-Google-Smtp-Source: ABdhPJxvuG3I65zlPdD4skewiMvBn8nz5148X1H8vTmA4sdcRFc+LaZ19VmIgO4jwCHL80go2OeYeQ==
X-Received: by 2002:a37:a390:: with SMTP id m138mr13446707qke.284.1624723528579;
        Sat, 26 Jun 2021 09:05:28 -0700 (PDT)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id 202sm5797624qki.83.2021.06.26.09.05.27
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 09:05:28 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Fix up inode attribute revalidation timeouts
Date:   Sat, 26 Jun 2021 12:05:24 -0400
Message-Id: <20210626160526.323332-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210626160526.323332-1-trond.myklebust@hammerspace.com>
References: <20210626160526.323332-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The inode is considered revalidated when we've checked the value of the
change attribute against our cached value since that suffices to
establish whether or not the other cached values are valid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 50 ++++++++++++++++----------------------------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 5ccc6b258ca5..b05414d5f5c7 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2070,24 +2070,22 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	} else {
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_CHANGE;
-		cache_revalidated = false;
+		if (!have_delegation ||
+		    (nfsi->cache_validity & NFS_INO_INVALID_CHANGE) != 0)
+			cache_revalidated = false;
 	}
 
-	if (fattr->valid & NFS_ATTR_FATTR_MTIME) {
+	if (fattr->valid & NFS_ATTR_FATTR_MTIME)
 		inode->i_mtime = fattr->mtime;
-	} else if (fattr_supported & NFS_ATTR_FATTR_MTIME) {
+	else if (fattr_supported & NFS_ATTR_FATTR_MTIME)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_MTIME;
-		cache_revalidated = false;
-	}
 
-	if (fattr->valid & NFS_ATTR_FATTR_CTIME) {
+	if (fattr->valid & NFS_ATTR_FATTR_CTIME)
 		inode->i_ctime = fattr->ctime;
-	} else if (fattr_supported & NFS_ATTR_FATTR_CTIME) {
+	else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_CTIME;
-		cache_revalidated = false;
-	}
 
 	/* Check if our cached file size is stale */
 	if (fattr->valid & NFS_ATTR_FATTR_SIZE) {
@@ -2115,19 +2113,15 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			fattr->du.nfs3.used = 0;
 			fattr->valid |= NFS_ATTR_FATTR_SPACE_USED;
 		}
-	} else {
+	} else
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_SIZE;
-		cache_revalidated = false;
-	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_ATIME)
 		inode->i_atime = fattr->atime;
-	else if (fattr_supported & NFS_ATTR_FATTR_ATIME) {
+	else if (fattr_supported & NFS_ATTR_FATTR_ATIME)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_ATIME;
-		cache_revalidated = false;
-	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_MODE) {
 		if ((inode->i_mode & S_IALLUGO) != (fattr->mode & S_IALLUGO)) {
@@ -2138,11 +2132,9 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 				| NFS_INO_INVALID_ACL;
 			attr_changed = true;
 		}
-	} else if (fattr_supported & NFS_ATTR_FATTR_MODE) {
+	} else if (fattr_supported & NFS_ATTR_FATTR_MODE)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_MODE;
-		cache_revalidated = false;
-	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_OWNER) {
 		if (!uid_eq(inode->i_uid, fattr->uid)) {
@@ -2151,11 +2143,9 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			inode->i_uid = fattr->uid;
 			attr_changed = true;
 		}
-	} else if (fattr_supported & NFS_ATTR_FATTR_OWNER) {
+	} else if (fattr_supported & NFS_ATTR_FATTR_OWNER)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_OTHER;
-		cache_revalidated = false;
-	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_GROUP) {
 		if (!gid_eq(inode->i_gid, fattr->gid)) {
@@ -2164,11 +2154,9 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			inode->i_gid = fattr->gid;
 			attr_changed = true;
 		}
-	} else if (fattr_supported & NFS_ATTR_FATTR_GROUP) {
+	} else if (fattr_supported & NFS_ATTR_FATTR_GROUP)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_OTHER;
-		cache_revalidated = false;
-	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_NLINK) {
 		if (inode->i_nlink != fattr->nlink) {
@@ -2177,30 +2165,24 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			set_nlink(inode, fattr->nlink);
 			attr_changed = true;
 		}
-	} else if (fattr_supported & NFS_ATTR_FATTR_NLINK) {
+	} else if (fattr_supported & NFS_ATTR_FATTR_NLINK)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_NLINK;
-		cache_revalidated = false;
-	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_SPACE_USED) {
 		/*
 		 * report the blocks in 512byte units
 		 */
 		inode->i_blocks = nfs_calc_block_size(fattr->du.nfs3.used);
-	} else if (fattr_supported & NFS_ATTR_FATTR_SPACE_USED) {
+	} else if (fattr_supported & NFS_ATTR_FATTR_SPACE_USED)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_BLOCKS;
-		cache_revalidated = false;
-	}
 
-	if (fattr->valid & NFS_ATTR_FATTR_BLOCKS_USED) {
+	if (fattr->valid & NFS_ATTR_FATTR_BLOCKS_USED)
 		inode->i_blocks = fattr->du.nfs2.blocks;
-	} else if (fattr_supported & NFS_ATTR_FATTR_BLOCKS_USED) {
+	else if (fattr_supported & NFS_ATTR_FATTR_BLOCKS_USED)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_BLOCKS;
-		cache_revalidated = false;
-	}
 
 	/* Update attrtimeo value if we're out of the unstable period */
 	if (attr_changed) {
-- 
2.31.1

