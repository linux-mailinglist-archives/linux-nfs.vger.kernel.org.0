Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E87C3717D1
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhECPYc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhECPYb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:24:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD0EA611CE
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:23:37 +0000 (UTC)
Subject: [PATCH v1 08/29] lockd: Update the NLMv1 UNLOCK arguments decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:23:36 -0400
Message-ID: <162005541696.23028.15563972975744948100.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr.c |   53 +++++++++++++----------------------------------------
 1 file changed, 13 insertions(+), 40 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index ef38f07d1224..b59e02b4417c 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -140,36 +140,6 @@ nlm_encode_oh(__be32 *p, struct xdr_netobj *oh)
 	return xdr_encode_netobj(p, oh);
 }
 
-static __be32 *
-nlm_decode_lock(__be32 *p, struct nlm_lock *lock)
-{
-	struct file_lock	*fl = &lock->fl;
-	s32			start, len, end;
-
-	if (!(p = xdr_decode_string_inplace(p, &lock->caller,
-					    &lock->len,
-					    NLM_MAXSTRLEN))
-	 || !(p = nlm_decode_fh(p, &lock->fh))
-	 || !(p = nlm_decode_oh(p, &lock->oh)))
-		return NULL;
-	lock->svid  = ntohl(*p++);
-
-	locks_init_lock(fl);
-	fl->fl_flags = FL_POSIX;
-	fl->fl_type  = F_RDLCK;		/* as good as anything else */
-	start = ntohl(*p++);
-	len = ntohl(*p++);
-	end = start + len - 1;
-
-	fl->fl_start = s32_to_loff_t(start);
-
-	if (len == 0 || end < 0)
-		fl->fl_end = OFFSET_MAX;
-	else
-		fl->fl_end = s32_to_loff_t(end);
-	return p;
-}
-
 static bool
 svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 {
@@ -315,25 +285,28 @@ nlmsvc_decode_cancargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p)
 {
-	struct nlm_res *resp = rqstp->rq_resp;
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
+	struct nlm_args *argp = rqstp->rq_argp;
 
-	if (!(p = nlm_encode_testres(p, resp)))
+	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
 		return 0;
-	return xdr_ressize_check(rqstp, p);
+	if (!svcxdr_decode_lock(xdr, &argp->lock))
+		return 0;
+	argp->lock.fl.fl_type = F_UNLCK;
+
+	return 1;
 }
 
 int
-nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct nlm_res *resp = rqstp->rq_resp;
 
-	if (!(p = nlm_decode_cookie(p, &argp->cookie))
-	 || !(p = nlm_decode_lock(p, &argp->lock)))
+	if (!(p = nlm_encode_testres(p, resp)))
 		return 0;
-	argp->lock.fl.fl_type = F_UNLCK;
-	return xdr_argsize_check(rqstp, p);
+	return xdr_ressize_check(rqstp, p);
 }
 
 int


