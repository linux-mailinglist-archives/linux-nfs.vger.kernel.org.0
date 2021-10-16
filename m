Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0C430526
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhJPWFB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235616AbhJPWFA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:05:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 231C060F44;
        Sat, 16 Oct 2021 22:02:52 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 5/7] NFS: Replace dprintk callsites in nfs_readpage(s)
Date:   Sat, 16 Oct 2021 18:02:51 -0400
Message-Id:  <163442177101.1585.8852378085253353318.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To:  <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
References:  <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=6475; h=from:subject:message-id; bh=QRIi+ucGa28hhEpCKpW5Hvpm8ML8uMSVa6gsQjDQ7qE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha0wLHGakPi5LNF6mbd57fy3JZ9quFD295C6wpLev xTRX5v+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtMCwAKCRAzarMzb2Z/l20kEA CTxLYg7k4huyg9UqQ76bThKWhpp5jalJqCxrA3uZcsJK1/vJp470q7jzi1NM0Il0jGsv4RP4w06Mnf +0kBvv919iAsAwfLmwloV9iLcuzR1LD2snBBG3MlxHJ5bsktop9sF3ctWX4qnHop5DG/h4kJfaHVE/ POmKcrrXzOj/19ByWj3Xhij69aJ70VLflABK6iggQdOhW1XA+sTdsGdlng/kZUJOv2kwhEIRhsXdM6 4oOSNNQDlQRGHI7US5iJTp6HmgMAqNDTNEZjaK3g3n0XsJHow0eFV+2hTjfP2A1cEQJyv+a4q0kL2v Tlm9eYp0yH1msJpwA9Uomil4h+lTciEyErKAE1iXiahf1j8b3DAOlrRFHFIpAGsc5eS0Kw3zeV49e/ LCGLK1OwGy3F2I5jXKo/V186TAF1nhwARpNMsdPjoDcfTk/AJzMewJdk3UO5KoJB32B4OI/MeGZ/nv ZT/mqLiDyJtchQqHO35t8PhgfImvkpfIfxdDzhHvDIyzgTh401xIZJLTIwrjCDk/2dU6XtTXy91gEj cged0s8Rzag5ouYiKOg+641UixUloPMrP/4Qm9aXywsUToc3AsHaYdwTwVXeGbXENyVe5tQzQvWPui wM/UX/4FGg7op84CZj6jvPUmeNNPys0GHScSwZm6nFPaWRE1Rnw3hgCCr70w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These new events report slightly different information for readpage
and readpages/readahead.

For readpage:
             fsx-1387  [006]   380.761896: nfs_aop_readpage:    fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355910932437 offset=131072
             fsx-1387  [006]   380.761900: nfs_aop_readpage_done: fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355910932437 offset=131072 ret=0

The index of a synchronous single-page read is reported.

For readpages:

             fsx-1387  [006]   380.760847: nfs_aop_readahead:   fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355909932456 nr_pages=3
             fsx-1387  [006]   380.760853: nfs_aop_readahead_done: fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355909932456 nr_pages=3 ret=0

The count of pages requested is reported. nfs_readpages does not
wait for the READ requests to complete.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfstrace.h |  146 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/read.c     |   11 ++--
 2 files changed, 151 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index e9be65b52bfe..898308780df8 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -862,6 +862,152 @@ TRACE_EVENT(nfs_sillyrename_unlink,
 		)
 );
 
+TRACE_EVENT(nfs_aop_readpage,
+		TP_PROTO(
+			const struct inode *inode,
+			struct page *page
+		),
+
+		TP_ARGS(inode, page),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(u64, version)
+			__field(loff_t, offset)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->offset = page_index(page) << PAGE_SHIFT;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu offset=%lld",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->version,
+			__entry->offset
+		)
+);
+
+TRACE_EVENT(nfs_aop_readpage_done,
+		TP_PROTO(
+			const struct inode *inode,
+			struct page *page,
+			int ret
+		),
+
+		TP_ARGS(inode, page, ret),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(int, ret)
+			__field(u64, fileid)
+			__field(u64, version)
+			__field(loff_t, offset)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->offset = page_index(page) << PAGE_SHIFT;
+			__entry->ret = ret;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu offset=%lld ret=%d",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->version,
+			__entry->offset, __entry->ret
+		)
+);
+
+TRACE_EVENT(nfs_aop_readahead,
+		TP_PROTO(
+			const struct inode *inode,
+			unsigned int nr_pages
+		),
+
+		TP_ARGS(inode, nr_pages),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(u64, version)
+			__field(unsigned int, nr_pages)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->nr_pages = nr_pages;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu nr_pages=%u",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->version,
+			__entry->nr_pages
+		)
+);
+
+TRACE_EVENT(nfs_aop_readahead_done,
+		TP_PROTO(
+			const struct inode *inode,
+			unsigned int nr_pages,
+			int ret
+		),
+
+		TP_ARGS(inode, nr_pages, ret),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(int, ret)
+			__field(u64, fileid)
+			__field(u64, version)
+			__field(unsigned int, nr_pages)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->nr_pages = nr_pages;
+			__entry->ret = ret;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu nr_pages=%u ret=%d",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->version,
+			__entry->nr_pages, __entry->ret
+		)
+);
+
 TRACE_EVENT(nfs_initiate_read,
 		TP_PROTO(
 			const struct nfs_pgio_header *hdr
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 08d6cc57cbc3..c8273d4b12ad 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -337,8 +337,7 @@ int nfs_readpage(struct file *file, struct page *page)
 	struct inode *inode = page_file_mapping(page)->host;
 	int ret;
 
-	dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
-		page, PAGE_SIZE, page_index(page));
+	trace_nfs_aop_readpage(inode, page);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
 
 	/*
@@ -390,9 +389,11 @@ int nfs_readpage(struct file *file, struct page *page)
 	}
 out:
 	put_nfs_open_context(desc.ctx);
+	trace_nfs_aop_readpage_done(inode, page, ret);
 	return ret;
 out_unlock:
 	unlock_page(page);
+	trace_nfs_aop_readpage_done(inode, page, ret);
 	return ret;
 }
 
@@ -403,10 +404,7 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	int ret;
 
-	dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
-			inode->i_sb->s_id,
-			(unsigned long long)NFS_FILEID(inode),
-			nr_pages);
+	trace_nfs_aop_readahead(inode, nr_pages);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
 
 	ret = -ESTALE;
@@ -439,6 +437,7 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
 read_complete:
 	put_nfs_open_context(desc.ctx);
 out:
+	trace_nfs_aop_readahead_done(inode, nr_pages, ret);
 	return ret;
 }
 

