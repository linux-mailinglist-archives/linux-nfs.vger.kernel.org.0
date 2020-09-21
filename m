Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A860827318B
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgIUSK6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUSK5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:10:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965BAC061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:10:57 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id j2so16433995ioj.7
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=12B/BcO63WFB/53O5OXXuXHHuVVshxS9wlgFzFS8GE4=;
        b=T5il0G31qa2KwXl617wTTLY43TkmzEZBpL9uawSYe4Eqeu8PnkLKJ1pbyOsb7pWFLx
         CWb0BAPMcuYwU/Rnud8ib21wo0A/jFzUizlLdZRSsgIHv+gOahiBFEDYNKXM9dy6GhJa
         Wx5U4FMa2A7OXlXae19pjDK8+TbLA0IUlcduNL3xAOHJ0nmI1/BBRmygWEiLL2oHnQD1
         AIQ+NqTohLfgMUcfgDuThRRLUgR42hmQGnpqefdgx3+h8Mik2ltpsQRJFHT6IRGjh1cA
         N4WD6mCoiOnYoEgaW2N9/aoxdjnWeXnthSqwVFnipXS2HR5HdEFFCO0mGpYKPOB2AGFc
         V5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=12B/BcO63WFB/53O5OXXuXHHuVVshxS9wlgFzFS8GE4=;
        b=pmuUyMHrsxhDTO79njpPgJNfuxJoPRGB6UNRxBVKYQ0GHmUV878vh6eMHViTBywcgv
         m3aXBXA8aVv1LscZTlXkj+vIg86Xe9lX8nGe6+fo1VHXya5Gd9xBk6jffmGU67by1oet
         cU5byBNqXb/HclBBk9pOze+hRHQzv+dvBPb9XXeLuvsUuRQmLbNjcOh6pGwZjDPJQnCz
         c9GLkxih9r8u92NrQRZ7WvJuBpV5zhQ9RvvGsW9f4UPWGFZLqtGudpeMCMlnTvw8zsBY
         eCS9YpXxiLoJVQqt9WqzGo+JooSnlb295Tg8DI3CNaG2oZOGHjy5NN2qZk7E7RWNOnGk
         gnzw==
X-Gm-Message-State: AOAM531XD4meqUwCa2eon7RacypKi5qBEf/EnPFn7Km1MVOtaV9uaqwD
        u01zEOTopfeXvZG6LUw6rvw=
X-Google-Smtp-Source: ABdhPJyZAPFAmqR4dZ+G6PdGwFvg+dZjVE1gzPc4gd+qwqvYUiEW3PBiTmcrPlifcGJ5Zqv9V3irSw==
X-Received: by 2002:a05:6638:148f:: with SMTP id j15mr1105816jak.54.1600711856829;
        Mon, 21 Sep 2020 11:10:56 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i6sm3900316ils.55.2020.09.21.11.10.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:10:56 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIAtS8003845;
        Mon, 21 Sep 2020 18:10:55 GMT
Subject: [PATCH v2 01/27] NFS: Move generic FS show macros to global header
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:10:55 -0400
Message-ID: <160071185529.1468.2075394901193220947.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: surface useful show_ macros to other trace consumers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4trace.h        |   59 +++++-------------
 fs/nfs/nfstrace.h         |  122 ++++---------------------------------
 include/trace/events/fs.h |  147 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 153 deletions(-)
 create mode 100644 include/trace/events/fs.h

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index b4f852d4d099..502b13651c94 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -10,6 +10,8 @@
 
 #include <linux/tracepoint.h>
 
+#include <trace/events/fs.h>
+
 TRACE_DEFINE_ENUM(EPERM);
 TRACE_DEFINE_ENUM(ENOENT);
 TRACE_DEFINE_ENUM(EIO);
@@ -313,19 +315,6 @@ TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
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
@@ -748,8 +737,8 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(unsigned int, flags)
-			__field(unsigned int, fmode)
+			__field(unsigned long, flags)
+			__field(unsigned long, fmode)
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
@@ -767,7 +756,7 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 
 			__entry->error = -error;
 			__entry->flags = flags;
-			__entry->fmode = (__force unsigned int)ctx->mode;
+			__entry->fmode = (__force unsigned long)ctx->mode;
 			__entry->dev = ctx->dentry->d_sb->s_dev;
 			if (!IS_ERR_OR_NULL(state)) {
 				inode = state->inode;
@@ -797,14 +786,14 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
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
+			 show_fcntl_open_flags(__entry->flags),
 			 show_fmode_flags(__entry->fmode),
 			 MAJOR(__entry->dev), MINOR(__entry->dev),
 			 (unsigned long long)__entry->fileid,
@@ -916,24 +905,6 @@ TRACE_EVENT(nfs4_close,
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
@@ -946,8 +917,8 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(int, cmd)
-			__field(char, type)
+			__field(unsigned long, cmd)
+			__field(unsigned long, type)
 			__field(loff_t, start)
 			__field(loff_t, end)
 			__field(dev_t, dev)
@@ -980,8 +951,8 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 			"stateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
-			show_lock_cmd(__entry->cmd),
-			show_lock_type(__entry->type),
+			show_fcntl_cmd(__entry->cmd),
+			show_fcntl_lock_type(__entry->type),
 			(long long)__entry->start,
 			(long long)__entry->end,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1016,8 +987,8 @@ TRACE_EVENT(nfs4_set_lock,
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(int, cmd)
-			__field(char, type)
+			__field(unsigned long, cmd)
+			__field(unsigned long, type)
 			__field(loff_t, start)
 			__field(loff_t, end)
 			__field(dev_t, dev)
@@ -1056,8 +1027,8 @@ TRACE_EVENT(nfs4_set_lock,
 			"stateid=%d:0x%08x lockstateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
-			show_lock_cmd(__entry->cmd),
-			show_lock_type(__entry->type),
+			show_fcntl_cmd(__entry->cmd),
+			show_fcntl_lock_type(__entry->type),
 			(long long)__entry->start,
 			(long long)__entry->end,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 5a59dcdce0b2..91677dea7e3d 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -11,27 +11,7 @@
 #include <linux/tracepoint.h>
 #include <linux/iversion.h>
 
-TRACE_DEFINE_ENUM(DT_UNKNOWN);
-TRACE_DEFINE_ENUM(DT_FIFO);
-TRACE_DEFINE_ENUM(DT_CHR);
-TRACE_DEFINE_ENUM(DT_DIR);
-TRACE_DEFINE_ENUM(DT_BLK);
-TRACE_DEFINE_ENUM(DT_REG);
-TRACE_DEFINE_ENUM(DT_LNK);
-TRACE_DEFINE_ENUM(DT_SOCK);
-TRACE_DEFINE_ENUM(DT_WHT);
-
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
+#include <trace/events/fs.h>
 
 TRACE_DEFINE_ENUM(NFS_INO_INVALID_DATA);
 TRACE_DEFINE_ENUM(NFS_INO_INVALID_ATIME);
@@ -159,7 +139,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event_done,
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			__entry->type,
-			nfs_show_file_type(__entry->type),
+			show_dirent_type(__entry->type),
 			(unsigned long long)__entry->version,
 			(long long)__entry->size,
 			__entry->cache_validity,
@@ -250,7 +230,7 @@ TRACE_EVENT(nfs_access_exit,
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			__entry->type,
-			nfs_show_file_type(__entry->type),
+			show_dirent_type(__entry->type),
 			(unsigned long long)__entry->version,
 			(long long)__entry->size,
 			__entry->cache_validity,
@@ -261,38 +241,6 @@ TRACE_EVENT(nfs_access_exit,
 		)
 );
 
-TRACE_DEFINE_ENUM(LOOKUP_FOLLOW);
-TRACE_DEFINE_ENUM(LOOKUP_DIRECTORY);
-TRACE_DEFINE_ENUM(LOOKUP_AUTOMOUNT);
-TRACE_DEFINE_ENUM(LOOKUP_PARENT);
-TRACE_DEFINE_ENUM(LOOKUP_REVAL);
-TRACE_DEFINE_ENUM(LOOKUP_RCU);
-TRACE_DEFINE_ENUM(LOOKUP_OPEN);
-TRACE_DEFINE_ENUM(LOOKUP_CREATE);
-TRACE_DEFINE_ENUM(LOOKUP_EXCL);
-TRACE_DEFINE_ENUM(LOOKUP_RENAME_TARGET);
-TRACE_DEFINE_ENUM(LOOKUP_JUMPED);
-TRACE_DEFINE_ENUM(LOOKUP_ROOT);
-TRACE_DEFINE_ENUM(LOOKUP_EMPTY);
-TRACE_DEFINE_ENUM(LOOKUP_DOWN);
-
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
-			{ LOOKUP_JUMPED, "JUMPED" }, \
-			{ LOOKUP_ROOT, "ROOT" }, \
-			{ LOOKUP_EMPTY, "EMPTY" }, \
-			{ LOOKUP_DOWN, "DOWN" })
-
 DECLARE_EVENT_CLASS(nfs_lookup_event,
 		TP_PROTO(
 			const struct inode *dir,
@@ -319,7 +267,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event,
 		TP_printk(
 			"flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			__entry->flags,
-			show_lookup_flags(__entry->flags),
+			show_vfs_lookup_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -365,7 +313,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
 			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			-__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
-			show_lookup_flags(__entry->flags),
+			show_vfs_lookup_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -387,50 +335,6 @@ DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_exit);
 DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_enter);
 DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_revalidate_exit);
 
-TRACE_DEFINE_ENUM(O_WRONLY);
-TRACE_DEFINE_ENUM(O_RDWR);
-TRACE_DEFINE_ENUM(O_CREAT);
-TRACE_DEFINE_ENUM(O_EXCL);
-TRACE_DEFINE_ENUM(O_NOCTTY);
-TRACE_DEFINE_ENUM(O_TRUNC);
-TRACE_DEFINE_ENUM(O_APPEND);
-TRACE_DEFINE_ENUM(O_NONBLOCK);
-TRACE_DEFINE_ENUM(O_DSYNC);
-TRACE_DEFINE_ENUM(O_DIRECT);
-TRACE_DEFINE_ENUM(O_LARGEFILE);
-TRACE_DEFINE_ENUM(O_DIRECTORY);
-TRACE_DEFINE_ENUM(O_NOFOLLOW);
-TRACE_DEFINE_ENUM(O_NOATIME);
-TRACE_DEFINE_ENUM(O_CLOEXEC);
-
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
-TRACE_DEFINE_ENUM(FMODE_READ);
-TRACE_DEFINE_ENUM(FMODE_WRITE);
-TRACE_DEFINE_ENUM(FMODE_EXEC);
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
@@ -442,7 +346,7 @@ TRACE_EVENT(nfs_atomic_open_enter,
 
 		TP_STRUCT__entry(
 			__field(unsigned long, flags)
-			__field(unsigned int, fmode)
+			__field(unsigned long, fmode)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, ctx->dentry->d_name.name)
@@ -452,14 +356,14 @@ TRACE_EVENT(nfs_atomic_open_enter,
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
+			show_fcntl_open_flags(__entry->flags),
 			show_fmode_flags(__entry->fmode),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
@@ -480,7 +384,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
 			__field(unsigned long, flags)
-			__field(unsigned int, fmode)
+			__field(unsigned long, fmode)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, ctx->dentry->d_name.name)
@@ -491,7 +395,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 			__entry->dev = dir->i_sb->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
-			__entry->fmode = (__force unsigned int)ctx->mode;
+			__entry->fmode = (__force unsigned long)ctx->mode;
 			__assign_str(name, ctx->dentry->d_name.name);
 		),
 
@@ -500,7 +404,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 			"name=%02x:%02x:%llu/%s",
 			-__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
-			show_open_flags(__entry->flags),
+			show_fcntl_open_flags(__entry->flags),
 			show_fmode_flags(__entry->fmode),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
@@ -534,7 +438,7 @@ TRACE_EVENT(nfs_create_enter,
 		TP_printk(
 			"flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			__entry->flags,
-			show_open_flags(__entry->flags),
+			show_fcntl_open_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -571,7 +475,7 @@ TRACE_EVENT(nfs_create_exit,
 			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			-__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
-			show_open_flags(__entry->flags),
+			show_fcntl_open_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
diff --git a/include/trace/events/fs.h b/include/trace/events/fs.h
new file mode 100644
index 000000000000..8ea0e84e425a
--- /dev/null
+++ b/include/trace/events/fs.h
@@ -0,0 +1,147 @@
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
+#define show_dirent_type(x) \
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
+#define show_fcntl_open_flags(x) \
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
+#define show_fmode_flags(x) \
+	__print_flags(x, "|", \
+		{ (__force unsigned long)FMODE_READ,		"READ" }, \
+		{ (__force unsigned long)FMODE_WRITE,		"WRITE" }, \
+		{ (__force unsigned long)FMODE_LSEEK,		"LSEEK" }, \
+		{ (__force unsigned long)FMODE_PREAD,		"PREAD" }, \
+		{ (__force unsigned long)FMODE_PWRITE,		"PWRITE" }, \
+		{ (__force unsigned long)FMODE_EXEC,		"EXEC" }, \
+		{ (__force unsigned long)FMODE_NDELAY,		"NDELAY" }, \
+		{ (__force unsigned long)FMODE_EXCL,		"EXCL" }, \
+		{ (__force unsigned long)FMODE_WRITE_IOCTL,	"WRITE_IOCTL" }, \
+		{ (__force unsigned long)FMODE_32BITHASH,	"32BITHASH" }, \
+		{ (__force unsigned long)FMODE_64BITHASH,	"64BITHASH" }, \
+		{ (__force unsigned long)FMODE_NOCMTIME, 	"NOCMTIME" }, \
+		{ (__force unsigned long)FMODE_RANDOM,		"RANDOM" }, \
+		{ (__force unsigned long)FMODE_UNSIGNED_OFFSET,	"UNSIGNED_OFFSET" }, \
+		{ (__force unsigned long)FMODE_PATH,		"PATH" }, \
+		{ (__force unsigned long)FMODE_ATOMIC_POS,	"ATOMIC_POS" }, \
+		{ (__force unsigned long)FMODE_WRITER,		"WRITER" }, \
+		{ (__force unsigned long)FMODE_CAN_READ,	"CAN_READ" }, \
+		{ (__force unsigned long)FMODE_CAN_WRITE,	"CAN_WRITE" }, \
+		{ (__force unsigned long)FMODE_OPENED,		"OPENED" }, \
+		{ (__force unsigned long)FMODE_CREATED,		"CREATED" }, \
+		{ (__force unsigned long)FMODE_STREAM,		"STREAM" }, \
+		{ (__force unsigned long)FMODE_NONOTIFY,	"NONOTIFY" }, \
+		{ (__force unsigned long)FMODE_NOWAIT,		"NOWAIT" }, \
+		{ (__force unsigned long)FMODE_NEED_UNMOUNT,	"NEED_UNMOUNT" }, \
+		{ (__force unsigned long)FMODE_NOACCOUNT,	"NOACCOUNT" }, \
+		{ (__force unsigned long)FMODE_BUF_RASYNC,	"BUF_RASYNC" })
+
+#ifdef CONFIG_64BIT
+#define show_fcntl_cmd(x) \
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
+#define show_fcntl_cmd(x) \
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
+#define show_fcntl_lock_type(x) \
+	__print_symbolic(x, \
+		{ F_RDLCK,		"RDLCK" }, \
+		{ F_WRLCK,		"WRLCK" }, \
+		{ F_UNLCK,		"UNLCK" })
+
+#define show_vfs_lookup_flags(flags) \
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
+		{ LOOKUP_JUMPED,	"JUMPED" }, \
+		{ LOOKUP_ROOT,		"ROOT" }, \
+		{ LOOKUP_ROOT_GRABBED,	"ROOT_GRABBED" }, \
+		{ LOOKUP_NO_SYMLINKS,	"NO_SYMLINKS" }, \
+		{ LOOKUP_NO_MAGICLINKS,	"NO_MAGICLINKS" }, \
+		{ LOOKUP_NO_XDEV,	"NO_XDEV" }, \
+		{ LOOKUP_BENEATH,	"BENEATH" }, \
+		{ LOOKUP_IN_ROOT,	"IN_ROOT" })


