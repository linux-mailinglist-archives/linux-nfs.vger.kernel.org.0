Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B348674B90
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jan 2023 06:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjATFCC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Jan 2023 00:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjATFBm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Jan 2023 00:01:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A9EBAF1C
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 20:49:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D640B82741
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1778C433EF;
        Thu, 19 Jan 2023 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164427;
        bh=oLB6cKH2yK/1rbMhCn6ZZdPvF6GK7QtadmUqyNQjwYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRRSZgIryqM8RvenoayNiieyR0irlWqBg2vOiRGm6LPBfi5q/VPF+cUY+fpW0Dwgi
         Dh0YKcXDQ2OazmYiRutSQgdOpmLdXWvX7yw/INKrvFf9EuIX2gtNrVWy1simkG9xn9
         PxFKyqQJ2S4Mh2ATjcJFDgyN2IOKG237Zhq4Cmb/YHaUwM4UytCbK3sEl+L9FeB/jP
         D/zfeVNuX2g5Nu7u2XhMtYKD6rbE+7dsDQRaCFJy14MoAnup5w4MFNyTixwOqFGJ9V
         lBlIDlMkwKgQ5W1CmpFlqtia9jws4TcPa/Q1C9C3wG7yPTwKyiECa86pCaw2p6FumI
         wkaF+jERin8IA==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 16/18] NFS: Enable tracing of nfs_invalidate_folio() and nfs_launder_folio()
Date:   Thu, 19 Jan 2023 16:33:49 -0500
Message-Id: <20230119213351.443388-17-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119213351.443388-16-trondmy@kernel.org>
References: <20230119213351.443388-1-trondmy@kernel.org>
 <20230119213351.443388-2-trondmy@kernel.org>
 <20230119213351.443388-3-trondmy@kernel.org>
 <20230119213351.443388-4-trondmy@kernel.org>
 <20230119213351.443388-5-trondmy@kernel.org>
 <20230119213351.443388-6-trondmy@kernel.org>
 <20230119213351.443388-7-trondmy@kernel.org>
 <20230119213351.443388-8-trondmy@kernel.org>
 <20230119213351.443388-9-trondmy@kernel.org>
 <20230119213351.443388-10-trondmy@kernel.org>
 <20230119213351.443388-11-trondmy@kernel.org>
 <20230119213351.443388-12-trondmy@kernel.org>
 <20230119213351.443388-13-trondmy@kernel.org>
 <20230119213351.443388-14-trondmy@kernel.org>
 <20230119213351.443388-15-trondmy@kernel.org>
 <20230119213351.443388-16-trondmy@kernel.org>
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
index b686b615586e..d3aa330fef36 100644
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

