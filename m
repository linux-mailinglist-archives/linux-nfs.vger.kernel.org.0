Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5623B39AC12
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCUy0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCUy0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:54:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 845B361263;
        Thu,  3 Jun 2021 20:52:41 +0000 (UTC)
Subject: [PATCH 21/29] lockd: Update the NLMv4 UNLOCK arguments decoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:52:40 -0400
Message-ID: <162275356080.32691.5264466318504221792.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr4.c |   53 +++++++++++++----------------------------------------
 1 file changed, 13 insertions(+), 40 deletions(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 37d45f1d7199..47a87ea4a99b 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -131,36 +131,6 @@ nlm4_decode_oh(__be32 *p, struct xdr_netobj *oh)
 	return xdr_decode_netobj(p, oh);
 }
 
-static __be32 *
-nlm4_decode_lock(__be32 *p, struct nlm_lock *lock)
-{
-	struct file_lock	*fl = &lock->fl;
-	__u64			len, start;
-	__s64			end;
-
-	if (!(p = xdr_decode_string_inplace(p, &lock->caller,
-					    &lock->len, NLM_MAXSTRLEN))
-	 || !(p = nlm4_decode_fh(p, &lock->fh))
-	 || !(p = nlm4_decode_oh(p, &lock->oh)))
-		return NULL;
-	lock->svid  = ntohl(*p++);
-
-	locks_init_lock(fl);
-	fl->fl_flags = FL_POSIX;
-	fl->fl_type  = F_RDLCK;		/* as good as anything else */
-	p = xdr_decode_hyper(p, &start);
-	p = xdr_decode_hyper(p, &len);
-	end = start + len - 1;
-
-	fl->fl_start = s64_to_loff_t(start);
-
-	if (len == 0 || end < 0)
-		fl->fl_end = OFFSET_MAX;
-	else
-		fl->fl_end = s64_to_loff_t(end);
-	return p;
-}
-
 static bool
 svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 {
@@ -311,25 +281,28 @@ nlm4svc_decode_cancargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p)
 {
-	struct nlm_res *resp = rqstp->rq_resp;
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
+	struct nlm_args *argp = rqstp->rq_argp;
 
-	if (!(p = nlm4_encode_testres(p, resp)))
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
-nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct nlm_res *resp = rqstp->rq_resp;
 
-	if (!(p = nlm4_decode_cookie(p, &argp->cookie))
-	 || !(p = nlm4_decode_lock(p, &argp->lock)))
+	if (!(p = nlm4_encode_testres(p, resp)))
 		return 0;
-	argp->lock.fl.fl_type = F_UNLCK;
-	return xdr_argsize_check(rqstp, p);
+	return xdr_ressize_check(rqstp, p);
 }
 
 int


