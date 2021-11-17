Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A0345503F
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 23:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbhKQWUf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Nov 2021 17:20:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241119AbhKQWUc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Nov 2021 17:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637187452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=pOVSo7AIopz8T/qZm0fpd1bkYSFNIYvYvnPcNIIJAU8=;
        b=RPzO+DOYQrMz5GXnPQ6598UZZ65I7hNwozcWMr404ttvQqJTQJGuDFpLed6QTS0OqcORYd
        g5ItAqaNPEdXa576lCvvpkJysScgGIK5uT0vukm14cSR+mTlPgxv3mJh0EKNm/4kIGu29k
        hW81YglsPXY7iQ6K/Dc9G6lA98+riB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-ZNQIPSMpNQyu7z2xqjh5qg-1; Wed, 17 Nov 2021 17:17:29 -0500
X-MC-Unique: ZNQIPSMpNQyu7z2xqjh5qg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BFBD100C660;
        Wed, 17 Nov 2021 22:17:28 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.32.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C02B960657;
        Wed, 17 Nov 2021 22:17:27 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH 5/7] NFS: Replace dfprintks with tracepoints in fscache read and write page functions
Date:   Wed, 17 Nov 2021 17:17:16 -0500
Message-Id: <1637187438-18858-6-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1637187438-18858-1-git-send-email-dwysocha@redhat.com>
References: <1637187438-18858-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Most of fscache and other NFS IO paths are now using tracepoints.
Remove the dfprintks in the NFS fscache read/write page functions
and replace with tracepoints at the begin and end of the functions.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c  |  51 ++++++++++-----------------
 fs/nfs/nfstrace.h | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 33 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 913a29f2b9e4..f4147a7915bd 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -382,9 +382,7 @@ static void nfs_fscache_read_page_complete(struct page *page,
 					       void *context,
 					       int error)
 {
-	dfprintk(FSCACHE,
-		 "NFS: fscache_read_page_complete (0x%p/0x%p/%d)\n",
-		 page, context, error);
+	trace_nfs_fscache_read_page_complete(page->mapping->host, page, 1, error);
 
 	/*
 	 * If the read completes with an error, mark the page with PG_checked,
@@ -405,13 +403,11 @@ int __nfs_fscache_read_page(struct nfs_open_context *ctx,
 {
 	int ret;
 
-	dfprintk(FSCACHE,
-		 "NFS: readpage_from_fscache(fsc:%p/p:%p(i:%lx f:%lx)/0x%p)\n",
-		 nfs_i_fscache(inode), page, page->index, page->flags, inode);
-
+	trace_nfs_fscache_read_pages(inode, page, 1);
 	if (PageChecked(page)) {
 		ClearPageChecked(page);
-		return 1;
+		ret = 1;
+		goto out;
 	}
 
 	ret = fscache_read_or_alloc_page(nfs_i_fscache(inode),
@@ -422,22 +418,21 @@ int __nfs_fscache_read_page(struct nfs_open_context *ctx,
 
 	switch (ret) {
 	case 0: /* read BIO submitted (page in fscache) */
-		dfprintk(FSCACHE,
-			 "NFS:    fscache_read_page: BIO submitted\n");
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
-		return ret;
+		break;
 
 	case -ENOBUFS: /* inode not in cache */
 	case -ENODATA: /* page not in cache */
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
-		dfprintk(FSCACHE,
-			 "NFS:    fscache_read_page %d\n", ret);
-		return 1;
+		ret = 1;
+		break;
 
 	default:
-		dfprintk(FSCACHE, "NFS:    fscache_read_page %d\n", ret);
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
 	}
+
+out:
+	trace_nfs_fscache_read_pages_exit(inode, page, 1, ret);
 	return ret;
 }
 
@@ -453,8 +448,7 @@ int __nfs_fscache_read_pages(struct nfs_open_context *ctx,
 	unsigned npages = *nr_pages;
 	int ret;
 
-	dfprintk(FSCACHE, "NFS: fscache_read_pages (0x%p/%u/0x%p)\n",
-		 nfs_i_fscache(inode), npages, inode);
+	trace_nfs_fscache_read_pages(inode, lru_to_page(pages), *nr_pages);
 
 	ret = fscache_read_or_alloc_pages(nfs_i_fscache(inode),
 					  mapping, pages, nr_pages,
@@ -472,22 +466,18 @@ int __nfs_fscache_read_pages(struct nfs_open_context *ctx,
 	case 0: /* read submitted to the cache for all pages */
 		BUG_ON(!list_empty(pages));
 		BUG_ON(*nr_pages != 0);
-		dfprintk(FSCACHE,
-			 "NFS: fscache_read_pages: submitted\n");
-
-		return ret;
+		break;
 
 	case -ENOBUFS: /* some pages aren't cached and can't be */
 	case -ENODATA: /* some pages aren't cached */
-		dfprintk(FSCACHE,
-			 "NFS: fscache_read_pages: no page: %d\n", ret);
-		return 1;
+		ret = 1;
+		break;
 
 	default:
-		dfprintk(FSCACHE,
-			 "NFS: fscache_read_pages: ret  %d\n", ret);
+		;
 	}
 
+	trace_nfs_fscache_read_pages_exit(inode, lru_to_page(pages), *nr_pages, ret);
 	return ret;
 }
 
@@ -499,16 +489,10 @@ void __nfs_fscache_write_page(struct inode *inode, struct page *page, int sync)
 {
 	int ret;
 
-	dfprintk(FSCACHE,
-		 "NFS: fscache_write_page(fsc:%p/p:%p(i:%lx f:%lx)/%d)\n",
-		 nfs_i_fscache(inode), page, page->index, page->flags, sync);
+	trace_nfs_fscache_write_page(inode, page, 1);
 
 	ret = fscache_write_page(nfs_i_fscache(inode), page,
 				 inode->i_size, GFP_KERNEL);
-	dfprintk(FSCACHE,
-		 "NFS:     nfs_fscache_write_page: p:%p(i:%lu f:%lx) ret %d\n",
-		 page, page->index, page->flags, ret);
-
 	if (ret != 0) {
 		fscache_uncache_page(nfs_i_fscache(inode), page);
 		nfs_inc_fscache_stats(inode,
@@ -518,4 +502,5 @@ void __nfs_fscache_write_page(struct inode *inode, struct page *page, int sync)
 		nfs_inc_fscache_stats(inode,
 				      NFSIOS_FSCACHE_PAGES_WRITTEN_OK);
 	}
+	trace_nfs_fscache_write_page_exit(inode, page, 1, ret);
 }
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 2da68adda88f..62c78e6b4582 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1097,6 +1097,107 @@
 		)
 );
 
+DECLARE_EVENT_CLASS(nfs_fscache_page_event,
+		TP_PROTO(
+			const struct inode *inode,
+			struct page *page,
+			unsigned int nr_pages
+		),
+
+		TP_ARGS(inode, page, nr_pages),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(loff_t, offset)
+			__field(u32, count)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = &nfsi->fh;
+
+			__entry->offset = page_index(page) << PAGE_SHIFT;
+			__entry->count = PAGE_SIZE*nr_pages;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(fh);
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%lld count=%u",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			(long long)__entry->offset, __entry->count
+		)
+);
+DECLARE_EVENT_CLASS(nfs_fscache_page_event_done,
+		TP_PROTO(
+			const struct inode *inode,
+			struct page *page,
+			unsigned int nr_pages,
+			int error
+		),
+
+		TP_ARGS(inode, page, nr_pages, error),
+
+		TP_STRUCT__entry(
+			__field(int, error)
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(loff_t, offset)
+			__field(u32, count)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = &nfsi->fh;
+
+			__entry->offset = page_index(page) << PAGE_SHIFT;
+			__entry->count = PAGE_SIZE*nr_pages;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(fh);
+			__entry->error = error;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%lld count=%u error=%d",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			(long long)__entry->offset, __entry->count,
+			__entry->error
+		)
+);
+#define DEFINE_NFS_FSCACHE_PAGE_EVENT(name) \
+	DEFINE_EVENT(nfs_fscache_page_event, name, \
+			TP_PROTO( \
+				const struct inode *inode, \
+				struct page *page, \
+				unsigned int nr_pages \
+			), \
+			TP_ARGS(inode, page, nr_pages))
+#define DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(name) \
+	DEFINE_EVENT(nfs_fscache_page_event_done, name, \
+			TP_PROTO( \
+				const struct inode *inode, \
+				struct page *page, \
+				unsigned int nr_pages, \
+				int error \
+			), \
+			TP_ARGS(inode, page, nr_pages, error))
+DEFINE_NFS_FSCACHE_PAGE_EVENT(nfs_fscache_read_pages);
+DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(nfs_fscache_read_pages_exit);
+DEFINE_NFS_FSCACHE_PAGE_EVENT(nfs_fscache_write_page);
+DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(nfs_fscache_write_page_exit);
+DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(nfs_fscache_read_page_complete);
+
 TRACE_EVENT(nfs_pgio_error,
 	TP_PROTO(
 		const struct nfs_pgio_header *hdr,
-- 
1.8.3.1

