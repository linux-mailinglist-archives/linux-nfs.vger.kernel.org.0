Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9150C425FE1
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Oct 2021 00:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbhJGWco (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 18:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237851AbhJGWcn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 18:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633645849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=dSbrdFbXZqha7P0aVddzpey9GeHmdmHkhSqVP6OSMgE=;
        b=Pkl5UovnGlSbhrF/UuLHmEKwuNjDi+wXZsk0jY+NV+xI6P68gJx0rqXBCxHMRiILC69K06
        0VbwEtgWtqFuVzPEDDb00YMBghIdPIUfzt2SZzAGNgldgCHDHp8cEc/WMFzNfVXgiis572
        NIput9coq4fEhK7JW1hZXNHlCuhQfdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-sBAe6yQhOJybspL-l-SiSw-1; Thu, 07 Oct 2021 18:30:48 -0400
X-MC-Unique: sBAe6yQhOJybspL-l-SiSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DF11824FA9;
        Thu,  7 Oct 2021 22:30:47 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F11B75D9C6;
        Thu,  7 Oct 2021 22:30:46 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH v2  5/7] NFS: Replace dfprintks with tracepoints in read and write page functions
Date:   Thu,  7 Oct 2021 18:30:21 -0400
Message-Id: <1633645823-31235-6-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
References: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Most of fscache and other NFS IO paths are now using tracepoints.
Remove the dfprintks in the NFS fscache read/write page functions
and replace with tracepoints at the begin and end of the functions.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c  | 29 ++++++-----------
 fs/nfs/nfstrace.h | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 50d68cb946c8..7dbe3a404f34 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -335,30 +335,27 @@ int __nfs_fscache_read_page(struct inode *inode, struct page *page)
 {
 	int ret;
 
-	dfprintk(FSCACHE,
-		 "NFS: readpage_from_fscache(fsc:%p/p:%p(i:%lx f:%lx)/0x%p)\n",
-		 nfs_i_fscache(inode), page, page->index, page->flags, inode);
-
+	trace_nfs_fscache_read_page(inode, page);
 	if (PageChecked(page)) {
-		dfprintk(FSCACHE, "NFS:    readpage_from_fscache: PageChecked\n");
 		ClearPageChecked(page);
-		return 1;
+		ret = 1;
+		goto out;
 	}
 
 	ret = fscache_fallback_read_page(nfs_i_fscache(inode), page);
 	if (ret < 0) {
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
-		dfprintk(FSCACHE,
-			 "NFS:    readpage_from_fscache failed %d\n", ret);
 		SetPageChecked(page);
-		return ret;
+		goto out;
 	}
 
 	/* Read completed synchronously */
-	dfprintk(FSCACHE, "NFS:    readpage_from_fscache: read successful\n");
 	nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
 	SetPageUptodate(page);
-	return 0;
+	ret = 0;
+out:
+	trace_nfs_fscache_read_page_done(inode, page, ret);
+	return ret;
 }
 
 /*
@@ -368,20 +365,14 @@ void __nfs_fscache_write_page(struct inode *inode, struct page *page)
 {
 	int ret;
 
-	dfprintk(FSCACHE,
-		 "NFS: readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx))\n",
-		 nfs_i_fscache(inode), page, page->index, page->flags);
-
+	trace_nfs_fscache_write_page(inode, page);
 	ret = fscache_fallback_write_page(nfs_i_fscache(inode), page);
 
-	dfprintk(FSCACHE,
-		 "NFS:     readpage_to_fscache: p:%p(i:%lu f:%lx) ret %d\n",
-		 page, page->index, page->flags, ret);
-
 	if (ret != 0) {
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL);
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_UNCACHED);
 	} else {
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_OK);
 	}
+	trace_nfs_fscache_write_page_done(inode, page, ret);
 }
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index b79f5fe2e39d..f751d841868c 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1012,6 +1012,102 @@
 		)
 );
 
+DECLARE_EVENT_CLASS(nfs_fscache_page_event,
+		TP_PROTO(
+			const struct inode *inode,
+			const struct page *page
+		),
+
+		TP_ARGS(inode, page),
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
+			__entry->offset = page->index << PAGE_SHIFT;
+			__entry->count = 4096;
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
+			const struct page *page,
+			int error
+		),
+
+		TP_ARGS(inode, page, error),
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
+			__entry->offset = page->index << PAGE_SHIFT;
+			__entry->count = 4096;
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
+				const struct page *page \
+			), \
+			TP_ARGS(inode, page))
+#define DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(name) \
+	DEFINE_EVENT(nfs_fscache_page_event_done, name, \
+			TP_PROTO( \
+				const struct inode *inode, \
+				const struct page *page, \
+				int error \
+			), \
+			TP_ARGS(inode, page, error))
+DEFINE_NFS_FSCACHE_PAGE_EVENT(nfs_fscache_read_page);
+DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(nfs_fscache_read_page_done);
+DEFINE_NFS_FSCACHE_PAGE_EVENT(nfs_fscache_write_page);
+DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(nfs_fscache_write_page_done);
+
 TRACE_EVENT(nfs_pgio_error,
 	TP_PROTO(
 		const struct nfs_pgio_header *hdr,
-- 
1.8.3.1

