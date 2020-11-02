Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80BC2A2C11
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 14:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgKBNvd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 08:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725927AbgKBNuT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 08:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604325017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=MeH4WQdTlQCh8nJjD9N4/seSFRiZo6NmrVULAUIRh7g=;
        b=XBnBADNxKWndU9cHl9BkKPZyZEY8mJm1Kc4kMn3XHoIuq0C0sA7dw/w9moOXotYdnyhfI6
        LroPj4mx3ylAWWZ/fQe6dOa7I6M5Fd2mHNogCrY0jfDGGCMM6x8rXZSMlNLLasE6uZUhSG
        0l0cqI42Jx0jNK0YHWFlugSNhPOcA40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-XNcaEiCEN6m1i3T_LW0wTA-1; Mon, 02 Nov 2020 08:50:16 -0500
X-MC-Unique: XNcaEiCEN6m1i3T_LW0wTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E835FA4206B;
        Mon,  2 Nov 2020 13:50:14 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-255.rdu2.redhat.com [10.10.113.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F8385D9DD;
        Mon,  2 Nov 2020 13:50:14 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 02/11] NFS: Replace dfprintk statements with trace events in nfs_readdir
Date:   Mon,  2 Nov 2020 08:50:02 -0500
Message-Id: <1604325011-29427-3-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove a couple dfprintks in nfs_readdir and replace them with
trace events on entry/exit that contain more information.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/dir.c      |  7 +++--
 fs/nfs/nfstrace.h | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index cb52db9a0cfb..116493e66922 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -900,9 +900,9 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 			*desc = &my_desc;
 	int res = 0;
 
-	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
-			file, (long long)ctx->pos);
 	nfs_inc_stats(inode, NFSIOS_VFSGETDENTS);
+	trace_nfs_readdir_enter(inode, ctx->pos, dir_ctx->dir_cookie,
+				NFS_SERVER(inode)->dtsize, my_desc.plus);
 
 	/*
 	 * ctx->pos points to the dirent entry number.
@@ -949,7 +949,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 out:
 	if (res > 0)
 		res = 0;
-	dfprintk(FILE, "NFS: readdir(%pD2) returns %d\n", file, res);
+	trace_nfs_readdir_exit(inode, ctx->pos, dir_ctx->dir_cookie,
+			       NFS_SERVER(inode)->dtsize, my_desc.plus, res);
 	return res;
 }
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 5a59dcdce0b2..6bbe0aa221f2 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -668,6 +668,90 @@
 DEFINE_NFS_DIRECTORY_EVENT(nfs_symlink_enter);
 DEFINE_NFS_DIRECTORY_EVENT_DONE(nfs_symlink_exit);
 
+TRACE_EVENT(nfs_readdir_enter,
+		TP_PROTO(
+			const struct inode *inode,
+			u64 cookie,
+			u64 dir_cookie,
+			unsigned int count,
+			bool plus
+		),
+
+		TP_ARGS(inode, cookie, dir_cookie, count, plus),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(u64, cookie)
+			__field(u64, dir_cookie)
+			__field(u64, count)
+			__field(bool, plus)
+		),
+
+		TP_fast_assign(
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->cookie = cookie;
+			__entry->dir_cookie = dir_cookie;
+			__entry->count = count;
+			__entry->plus = plus;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x cookie=0x%08llx dir_cookie=0x%08llx count=%llu plus=%s",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->cookie, __entry->dir_cookie,
+			__entry->count, __entry->plus ? "true" : "false"
+		)
+);
+
+TRACE_EVENT(nfs_readdir_exit,
+		TP_PROTO(
+			const struct inode *inode,
+			u64 cookie,
+			u64 dir_cookie,
+			unsigned int count,
+			bool plus,
+			int error
+		),
+
+		TP_ARGS(inode, cookie, dir_cookie, count, plus, error),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(unsigned long, error)
+			__field(u64, cookie)
+			__field(u64, dir_cookie)
+			__field(u64, count)
+			__field(bool, plus)
+		),
+
+		TP_fast_assign(
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->error = error;
+			__entry->cookie = cookie;
+			__entry->dir_cookie = dir_cookie;
+			__entry->count = count;
+			__entry->plus = plus;
+		),
+
+		TP_printk(
+			"error=%ld fileid=%02x:%02x:%llu fhandle=0x%08x cookie=0x%08llx dir_cookie=0x%08llx count=%llu plus=%s",
+			__entry->error,
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->cookie, __entry->dir_cookie,
+			__entry->count, __entry->plus ? "true" : "false"
+		)
+);
+
 TRACE_EVENT(nfs_link_enter,
 		TP_PROTO(
 			const struct inode *inode,
-- 
1.8.3.1

