Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C47D4C4DD5
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiBYSfU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiBYSfR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC20E1B50C4
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 479CCB83308
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A3AC340F1
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814082;
        bh=m57b4IjAomidbDJ1/GVjGgFOHMGIw+PNED7rIgkGrXQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SF5unE22yzRFM9qJj03MhNS71DOTFMV3Ofp9tlXn/iTdxnL4lWbAJpDSluVfTjuWM
         i9CR5zKRJmNiixGp4fhrayz1FNEvxIBrdRqayUrxjexptN8GWA1bYlncNgLKCDS34K
         xDy1GVmMQENf07Wn7oooAfH7PZcjBeAui4lRDhEDNgBvAOwaIVcn97f4344o/NsByP
         OMt4zZhySmVD1ENJq19GZ7dRqI40buvuatHikMQkwsz6GBo01HsdzKfy+q9l+GkmJJ
         5gF7p4qn2oQtvvCTnfTwqBZopnZ0ac45JvAuk01cv0ZgthZiJZqhrLlsqdJnUG4cj/
         +Si3W2iu9rVLg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 17/24] NFS: Don't request readdirplus when revalidation was forced
Date:   Fri, 25 Feb 2022 13:28:22 -0500
Message-Id: <20220225182829.1236093-18-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-17-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
 <20220225182829.1236093-5-trondmy@kernel.org>
 <20220225182829.1236093-6-trondmy@kernel.org>
 <20220225182829.1236093-7-trondmy@kernel.org>
 <20220225182829.1236093-8-trondmy@kernel.org>
 <20220225182829.1236093-9-trondmy@kernel.org>
 <20220225182829.1236093-10-trondmy@kernel.org>
 <20220225182829.1236093-11-trondmy@kernel.org>
 <20220225182829.1236093-12-trondmy@kernel.org>
 <20220225182829.1236093-13-trondmy@kernel.org>
 <20220225182829.1236093-14-trondmy@kernel.org>
 <20220225182829.1236093-15-trondmy@kernel.org>
 <20220225182829.1236093-16-trondmy@kernel.org>
 <20220225182829.1236093-17-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index feaf19240db1..963f4061c904 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -682,10 +682,13 @@ void nfs_readdir_record_entry_cache_miss(struct inode *dir)
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
 
@@ -1581,15 +1584,17 @@ nfs_lookup_revalidate_delegated(struct inode *dir, struct dentry *dentry,
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
@@ -1610,6 +1615,10 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
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
@@ -1619,8 +1628,6 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	nfs_setsecurity(inode, fattr);
 	nfs_set_verifier(dentry, dir_verifier);
 
-	/* set a readdirplus hint that we had a cache miss */
-	nfs_lookup_advise_force_readdirplus(dir);
 	ret = 1;
 out:
 	nfs_free_fattr(fattr);
@@ -1686,8 +1693,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 	if (NFS_STALE(inode))
 		goto out_bad;
 
-	trace_nfs_lookup_revalidate_enter(dir, dentry, flags);
-	return nfs_lookup_revalidate_dentry(dir, dentry, inode);
+	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
 out_valid:
 	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
 out_bad:
@@ -1881,7 +1887,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 		goto out;
 
 	/* Notify readdir to use READDIRPLUS */
-	nfs_lookup_advise_force_readdirplus(dir);
+	nfs_lookup_advise_force_readdirplus(dir, flags);
 
 no_entry:
 	res = d_splice_alias(inode, dentry);
@@ -2144,7 +2150,7 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 reval_dentry:
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
-	return nfs_lookup_revalidate_dentry(dir, dentry, inode);
+	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
 
 full_reval:
 	return nfs_do_lookup_revalidate(dir, dentry, flags);
-- 
2.35.1

