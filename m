Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39FE3C5E98
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 16:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhGLOzX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 10:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234914AbhGLOzX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Jul 2021 10:55:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DACC16120A
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jul 2021 14:52:34 +0000 (UTC)
Subject: [PATCH RFC 3/7] SUNRPC: Eliminate the RQ_AUTHERR flag
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Jul 2021 10:52:34 -0400
Message-ID: <162610155419.2466.15761450713724899063.stgit@klimt.1015granger.net>
In-Reply-To: <162610122257.2466.7452891285800059767.stgit@klimt.1015granger.net>
References: <162610122257.2466.7452891285800059767.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that there is an alternate method for returning an auth_stat
value, replace the RQ_AUTHERR flag with use of that new method.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback_xdr.c         |    3 ++-
 include/linux/sunrpc/svc.h    |    2 --
 include/trace/events/sunrpc.h |    3 +--
 net/sunrpc/svc.c              |   24 ++++--------------------
 4 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index c5348ba81129..7ff99155b023 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -988,7 +988,8 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 
 out_invalidcred:
 	pr_warn_ratelimited("NFS: NFSv4 callback contains invalid cred\n");
-	return svc_return_autherr(rqstp, rpc_autherr_badcred);
+	rqstp->rq_auth_stat = rpc_autherr_badcred;
+	return rpc_success;
 }
 
 /*
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 35f12963e1ff..63c9210cae06 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -275,7 +275,6 @@ struct svc_rqst {
 #define	RQ_VICTIM	(5)			/* about to be shut down */
 #define	RQ_BUSY		(6)			/* request is busy */
 #define	RQ_DATA		(7)			/* request has data */
-#define RQ_AUTHERR	(8)			/* Request status is auth error */
 	unsigned long		rq_flags;	/* flags field */
 	ktime_t			rq_qtime;	/* enqueue time */
 
@@ -533,7 +532,6 @@ unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
 char		  *svc_fill_symlink_pathname(struct svc_rqst *rqstp,
 					     struct kvec *first, void *p,
 					     size_t total);
-__be32		   svc_return_autherr(struct svc_rqst *rqstp, __be32 auth_err);
 __be32		   svc_generic_init_request(struct svc_rqst *rqstp,
 					    const struct svc_program *progp,
 					    struct svc_process_info *procinfo);
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 9f09f5b4d0f8..174385da20ad 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1568,8 +1568,7 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
 	svc_rqst_flag(SPLICE_OK)					\
 	svc_rqst_flag(VICTIM)						\
 	svc_rqst_flag(BUSY)						\
-	svc_rqst_flag(DATA)						\
-	svc_rqst_flag_end(AUTHERR)
+	svc_rqst_flag_end(DATA)
 
 #undef svc_rqst_flag
 #undef svc_rqst_flag_end
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 2019d1203641..95836bf514b5 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1163,22 +1163,6 @@ void svc_printk(struct svc_rqst *rqstp, const char *fmt, ...)
 static __printf(2,3) void svc_printk(struct svc_rqst *rqstp, const char *fmt, ...) {}
 #endif
 
-__be32
-svc_return_autherr(struct svc_rqst *rqstp, __be32 auth_err)
-{
-	set_bit(RQ_AUTHERR, &rqstp->rq_flags);
-	return auth_err;
-}
-EXPORT_SYMBOL_GPL(svc_return_autherr);
-
-static __be32
-svc_get_autherr(struct svc_rqst *rqstp, __be32 *statp)
-{
-	if (test_and_clear_bit(RQ_AUTHERR, &rqstp->rq_flags))
-		return *statp;
-	return rpc_auth_ok;
-}
-
 static int
 svc_generic_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
@@ -1202,7 +1186,7 @@ svc_generic_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	    test_bit(RQ_DROPME, &rqstp->rq_flags))
 		return 0;
 
-	if (test_bit(RQ_AUTHERR, &rqstp->rq_flags))
+	if (rqstp->rq_auth_stat != rpc_auth_ok)
 		return 1;
 
 	if (*statp != rpc_success)
@@ -1390,15 +1374,15 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 			goto release_dropit;
 		if (*statp == rpc_garbage_args)
 			goto err_garbage;
-		rqstp->rq_auth_stat = svc_get_autherr(rqstp, statp);
-		if (rqstp->rq_auth_stat != rpc_auth_ok)
-			goto err_release_bad_auth;
 	} else {
 		dprintk("svc: calling dispatcher\n");
 		if (!process.dispatch(rqstp, statp))
 			goto release_dropit; /* Release reply info */
 	}
 
+	if (rqstp->rq_auth_stat != rpc_auth_ok)
+		goto err_release_bad_auth;
+
 	/* Check RPC status result */
 	if (*statp != rpc_success)
 		resv->iov_len = ((void*)statp)  - resv->iov_base + 4;


