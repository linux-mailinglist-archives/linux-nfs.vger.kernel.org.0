Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0544F2A2C16
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 14:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgKBNve (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 08:51:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbgKBNuU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 08:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604325019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=4Cx6K3ggHUBx5scQPf00PZiwB8K7VLCXD77JJTECjB0=;
        b=dgp36B/jWz0Qd32quPUcqO7bHxEnUSsOS7vEZ9hJh+s7K7N+0towqxxJcI9dj0vW7pmpNw
        SvguLO1nZD1HCMpxRbj8S2okIDbI+r0s5So0V5bubdSzZJ39AfUApbHQPTZHP37ZCfr0d5
        ioaX1eemXBGT9cqDFSLNZemytavx+Bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-LV8o6bEGOj-WUJ0SGxxqMw-1; Mon, 02 Nov 2020 08:50:17 -0500
X-MC-Unique: LV8o6bEGOj-WUJ0SGxxqMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 674F8A42052;
        Mon,  2 Nov 2020 13:50:16 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-255.rdu2.redhat.com [10.10.113.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E34C5D9DD;
        Mon,  2 Nov 2020 13:50:15 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 05/11] NFS: Add tracepoints for opendir, closedir, fsync_dir and llseek_dir
Date:   Mon,  2 Nov 2020 08:50:05 -0500
Message-Id: <1604325011-29427-6-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a few more directory operation tracepoints and remove a few
more dfprintks.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/dir.c      | 10 +++++---
 fs/nfs/nfstrace.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 227cddc12983..e4cd9789ebb5 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -109,7 +109,7 @@ static void put_nfs_open_dir_context(struct inode *dir, struct nfs_open_dir_cont
 	int res = 0;
 	struct nfs_open_dir_context *ctx;
 
-	dfprintk(FILE, "NFS: open dir(%pD2)\n", filp);
+	trace_nfs_opendir_enter(file_inode(filp), file_dentry(filp));
 
 	nfs_inc_stats(inode, NFSIOS_VFSOPEN);
 
@@ -120,13 +120,16 @@ static void put_nfs_open_dir_context(struct inode *dir, struct nfs_open_dir_cont
 	}
 	filp->private_data = ctx;
 out:
+	trace_nfs_opendir_exit(file_inode(filp), file_dentry(filp), res);
 	return res;
 }
 
 static int
 nfs_closedir(struct inode *inode, struct file *filp)
 {
+	trace_nfs_closedir_enter(file_inode(filp), file_dentry(filp));
 	put_nfs_open_dir_context(file_inode(filp), filp->private_data);
+	trace_nfs_closedir_exit(file_inode(filp), file_dentry(filp), 0);
 	return 0;
 }
 
@@ -943,8 +946,7 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 	struct inode *inode = file_inode(filp);
 	struct nfs_open_dir_context *dir_ctx = filp->private_data;
 
-	dfprintk(FILE, "NFS: llseek dir(%pD2, %lld, %d)\n",
-			filp, offset, whence);
+	trace_nfs_llseek_dir_enter(inode, offset, whence);
 
 	switch (whence) {
 	default:
@@ -985,7 +987,7 @@ static int nfs_fsync_dir(struct file *filp, loff_t start, loff_t end,
 {
 	struct inode *inode = file_inode(filp);
 
-	dfprintk(FILE, "NFS: fsync dir(%pD2) datasync %d\n", filp, datasync);
+	trace_nfs_fsync_dir_enter(inode, start, end, datasync);
 
 	inode_lock(inode);
 	nfs_inc_stats(inode, NFSIOS_VFSFSYNC);
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index e6a946b83330..0ed330f323bb 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -667,6 +667,79 @@
 DEFINE_NFS_DIRECTORY_EVENT_DONE(nfs_unlink_exit);
 DEFINE_NFS_DIRECTORY_EVENT(nfs_symlink_enter);
 DEFINE_NFS_DIRECTORY_EVENT_DONE(nfs_symlink_exit);
+DEFINE_NFS_DIRECTORY_EVENT(nfs_opendir_enter);
+DEFINE_NFS_DIRECTORY_EVENT_DONE(nfs_opendir_exit);
+DEFINE_NFS_DIRECTORY_EVENT(nfs_closedir_enter);
+DEFINE_NFS_DIRECTORY_EVENT_DONE(nfs_closedir_exit);
+
+TRACE_EVENT(nfs_llseek_dir_enter,
+		TP_PROTO(
+			const struct inode *inode,
+			u64 offset,
+			int whence
+		),
+
+		TP_ARGS(inode, offset, whence),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(u64, offset)
+			__field(unsigned long, whence)
+		),
+
+		TP_fast_assign(
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->offset = offset;
+			__entry->whence = whence;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu handle=0x%08x offset=0x%08llx whence=%lu",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->offset, __entry->whence
+		)
+);
+
+TRACE_EVENT(nfs_fsync_dir_enter,
+		TP_PROTO(
+			const struct inode *inode,
+			u64 start,
+			u64 end,
+			int datasync
+		),
+
+		TP_ARGS(inode, start, end, datasync),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(u64, start)
+			__field(u64, end)
+			__field(unsigned long, datasync)
+		),
+
+		TP_fast_assign(
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->start = start;
+			__entry->end = end;
+			__entry->datasync = datasync;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu handle=0x%08x start=0x%08llx end=0x%08llx datasync=%lu",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->start, __entry->end, __entry->datasync
+		)
+);
 
 TRACE_EVENT(nfs_readdir_enter,
 		TP_PROTO(
-- 
1.8.3.1

