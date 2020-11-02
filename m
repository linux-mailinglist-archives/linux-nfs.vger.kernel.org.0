Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE0B2A2BFF
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 14:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgKBNvN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 08:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgKBNuX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 08:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604325022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=A5QAluO9jJjtQ1kbWIac7ykdsGFp0O5j0QiLabMsVe8=;
        b=i2IQmrHkmvam9nHLZfgKp0fGxK4Irli8Ua8e1Ta1UYBw8Q7ym1Z2Toiehj/Qs3nOt8gLbu
        TsbK7bkB7Ydg0iP9MM2wBDhxVIY0HwjjrYf/N3mzMZDq6iQtjJf54vYxvg08KntP7dLqJE
        hxTKXJLAMURggcn23H+u5sduF1I2V/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-vPWh2UqRN8q4CSiGzlSgpA-1; Mon, 02 Nov 2020 08:50:20 -0500
X-MC-Unique: vPWh2UqRN8q4CSiGzlSgpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFE361099F7D;
        Mon,  2 Nov 2020 13:50:18 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-255.rdu2.redhat.com [10.10.113.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 832235D9DD;
        Mon,  2 Nov 2020 13:50:18 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/11] NFS: Add page_index to nfs_readdir enter and exit tracepoints
Date:   Mon,  2 Nov 2020 08:50:10 -0500
Message-Id: <1604325011-29427-11-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add nfs_open_dir_context.page_index to enter and exit tracepoints
since this affects searching the cache.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/dir.c      |  2 ++
 fs/nfs/nfstrace.h | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b266f505b521..cbd74cbdbb9f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -894,6 +894,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 	nfs_inc_stats(inode, NFSIOS_VFSGETDENTS);
 	trace_nfs_readdir_enter(inode, ctx->pos, dir_ctx->dir_cookie,
+				dir_ctx->page_index,
 				NFS_SERVER(inode)->dtsize, my_desc.plus);
 
 	/*
@@ -943,6 +944,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		res = 0;
 	dir_ctx->page_index = desc->page_index;
 	trace_nfs_readdir_exit(inode, ctx->pos, dir_ctx->dir_cookie,
+			       dir_ctx->page_index,
 			       NFS_SERVER(inode)->dtsize, my_desc.plus, res);
 	return res;
 }
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 06b301da85a2..12869b0c3f70 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -754,11 +754,12 @@
 			const struct inode *inode,
 			u64 cookie,
 			u64 dir_cookie,
+			unsigned long page_index,
 			unsigned int count,
 			bool plus
 		),
 
-		TP_ARGS(inode, cookie, dir_cookie, count, plus),
+		TP_ARGS(inode, cookie, dir_cookie, page_index, count, plus),
 
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
@@ -766,6 +767,7 @@
 			__field(u64, fileid)
 			__field(u64, cookie)
 			__field(u64, dir_cookie)
+			__field(unsigned long, page_index)
 			__field(u64, count)
 			__field(bool, plus)
 		),
@@ -776,15 +778,16 @@
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->cookie = cookie;
 			__entry->dir_cookie = dir_cookie;
+			__entry->page_index = page_index;
 			__entry->count = count;
 			__entry->plus = plus;
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x cookie=0x%08llx dir_cookie=0x%08llx count=%llu plus=%s",
+			"fileid=%02x:%02x:%llu fhandle=0x%08x cookie=0x%08llx dir_cookie=0x%08llx page_index=0x%08lx count=%llu plus=%s",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
-			(unsigned long long)__entry->fileid,
-			__entry->fhandle, __entry->cookie, __entry->dir_cookie,
+			(unsigned long long)__entry->fileid, __entry->fhandle,
+			__entry->cookie, __entry->dir_cookie, __entry->page_index,
 			__entry->count, __entry->plus ? "true" : "false"
 		)
 );
@@ -794,12 +797,13 @@
 			const struct inode *inode,
 			u64 cookie,
 			u64 dir_cookie,
+			unsigned long page_index,
 			unsigned int count,
 			bool plus,
 			int error
 		),
 
-		TP_ARGS(inode, cookie, dir_cookie, count, plus, error),
+		TP_ARGS(inode, cookie, dir_cookie, page_index, count, plus, error),
 
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
@@ -808,6 +812,7 @@
 			__field(unsigned long, error)
 			__field(u64, cookie)
 			__field(u64, dir_cookie)
+			__field(unsigned long, page_index)
 			__field(u64, count)
 			__field(bool, plus)
 		),
@@ -819,16 +824,17 @@
 			__entry->error = error;
 			__entry->cookie = cookie;
 			__entry->dir_cookie = dir_cookie;
+			__entry->page_index = page_index;
 			__entry->count = count;
 			__entry->plus = plus;
 		),
 
 		TP_printk(
-			"error=%ld fileid=%02x:%02x:%llu fhandle=0x%08x cookie=0x%08llx dir_cookie=0x%08llx count=%llu plus=%s",
+			"error=%ld fileid=%02x:%02x:%llu fhandle=0x%08x cookie=0x%08llx dir_cookie=0x%08llx page_index=0x%08lx count=%llu plus=%s",
 			__entry->error,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
-			(unsigned long long)__entry->fileid,
-			__entry->fhandle, __entry->cookie, __entry->dir_cookie,
+			(unsigned long long)__entry->fileid, __entry->fhandle,
+			__entry->cookie, __entry->dir_cookie, __entry->page_index,
 			__entry->count, __entry->plus ? "true" : "false"
 		)
 );
-- 
1.8.3.1

