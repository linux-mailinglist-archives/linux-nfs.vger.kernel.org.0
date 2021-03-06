Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D9C32FDE4
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCFWdy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhCFWd0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:33:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AF896509D
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:33:26 +0000 (UTC)
Subject: [PATCH v2 42/43] NFSD: Add a tracepoint to record directory entry
 encoding
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:33:25 -0500
Message-ID: <161507000581.4312.9786948538926639585.stgit@klimt.1015granger.net>
In-Reply-To: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
References: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Enable watching the progress of directory encoding to capture the
timing of any issues with reading or encoding a directory. The
new tracepoint captures dirent encoding for all NFS versions.

For example, here's what a few NFSv4 directory entries might look
like:

nfsd-989   [002]   468.596265: nfsd_dirent:          fh_hash=0x5d162594 ino=2 name=.
nfsd-989   [002]   468.596267: nfsd_dirent:          fh_hash=0x5d162594 ino=1 name=..
nfsd-989   [002]   468.596299: nfsd_dirent:          fh_hash=0x5d162594 ino=3827 name=zlib.c
nfsd-989   [002]   468.596325: nfsd_dirent:          fh_hash=0x5d162594 ino=3811 name=xdiff
nfsd-989   [002]   468.596351: nfsd_dirent:          fh_hash=0x5d162594 ino=3810 name=xdiff-interface.h
nfsd-989   [002]   468.596377: nfsd_dirent:          fh_hash=0x5d162594 ino=3809 name=xdiff-interface.c

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |   24 ++++++++++++++++++++++++
 fs/nfsd/vfs.c   |    9 ++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 92a0973dd671..27a93ebd1d80 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -391,6 +391,30 @@ DEFINE_EVENT(nfsd_err_class, nfsd_##name,	\
 DEFINE_NFSD_ERR_EVENT(read_err);
 DEFINE_NFSD_ERR_EVENT(write_err);
 
+TRACE_EVENT(nfsd_dirent,
+	TP_PROTO(struct svc_fh *fhp,
+		 u64 ino,
+		 const char *name,
+		 int namlen),
+	TP_ARGS(fhp, ino, name, namlen),
+	TP_STRUCT__entry(
+		__field(u32, fh_hash)
+		__field(u64, ino)
+		__field(int, len)
+		__dynamic_array(unsigned char, name, namlen)
+	),
+	TP_fast_assign(
+		__entry->fh_hash = fhp ? knfsd_fh_hash(&fhp->fh_handle) : 0;
+		__entry->ino = ino;
+		__entry->len = namlen;
+		memcpy(__get_str(name), name, namlen);
+		__assign_str(name, name);
+	),
+	TP_printk("fh_hash=0x%08x ino=%llu name=%.*s",
+		__entry->fh_hash, __entry->ino,
+		__entry->len, __get_str(name))
+)
+
 #include "state.h"
 #include "filecache.h"
 #include "vfs.h"
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fd6be35a1642..15adf1f6ab21 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1968,8 +1968,9 @@ static int nfsd_buffered_filldir(struct dir_context *ctx, const char *name,
 	return 0;
 }
 
-static __be32 nfsd_buffered_readdir(struct file *file, nfsd_filldir_t func,
-				    struct readdir_cd *cdp, loff_t *offsetp)
+static __be32 nfsd_buffered_readdir(struct file *file, struct svc_fh *fhp,
+				    nfsd_filldir_t func, struct readdir_cd *cdp,
+				    loff_t *offsetp)
 {
 	struct buffered_dirent *de;
 	int host_err;
@@ -2015,6 +2016,8 @@ static __be32 nfsd_buffered_readdir(struct file *file, nfsd_filldir_t func,
 			if (cdp->err != nfs_ok)
 				break;
 
+			trace_nfsd_dirent(fhp, de->ino, de->name, de->namlen);
+
 			reclen = ALIGN(sizeof(*de) + de->namlen,
 				       sizeof(u64));
 			size -= reclen;
@@ -2062,7 +2065,7 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp,
 		goto out_close;
 	}
 
-	err = nfsd_buffered_readdir(file, func, cdp, offsetp);
+	err = nfsd_buffered_readdir(file, fhp, func, cdp, offsetp);
 
 	if (err == nfserr_eof || err == nfserr_toosmall)
 		err = nfs_ok; /* can still be found in ->err */


