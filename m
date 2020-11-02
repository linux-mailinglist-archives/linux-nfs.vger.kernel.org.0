Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2422A2C10
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 14:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgKBNvc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 08:51:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbgKBNuU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 08:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604325018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=HnkXIkWkSO1sjzbcqpAshdTprsfO8JyCeJtXHZkA5qI=;
        b=cFr5wC3PKd/PwO2P89JrZNAijPIMlrseOM44Slq1dGxEqNyy9ilPk7AzsSQU+Mc13UOnXQ
        pZkzRhHC8PAp9ePKBOIbfp4R/0mHqM6Y5HAawfQsbqopjD3OJnxpBuZmjkirAJcCIbjVfF
        IXXSmCLd89RU3Xpf6pJVopTzbaL5ie4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-txq02oJYNduriAKhY-L3Yg-1; Mon, 02 Nov 2020 08:50:17 -0500
X-MC-Unique: txq02oJYNduriAKhY-L3Yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E402A191E2A0;
        Mon,  2 Nov 2020 13:50:15 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-255.rdu2.redhat.com [10.10.113.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A3D25D9DD;
        Mon,  2 Nov 2020 13:50:15 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 04/11] NFS: Add tracepoints for functions involving nfs_readdir_descriptor_t
Date:   Mon,  2 Nov 2020 08:50:04 -0500
Message-Id: <1604325011-29427-5-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add more tracepoints in the NFS readdir code to trace functions
which change members of nfs_readdir_descriptor_t.  In the process,
remove two more dfprintks inside uncached_readdir().

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/dir.c      |  10 +++---
 fs/nfs/nfstrace.h | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 145393188f6a..227cddc12983 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -329,6 +329,7 @@ int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
 	struct nfs_cache_array *array;
 	int status;
 
+	trace_nfs_readdir_search_array_enter(desc);
 	array = kmap(desc->page);
 
 	if (*desc->dir_cookie == 0)
@@ -342,6 +343,7 @@ int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
 		desc->page_index++;
 	}
 	kunmap(desc->page);
+	trace_nfs_readdir_search_array_exit(desc, status);
 	return status;
 }
 
@@ -762,6 +764,7 @@ int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
 {
 	int res;
 
+	trace_nfs_readdir_search_pagecache_enter(desc);
 	if (desc->page_index == 0) {
 		desc->current_index = 0;
 		desc->prev_index = 0;
@@ -770,6 +773,7 @@ int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
 	do {
 		res = find_and_lock_cache_page(desc);
 	} while (res == -EAGAIN);
+	trace_nfs_readdir_search_pagecache_exit(desc, res);
 	return res;
 }
 
@@ -835,8 +839,7 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 	struct inode *inode = file_inode(desc->file);
 	struct nfs_open_dir_context *ctx = desc->file->private_data;
 
-	dfprintk(DIRCACHE, "NFS: uncached_readdir() searching for cookie %Lu\n",
-			(unsigned long long)*desc->dir_cookie);
+	trace_nfs_uncached_readdir_enter(desc);
 
 	page = alloc_page(GFP_HIGHUSER);
 	if (!page) {
@@ -859,8 +862,7 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 	nfs_readdir_clear_array(desc->page);
 	cache_page_release(desc);
  out:
-	dfprintk(DIRCACHE, "NFS: %s: returns %d\n",
-			__func__, status);
+	trace_nfs_uncached_readdir_exit(desc, status);
 	return status;
 }
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 6bbe0aa221f2..e6a946b83330 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -752,6 +752,108 @@
 		)
 );
 
+DECLARE_EVENT_CLASS(nfs_readdir_descriptor_event_enter,
+		TP_PROTO(
+				const nfs_readdir_descriptor_t *desc
+			),
+
+		TP_ARGS(desc),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u64, fileid)
+			__field(u32, fhandle)
+			__field(u64, dir_cookie)
+			__field(u64, page_index)
+			__field(u64, last_cookie)
+			__field(u64, current_index)
+			__field(u64, prev_index)
+		),
+
+		TP_fast_assign(
+			__entry->dev = file_inode(desc->file)->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(file_inode(desc->file));
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(file_inode(desc->file)));
+			__entry->dir_cookie = *desc->dir_cookie;
+			__entry->page_index = desc->page_index;
+			__entry->last_cookie = desc->last_cookie;
+			__entry->current_index = desc->current_index;
+			__entry->prev_index = desc->prev_index;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x dir_cookie=0x%08llx last_cookie=0x%08llx page_index=0x%08llx current_index=0x%08llu prev_index=0x%08llu",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid, __entry->fhandle,
+			__entry->dir_cookie, __entry->last_cookie, __entry->page_index,
+			__entry->current_index, __entry->prev_index
+		)
+);
+
+#define DEFINE_NFS_READDIR_DESCRIPTOR_EVENT(name) \
+	DEFINE_EVENT(nfs_readdir_descriptor_event_enter, name, \
+			TP_PROTO( \
+				const nfs_readdir_descriptor_t *desc \
+			), \
+			TP_ARGS(desc))
+
+DECLARE_EVENT_CLASS(nfs_readdir_descriptor_event_exit,
+		TP_PROTO(
+				const nfs_readdir_descriptor_t *desc,
+				int error
+			),
+
+		TP_ARGS(desc, error),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u64, fileid)
+			__field(u32, fhandle)
+			__field(u64, dir_cookie)
+			__field(unsigned long, error)
+			__field(u64, page_index)
+			__field(u64, last_cookie)
+			__field(u64, current_index)
+			__field(u64, prev_index)
+		),
+
+		TP_fast_assign(
+			__entry->dev = file_inode(desc->file)->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(file_inode(desc->file));
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(file_inode(desc->file)));
+			__entry->dir_cookie = *desc->dir_cookie;
+			__entry->error = error;
+			__entry->page_index = desc->page_index;
+			__entry->last_cookie = desc->last_cookie;
+			__entry->current_index = desc->current_index;
+			__entry->prev_index = desc->prev_index;
+		),
+
+		TP_printk(
+			"error=%ld fileid=%02x:%02x:%llu fhandle=0x%08x dir_cookie=0x%08llx last_cookie=0x%08llx page_index=0x%08llx current_index=0x%08llu prev_index=0x%08llu",
+			__entry->error,
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid, __entry->fhandle,
+			__entry->dir_cookie, __entry->last_cookie, __entry->page_index,
+			__entry->current_index, __entry->prev_index
+		)
+);
+
+#define DEFINE_NFS_READDIR_DESCRIPTOR_EVENT_EXIT(name) \
+	DEFINE_EVENT(nfs_readdir_descriptor_event_exit, name, \
+			TP_PROTO( \
+				const nfs_readdir_descriptor_t *desc, \
+				int error \
+			), \
+			TP_ARGS(desc, error))
+
+DEFINE_NFS_READDIR_DESCRIPTOR_EVENT(nfs_uncached_readdir_enter);
+DEFINE_NFS_READDIR_DESCRIPTOR_EVENT_EXIT(nfs_uncached_readdir_exit);
+DEFINE_NFS_READDIR_DESCRIPTOR_EVENT(nfs_readdir_search_pagecache_enter);
+DEFINE_NFS_READDIR_DESCRIPTOR_EVENT_EXIT(nfs_readdir_search_pagecache_exit);
+DEFINE_NFS_READDIR_DESCRIPTOR_EVENT(nfs_readdir_search_array_enter);
+DEFINE_NFS_READDIR_DESCRIPTOR_EVENT_EXIT(nfs_readdir_search_array_exit);
+
 TRACE_EVENT(nfs_link_enter,
 		TP_PROTO(
 			const struct inode *inode,
-- 
1.8.3.1

