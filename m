Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CD2425793
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 18:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbhJGQTM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 12:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242677AbhJGQTC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Oct 2021 12:19:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06A876105A;
        Thu,  7 Oct 2021 16:17:07 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFS: Replace dprintk callsites in nfs_readpage(s)
Date:   Thu,  7 Oct 2021 12:17:07 -0400
Message-Id:  <163362342678.1680.15890862221793282300.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.33.0
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=6154; h=from:subject:message-id; bh=wvwuWds0vvcQAQ+eG8i8Zbm5daYEd7qZvmYu0pv+QzA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhXx2CHOgGAwLGJVo2QGb4jMCEduhSAdiDomQkRImb Z2CLcIaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYV8dggAKCRAzarMzb2Z/lwyyEA CR/NO+ZN5SA0bekDyMNefGZCBzxe133cvdU4ZxXTjXo5yZh9jGXZL1Z5qraCm3L0nj758i79XltpMk Jj2siW3o3nFjLSWVdii7R7DkdpORQNKdWOMPtWg1QDzkzGCIu9VpU92KXM2IyzTk1LuSRcFie7Igao 3vYamvfKU3RtfM+jwOhqIvVCcAUEy3XSb5t2AvPACIJIR2GDVPVV+dKeo0EEZyiVYxS753+fqbpo3m 7obkDco3Oj+1clEh1KMrtr+53s8yC+Lkq9NT3gp6aRy8bUOJ/BlXmyxH9qScWgk25STjRfRNuRtQx/ vy9dG/91+3mqBMJtwow0ojG2rD80v4BROwVEDQy+qQwZ+GpgpuEaE4Ug02uEq+t3gYs7z3sNejCkXh 9kHyPCAQ63+2+9Bz8hK8zD4qy1FS0p1rtbkGtvpXlutemxD6RMMPplHwm9v3KaLHcoIQnmvj2IJTZ6 KZBw62AF40QaccZz9zWT8oM1UW+fkELgZwGmNQi+z1ZDaBgwcFpBI3ecyLWgSsGziqwgrWbJQDB7Ul uahk6LeUs8jQwtItZp9kBS425Oi339viTKspov3q7DktuXjf6Wvs7bhLT94PQVg9Vg+sEpp3NWSSot qTQb6VWhOvln5NPsQk/ug5A4Ky+qNYOS0++7Df0lEJZPTFEjAQf2FoOImYfA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
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
 fs/nfs/nfstrace.h |  146 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/read.c     |   11 ++--
 2 files changed, 151 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index e9be65b52bfe..85e67b326bcd 100644
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
+			__entry->ret = ret;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu page_index=%lu ret=%d",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->version,
+			__entry->index, __entry->ret
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
 

