Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D936E4C5FD7
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiB0XTU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiB0XTS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F8222505
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D9FB611D9
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BFDC340EE
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003921;
        bh=cWdoEAxiyJbm8FK1n2ICqEmLe4AnnzqDZhR0Jrn3E2o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PTJU8o1GR//DKkNzTlZWG/MvObchiM+WOjvu1pGXWmGLdGRJb5LaR/ZDqZQRHJ+4M
         zfa6564+CVQoM5m8LZHAmeFam/nAkl5eRUHNvdRshBq54J81S1qJY5CLzgTW0/TuXj
         py+ovS97nbryGYgjf3vvBupJG7mkaN3XaM/mTxxn4Wqt6gQqjjZlKK/ymSho6zGv5w
         cvlDATUPEYERlZvpdIfISa1EtsyAgCvgqB0EVRQ8/uudBifXQulO1c7O1renS+Nywm
         m1Yk/SsHf6NO1cAKc3ivjrhXPwBhbWRocNLxvg5ZZCIq108im9ljg0z0IuQFLcBBqF
         u5rI579DZawiA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 18/27] NFS: Don't request readdirplus when revalidation was forced
Date:   Sun, 27 Feb 2022 18:12:18 -0500
Message-Id: <20220227231227.9038-19-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-18-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
 <20220227231227.9038-14-trondmy@kernel.org>
 <20220227231227.9038-15-trondmy@kernel.org>
 <20220227231227.9038-16-trondmy@kernel.org>
 <20220227231227.9038-17-trondmy@kernel.org>
 <20220227231227.9038-18-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the revalidation was forced, due to the presence of a LOOKUP_EXCL or
a LOOKUP_REVAL flag, then readdirplus won't help. It also can't help
when we're doing a path component lookup.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5892c4ee3a6d..1da741dd2135 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -692,10 +692,13 @@ void nfs_readdir_record_entry_cache_miss(struct inode *dir)
 	}
 }
 
-static void nfs_lookup_advise_force_readdirplus(struct inode *dir)
+static void nfs_lookup_advise_force_readdirplus(struct inode *dir,
+						unsigned int flags)
 {
 	if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
 		return;
+	if (flags & (LOOKUP_EXCL | LOOKUP_PARENT | LOOKUP_REVAL))
+		return;
 	nfs_readdir_record_entry_cache_miss(dir);
 }
 
@@ -1594,15 +1597,17 @@ nfs_lookup_revalidate_delegated(struct inode *dir, struct dentry *dentry,
 	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
 }
 
-static int
-nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
-			     struct inode *inode)
+static int nfs_lookup_revalidate_dentry(struct inode *dir,
+					struct dentry *dentry,
+					struct inode *inode, unsigned int flags)
 {
 	struct nfs_fh *fhandle;
 	struct nfs_fattr *fattr;
 	unsigned long dir_verifier;
 	int ret;
 
+	trace_nfs_lookup_revalidate_enter(dir, dentry, flags);
+
 	ret = -ENOMEM;
 	fhandle = nfs_alloc_fhandle();
 	fattr = nfs_alloc_fattr_with_label(NFS_SERVER(inode));
@@ -1623,6 +1628,10 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 		}
 		goto out;
 	}
+
+	/* Request help from readdirplus */
+	nfs_lookup_advise_force_readdirplus(dir, flags);
+
 	ret = 0;
 	if (nfs_compare_fh(NFS_FH(inode), fhandle))
 		goto out;
@@ -1632,8 +1641,6 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	nfs_setsecurity(inode, fattr);
 	nfs_set_verifier(dentry, dir_verifier);
 
-	/* set a readdirplus hint that we had a cache miss */
-	nfs_lookup_advise_force_readdirplus(dir);
 	ret = 1;
 out:
 	nfs_free_fattr(fattr);
@@ -1699,8 +1706,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 	if (NFS_STALE(inode))
 		goto out_bad;
 
-	trace_nfs_lookup_revalidate_enter(dir, dentry, flags);
-	return nfs_lookup_revalidate_dentry(dir, dentry, inode);
+	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
 out_valid:
 	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
 out_bad:
@@ -1894,7 +1900,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 		goto out;
 
 	/* Notify readdir to use READDIRPLUS */
-	nfs_lookup_advise_force_readdirplus(dir);
+	nfs_lookup_advise_force_readdirplus(dir, flags);
 
 no_entry:
 	res = d_splice_alias(inode, dentry);
@@ -2157,7 +2163,7 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 reval_dentry:
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
-	return nfs_lookup_revalidate_dentry(dir, dentry, inode);
+	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
 
 full_reval:
 	return nfs_do_lookup_revalidate(dir, dentry, flags);
-- 
2.35.1

