Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F38E39AC01
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFCUwu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCUwu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:52:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6518613E7;
        Thu,  3 Jun 2021 20:51:04 +0000 (UTC)
Subject: [PATCH 05/29] lockd: Update the NLMv1 TEST arguments decoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:51:04 -0400
Message-ID: <162275346423.32691.1770908950069060451.stgit@klimt.1015granger.net>
In-Reply-To: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
References: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/xdr.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 8be42a23679e..56982edd4766 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -98,6 +98,33 @@ nlm_decode_fh(__be32 *p, struct nfs_fh *f)
 	return p + XDR_QUADLEN(NFS2_FHSIZE);
 }
 
+/*
+ * NLM file handles are defined by specification to be a variable-length
+ * XDR opaque no longer than 1024 bytes. However, this implementation
+ * constrains their length to exactly the length of an NFSv2 file
+ * handle.
+ */
+static bool
+svcxdr_decode_fhandle(struct xdr_stream *xdr, struct nfs_fh *fh)
+{
+	__be32 *p;
+	u32 len;
+
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
+		return false;
+	if (len != NFS2_FHSIZE)
+		return false;
+
+	p = xdr_inline_decode(xdr, len);
+	if (!p)
+		return false;
+	fh->size = NFS2_FHSIZE;
+	memcpy(fh->data, p, len);
+	memset(fh->data + NFS2_FHSIZE, 0, sizeof(fh->data) - NFS2_FHSIZE);
+
+	return true;
+}
+
 /*
  * Encode and decode owner handle
  */
@@ -143,6 +170,38 @@ nlm_decode_lock(__be32 *p, struct nlm_lock *lock)
 	return p;
 }
 
+static bool
+svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
+{
+	struct file_lock *fl = &lock->fl;
+	s32 start, len, end;
+
+	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
+		return false;
+	if (!svcxdr_decode_fhandle(xdr, &lock->fh))
+		return false;
+	if (!svcxdr_decode_owner(xdr, &lock->oh))
+		return false;
+	if (xdr_stream_decode_u32(xdr, &lock->svid) < 0)
+		return false;
+	if (xdr_stream_decode_u32(xdr, &start) < 0)
+		return false;
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
+		return false;
+
+	locks_init_lock(fl);
+	fl->fl_flags = FL_POSIX;
+	fl->fl_type  = F_RDLCK;
+	end = start + len - 1;
+	fl->fl_start = s32_to_loff_t(start);
+	if (len == 0 || end < 0)
+		fl->fl_end = OFFSET_MAX;
+	else
+		fl->fl_end = s32_to_loff_t(end);
+
+	return true;
+}
+
 /*
  * Encode result of a TEST/TEST_MSG call
  */
@@ -192,19 +251,20 @@ nlmsvc_decode_void(struct svc_rqst *rqstp, __be32 *p)
 int
 nlmsvc_decode_testargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
-	u32	exclusive;
+	u32 exclusive;
 
-	if (!(p = nlm_decode_cookie(p, &argp->cookie)))
+	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
 		return 0;
-
-	exclusive = ntohl(*p++);
-	if (!(p = nlm_decode_lock(p, &argp->lock)))
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


