Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB244BE280
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 18:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379990AbiBUQPc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 11:15:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379987AbiBUQP2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 11:15:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748E5275E9
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 08:15:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1201A61295
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4CFC340F3
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645460103;
        bh=rxN5HWn8Blfxoh/K50i/hliOel8/q7JNo+KYL2xck2A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gpDsz1UOV85eKN44hkTTO7ChOgR2Ny38AU+HaODN4zT4AmD1s6kBenAX/3pmrawSn
         qQ7pdiZyWah2Jkb+RVy67lVnnJIQJGgoz+nLeibNfbvKUpi+FBKEprBEmDOowIrdSw
         +qUTSyLOHG2qvhblt2dN+f88L++qaxZlt1/YBp1+leIZzUAQgTMHk0gUk7V/OrFTIT
         wsq3x5iYV1Ai/PnutShdbMhecexSulMUb5gj7FuQouk1izB/e2bHMmvZzWWlVPbvba
         rhaywG8Gupbg/mcLjFoY5bfNF3DaGv0JRaFlJu7AMvr9HP8/mADgAhzqio7B70ZOzB
         jGBwOyWAn//Xg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 10/13] NFS: Don't request readdirplus when revaldation was forced
Date:   Mon, 21 Feb 2022 11:08:48 -0500
Message-Id: <20220221160851.15508-11-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221160851.15508-10-trondmy@kernel.org>
References: <20220221160851.15508-1-trondmy@kernel.org>
 <20220221160851.15508-2-trondmy@kernel.org>
 <20220221160851.15508-3-trondmy@kernel.org>
 <20220221160851.15508-4-trondmy@kernel.org>
 <20220221160851.15508-5-trondmy@kernel.org>
 <20220221160851.15508-6-trondmy@kernel.org>
 <20220221160851.15508-7-trondmy@kernel.org>
 <20220221160851.15508-8-trondmy@kernel.org>
 <20220221160851.15508-9-trondmy@kernel.org>
 <20220221160851.15508-10-trondmy@kernel.org>
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
index b1e6c56d7e1a..b6e21c5e1a0f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -665,10 +665,13 @@ void nfs_readdir_record_entry_cache_miss(struct inode *dir)
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
 
@@ -1582,15 +1585,17 @@ nfs_lookup_revalidate_delegated(struct inode *dir, struct dentry *dentry,
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
@@ -1611,6 +1616,10 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
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
@@ -1620,8 +1629,6 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	nfs_setsecurity(inode, fattr);
 	nfs_set_verifier(dentry, dir_verifier);
 
-	/* set a readdirplus hint that we had a cache miss */
-	nfs_lookup_advise_force_readdirplus(dir);
 	ret = 1;
 out:
 	nfs_free_fattr(fattr);
@@ -1687,8 +1694,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 	if (NFS_STALE(inode))
 		goto out_bad;
 
-	trace_nfs_lookup_revalidate_enter(dir, dentry, flags);
-	return nfs_lookup_revalidate_dentry(dir, dentry, inode);
+	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
 out_valid:
 	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
 out_bad:
@@ -1882,7 +1888,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 		goto out;
 
 	/* Notify readdir to use READDIRPLUS */
-	nfs_lookup_advise_force_readdirplus(dir);
+	nfs_lookup_advise_force_readdirplus(dir, flags);
 
 no_entry:
 	res = d_splice_alias(inode, dentry);
@@ -2145,7 +2151,7 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 reval_dentry:
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
-	return nfs_lookup_revalidate_dentry(dir, dentry, inode);
+	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
 
 full_reval:
 	return nfs_do_lookup_revalidate(dir, dentry, flags);
-- 
2.35.1

