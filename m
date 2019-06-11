Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188E93D065
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404180AbfFKPJh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:09:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45196 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404326AbfFKPJh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:09:37 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so10163522ioc.12;
        Tue, 11 Jun 2019 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ULEx7VgNus7ug/C3s3k8RocDUU7IKiW0bIpc5vySRYE=;
        b=gBO7IZuxiwWjzJILLCxSrWPzOJDJqDOQW53CKM5N6RsjiZV45wPwTpVPxB5Jgah49a
         c5pEoYUjj3lF1NODrCPlreRJ/HECX8gP6xGZmMZ0OmthhJAcvWTeJE/oMFLnUpk2TvJr
         ucmE6R2o8ASpQaK3OlynxerNdQwA7dYI+czjkRmdkb6xQ8kZUSkL1hKodoAqLcDM9X8u
         jmVVXHR1XjtP5mmg1t8yjsFMt+wgJLRBQ3v6APuhMoXUb/6o0aMrsK8w+rvOSmdqA5QO
         r4XqOyYdUlKA1vOc4wsNBkeegT39s12Xu7XbcuyPYWsZc0lJaZc0Wh5zQ3ftr1toRzMS
         It2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ULEx7VgNus7ug/C3s3k8RocDUU7IKiW0bIpc5vySRYE=;
        b=dHlE96JSJkFtTeREJ+xe280vm2DnrTMNoQP55RJMJ6Ml2SjZvCYdWdBdVf+YcZgVHY
         PTClivugLLElCPMIffCTlMuXYF7Mm4QpwPfuI/F85yJ0yn91rSduo2cWHnc1+0o0d1Gk
         Aw3Dfi8QGmTgIVHK6Dd8E2vVsFcnKHAYqYCDcVguomUikbG/jUURwfSOcJ/AL/KhVkEe
         J7jXlPrnUUP2yLu2AFXZ3nIZ1WGqHbvIkvbjZK/4UNQDfWxV+JMe/VCs3edN/m49O90S
         1AZS+Hm/BY3lbSgqNEKQ3wwTmeKdLqGYKF5KGWGppFQf0qkQdzFkxm2Rchy7cUaH82+R
         Uc6g==
X-Gm-Message-State: APjAAAWvpyYp1v3B6tiWBnXq2oOwaSUST/KUgZMwb3eAb23EqweE38Ks
        tgxRv1E1ty4X3ySvURPpJ+K3AuYG
X-Google-Smtp-Source: APXvYqwqfi1znTgaVUsWw4rwdlnXmHm6nPiczKVSPd4COTPxpRG4Uu5pv3h/qGduGYBsoMzEJ2GabA==
X-Received: by 2002:a05:6602:98:: with SMTP id h24mr3349929iob.49.1560265775814;
        Tue, 11 Jun 2019 08:09:35 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 17sm1952064itk.35.2019.06.11.08.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:09:35 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF9YZv021779;
        Tue, 11 Jun 2019 15:09:34 GMT
Subject: [PATCH v2 18/19] NFS: Update symbolic flags displayed by trace
 events
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:09:34 -0400
Message-ID: <20190611150934.2877.79979.stgit@manet.1015granger.net>
In-Reply-To: <20190611150445.2877.8656.stgit@manet.1015granger.net>
References: <20190611150445.2877.8656.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfstrace.h |   98 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index adc30b0..3a0ed3d 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -11,6 +11,16 @@
 #include <linux/tracepoint.h>
 #include <linux/iversion.h>
 
+TRACE_DEFINE_ENUM(DT_UNKNOWN);
+TRACE_DEFINE_ENUM(DT_FIFO);
+TRACE_DEFINE_ENUM(DT_CHR);
+TRACE_DEFINE_ENUM(DT_DIR);
+TRACE_DEFINE_ENUM(DT_BLK);
+TRACE_DEFINE_ENUM(DT_REG);
+TRACE_DEFINE_ENUM(DT_LNK);
+TRACE_DEFINE_ENUM(DT_SOCK);
+TRACE_DEFINE_ENUM(DT_WHT);
+
 #define nfs_show_file_type(ftype) \
 	__print_symbolic(ftype, \
 			{ DT_UNKNOWN, "UNKNOWN" }, \
@@ -23,25 +33,57 @@
 			{ DT_SOCK, "SOCK" }, \
 			{ DT_WHT, "WHT" })
 
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_DATA);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_ATIME);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_ACCESS);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_ACL);
+TRACE_DEFINE_ENUM(NFS_INO_REVAL_PAGECACHE);
+TRACE_DEFINE_ENUM(NFS_INO_REVAL_FORCED);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_LABEL);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_CHANGE);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_CTIME);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_MTIME);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_SIZE);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_OTHER);
+
 #define nfs_show_cache_validity(v) \
 	__print_flags(v, "|", \
-			{ NFS_INO_INVALID_ATTR, "INVALID_ATTR" }, \
 			{ NFS_INO_INVALID_DATA, "INVALID_DATA" }, \
 			{ NFS_INO_INVALID_ATIME, "INVALID_ATIME" }, \
 			{ NFS_INO_INVALID_ACCESS, "INVALID_ACCESS" }, \
 			{ NFS_INO_INVALID_ACL, "INVALID_ACL" }, \
 			{ NFS_INO_REVAL_PAGECACHE, "REVAL_PAGECACHE" }, \
 			{ NFS_INO_REVAL_FORCED, "REVAL_FORCED" }, \
-			{ NFS_INO_INVALID_LABEL, "INVALID_LABEL" })
+			{ NFS_INO_INVALID_LABEL, "INVALID_LABEL" }, \
+			{ NFS_INO_INVALID_CHANGE, "INVALID_CHANGE" }, \
+			{ NFS_INO_INVALID_CTIME, "INVALID_CTIME" }, \
+			{ NFS_INO_INVALID_MTIME, "INVALID_MTIME" }, \
+			{ NFS_INO_INVALID_SIZE, "INVALID_SIZE" }, \
+			{ NFS_INO_INVALID_OTHER, "INVALID_OTHER" })
+
+TRACE_DEFINE_ENUM(NFS_INO_ADVISE_RDPLUS);
+TRACE_DEFINE_ENUM(NFS_INO_STALE);
+TRACE_DEFINE_ENUM(NFS_INO_ACL_LRU_SET);
+TRACE_DEFINE_ENUM(NFS_INO_INVALIDATING);
+TRACE_DEFINE_ENUM(NFS_INO_FSCACHE);
+TRACE_DEFINE_ENUM(NFS_INO_FSCACHE_LOCK);
+TRACE_DEFINE_ENUM(NFS_INO_LAYOUTCOMMIT);
+TRACE_DEFINE_ENUM(NFS_INO_LAYOUTCOMMITTING);
+TRACE_DEFINE_ENUM(NFS_INO_LAYOUTSTATS);
+TRACE_DEFINE_ENUM(NFS_INO_ODIRECT);
 
 #define nfs_show_nfsi_flags(v) \
 	__print_flags(v, "|", \
 			{ 1 << NFS_INO_ADVISE_RDPLUS, "ADVISE_RDPLUS" }, \
 			{ 1 << NFS_INO_STALE, "STALE" }, \
+			{ 1 << NFS_INO_ACL_LRU_SET, "ACL_LRU_SET" }, \
 			{ 1 << NFS_INO_INVALIDATING, "INVALIDATING" }, \
 			{ 1 << NFS_INO_FSCACHE, "FSCACHE" }, \
+			{ 1 << NFS_INO_FSCACHE_LOCK, "FSCACHE_LOCK" }, \
 			{ 1 << NFS_INO_LAYOUTCOMMIT, "NEED_LAYOUTCOMMIT" }, \
-			{ 1 << NFS_INO_LAYOUTCOMMITTING, "LAYOUTCOMMIT" })
+			{ 1 << NFS_INO_LAYOUTCOMMITTING, "LAYOUTCOMMIT" }, \
+			{ 1 << NFS_INO_LAYOUTSTATS, "LAYOUTSTATS" }, \
+			{ 1 << NFS_INO_ODIRECT, "ODIRECT" })
 
 DECLARE_EVENT_CLASS(nfs_inode_event,
 		TP_PROTO(
@@ -110,7 +152,7 @@
 		TP_printk(
 			"error=%lu (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"type=%u (%s) version=%llu size=%lld "
-			"cache_validity=%lu (%s) nfs_flags=%ld (%s)",
+			"cache_validity=0x%lx (%s) nfs_flags=0x%lx (%s)",
 			__entry->error, nfs_show_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -260,15 +302,43 @@
 DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_enter);
 DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_revalidate_exit);
 
+TRACE_DEFINE_ENUM(O_WRONLY);
+TRACE_DEFINE_ENUM(O_RDWR);
+TRACE_DEFINE_ENUM(O_CREAT);
+TRACE_DEFINE_ENUM(O_EXCL);
+TRACE_DEFINE_ENUM(O_NOCTTY);
+TRACE_DEFINE_ENUM(O_TRUNC);
+TRACE_DEFINE_ENUM(O_APPEND);
+TRACE_DEFINE_ENUM(O_NONBLOCK);
+TRACE_DEFINE_ENUM(O_DSYNC);
+TRACE_DEFINE_ENUM(O_DIRECT);
+TRACE_DEFINE_ENUM(O_LARGEFILE);
+TRACE_DEFINE_ENUM(O_DIRECTORY);
+TRACE_DEFINE_ENUM(O_NOFOLLOW);
+TRACE_DEFINE_ENUM(O_NOATIME);
+TRACE_DEFINE_ENUM(O_CLOEXEC);
+
 #define show_open_flags(flags) \
-	__print_flags((unsigned long)flags, "|", \
+	__print_flags(flags, "|", \
+		{ O_WRONLY, "O_WRONLY" }, \
+		{ O_RDWR, "O_RDWR" }, \
 		{ O_CREAT, "O_CREAT" }, \
 		{ O_EXCL, "O_EXCL" }, \
+		{ O_NOCTTY, "O_NOCTTY" }, \
 		{ O_TRUNC, "O_TRUNC" }, \
 		{ O_APPEND, "O_APPEND" }, \
+		{ O_NONBLOCK, "O_NONBLOCK" }, \
 		{ O_DSYNC, "O_DSYNC" }, \
 		{ O_DIRECT, "O_DIRECT" }, \
-		{ O_DIRECTORY, "O_DIRECTORY" })
+		{ O_LARGEFILE, "O_LARGEFILE" }, \
+		{ O_DIRECTORY, "O_DIRECTORY" }, \
+		{ O_NOFOLLOW, "O_NOFOLLOW" }, \
+		{ O_NOATIME, "O_NOATIME" }, \
+		{ O_CLOEXEC, "O_CLOEXEC" })
+
+TRACE_DEFINE_ENUM(FMODE_READ);
+TRACE_DEFINE_ENUM(FMODE_WRITE);
+TRACE_DEFINE_ENUM(FMODE_EXEC);
 
 #define show_fmode_flags(mode) \
 	__print_flags(mode, "|", \
@@ -286,7 +356,7 @@
 		TP_ARGS(dir, ctx, flags),
 
 		TP_STRUCT__entry(
-			__field(unsigned int, flags)
+			__field(unsigned long, flags)
 			__field(unsigned int, fmode)
 			__field(dev_t, dev)
 			__field(u64, dir)
@@ -302,7 +372,7 @@
 		),
 
 		TP_printk(
-			"flags=%u (%s) fmode=%s name=%02x:%02x:%llu/%s",
+			"flags=%lu (%s) fmode=%s name=%02x:%02x:%llu/%s",
 			__entry->flags,
 			show_open_flags(__entry->flags),
 			show_fmode_flags(__entry->fmode),
@@ -324,7 +394,7 @@
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(unsigned int, flags)
+			__field(unsigned long, flags)
 			__field(unsigned int, fmode)
 			__field(dev_t, dev)
 			__field(u64, dir)
@@ -341,7 +411,7 @@
 		),
 
 		TP_printk(
-			"error=%lu (%s) flags=%u (%s) fmode=%s "
+			"error=%lu (%s) flags=%lu (%s) fmode=%s "
 			"name=%02x:%02x:%llu/%s",
 			__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
@@ -363,7 +433,7 @@
 		TP_ARGS(dir, dentry, flags),
 
 		TP_STRUCT__entry(
-			__field(unsigned int, flags)
+			__field(unsigned long, flags)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, dentry->d_name.name)
@@ -377,7 +447,7 @@
 		),
 
 		TP_printk(
-			"flags=%u (%s) name=%02x:%02x:%llu/%s",
+			"flags=%lu (%s) name=%02x:%02x:%llu/%s",
 			__entry->flags,
 			show_open_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -398,7 +468,7 @@
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(unsigned int, flags)
+			__field(unsigned long, flags)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, dentry->d_name.name)
@@ -413,7 +483,7 @@
 		),
 
 		TP_printk(
-			"error=%lu (%s) flags=%u (%s) name=%02x:%02x:%llu/%s",
+			"error=%lu (%s) flags=%lu (%s) name=%02x:%02x:%llu/%s",
 			__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
 			show_open_flags(__entry->flags),

