Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD4E4D771C
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiCMRNY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiCMRNV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F779139CDC
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09309B80CD7
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96024C340EE
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191531;
        bh=j6ypKYPb9DTnKk79FPGpIf85rMFSI9I9CGn0mbbvcNM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AXdVyq5i43r9E3anENCR7qeGlmoKdvVmaduRP+is9jk163QTGD2Y3dIJxAC6o/g5K
         Lulv5krfJYWSVeUC/wysKbnRV5ZAZvIRbF3LiO0cLNnBYn/b73h4kUfu24T1aJiE09
         aS2x3aZQoKUybK0MFmk4ZDZXo+21Xbf5PNSVGBvrrtfDdc45V9wrR37P+WTG3Mkwr3
         jP1h5ZZQpScmDozk4iSnIIUxcI07rG2NmdtnGiQ+o6i8AoK19Q2Vizkq7l59hYviyj
         4MtFYzUeTw2M5MJrZlMib5NW0nyU7M2hkYdYVszLtBCUONBQrUIslU3AqqcjUfvfwC
         gmueiTzmlvFxw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 20/26] NFS: Trace effects of readdirplus on the dcache
Date:   Sun, 13 Mar 2022 13:05:51 -0400
Message-Id: <20220313170557.5940-21-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-20-trondmy@kernel.org>
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
 <20220313170557.5940-19-trondmy@kernel.org>
 <20220313170557.5940-20-trondmy@kernel.org>
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

Trace the effects of readdirplus on attribute and dentry revalidation.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c      | 5 +++++
 fs/nfs/nfstrace.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d591d20f7534..8b25a39b1761 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -754,8 +754,12 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 			status = nfs_refresh_inode(d_inode(dentry), entry->fattr);
 			if (!status)
 				nfs_setsecurity(d_inode(dentry), entry->fattr);
+			trace_nfs_readdir_lookup_revalidate(d_inode(parent),
+							    dentry, 0, status);
 			goto out;
 		} else {
+			trace_nfs_readdir_lookup_revalidate_failed(
+				d_inode(parent), dentry, 0);
 			d_invalidate(dentry);
 			dput(dentry);
 			dentry = NULL;
@@ -777,6 +781,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		dentry = alias;
 	}
 	nfs_set_verifier(dentry, dir_verifier);
+	trace_nfs_readdir_lookup(d_inode(parent), dentry, 0);
 out:
 	dput(dentry);
 }
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index c2d0543ecb2d..7c1102b991d0 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -432,6 +432,9 @@ DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_enter);
 DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_exit);
 DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_enter);
 DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_revalidate_exit);
+DEFINE_NFS_LOOKUP_EVENT(nfs_readdir_lookup);
+DEFINE_NFS_LOOKUP_EVENT(nfs_readdir_lookup_revalidate_failed);
+DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_readdir_lookup_revalidate);
 
 TRACE_EVENT(nfs_atomic_open_enter,
 		TP_PROTO(
-- 
2.35.1

