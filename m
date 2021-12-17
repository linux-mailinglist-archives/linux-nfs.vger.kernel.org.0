Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8B5479325
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 18:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbhLQRyi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 12:54:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239469AbhLQRyh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 12:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639763677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=aPVedIJZs1KvAQojC4R91aK+V4iKPOQ4UAcSS085xiE=;
        b=hIMxWo98YsJh8BWht8HVNGFINI9A/TG0QMmMLPuHHqWoRK12X3f26qCd+rZIj3fEmq0Pq3
        27iH/iuvvwEa5QuX9zVqvBzOfKVqvkGrq4p2JQBihs3eXMDk5Lwo9UV4fx5zBtyh39mnL3
        ES+S2YZ5Cf4CLsMvh9LNy6FYKhKLdZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-VuqHuoa0N7KxOJwKNjTTlw-1; Fri, 17 Dec 2021 12:54:34 -0500
X-MC-Unique: VuqHuoa0N7KxOJwKNjTTlw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0947881CCB6;
        Fri, 17 Dec 2021 17:54:33 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F3AD1037F39;
        Fri, 17 Dec 2021 17:54:32 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH v2 3/4] NFS: Replace dfprintks with tracepoints in fscache read and write page functions
Date:   Fri, 17 Dec 2021 12:54:24 -0500
Message-Id: <1639763665-4917-4-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
References: <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Most of fscache and other NFS IO paths are now using tracepoints.
Remove the dfprintks in the NFS fscache read/write page functions
and replace with tracepoints at the begin and end of the functions.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c  | 29 +++++++-----------
 fs/nfs/nfstrace.h | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 62fbce28fe85..841b69aef189 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -19,6 +19,7 @@
 #include "internal.h"
 #include "iostat.h"
 #include "fscache.h"
+#include "nfstrace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_FSCACHE
 
@@ -321,30 +322,27 @@ int __nfs_fscache_read_page(struct inode *inode, struct page *page)
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
 
 	ret = fscache_fallback_read_page(inode, page);
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
+	trace_nfs_fscache_read_page_exit(inode, page, ret);
+	return ret;
 }
 
 /*
@@ -355,20 +353,15 @@ void __nfs_fscache_write_page(struct inode *inode, struct page *page)
 {
 	int ret;
 
-	dfprintk(FSCACHE,
-		 "NFS: readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx))\n",
-		 nfs_i_fscache(inode), page, page->index, page->flags);
+	trace_nfs_fscache_write_page(inode, page);
 
 	ret = fscache_fallback_write_page(inode, page, true);
 
-	dfprintk(FSCACHE,
-		 "NFS:     nfs_fscache_write_page: p:%p(i:%lu f:%lx) ret %d\n",
-		 page, page->index, page->flags, ret);
-
 	if (ret != 0) {
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL);
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_UNCACHED);
 	} else {
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_OK);
 	}
+	trace_nfs_fscache_write_page_exit(inode, page, ret);
 }
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 317ce27bdc4b..f4d335c22113 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1095,6 +1095,97 @@
 		)
 );
 
+DECLARE_EVENT_CLASS(nfs_fscache_page_event,
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
+			__field(loff_t, offset)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = &nfsi->fh;
+
+			__entry->offset = page_index(page) << PAGE_SHIFT;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(fh);
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%lld",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			(long long)__entry->offset
+		)
+);
+DECLARE_EVENT_CLASS(nfs_fscache_page_event_done,
+		TP_PROTO(
+			const struct inode *inode,
+			struct page *page,
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
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = &nfsi->fh;
+
+			__entry->offset = page_index(page) << PAGE_SHIFT;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(fh);
+			__entry->error = error;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%lld error=%d",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			(long long)__entry->offset, __entry->error
+		)
+);
+#define DEFINE_NFS_FSCACHE_PAGE_EVENT(name) \
+	DEFINE_EVENT(nfs_fscache_page_event, name, \
+			TP_PROTO( \
+				const struct inode *inode, \
+				struct page *page \
+			), \
+			TP_ARGS(inode, page))
+#define DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(name) \
+	DEFINE_EVENT(nfs_fscache_page_event_done, name, \
+			TP_PROTO( \
+				const struct inode *inode, \
+				struct page *page, \
+				int error \
+			), \
+			TP_ARGS(inode, page, error))
+DEFINE_NFS_FSCACHE_PAGE_EVENT(nfs_fscache_read_page);
+DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(nfs_fscache_read_page_exit);
+DEFINE_NFS_FSCACHE_PAGE_EVENT(nfs_fscache_write_page);
+DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(nfs_fscache_write_page_exit);
+
 TRACE_EVENT(nfs_pgio_error,
 	TP_PROTO(
 		const struct nfs_pgio_header *hdr,
-- 
1.8.3.1

