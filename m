Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2DE426D1D
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Oct 2021 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbhJHO7w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Oct 2021 10:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhJHO7w (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 Oct 2021 10:59:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3AA860F9E
        for <linux-nfs@vger.kernel.org>; Fri,  8 Oct 2021 14:57:56 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3] NFS: Replace dprintk callsites in nfs_readpage(s)
Date:   Fri,  8 Oct 2021 10:57:55 -0400
Message-Id:  <163370502469.515303.12254136133220397877.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.33.0
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=6609; h=from:subject:message-id; bh=G9x98Ay1E4O3LrwTBeybs2q0RGRNkz+afXpJvWnCRIk=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhYFxsFZ0CTaiXq7pZxYKoRM04jPutFemjyExoYe2s ILUnpZSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWBcbAAKCRAzarMzb2Z/l3SXEA CSwY1+HM7QhiEpzaNyQaTMx5Gqi+IiJTsYP2+X2NqEgHGrshbQNsQNXpurkiOExfsNJnQUZVEv5XWV gzWjjq/1kDVsk/hppml5u3GsaV1BcQO8RMxU0VS/OaTyhsiNvAjakZOJgDB6PJ7mduvHm3mUwT0rc8 OHiMa7+KU9TsDs2Fb42U3s5uFwpnyM5sPZVJQswvkxTcdBPHI8YdT87hYO6kJGNETfWN/0/Nqbp1zQ rEEqjXWVo+Ud6jjhpo7Tt2Y11rYjsAff+oP/SYmfoRuAt4osOGmKYseN1jFjAd4f0ZCunCo+Vxvz+b ZVGFy3L2IFR8MmtNxlp1dUEzH7z6QYHtsX1z4sqTOzy/6dHFWKOvBjnTryjalDIDkjYnoGbIZRywPI +ZUwe1rqAyFxS14jiwj37EJVW8DMZM0t00WNH5BF0e2Ka6D13husBWLFHchq0UnrP9iBThGiZHqsEK ys942xxp7TkGxY4cejiLdn74foLLTvCrT1jZ5vMaiIEEgzbdNPFoQVgzmqENTpPbn0F+JZ5EB+sC4Z LkQiI/IT9DifWomffnFTYuFkvn93cMzuAkc6gAw7rrRlio/w+rFqqlNdAkEvwf0yyGlSbLqoUNNorF ZPcdd3QltzMnfpC+S3fgVs6EQYeHxBtl8iIJ+AzX1ERCL13kFLu1uTH7FzHg==
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

Changes since v3:
- Update the patch description to reflect recent changes
- Store and display file offset instead of page index

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
 

