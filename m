Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78966610A2
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjAGRmU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjAGRmQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113E61C43A
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CC2C60B8C
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB86C433D2
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113334;
        bh=gDD/5HKC9viBR6gXZ+RODdRBYkBHgUbp0tTip2o1bQ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TYoW0emHS03hmT4eMF8mJpg5+s7MVjVgLPn4jfAT75YciFrRv+0ML/a0j5ywn4hvR
         s6g58UKPrg6p74BLCOV7XpAwK+Oy3ffutIzXDrr+1GsDfmYXc6W40jNhOiK2lTBU5R
         Q6ehrw9ae9qsEbSA6DfLQl1/w2kDvDBmiu9vgOqhrKax4pJLdZtcfHKDAcOj1KAJqz
         sXjKqiZ4ryhapHx5fDfCLtrgzPY0sdbJVq7OyVknBkB9FJXb39lFu7w2Vafq3npxC0
         v4gctm+sYuPLJj19SQt8B6MDe0qWMlGzbTP9hX8GRhMn615WwrNptXOtBqJsdKLQL4
         Q4yTZ6AeVe63Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 16/17] NFS: Enable tracing of nfs_invalidate_folio() and nfs_launder_folio()
Date:   Sat,  7 Jan 2023 12:36:34 -0500
Message-Id: <20230107173635.2025233-17-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107173635.2025233-16-trondmy@kernel.org>
References: <20230107173635.2025233-1-trondmy@kernel.org>
 <20230107173635.2025233-2-trondmy@kernel.org>
 <20230107173635.2025233-3-trondmy@kernel.org>
 <20230107173635.2025233-4-trondmy@kernel.org>
 <20230107173635.2025233-5-trondmy@kernel.org>
 <20230107173635.2025233-6-trondmy@kernel.org>
 <20230107173635.2025233-7-trondmy@kernel.org>
 <20230107173635.2025233-8-trondmy@kernel.org>
 <20230107173635.2025233-9-trondmy@kernel.org>
 <20230107173635.2025233-10-trondmy@kernel.org>
 <20230107173635.2025233-11-trondmy@kernel.org>
 <20230107173635.2025233-12-trondmy@kernel.org>
 <20230107173635.2025233-13-trondmy@kernel.org>
 <20230107173635.2025233-14-trondmy@kernel.org>
 <20230107173635.2025233-15-trondmy@kernel.org>
 <20230107173635.2025233-16-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c     |  9 +++++++--
 fs/nfs/nfstrace.h | 41 +++++++++++++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 3bed75c5250b..bcade290605a 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -411,14 +411,16 @@ static int nfs_write_end(struct file *file, struct address_space *mapping,
 static void nfs_invalidate_folio(struct folio *folio, size_t offset,
 				size_t length)
 {
+	struct inode *inode = folio_file_mapping(folio)->host;
 	dfprintk(PAGECACHE, "NFS: invalidate_folio(%lu, %zu, %zu)\n",
 		 folio->index, offset, length);
 
 	if (offset != 0 || length < folio_size(folio))
 		return;
 	/* Cancel any unstarted writes on this page */
-	nfs_wb_folio_cancel(folio->mapping->host, folio);
+	nfs_wb_folio_cancel(inode, folio);
 	folio_wait_fscache(folio);
+	trace_nfs_invalidate_folio(inode, folio);
 }
 
 /*
@@ -479,12 +481,15 @@ static void nfs_check_dirty_writeback(struct folio *folio,
 static int nfs_launder_folio(struct folio *folio)
 {
 	struct inode *inode = folio->mapping->host;
+	int ret;
 
 	dfprintk(PAGECACHE, "NFS: launder_folio(%ld, %llu)\n",
 		inode->i_ino, folio_pos(folio));
 
 	folio_wait_fscache(folio);
-	return nfs_wb_folio(inode, folio);
+	ret = nfs_wb_folio(inode, folio);
+	trace_nfs_launder_folio_done(inode, folio, ret);
+	return ret;
 }
 
 static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index d83226e45335..988f2c9b607f 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -933,7 +933,7 @@ TRACE_EVENT(nfs_sillyrename_unlink,
 		)
 );
 
-TRACE_EVENT(nfs_aop_readpage,
+DECLARE_EVENT_CLASS(nfs_folio_event,
 		TP_PROTO(
 			const struct inode *inode,
 			struct folio *folio
@@ -947,6 +947,7 @@ TRACE_EVENT(nfs_aop_readpage,
 			__field(u64, fileid)
 			__field(u64, version)
 			__field(loff_t, offset)
+			__field(u32, count)
 		),
 
 		TP_fast_assign(
@@ -957,18 +958,28 @@ TRACE_EVENT(nfs_aop_readpage,
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
 			__entry->offset = folio_file_pos(folio);
+			__entry->count = nfs_folio_length(folio);
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu offset=%lld",
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu "
+			"offset=%lld count=%u",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle, __entry->version,
-			__entry->offset
+			__entry->offset, __entry->count
 		)
 );
 
-TRACE_EVENT(nfs_aop_readpage_done,
+#define DEFINE_NFS_FOLIO_EVENT(name) \
+	DEFINE_EVENT(nfs_folio_event, name, \
+			TP_PROTO( \
+				const struct inode *inode, \
+				struct folio *folio \
+			), \
+			TP_ARGS(inode, folio))
+
+DECLARE_EVENT_CLASS(nfs_folio_event_done,
 		TP_PROTO(
 			const struct inode *inode,
 			struct folio *folio,
@@ -984,6 +995,7 @@ TRACE_EVENT(nfs_aop_readpage_done,
 			__field(u64, fileid)
 			__field(u64, version)
 			__field(loff_t, offset)
+			__field(u32, count)
 		),
 
 		TP_fast_assign(
@@ -994,18 +1006,35 @@ TRACE_EVENT(nfs_aop_readpage_done,
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
 			__entry->offset = folio_file_pos(folio);
+			__entry->count = nfs_folio_length(folio);
 			__entry->ret = ret;
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu offset=%lld ret=%d",
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu "
+			"offset=%lld count=%u ret=%d",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle, __entry->version,
-			__entry->offset, __entry->ret
+			__entry->offset, __entry->count, __entry->ret
 		)
 );
 
+#define DEFINE_NFS_FOLIO_EVENT_DONE(name) \
+	DEFINE_EVENT(nfs_folio_event_done, name, \
+			TP_PROTO( \
+				const struct inode *inode, \
+				struct folio *folio, \
+				int ret \
+			), \
+			TP_ARGS(inode, folio, ret))
+
+DEFINE_NFS_FOLIO_EVENT(nfs_aop_readpage);
+DEFINE_NFS_FOLIO_EVENT_DONE(nfs_aop_readpage_done);
+
+DEFINE_NFS_FOLIO_EVENT(nfs_invalidate_folio);
+DEFINE_NFS_FOLIO_EVENT_DONE(nfs_launder_folio_done);
+
 TRACE_EVENT(nfs_aop_readahead,
 		TP_PROTO(
 			const struct inode *inode,
-- 
2.39.0

