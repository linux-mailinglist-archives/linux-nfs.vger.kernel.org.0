Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009023717E7
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhECP03 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhECP02 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:26:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0905611CE
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:25:34 +0000 (UTC)
Subject: [PATCH v1 27/29] lockd: Update the NLMv4 TEST results encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:25:33 -0400
Message-ID: <162005553390.23028.3368284301170747222.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr4.c |   74 +++++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 0db142e203d2..9b8a7afb935c 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -20,8 +20,6 @@
 
 #include "svcxdr.h"
 
-#define NLMDBG_FACILITY		NLMDBG_XDR
-
 static inline loff_t
 s64_to_loff_t(__s64 offset)
 {
@@ -110,44 +108,44 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 	return true;
 }
 
-/*
- * Encode result of a TEST/TEST_MSG call
- */
-static __be32 *
-nlm4_encode_testres(__be32 *p, struct nlm_res *resp)
+static bool
+svcxdr_encode_holder(struct xdr_stream *xdr, const struct nlm_lock *lock)
 {
-	s64		start, len;
+	const struct file_lock *fl = &lock->fl;
+	s64 start, len;
 
-	dprintk("xdr: before encode_testres (p %p resp %p)\n", p, resp);
-	if (!(p = nlm4_encode_cookie(p, &resp->cookie)))
-		return NULL;
-	*p++ = resp->status;
+	/* exclusive */
+	if (xdr_stream_encode_bool(xdr, fl->fl_type != F_RDLCK) < 0)
+		return false;
+	if (xdr_stream_encode_u32(xdr, lock->svid) < 0)
+		return false;
+	if (!svcxdr_encode_owner(xdr, &lock->oh))
+		return false;
+	start = loff_t_to_s64(fl->fl_start);
+	if (fl->fl_end == OFFSET_MAX)
+		len = 0;
+	else
+		len = loff_t_to_s64(fl->fl_end - fl->fl_start + 1);
+	if (xdr_stream_encode_u64(xdr, start) < 0)
+		return false;
+	if (xdr_stream_encode_u64(xdr, len) < 0)
+		return false;
+
+	return true;
+}
 
-	if (resp->status == nlm_lck_denied) {
-		struct file_lock	*fl = &resp->lock.fl;
-
-		*p++ = (fl->fl_type == F_RDLCK)? xdr_zero : xdr_one;
-		*p++ = htonl(resp->lock.svid);
-
-		/* Encode owner handle. */
-		if (!(p = xdr_encode_netobj(p, &resp->lock.oh)))
-			return NULL;
-
-		start = loff_t_to_s64(fl->fl_start);
-		if (fl->fl_end == OFFSET_MAX)
-			len = 0;
-		else
-			len = loff_t_to_s64(fl->fl_end - fl->fl_start + 1);
-		
-		p = xdr_encode_hyper(p, start);
-		p = xdr_encode_hyper(p, len);
-		dprintk("xdr: encode_testres (status %u pid %d type %d start %Ld end %Ld)\n",
-			resp->status, (int)resp->lock.svid, fl->fl_type,
-			(long long)fl->fl_start,  (long long)fl->fl_end);
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
 
-	dprintk("xdr: after encode_testres (p %p resp %p)\n", p, resp);
-	return p;
+	return true;
 }
 
 
@@ -338,11 +336,11 @@ nlm4svc_encode_void(struct svc_rqst *rqstp, __be32 *p)
 int
 nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
-	if (!(p = nlm4_encode_testres(p, resp)))
-		return 0;
-	return xdr_ressize_check(rqstp, p);
+	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
+		svcxdr_encode_testrply(xdr, resp);
 }
 
 int


