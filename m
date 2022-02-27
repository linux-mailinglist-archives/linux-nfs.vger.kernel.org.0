Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9652F4C5FDA
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiB0XTW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiB0XTU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E1322501
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A381611AF
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEA0C340EE
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003922;
        bh=M0q91ByO+mfG/hFZeg3HAB8JvyG/WufPfxRpyrkYrJk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oCvwJIFpU3rUoiLOTdGndRLJbBIQKrBHYBhe5dUBc4Ji6UpAGwD7j/clQsnGhQKU4
         UeMYBahK1p3DyywIhakClp+b9+cuoSa6vSolmKrY1lncvzYlLCMwSfqLFKhWaY47di
         FOmmjT6ZN9sbJyMSlg8KOE6TmgsNWv5IxuYU8F3tCfChjXpva/X/xIoAwVAQu9MeGk
         ulPmnibWaRtEDj+4HNXafv3OMMsnEf83ZXchIQztYKkzsfUmd7b8mrH3fQw/ko450z
         i6m7RsH5Q+EcuzQ+0+42/eK4/B2yxn95NQ5b9vfuXRLOPq9RxAm1v4r/0vBdQkJumu
         b8zfnTfNjktzg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 21/27] NFS: Trace effects of the readdirplus heuristic
Date:   Sun, 27 Feb 2022 18:12:21 -0500
Message-Id: <20220227231227.9038-22-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-21-trondmy@kernel.org>
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
 <20220227231227.9038-19-trondmy@kernel.org>
 <20220227231227.9038-20-trondmy@kernel.org>
 <20220227231227.9038-21-trondmy@kernel.org>
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

Enable tracking of when the readdirplus heuristic causes a page cache
invalidation.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c      | 11 ++++++++++-
 fs/nfs/nfstrace.h | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 9a2415b5be73..483bb67d2ace 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -998,6 +998,8 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 			if (res == -EBADCOOKIE || res == -ENOTSYNC) {
 				invalidate_inode_pages2(desc->file->f_mapping);
 				desc->page_index = 0;
+				trace_nfs_readdir_invalidate_cache_range(
+					inode, 0, MAX_LFS_FILESIZE);
 				return -EAGAIN;
 			}
 			return res;
@@ -1012,6 +1014,9 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 			invalidate_inode_pages2_range(desc->file->f_mapping,
 						      desc->page_index_max + 1,
 						      -1);
+			trace_nfs_readdir_invalidate_cache_range(
+				inode, desc->page_index_max + 1,
+				MAX_LFS_FILESIZE);
 		}
 	}
 	res = nfs_readdir_search_array(desc);
@@ -1161,7 +1166,11 @@ static void nfs_readdir_handle_cache_misses(struct inode *inode,
 	if (desc->ctx->pos == 0 ||
 	    cache_misses <= NFS_READDIR_CACHE_MISS_THRESHOLD)
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

