Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D40B437F3D
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhJVUTQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232082AbhJVUTQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 22 Oct 2021 16:19:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB6ED610CB;
        Fri, 22 Oct 2021 20:16:57 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     kolga@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] NFS: Move generic FS show macros to global header
Date:   Fri, 22 Oct 2021 16:16:56 -0400
Message-Id:  <163493381671.45814.11254555052679404974.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163493357334.45814.12809635386158569619.stgit@bazille.1015granger.net>
References:  <163493357334.45814.12809635386158569619.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=16619; h=from:subject:message-id; bh=+nqITw2+E2mXqFkOAuKVKFNLRuHs8aIbkAmKOFU4IBc=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhcxw40gB2S5o4Doq/X/z4EngauR2TmlQye5XmXNWw jzB9grGJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYXMcOAAKCRAzarMzb2Z/l7zfD/ wP0XCXMg2lEME+TysR7xqq9BXpQMcAP/ABK7WqV3cIu6vd6z+rbHkVU3ng9Mwzc2nSmhEW78MZiBTP oEDd5E6yHX6hTEuczSlswcSh3s7LVKGjltBO8SbZGghyiU3S2Bd+WMrMzmJd588MR8F8I5L5Ea65of 4ucHzltOgbzisPxJondPAmDfVV/2wYXqJowZTwlelzAMr7SyK5CUq8R8cnS6DAYsN7nDTSkhYESU87 X90FIoTXOkytrnZZ2hCRIOfelXmTXEid3rN/bsvdYAH4QQ82OTvJFzixc8BlPBx1jZLieFeNR7rL0k 2ev4eVOi0l4/yraqCcMSQvVwiP5kcTPes2/RD0SOUcN1iBt/UM0H6qK3TauvhBk8ozGBuIJKmRu6Wt DceI69xmJ+swMH+VlnxGzT6wIPnwqZGyUuqL+5ElgKgCAWrss1kxcI1PiLIuW5a6Wbzm+cm+GgPzKd IyJVRkUVvcQ+KuKsih84oHZK/pOSmtQDqduNDthb/kaEkMQypEQrwzfx4OWRf8+YXI/zm3zhkyOQF0 i7W1wqX1vUM0DIGWSHCoK+jEBs0ES+gVa2d/k0uOlhLeb25ZEtZ2ninAyAqvEvWmWNJGVhLsUMP4LL +Sbq7Xr1lF14GQFHMNFhkE64KdENI7AgkRbgOLwydU/231WC1no8kNE3Ii8A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Surface useful show_ macros for use by other trace
subsystems.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4trace.h        |   67 +++++++------------------
 fs/nfs/nfstrace.h         |   80 ++++++------------------------
 include/trace/events/fs.h |  122 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 113 deletions(-)
 create mode 100644 include/trace/events/fs.h

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index d4f061046c09..424d9cd4c196 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -11,6 +11,8 @@
 #include <linux/tracepoint.h>
 #include <trace/events/sunrpc_base.h>
 
+#include <trace/events/fs.h>
+
 TRACE_DEFINE_ENUM(EPERM);
 TRACE_DEFINE_ENUM(ENOENT);
 TRACE_DEFINE_ENUM(EIO);
@@ -314,19 +316,6 @@ TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
 		{ NFS4ERR_RESET_TO_MDS, "RESET_TO_MDS" }, \
 		{ NFS4ERR_RESET_TO_PNFS, "RESET_TO_PNFS" })
 
-#define show_open_flags(flags) \
-	__print_flags(flags, "|", \
-		{ O_CREAT, "O_CREAT" }, \
-		{ O_EXCL, "O_EXCL" }, \
-		{ O_TRUNC, "O_TRUNC" }, \
-		{ O_DIRECT, "O_DIRECT" })
-
-#define show_fmode_flags(mode) \
-	__print_flags(mode, "|", \
-		{ ((__force unsigned long)FMODE_READ), "READ" }, \
-		{ ((__force unsigned long)FMODE_WRITE), "WRITE" }, \
-		{ ((__force unsigned long)FMODE_EXEC), "EXEC" })
-
 #define show_nfs_fattr_flags(valid) \
 	__print_flags((unsigned long)valid, "|", \
 		{ NFS_ATTR_FATTR_TYPE, "TYPE" }, \
@@ -794,8 +783,8 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(unsigned int, flags)
-			__field(unsigned int, fmode)
+			__field(unsigned long, flags)
+			__field(unsigned long, fmode)
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
@@ -813,7 +802,7 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 
 			__entry->error = -error;
 			__entry->flags = flags;
-			__entry->fmode = (__force unsigned int)ctx->mode;
+			__entry->fmode = (__force unsigned long)ctx->mode;
 			__entry->dev = ctx->dentry->d_sb->s_dev;
 			if (!IS_ERR_OR_NULL(state)) {
 				inode = state->inode;
@@ -843,15 +832,15 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 		),
 
 		TP_printk(
-			"error=%ld (%s) flags=%d (%s) fmode=%s "
+			"error=%ld (%s) flags=%lu (%s) fmode=%s "
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"name=%02x:%02x:%llu/%s stateid=%d:0x%08x "
 			"openstateid=%d:0x%08x",
 			 -__entry->error,
 			 show_nfsv4_errors(__entry->error),
 			 __entry->flags,
-			 show_open_flags(__entry->flags),
-			 show_fmode_flags(__entry->fmode),
+			 show_fs_fcntl_open_flags(__entry->flags),
+			 show_fs_fmode_flags(__entry->fmode),
 			 MAJOR(__entry->dev), MINOR(__entry->dev),
 			 (unsigned long long)__entry->fileid,
 			 __entry->fhandle,
@@ -905,7 +894,7 @@ TRACE_EVENT(nfs4_cached_open,
 		TP_printk(
 			"fmode=%s fileid=%02x:%02x:%llu "
 			"fhandle=0x%08x stateid=%d:0x%08x",
-			__entry->fmode ?  show_fmode_flags(__entry->fmode) :
+			__entry->fmode ?  show_fs_fmode_flags(__entry->fmode) :
 					  "closed",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -953,7 +942,7 @@ TRACE_EVENT(nfs4_close,
 			"fhandle=0x%08x openstateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
-			__entry->fmode ?  show_fmode_flags(__entry->fmode) :
+			__entry->fmode ?  show_fs_fmode_flags(__entry->fmode) :
 					  "closed",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -962,24 +951,6 @@ TRACE_EVENT(nfs4_close,
 		)
 );
 
-TRACE_DEFINE_ENUM(F_GETLK);
-TRACE_DEFINE_ENUM(F_SETLK);
-TRACE_DEFINE_ENUM(F_SETLKW);
-TRACE_DEFINE_ENUM(F_RDLCK);
-TRACE_DEFINE_ENUM(F_WRLCK);
-TRACE_DEFINE_ENUM(F_UNLCK);
-
-#define show_lock_cmd(type) \
-	__print_symbolic((int)type, \
-		{ F_GETLK, "GETLK" }, \
-		{ F_SETLK, "SETLK" }, \
-		{ F_SETLKW, "SETLKW" })
-#define show_lock_type(type) \
-	__print_symbolic((int)type, \
-		{ F_RDLCK, "RDLCK" }, \
-		{ F_WRLCK, "WRLCK" }, \
-		{ F_UNLCK, "UNLCK" })
-
 DECLARE_EVENT_CLASS(nfs4_lock_event,
 		TP_PROTO(
 			const struct file_lock *request,
@@ -992,8 +963,8 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(int, cmd)
-			__field(char, type)
+			__field(unsigned long, cmd)
+			__field(unsigned long, type)
 			__field(loff_t, start)
 			__field(loff_t, end)
 			__field(dev_t, dev)
@@ -1026,8 +997,8 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 			"stateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
-			show_lock_cmd(__entry->cmd),
-			show_lock_type(__entry->type),
+			show_fs_fcntl_cmd(__entry->cmd),
+			show_fs_fcntl_lock_type(__entry->type),
 			(long long)__entry->start,
 			(long long)__entry->end,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1062,8 +1033,8 @@ TRACE_EVENT(nfs4_set_lock,
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(int, cmd)
-			__field(char, type)
+			__field(unsigned long, cmd)
+			__field(unsigned long, type)
 			__field(loff_t, start)
 			__field(loff_t, end)
 			__field(dev_t, dev)
@@ -1102,8 +1073,8 @@ TRACE_EVENT(nfs4_set_lock,
 			"stateid=%d:0x%08x lockstateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
-			show_lock_cmd(__entry->cmd),
-			show_lock_type(__entry->type),
+			show_fs_fcntl_cmd(__entry->cmd),
+			show_fs_fcntl_lock_type(__entry->type),
 			(long long)__entry->start,
 			(long long)__entry->end,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1220,7 +1191,7 @@ DECLARE_EVENT_CLASS(nfs4_set_delegation_event,
 
 		TP_printk(
 			"fmode=%s fileid=%02x:%02x:%llu fhandle=0x%08x",
-			show_fmode_flags(__entry->fmode),
+			show_fs_fmode_flags(__entry->fmode),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 83e9615c8b8c..331bcc0c0a75 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -11,20 +11,9 @@
 #include <linux/tracepoint.h>
 #include <linux/iversion.h>
 
+#include <trace/events/fs.h>
 #include <trace/events/sunrpc_base.h>
 
-#define nfs_show_file_type(ftype) \
-	__print_symbolic(ftype, \
-			{ DT_UNKNOWN, "UNKNOWN" }, \
-			{ DT_FIFO, "FIFO" }, \
-			{ DT_CHR, "CHR" }, \
-			{ DT_DIR, "DIR" }, \
-			{ DT_BLK, "BLK" }, \
-			{ DT_REG, "REG" }, \
-			{ DT_LNK, "LNK" }, \
-			{ DT_SOCK, "SOCK" }, \
-			{ DT_WHT, "WHT" })
-
 #define nfs_show_cache_validity(v) \
 	__print_flags(v, "|", \
 			{ NFS_INO_INVALID_DATA, "INVALID_DATA" }, \
@@ -131,7 +120,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event_done,
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			__entry->type,
-			nfs_show_file_type(__entry->type),
+			show_fs_dirent_type(__entry->type),
 			(unsigned long long)__entry->version,
 			(long long)__entry->size,
 			__entry->cache_validity,
@@ -222,7 +211,7 @@ TRACE_EVENT(nfs_access_exit,
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			__entry->type,
-			nfs_show_file_type(__entry->type),
+			show_fs_dirent_type(__entry->type),
 			(unsigned long long)__entry->version,
 			(long long)__entry->size,
 			__entry->cache_validity,
@@ -283,21 +272,6 @@ DEFINE_NFS_UPDATE_SIZE_EVENT(wcc);
 DEFINE_NFS_UPDATE_SIZE_EVENT(update);
 DEFINE_NFS_UPDATE_SIZE_EVENT(grow);
 
-#define show_lookup_flags(flags) \
-	__print_flags(flags, "|", \
-			{ LOOKUP_FOLLOW, "FOLLOW" }, \
-			{ LOOKUP_DIRECTORY, "DIRECTORY" }, \
-			{ LOOKUP_AUTOMOUNT, "AUTOMOUNT" }, \
-			{ LOOKUP_PARENT, "PARENT" }, \
-			{ LOOKUP_REVAL, "REVAL" }, \
-			{ LOOKUP_RCU, "RCU" }, \
-			{ LOOKUP_OPEN, "OPEN" }, \
-			{ LOOKUP_CREATE, "CREATE" }, \
-			{ LOOKUP_EXCL, "EXCL" }, \
-			{ LOOKUP_RENAME_TARGET, "RENAME_TARGET" }, \
-			{ LOOKUP_EMPTY, "EMPTY" }, \
-			{ LOOKUP_DOWN, "DOWN" })
-
 DECLARE_EVENT_CLASS(nfs_lookup_event,
 		TP_PROTO(
 			const struct inode *dir,
@@ -324,7 +298,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event,
 		TP_printk(
 			"flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			__entry->flags,
-			show_lookup_flags(__entry->flags),
+			show_fs_lookup_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -370,7 +344,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
 			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			-__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
-			show_lookup_flags(__entry->flags),
+			show_fs_lookup_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -392,30 +366,6 @@ DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_exit);
 DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_enter);
 DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_revalidate_exit);
 
-#define show_open_flags(flags) \
-	__print_flags(flags, "|", \
-		{ O_WRONLY, "O_WRONLY" }, \
-		{ O_RDWR, "O_RDWR" }, \
-		{ O_CREAT, "O_CREAT" }, \
-		{ O_EXCL, "O_EXCL" }, \
-		{ O_NOCTTY, "O_NOCTTY" }, \
-		{ O_TRUNC, "O_TRUNC" }, \
-		{ O_APPEND, "O_APPEND" }, \
-		{ O_NONBLOCK, "O_NONBLOCK" }, \
-		{ O_DSYNC, "O_DSYNC" }, \
-		{ O_DIRECT, "O_DIRECT" }, \
-		{ O_LARGEFILE, "O_LARGEFILE" }, \
-		{ O_DIRECTORY, "O_DIRECTORY" }, \
-		{ O_NOFOLLOW, "O_NOFOLLOW" }, \
-		{ O_NOATIME, "O_NOATIME" }, \
-		{ O_CLOEXEC, "O_CLOEXEC" })
-
-#define show_fmode_flags(mode) \
-	__print_flags(mode, "|", \
-		{ ((__force unsigned long)FMODE_READ), "READ" }, \
-		{ ((__force unsigned long)FMODE_WRITE), "WRITE" }, \
-		{ ((__force unsigned long)FMODE_EXEC), "EXEC" })
-
 TRACE_EVENT(nfs_atomic_open_enter,
 		TP_PROTO(
 			const struct inode *dir,
@@ -427,7 +377,7 @@ TRACE_EVENT(nfs_atomic_open_enter,
 
 		TP_STRUCT__entry(
 			__field(unsigned long, flags)
-			__field(unsigned int, fmode)
+			__field(unsigned long, fmode)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, ctx->dentry->d_name.name)
@@ -437,15 +387,15 @@ TRACE_EVENT(nfs_atomic_open_enter,
 			__entry->dev = dir->i_sb->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
-			__entry->fmode = (__force unsigned int)ctx->mode;
+			__entry->fmode = (__force unsigned long)ctx->mode;
 			__assign_str(name, ctx->dentry->d_name.name);
 		),
 
 		TP_printk(
 			"flags=0x%lx (%s) fmode=%s name=%02x:%02x:%llu/%s",
 			__entry->flags,
-			show_open_flags(__entry->flags),
-			show_fmode_flags(__entry->fmode),
+			show_fs_fcntl_open_flags(__entry->flags),
+			show_fs_fmode_flags(__entry->fmode),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -465,7 +415,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
 			__field(unsigned long, flags)
-			__field(unsigned int, fmode)
+			__field(unsigned long, fmode)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, ctx->dentry->d_name.name)
@@ -476,7 +426,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 			__entry->dev = dir->i_sb->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
-			__entry->fmode = (__force unsigned int)ctx->mode;
+			__entry->fmode = (__force unsigned long)ctx->mode;
 			__assign_str(name, ctx->dentry->d_name.name);
 		),
 
@@ -485,8 +435,8 @@ TRACE_EVENT(nfs_atomic_open_exit,
 			"name=%02x:%02x:%llu/%s",
 			-__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
-			show_open_flags(__entry->flags),
-			show_fmode_flags(__entry->fmode),
+			show_fs_fcntl_open_flags(__entry->flags),
+			show_fs_fmode_flags(__entry->fmode),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -519,7 +469,7 @@ TRACE_EVENT(nfs_create_enter,
 		TP_printk(
 			"flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			__entry->flags,
-			show_open_flags(__entry->flags),
+			show_fs_fcntl_open_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -556,7 +506,7 @@ TRACE_EVENT(nfs_create_exit,
 			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			-__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
-			show_open_flags(__entry->flags),
+			show_fs_fcntl_open_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
diff --git a/include/trace/events/fs.h b/include/trace/events/fs.h
new file mode 100644
index 000000000000..738b97f22f36
--- /dev/null
+++ b/include/trace/events/fs.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Display helpers for generic filesystem items
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#include <linux/fs.h>
+
+#define show_fs_dirent_type(x) \
+	__print_symbolic(x, \
+		{ DT_UNKNOWN,		"UNKNOWN" }, \
+		{ DT_FIFO,		"FIFO" }, \
+		{ DT_CHR,		"CHR" }, \
+		{ DT_DIR,		"DIR" }, \
+		{ DT_BLK,		"BLK" }, \
+		{ DT_REG,		"REG" }, \
+		{ DT_LNK,		"LNK" }, \
+		{ DT_SOCK,		"SOCK" }, \
+		{ DT_WHT,		"WHT" })
+
+#define show_fs_fcntl_open_flags(x) \
+	__print_flags(x, "|", \
+		{ O_WRONLY,		"O_WRONLY" }, \
+		{ O_RDWR,		"O_RDWR" }, \
+		{ O_CREAT,		"O_CREAT" }, \
+		{ O_EXCL,		"O_EXCL" }, \
+		{ O_NOCTTY,		"O_NOCTTY" }, \
+		{ O_TRUNC,		"O_TRUNC" }, \
+		{ O_APPEND,		"O_APPEND" }, \
+		{ O_NONBLOCK,		"O_NONBLOCK" }, \
+		{ O_DSYNC,		"O_DSYNC" }, \
+		{ O_DIRECT,		"O_DIRECT" }, \
+		{ O_LARGEFILE,		"O_LARGEFILE" }, \
+		{ O_DIRECTORY,		"O_DIRECTORY" }, \
+		{ O_NOFOLLOW,		"O_NOFOLLOW" }, \
+		{ O_NOATIME,		"O_NOATIME" }, \
+		{ O_CLOEXEC,		"O_CLOEXEC" })
+
+#define __fmode_flag(x)	{ (__force unsigned long)FMODE_##x, #x }
+#define show_fs_fmode_flags(x) \
+	__print_flags(x, "|", \
+		__fmode_flag(READ), \
+		__fmode_flag(WRITE), \
+		__fmode_flag(EXEC))
+
+#ifdef CONFIG_64BIT
+#define show_fs_fcntl_cmd(x) \
+	__print_symbolic(x, \
+		{ F_DUPFD,		"DUPFD" }, \
+		{ F_GETFD,		"GETFD" }, \
+		{ F_SETFD,		"SETFD" }, \
+		{ F_GETFL,		"GETFL" }, \
+		{ F_SETFL,		"SETFL" }, \
+		{ F_GETLK,		"GETLK" }, \
+		{ F_SETLK,		"SETLK" }, \
+		{ F_SETLKW,		"SETLKW" }, \
+		{ F_SETOWN,		"SETOWN" }, \
+		{ F_GETOWN,		"GETOWN" }, \
+		{ F_SETSIG,		"SETSIG" }, \
+		{ F_GETSIG,		"GETSIG" }, \
+		{ F_SETOWN_EX,		"SETOWN_EX" }, \
+		{ F_GETOWN_EX,		"GETOWN_EX" }, \
+		{ F_GETOWNER_UIDS,	"GETOWNER_UIDS" }, \
+		{ F_OFD_GETLK,		"OFD_GETLK" }, \
+		{ F_OFD_SETLK,		"OFD_SETLK" }, \
+		{ F_OFD_SETLKW,		"OFD_SETLKW" })
+#else /* CONFIG_64BIT */
+#define show_fs_fcntl_cmd(x) \
+	__print_symbolic(x, \
+		{ F_DUPFD,		"DUPFD" }, \
+		{ F_GETFD,		"GETFD" }, \
+		{ F_SETFD,		"SETFD" }, \
+		{ F_GETFL,		"GETFL" }, \
+		{ F_SETFL,		"SETFL" }, \
+		{ F_GETLK,		"GETLK" }, \
+		{ F_SETLK,		"SETLK" }, \
+		{ F_SETLKW,		"SETLKW" }, \
+		{ F_SETOWN,		"SETOWN" }, \
+		{ F_GETOWN,		"GETOWN" }, \
+		{ F_SETSIG,		"SETSIG" }, \
+		{ F_GETSIG,		"GETSIG" }, \
+		{ F_GETLK64,		"GETLK64" }, \
+		{ F_SETLK64,		"SETLK64" }, \
+		{ F_SETLKW64,		"SETLKW64" }, \
+		{ F_SETOWN_EX,		"SETOWN_EX" }, \
+		{ F_GETOWN_EX,		"GETOWN_EX" }, \
+		{ F_GETOWNER_UIDS,	"GETOWNER_UIDS" }, \
+		{ F_OFD_GETLK,		"OFD_GETLK" }, \
+		{ F_OFD_SETLK,		"OFD_SETLK" }, \
+		{ F_OFD_SETLKW,		"OFD_SETLKW" })
+#endif /* CONFIG_64BIT */
+
+#define show_fs_fcntl_lock_type(x) \
+	__print_symbolic(x, \
+		{ F_RDLCK,		"RDLCK" }, \
+		{ F_WRLCK,		"WRLCK" }, \
+		{ F_UNLCK,		"UNLCK" })
+
+#define show_fs_lookup_flags(flags) \
+	__print_flags(flags, "|", \
+		{ LOOKUP_FOLLOW,	"FOLLOW" }, \
+		{ LOOKUP_DIRECTORY,	"DIRECTORY" }, \
+		{ LOOKUP_AUTOMOUNT,	"AUTOMOUNT" }, \
+		{ LOOKUP_EMPTY,		"EMPTY" }, \
+		{ LOOKUP_DOWN,		"DOWN" }, \
+		{ LOOKUP_MOUNTPOINT,	"MOUNTPOINT" }, \
+		{ LOOKUP_REVAL,		"REVAL" }, \
+		{ LOOKUP_RCU,		"RCU" }, \
+		{ LOOKUP_OPEN,		"OPEN" }, \
+		{ LOOKUP_CREATE,	"CREATE" }, \
+		{ LOOKUP_EXCL,		"EXCL" }, \
+		{ LOOKUP_RENAME_TARGET,	"RENAME_TARGET" }, \
+		{ LOOKUP_PARENT,	"PARENT" }, \
+		{ LOOKUP_NO_SYMLINKS,	"NO_SYMLINKS" }, \
+		{ LOOKUP_NO_MAGICLINKS,	"NO_MAGICLINKS" }, \
+		{ LOOKUP_NO_XDEV,	"NO_XDEV" }, \
+		{ LOOKUP_BENEATH,	"BENEATH" }, \
+		{ LOOKUP_IN_ROOT,	"IN_ROOT" }, \
+		{ LOOKUP_CACHED,	"CACHED" })

