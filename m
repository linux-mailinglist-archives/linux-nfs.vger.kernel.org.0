Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012964BE2AD
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 18:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379987AbiBUQPc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 11:15:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379992AbiBUQP2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 11:15:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12B423BD4
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 08:15:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DA38612A3
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78728C340EC
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645460104;
        bh=hLDoQkvyJmnOiq6gFw7//p6qSnKAkLj3H61khVngHzs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UPAj5+vaG8C1xe+nxJxCZdrLYUQZ3cXaizsYY5nT5e6Cwv3R5wq9eeMtl9hKL6LWl
         144v9ZrRiTxMksHFJiu62gzsEVRTqKP9YtkPIR/gHtCi3aGYIsMBJ0eE7L5Peeod7S
         pxDEZtsv9fTPB5D9br4TXxQpZWMjES+kgfuWH0jlkTri9nvh2dPyupDfghu+2fW063
         mn25SyGauVVxuxCvW/oZ78JRihkxaAh5aGQ81mmtoHbmSebRjzYFg1ULZ8rA6VM5B3
         DtLggy6gXtI29ig485qJ64956aLnX/4cmlmIH5sXP5fTwvzHWZvCzBvAmin7/aQmYk
         XQ1KAlPPd/giA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 13/13] NFS: Trace effects of the readdirplus heuristic
Date:   Mon, 21 Feb 2022 11:08:51 -0500
Message-Id: <20220221160851.15508-14-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221160851.15508-13-trondmy@kernel.org>
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
 <20220221160851.15508-11-trondmy@kernel.org>
 <20220221160851.15508-12-trondmy@kernel.org>
 <20220221160851.15508-13-trondmy@kernel.org>
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

Enable tracking of when the readdirplus heuristic causes a page cache
invalidation.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c      |  6 +++++-
 fs/nfs/nfstrace.h | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index bcbfe03e3835..9f48c75dbf4c 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1141,7 +1141,11 @@ static void nfs_readdir_handle_cache_misses(struct inode *inode,
 	    cache_misses <= NFS_READDIR_CACHE_MISS_THRESHOLD ||
 	    !nfs_readdir_may_fill_pagecache(desc))
 		return;
-	invalidate_mapping_pages(inode->i_mapping, page_index + 1, -1);
+	if (invalidate_mapping_pages(inode->i_mapping, page_index + 1, -1) == 0)
+		return;
+	trace_nfs_readdir_invalidate_cache_range(
+		inode, (loff_t)(page_index + 1) << PAGE_SHIFT,
+		MAX_LFS_FILESIZE);
 }
 
 /* The file offset position represents the dirent entry number.  A
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 7c1102b991d0..ec2645d20abf 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -273,6 +273,56 @@ DEFINE_NFS_UPDATE_SIZE_EVENT(wcc);
 DEFINE_NFS_UPDATE_SIZE_EVENT(update);
 DEFINE_NFS_UPDATE_SIZE_EVENT(grow);
 
+DECLARE_EVENT_CLASS(nfs_inode_range_event,
+		TP_PROTO(
+			const struct inode *inode,
+			loff_t range_start,
+			loff_t range_end
+		),
+
+		TP_ARGS(inode, range_start, range_end),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(u64, version)
+			__field(loff_t, range_start)
+			__field(loff_t, range_end)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->fileid = nfsi->fileid;
+			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->range_start = range_start;
+			__entry->range_end = range_end;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu "
+			"range=[%lld, %lld]",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->version,
+			__entry->range_start, __entry->range_end
+		)
+);
+
+#define DEFINE_NFS_INODE_RANGE_EVENT(name) \
+	DEFINE_EVENT(nfs_inode_range_event, name, \
+			TP_PROTO( \
+				const struct inode *inode, \
+				loff_t range_start, \
+				loff_t range_end \
+			), \
+			TP_ARGS(inode, range_start, range_end))
+
+DEFINE_NFS_INODE_RANGE_EVENT(nfs_readdir_invalidate_cache_range);
+
 DECLARE_EVENT_CLASS(nfs_readdir_event,
 		TP_PROTO(
 			const struct file *file,
-- 
2.35.1

