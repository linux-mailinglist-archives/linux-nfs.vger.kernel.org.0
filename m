Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7E94D7721
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiCMRNW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiCMRNT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A103D13A1E1
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 219476122D
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86CFC340F4
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191530;
        bh=DLK2UGtIautxGoPZbgLFz5UlZ4TdoRzxssBXUh6+AQU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Lh3dapmS9WnIXCq7Hzwn9NhY07r//oHE/ZGyb38p1+CX1McixYihwwdM4e57ypDKN
         KO7lV2Kb6PSGnGc+5ua2nyJ+qBu279mYzPB/RDAQdLE4Gfhl40JtYkIXf7zfflRGAs
         9+FdD5uXrhgoqtoTafU3viOWlg2LvcyN2mf+7BxS2A2o+Rwo0yHn8LK+Zl4vf5mNar
         387qM3McfqV2MBOEhR+AwU2kNLX+/PDzcpOjClNGzac0xJv5XabkJIXR1TeTguRm/q
         vf3kC4NP7DPNqqp5tai+vzWPbk31jssnDJabfWS411l1p/H5c/f32msQDV05T2LY1r
         Q+r4BAX8VhASQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 18/26] NFS: Don't request readdirplus when revalidation was forced
Date:   Sun, 13 Mar 2022 13:05:49 -0400
Message-Id: <20220313170557.5940-19-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-18-trondmy@kernel.org>
References: <20220313170557.5940-1-trondmy@kernel.org>
 <20220313170557.5940-2-trondmy@kernel.org>
 <20220313170557.5940-3-trondmy@kernel.org>
 <20220313170557.5940-4-trondmy@kernel.org>
 <20220313170557.5940-5-trondmy@kernel.org>
 <20220313170557.5940-6-trondmy@kernel.org>
 <20220313170557.5940-7-trondmy@kernel.org>
 <20220313170557.5940-8-trondmy@kernel.org>
 <20220313170557.5940-9-trondmy@kernel.org>
 <20220313170557.5940-10-trondmy@kernel.org>
 <20220313170557.5940-11-trondmy@kernel.org>
 <20220313170557.5940-12-trondmy@kernel.org>
 <20220313170557.5940-13-trondmy@kernel.org>
 <20220313170557.5940-14-trondmy@kernel.org>
 <20220313170557.5940-15-trondmy@kernel.org>
 <20220313170557.5940-16-trondmy@kernel.org>
 <20220313170557.5940-17-trondmy@kernel.org>
 <20220313170557.5940-18-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index dcfc44411787..cf7974642a19 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -694,10 +694,13 @@ void nfs_readdir_record_entry_cache_miss(struct inode *dir)
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
 
@@ -1596,15 +1599,17 @@ nfs_lookup_revalidate_delegated(struct inode *dir, struct dentry *dentry,
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
@@ -1625,6 +1630,10 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
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
@@ -1634,8 +1643,6 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	nfs_setsecurity(inode, fattr);
 	nfs_set_verifier(dentry, dir_verifier);
 
-	/* set a readdirplus hint that we had a cache miss */
-	nfs_lookup_advise_force_readdirplus(dir);
 	ret = 1;
 out:
 	nfs_free_fattr(fattr);
@@ -1701,8 +1708,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 	if (NFS_STALE(inode))
 		goto out_bad;
 
-	trace_nfs_lookup_revalidate_enter(dir, dentry, flags);
-	return nfs_lookup_revalidate_dentry(dir, dentry, inode);
+	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
 out_valid:
 	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
 out_bad:
@@ -1896,7 +1902,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 		goto out;
 
 	/* Notify readdir to use READDIRPLUS */
-	nfs_lookup_advise_force_readdirplus(dir);
+	nfs_lookup_advise_force_readdirplus(dir, flags);
 
 no_entry:
 	res = d_splice_alias(inode, dentry);
@@ -2159,7 +2165,7 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 reval_dentry:
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
-	return nfs_lookup_revalidate_dentry(dir, dentry, inode);
+	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
 
 full_reval:
 	return nfs_do_lookup_revalidate(dir, dentry, flags);
-- 
2.35.1

