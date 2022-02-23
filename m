Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7704C1DA2
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbiBWVVM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242482AbiBWVUJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294D94ECC9
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D831BB81CA4
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AB6C340E7
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651178;
        bh=i7/gOqtVIeKb2i7ihQdqIN8e18muCBZ89nPBFm9KjNc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qVaHEUUMaEGJKXLo2yIKVgPCHDiP0QKlKxcwAzelNuoE04G25lgrKqDl3/2Py0mIJ
         2g4J486KzTUHj/FsFJttfAp9YHNp50JTv0y3v+pTRAGfiz8gcyJun08eBJR8qE8zc6
         mj6+9nFlu8l77XDEFG6GwPtQh20tB3hTzzoeeQz2m3jNczkv3HYVTh2b+kfUtlQy0Y
         Y2M3BLbZhCY0OlpcKY86wD8kKkN8VLMCEwCT8yyMe87CKLRCd7SQAPEs9fPd+/nr5X
         7pbACOphgAWVGbt3UMTcmKbDHEKYoluTmJVFLo7QFMR+Ym/umgSqMruGX2hhWyg+Qg
         6s2VGf5Q2RwEg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 17/21] NFS: Trace effects of readdirplus on the dcache
Date:   Wed, 23 Feb 2022 16:13:01 -0500
Message-Id: <20220223211305.296816-18-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-17-trondmy@kernel.org>
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
 <20220223211305.296816-16-trondmy@kernel.org>
 <20220223211305.296816-17-trondmy@kernel.org>
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

Trace the effects of readdirplus on attribute and dentry revalidation.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c      | 5 +++++
 fs/nfs/nfstrace.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 41e2d02d8611..95b18d1ad0cf 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -742,8 +742,12 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
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
@@ -765,6 +769,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
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

