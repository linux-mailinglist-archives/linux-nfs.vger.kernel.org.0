Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E4739AC0A
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCUxo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:53:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhFCUxo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:53:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40C4D61263;
        Thu,  3 Jun 2021 20:51:59 +0000 (UTC)
Subject: [PATCH 14/29] lockd: Update the NLMv1 TEST results encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:51:58 -0400
Message-ID: <162275351854.32691.13479213329688997866.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr.c |   74 ++++++++++++++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 840fa8ff8426..daf3524040d6 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -80,15 +80,6 @@ svcxdr_decode_fhandle(struct xdr_stream *xdr, struct nfs_fh *fh)
 	return true;
 }
 
-/*
- * Encode and decode owner handle
- */
-static inline __be32 *
-nlm_encode_oh(__be32 *p, struct xdr_netobj *oh)
-{
-	return xdr_encode_netobj(p, oh);
-}
-
 static bool
 svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 {
@@ -121,39 +112,44 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 	return true;
 }
 
-/*
- * Encode result of a TEST/TEST_MSG call
- */
-static __be32 *
-nlm_encode_testres(__be32 *p, struct nlm_res *resp)
+static bool
+svcxdr_encode_holder(struct xdr_stream *xdr, const struct nlm_lock *lock)
 {
-	s32		start, len;
-
-	if (!(p = nlm_encode_cookie(p, &resp->cookie)))
-		return NULL;
-	*p++ = resp->status;
+	const struct file_lock *fl = &lock->fl;
+	s32 start, len;
 
-	if (resp->status == nlm_lck_denied) {
-		struct file_lock	*fl = &resp->lock.fl;
-
-		*p++ = (fl->fl_type == F_RDLCK)? xdr_zero : xdr_one;
-		*p++ = htonl(resp->lock.svid);
-
-		/* Encode owner handle. */
-		if (!(p = xdr_encode_netobj(p, &resp->lock.oh)))
-			return NULL;
+	/* exclusive */
+	if (xdr_stream_encode_bool(xdr, fl->fl_type != F_RDLCK) < 0)
+		return false;
+	if (xdr_stream_encode_u32(xdr, lock->svid) < 0)
+		return false;
+	if (!svcxdr_encode_owner(xdr, &lock->oh))
+		return false;
+	start = loff_t_to_s32(fl->fl_start);
+	if (fl->fl_end == OFFSET_MAX)
+		len = 0;
+	else
+		len = loff_t_to_s32(fl->fl_end - fl->fl_start + 1);
+	if (xdr_stream_encode_u32(xdr, start) < 0)
+		return false;
+	if (xdr_stream_encode_u32(xdr, len) < 0)
+		return false;
 
-		start = loff_t_to_s32(fl->fl_start);
-		if (fl->fl_end == OFFSET_MAX)
-			len = 0;
-		else
-			len = loff_t_to_s32(fl->fl_end - fl->fl_start + 1);
+	return true;
+}
 
-		*p++ = htonl(start);
-		*p++ = htonl(len);
+static bool
+svcxdr_encode_testrply(struct xdr_stream *xdr, const struct nlm_res *resp)
+{
+	if (!svcxdr_encode_stats(xdr, resp->status))
+		return false;
+	switch (resp->status) {
+	case nlm_lck_denied:
+		if (!svcxdr_encode_holder(xdr, &resp->lock))
+			return false;
 	}
 
-	return p;
+	return true;
 }
 
 
@@ -345,11 +341,11 @@ nlmsvc_encode_void(struct svc_rqst *rqstp, __be32 *p)
 int
 nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
-	if (!(p = nlm_encode_testres(p, resp)))
-		return 0;
-	return xdr_ressize_check(rqstp, p);
+	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
+		svcxdr_encode_testrply(xdr, resp);
 }
 
 int


