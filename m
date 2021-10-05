Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193DF422EDB
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 19:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhJERQU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 13:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233961AbhJERQU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Oct 2021 13:16:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD7A3611CA
        for <linux-nfs@vger.kernel.org>; Tue,  5 Oct 2021 17:14:29 +0000 (UTC)
Subject: [PATCH RFC 5/5] NFS: Replace dprintk callsites in nfs_readpage(s)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Oct 2021 13:14:29 -0400
Message-ID: <163345406901.524558.6277128986656130592.stgit@morisot.1015granger.net>
In-Reply-To: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
References: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There are two new events that report slightly different information
for readpage and readpages.

For readpage:
             fsx-1387  [006]   380.761896: nfs_aops_readpage:    fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355910932437 page_index=32

The index of a synchronous single-page read is reported.

For readpages:

             fsx-1387  [006]   380.760847: nfs_aops_readpages:   fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355909932456 nr_pages=3

The count of pages requested is reported. readpages does not wait
for the READ requests to complete.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfstrace.h |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/read.c     |    8 ++----
 2 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index e9be65b52bfe..0534d090ee55 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -862,6 +862,76 @@ TRACE_EVENT(nfs_sillyrename_unlink,
 		)
 );
 
+TRACE_EVENT(nfs_aops_readpage,
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
+			__field(pgoff_t, index)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->index = page_index(page);
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu page_index=%lu",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->version,
+			__entry->index
+		)
+);
+
+TRACE_EVENT(nfs_aops_readpages,
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
 TRACE_EVENT(nfs_initiate_read,
 		TP_PROTO(
 			const struct nfs_pgio_header *hdr
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 08d6cc57cbc3..94690eda2a88 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -337,8 +337,7 @@ int nfs_readpage(struct file *file, struct page *page)
 	struct inode *inode = page_file_mapping(page)->host;
 	int ret;
 
-	dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
-		page, PAGE_SIZE, page_index(page));
+	trace_nfs_aops_readpage(inode, page);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
 
 	/*
@@ -403,10 +402,7 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	int ret;
 
-	dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
-			inode->i_sb->s_id,
-			(unsigned long long)NFS_FILEID(inode),
-			nr_pages);
+	trace_nfs_aops_readpages(inode, nr_pages);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
 
 	ret = -ESTALE;


