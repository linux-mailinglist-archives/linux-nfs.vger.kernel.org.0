Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB3039AC17
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFCUyp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhFCUyo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:54:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A26F261263;
        Thu,  3 Jun 2021 20:52:59 +0000 (UTC)
Subject: [PATCH 24/29] lockd: Update the NLMv4 SHARE arguments decoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:52:58 -0400
Message-ID: <162275357894.32691.2924442001842580373.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr4.c |   99 ++++++++++++++-----------------------------------------
 1 file changed, 26 insertions(+), 73 deletions(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 2dbf82c2726b..e6bab1d1e41f 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -42,37 +42,6 @@ loff_t_to_s64(loff_t offset)
 	return res;
 }
 
-/*
- * XDR functions for basic NLM types
- */
-static __be32 *
-nlm4_decode_cookie(__be32 *p, struct nlm_cookie *c)
-{
-	unsigned int	len;
-
-	len = ntohl(*p++);
-	
-	if(len==0)
-	{
-		c->len=4;
-		memset(c->data, 0, 4);	/* hockeypux brain damage */
-	}
-	else if(len<=NLM_MAXCOOKIELEN)
-	{
-		c->len=len;
-		memcpy(c->data, p, len);
-		p+=XDR_QUADLEN(len);
-	}
-	else 
-	{
-		dprintk("lockd: bad cookie size %d (only cookies under "
-			"%d bytes are supported.)\n",
-				len, NLM_MAXCOOKIELEN);
-		return NULL;
-	}
-	return p;
-}
-
 static __be32 *
 nlm4_encode_cookie(__be32 *p, struct nlm_cookie *c)
 {
@@ -82,20 +51,6 @@ nlm4_encode_cookie(__be32 *p, struct nlm_cookie *c)
 	return p;
 }
 
-static __be32 *
-nlm4_decode_fh(__be32 *p, struct nfs_fh *f)
-{
-	memset(f->data, 0, sizeof(f->data));
-	f->size = ntohl(*p++);
-	if (f->size > NFS_MAXFHSIZE) {
-		dprintk("lockd: bad fhandle size %d (should be <=%d)\n",
-			f->size, NFS_MAXFHSIZE);
-		return NULL;
-	}
-      	memcpy(f->data, p, f->size);
-	return p + XDR_QUADLEN(f->size);
-}
-
 /*
  * NLM file handles are defined by specification to be a variable-length
  * XDR opaque no longer than 1024 bytes. However, this implementation
@@ -122,15 +77,6 @@ svcxdr_decode_fhandle(struct xdr_stream *xdr, struct nfs_fh *fh)
 	return true;
 }
 
-/*
- * Encode and decode owner handle
- */
-static __be32 *
-nlm4_decode_oh(__be32 *p, struct xdr_netobj *oh)
-{
-	return xdr_decode_netobj(p, oh);
-}
-
 static bool
 svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 {
@@ -335,35 +281,42 @@ nlm4svc_decode_reboot(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
-int
-nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
-{
-	struct nlm_res *resp = rqstp->rq_resp;
-
-	if (!(p = nlm4_encode_testres(p, resp)))
-		return 0;
-	return xdr_ressize_check(rqstp, p);
-}
-
 int
 nlm4svc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_lock	*lock = &argp->lock;
 
 	memset(lock, 0, sizeof(*lock));
 	locks_init_lock(&lock->fl);
-	lock->svid = ~(u32) 0;
+	lock->svid = ~(u32)0;
 
-	if (!(p = nlm4_decode_cookie(p, &argp->cookie))
-	 || !(p = xdr_decode_string_inplace(p, &lock->caller,
-					    &lock->len, NLM_MAXSTRLEN))
-	 || !(p = nlm4_decode_fh(p, &lock->fh))
-	 || !(p = nlm4_decode_oh(p, &lock->oh)))
+	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
 		return 0;
-	argp->fsm_mode = ntohl(*p++);
-	argp->fsm_access = ntohl(*p++);
-	return xdr_argsize_check(rqstp, p);
+	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
+		return 0;
+	if (!svcxdr_decode_fhandle(xdr, &lock->fh))
+		return 0;
+	if (!svcxdr_decode_owner(xdr, &lock->oh))
+		return 0;
+	/* XXX: Range checks are missing in the original code */
+	if (xdr_stream_decode_u32(xdr, &argp->fsm_mode) < 0)
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &argp->fsm_access) < 0)
+		return 0;
+
+	return 1;
+}
+
+int
+nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
+{
+	struct nlm_res *resp = rqstp->rq_resp;
+
+	if (!(p = nlm4_encode_testres(p, resp)))
+		return 0;
+	return xdr_ressize_check(rqstp, p);
 }
 
 int


