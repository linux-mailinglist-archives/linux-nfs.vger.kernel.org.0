Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3FE4C1DAD
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242677AbiBWVWa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242451AbiBWVUG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3321F4ECE7
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A63618A2
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9778C340E7
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651177;
        bh=+MiUFfC0SeWN4+VjycQsRApv2J4rGpod/B+OPr+ibOY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=G4phKhTO2915vwYfqSffGoESTnDHs/wPoBS1eL+aM40Xewju8OD/B1D3BuDPWxlpQ
         BpuWI+BL96UgMDfTWzchJh1jTG0rt1VIbbdA67Acxq1XG5OQRerIwx0CxUnCDV2YxN
         qoETTG8AgYKrlIwmmqquiPieG8Pxnb8bOhhAJ+L8JaJb+HJaPFNpITVnd/z8rf1PF5
         LwbiRkhlXTPCT46FJYl5AHUvNODnUodY7D4HQgv8qBisqDNyGXuhxn4t4Nh/WzUONP
         darcJZCK2AFQVuKjbi+seGF2IMg317BUa7vabCoeuo/hICUKAi53jCmH7NN1JHk1je
         MgpUfUiKNkO7Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 15/21] NFS: Don't request readdirplus when revalidation was forced
Date:   Wed, 23 Feb 2022 16:12:59 -0500
Message-Id: <20220223211305.296816-16-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-15-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
 <20220223211305.296816-7-trondmy@kernel.org>
 <20220223211305.296816-8-trondmy@kernel.org>
 <20220223211305.296816-9-trondmy@kernel.org>
 <20220223211305.296816-10-trondmy@kernel.org>
 <20220223211305.296816-11-trondmy@kernel.org>
 <20220223211305.296816-12-trondmy@kernel.org>
 <20220223211305.296816-13-trondmy@kernel.org>
 <20220223211305.296816-14-trondmy@kernel.org>
 <20220223211305.296816-15-trondmy@kernel.org>
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
index a9098d5a9fc8..54f0d37485d5 100644
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
 
@@ -1583,15 +1586,17 @@ nfs_lookup_revalidate_delegated(struct inode *dir, struct dentry *dentry,
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
@@ -1612,6 +1617,10 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
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
@@ -1621,8 +1630,6 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	nfs_setsecurity(inode, fattr);
 	nfs_set_verifier(dentry, dir_verifier);
 
-	/* set a readdirplus hint that we had a cache miss */
-	nfs_lookup_advise_force_readdirplus(dir);
 	ret = 1;
 out:
 	nfs_free_fattr(fattr);
@@ -1688,8 +1695,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 	if (NFS_STALE(inode))
 		goto out_bad;
 
-	trace_nfs_lookup_revalidate_enter(dir, dentry, flags);
-	return nfs_lookup_revalidate_dentry(dir, dentry, inode);
+	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
 out_valid:
 	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
 out_bad:
@@ -1883,7 +1889,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 		goto out;
 
 	/* Notify readdir to use READDIRPLUS */
-	nfs_lookup_advise_force_readdirplus(dir);
+	nfs_lookup_advise_force_readdirplus(dir, flags);
 
 no_entry:
 	res = d_splice_alias(inode, dentry);
@@ -2146,7 +2152,7 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 reval_dentry:
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
-	return nfs_lookup_revalidate_dentry(dir, dentry, inode);
+	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
 
 full_reval:
 	return nfs_do_lookup_revalidate(dir, dentry, flags);
-- 
2.35.1

