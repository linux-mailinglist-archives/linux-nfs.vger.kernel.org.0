Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF60A421105
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 16:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhJDOLr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 10:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhJDOLr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Oct 2021 10:11:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66E4761216;
        Mon,  4 Oct 2021 14:09:58 +0000 (UTC)
Subject: [PATCH 1/4] NFS: Remove unnecessary TRACE_DEFINE_ENUM()s
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Oct 2021 10:09:57 -0400
Message-ID: <163335659770.1225.15712975239962366454.stgit@morisot.1015granger.net>
In-Reply-To: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
References: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: TRACE_DEFINE_ENUM is unnecessary because the target
symbols are all C macros, not enums.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfstrace.h |   68 -----------------------------------------------------
 1 file changed, 68 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 8a224871be74..589f32fdbe63 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -11,16 +11,6 @@
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
 #define nfs_show_file_type(ftype) \
 	__print_symbolic(ftype, \
 			{ DT_UNKNOWN, "UNKNOWN" }, \
@@ -33,24 +23,6 @@ TRACE_DEFINE_ENUM(DT_WHT);
 			{ DT_SOCK, "SOCK" }, \
 			{ DT_WHT, "WHT" })
 
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_DATA);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_ATIME);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_ACCESS);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_ACL);
-TRACE_DEFINE_ENUM(NFS_INO_REVAL_PAGECACHE);
-TRACE_DEFINE_ENUM(NFS_INO_REVAL_FORCED);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_LABEL);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_CHANGE);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_CTIME);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_MTIME);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_SIZE);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_OTHER);
-TRACE_DEFINE_ENUM(NFS_INO_DATA_INVAL_DEFER);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_BLOCKS);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_XATTR);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_NLINK);
-TRACE_DEFINE_ENUM(NFS_INO_INVALID_MODE);
-
 #define nfs_show_cache_validity(v) \
 	__print_flags(v, "|", \
 			{ NFS_INO_INVALID_DATA, "INVALID_DATA" }, \
@@ -71,17 +43,6 @@ TRACE_DEFINE_ENUM(NFS_INO_INVALID_MODE);
 			{ NFS_INO_INVALID_NLINK, "INVALID_NLINK" }, \
 			{ NFS_INO_INVALID_MODE, "INVALID_MODE" })
 
-TRACE_DEFINE_ENUM(NFS_INO_ADVISE_RDPLUS);
-TRACE_DEFINE_ENUM(NFS_INO_STALE);
-TRACE_DEFINE_ENUM(NFS_INO_ACL_LRU_SET);
-TRACE_DEFINE_ENUM(NFS_INO_INVALIDATING);
-TRACE_DEFINE_ENUM(NFS_INO_FSCACHE);
-TRACE_DEFINE_ENUM(NFS_INO_FSCACHE_LOCK);
-TRACE_DEFINE_ENUM(NFS_INO_LAYOUTCOMMIT);
-TRACE_DEFINE_ENUM(NFS_INO_LAYOUTCOMMITTING);
-TRACE_DEFINE_ENUM(NFS_INO_LAYOUTSTATS);
-TRACE_DEFINE_ENUM(NFS_INO_ODIRECT);
-
 #define nfs_show_nfsi_flags(v) \
 	__print_flags(v, "|", \
 			{ BIT(NFS_INO_ADVISE_RDPLUS), "ADVISE_RDPLUS" }, \
@@ -270,19 +231,6 @@ TRACE_EVENT(nfs_access_exit,
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
-TRACE_DEFINE_ENUM(LOOKUP_EMPTY);
-TRACE_DEFINE_ENUM(LOOKUP_DOWN);
-
 #define show_lookup_flags(flags) \
 	__print_flags(flags, "|", \
 			{ LOOKUP_FOLLOW, "FOLLOW" }, \
@@ -392,22 +340,6 @@ DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_exit);
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
 #define show_open_flags(flags) \
 	__print_flags(flags, "|", \
 		{ O_WRONLY, "O_WRONLY" }, \


