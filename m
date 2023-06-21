Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADE17387DE
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jun 2023 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjFUOv7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Jun 2023 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjFUOvD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Jun 2023 10:51:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46FC1994;
        Wed, 21 Jun 2023 07:48:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F7CC61593;
        Wed, 21 Jun 2023 14:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D00BC433C8;
        Wed, 21 Jun 2023 14:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358933;
        bh=MY6mT00ynJC7gWrFRag5H79VJzPsY926+Cc80XaEvT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vfm6clhmA9VGRlnCKwWiGg+3rR+17VSVMNzcNhQspybcY256kPnQfmWJm8pHcPgEL
         Z3SrWZBk3ANeZerVEi0rn+F8gA0gZzWw4NHfRzmfNzGgC9WJ0fZa9c9dHgWjIy3ZlN
         M0vYpcJtiOZuSrQPN2EJdT8+9DTANmvT39Xko6dkTmeXSENQtyKT/1n90GKozUqy0j
         uRKStcoopAVce9dbI5Eo0BB+bIsc4gcI0eJDpZjLyG8x94KK30aZQHklmKnTcbIZ4l
         Wr98RnSUFNR1Ky+Oew/VpbbvcuO+gKbsGIcvnlRkWwB0iUPfK9smCU6OkHEePWEZKs
         401LIyjvC7aPQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 45/79] nfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:58 -0400
Message-ID: <20230621144735.55953-44-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/callback_proc.c |  2 +-
 fs/nfs/fscache.h       |  4 ++--
 fs/nfs/inode.c         | 21 +++++++++++----------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index c1eda73254e1..995654050815 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -59,7 +59,7 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 	res->change_attr = delegation->change_attr;
 	if (nfs_have_writebacks(inode))
 		res->change_attr++;
-	res->ctime = inode->i_ctime;
+	res->ctime = inode_ctime_peek(inode);
 	res->mtime = inode->i_mtime;
 	res->bitmap[0] = (FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE) &
 		args->bitmap[0];
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index e1706e736c64..98be316c64a0 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -116,8 +116,8 @@ static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *
 	memset(auxdata, 0, sizeof(*auxdata));
 	auxdata->mtime_sec  = inode->i_mtime.tv_sec;
 	auxdata->mtime_nsec = inode->i_mtime.tv_nsec;
-	auxdata->ctime_sec  = inode->i_ctime.tv_sec;
-	auxdata->ctime_nsec = inode->i_ctime.tv_nsec;
+	auxdata->ctime_sec = inode_ctime_peek(inode).tv_sec;
+	auxdata->ctime_nsec = inode_ctime_peek(inode).tv_nsec;
 
 	if (NFS_SERVER(inode)->nfs_client->rpc_ops->version == 4)
 		auxdata->change_attr = inode_peek_iversion_raw(inode);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index a910b9a638c5..bc4cac08bb24 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -514,7 +514,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 
 		memset(&inode->i_atime, 0, sizeof(inode->i_atime));
 		memset(&inode->i_mtime, 0, sizeof(inode->i_mtime));
-		memset(&inode->i_ctime, 0, sizeof(inode->i_ctime));
+		inode_ctime_set_sec(inode, 0);
+		inode_ctime_set_nsec(inode, 0);
 		inode_set_iversion_raw(inode, 0);
 		inode->i_size = 0;
 		clear_nlink(inode);
@@ -535,7 +536,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		else if (fattr_supported & NFS_ATTR_FATTR_MTIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = fattr->ctime;
+			inode_ctime_set(inode, fattr->ctime);
 		else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
@@ -731,7 +732,7 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 		if ((attr->ia_valid & ATTR_GID) != 0)
 			inode->i_gid = attr->ia_gid;
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = fattr->ctime;
+			inode_ctime_set(inode, fattr->ctime);
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE
 					| NFS_INO_INVALID_CTIME);
@@ -749,7 +750,7 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATIME);
 
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = fattr->ctime;
+			inode_ctime_set(inode, fattr->ctime);
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE
 					| NFS_INO_INVALID_CTIME);
@@ -765,7 +766,7 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
 
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = fattr->ctime;
+			inode_ctime_set(inode, fattr->ctime);
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE
 					| NFS_INO_INVALID_CTIME);
@@ -1444,11 +1445,11 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_XATTR);
 	}
 	/* If we have atomic WCC data, we may update some attributes */
-	ts = inode->i_ctime;
+	ts = inode_ctime_peek(inode);
 	if ((fattr->valid & NFS_ATTR_FATTR_PRECTIME)
 			&& (fattr->valid & NFS_ATTR_FATTR_CTIME)
 			&& timespec64_equal(&ts, &fattr->pre_ctime)) {
-		inode->i_ctime = fattr->ctime;
+		inode_ctime_set(inode, fattr->ctime);
 	}
 
 	ts = inode->i_mtime;
@@ -1510,7 +1511,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 		if ((fattr->valid & NFS_ATTR_FATTR_MTIME) && !timespec64_equal(&ts, &fattr->mtime))
 			invalid |= NFS_INO_INVALID_MTIME;
 
-		ts = inode->i_ctime;
+		ts = inode_ctime_peek(inode);
 		if ((fattr->valid & NFS_ATTR_FATTR_CTIME) && !timespec64_equal(&ts, &fattr->ctime))
 			invalid |= NFS_INO_INVALID_CTIME;
 
@@ -1997,7 +1998,7 @@ int nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct nfs_fa
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_CTIME) != 0 &&
 			(fattr->valid & NFS_ATTR_FATTR_PRECTIME) == 0) {
-		fattr->pre_ctime = inode->i_ctime;
+		fattr->pre_ctime = inode_ctime_peek(inode);
 		fattr->valid |= NFS_ATTR_FATTR_PRECTIME;
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_MTIME) != 0 &&
@@ -2190,7 +2191,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			save_cache_validity & NFS_INO_INVALID_MTIME;
 
 	if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-		inode->i_ctime = fattr->ctime;
+		inode_ctime_set(inode, fattr->ctime);
 	else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_CTIME;
-- 
2.41.0

