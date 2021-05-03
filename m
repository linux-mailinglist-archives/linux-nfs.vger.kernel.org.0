Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F413717DC
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhECPZd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhECPZc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:25:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65900611CE
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:24:39 +0000 (UTC)
Subject: [PATCH v1 18/29] lockd: Update the NLMv4 TEST arguments decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:24:38 -0400
Message-ID: <162005547856.23028.17390833990771179627.stgit@klimt.1015granger.net>
In-Reply-To: <162005520101.23028.15766816408658851498.stgit@klimt.1015granger.net>
References: <162005520101.23028.15766816408658851498.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/xdr4.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index d0960a8551f8..cf64794fdc1f 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -96,6 +96,32 @@ nlm4_decode_fh(__be32 *p, struct nfs_fh *f)
 	return p + XDR_QUADLEN(f->size);
 }
 
+/*
+ * NLM file handles are defined by specification to be a variable-length
+ * XDR opaque no longer than 1024 bytes. However, this implementation
+ * limits their length to the size of an NFSv3 file handle.
+ */
+static bool
+svcxdr_decode_fhandle(struct xdr_stream *xdr, struct nfs_fh *fh)
+{
+	__be32 *p;
+	u32 len;
+
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
+		return false;
+	if (len > NFS_MAXFHSIZE)
+		return false;
+
+	p = xdr_inline_decode(xdr, len);
+	if (!p)
+		return false;
+	fh->size = len;
+	memcpy(fh->data, p, len);
+	memset(fh->data + len, 0, sizeof(fh->data) - len);
+
+	return true;
+}
+
 /*
  * Encode and decode owner handle
  */
@@ -135,6 +161,39 @@ nlm4_decode_lock(__be32 *p, struct nlm_lock *lock)
 	return p;
 }
 
+static bool
+svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
+{
+	struct file_lock *fl = &lock->fl;
+	u64 len, start;
+	s64 end;
+
+	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
+		return false;
+	if (!svcxdr_decode_fhandle(xdr, &lock->fh))
+		return false;
+	if (!svcxdr_decode_owner(xdr, &lock->oh))
+		return false;
+	if (xdr_stream_decode_u32(xdr, &lock->svid) < 0)
+		return false;
+	if (xdr_stream_decode_u64(xdr, &start) < 0)
+		return false;
+	if (xdr_stream_decode_u64(xdr, &len) < 0)
+		return false;
+
+	locks_init_lock(fl);
+	fl->fl_flags = FL_POSIX;
+	fl->fl_type  = F_RDLCK;
+	end = start + len - 1;
+	fl->fl_start = s64_to_loff_t(start);
+	if (len == 0 || end < 0)
+		fl->fl_end = OFFSET_MAX;
+	else
+		fl->fl_end = s64_to_loff_t(end);
+
+	return true;
+}
+
 /*
  * Encode result of a TEST/TEST_MSG call
  */
@@ -189,19 +248,20 @@ nlm4svc_decode_void(struct svc_rqst *rqstp, __be32 *p)
 int
 nlm4svc_decode_testargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
-	u32	exclusive;
+	u32 exclusive;
 
-	if (!(p = nlm4_decode_cookie(p, &argp->cookie)))
+	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
 		return 0;
-
-	exclusive = ntohl(*p++);
-	if (!(p = nlm4_decode_lock(p, &argp->lock)))
+	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
+		return 0;
+	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return 0;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
 
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
 int


