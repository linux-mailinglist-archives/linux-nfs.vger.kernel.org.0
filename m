Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A233CAD42
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 21:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbhGOT4T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 15:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345608AbhGOTzB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Jul 2021 15:55:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 884E261285;
        Thu, 15 Jul 2021 19:52:07 +0000 (UTC)
Subject: [PATCH v2 1/7] SUNRPC: Add svc_rqst::rq_auth_stat
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 15 Jul 2021 15:52:06 -0400
Message-ID: <162637872679.728653.18259583584321811849.stgit@manet.1015granger.net>
In-Reply-To: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
References: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'd like to take commit 4532608d71c8 ("SUNRPC: Clean up generic
dispatcher code") even further by using only private local SVC
dispatchers for all kernel RPC services. This change would enable
the removal of the logic that switches between
svc_generic_dispatch() and a service's private dispatcher, and
simplify the invocation of the service's pc_release method
so that humans can visually verify that it is always invoked
properly.

All that will come later.

First, let's provide a better way to return authentication errors
from SVC dispatcher functions. Instead of overloading the dispatch
method's *statp argument, add a field to struct svc_rqst that can
hold an error value.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h        |    1 +
 include/linux/sunrpc/svcauth.h    |    4 ++-
 include/trace/events/sunrpc.h     |    6 +++--
 net/sunrpc/auth_gss/svcauth_gss.c |   43 ++++++++++++++++++-------------------
 net/sunrpc/svc.c                  |   17 ++++++++-------
 net/sunrpc/svcauth.c              |    8 +++----
 net/sunrpc/svcauth_unix.c         |   12 +++++-----
 7 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e91d51ea028b..35f12963e1ff 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -282,6 +282,7 @@ struct svc_rqst {
 	void *			rq_argp;	/* decoded arguments */
 	void *			rq_resp;	/* xdr'd results */
 	void *			rq_auth_data;	/* flavor-specific data */
+	__be32			rq_auth_stat;	/* authentication status */
 	int			rq_auth_slack;	/* extra space xdr code
 						 * should leave in head
 						 * for krb5i, krb5p.
diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
index b0003866a249..6d9cc9080aca 100644
--- a/include/linux/sunrpc/svcauth.h
+++ b/include/linux/sunrpc/svcauth.h
@@ -127,7 +127,7 @@ struct auth_ops {
 	char *	name;
 	struct module *owner;
 	int	flavour;
-	int	(*accept)(struct svc_rqst *rq, __be32 *authp);
+	int	(*accept)(struct svc_rqst *rq);
 	int	(*release)(struct svc_rqst *rq);
 	void	(*domain_release)(struct auth_domain *);
 	int	(*set_client)(struct svc_rqst *rq);
@@ -149,7 +149,7 @@ struct auth_ops {
 
 struct svc_xprt;
 
-extern int	svc_authenticate(struct svc_rqst *rqstp, __be32 *authp);
+extern int	svc_authenticate(struct svc_rqst *rqstp);
 extern int	svc_authorise(struct svc_rqst *rqstp);
 extern int	svc_set_client(struct svc_rqst *rqstp);
 extern int	svc_auth_register(rpc_authflavor_t flavor, struct auth_ops *aops);
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 861f199896c6..9f09f5b4d0f8 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1611,9 +1611,9 @@ TRACE_DEFINE_ENUM(SVC_COMPLETE);
 		{ SVC_COMPLETE,	"SVC_COMPLETE" })
 
 TRACE_EVENT(svc_authenticate,
-	TP_PROTO(const struct svc_rqst *rqst, int auth_res, __be32 auth_stat),
+	TP_PROTO(const struct svc_rqst *rqst, int auth_res),
 
-	TP_ARGS(rqst, auth_res, auth_stat),
+	TP_ARGS(rqst, auth_res),
 
 	TP_STRUCT__entry(
 		__field(u32, xid)
@@ -1624,7 +1624,7 @@ TRACE_EVENT(svc_authenticate,
 	TP_fast_assign(
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->svc_status = auth_res;
-		__entry->auth_stat = be32_to_cpu(auth_stat);
+		__entry->auth_stat = be32_to_cpu(rqst->rq_auth_stat);
 	),
 
 	TP_printk("xid=0x%08x auth_res=%s auth_stat=%s",
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index a81be45f40d9..635449ed7af6 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -707,11 +707,11 @@ svc_safe_putnetobj(struct kvec *resv, struct xdr_netobj *o)
 /*
  * Verify the checksum on the header and return SVC_OK on success.
  * Otherwise, return SVC_DROP (in the case of a bad sequence number)
- * or return SVC_DENIED and indicate error in authp.
+ * or return SVC_DENIED and indicate error in rqstp->rq_auth_stat.
  */
 static int
 gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
-		  __be32 *rpcstart, struct rpc_gss_wire_cred *gc, __be32 *authp)
+		  __be32 *rpcstart, struct rpc_gss_wire_cred *gc)
 {
 	struct gss_ctx		*ctx_id = rsci->mechctx;
 	struct xdr_buf		rpchdr;
@@ -725,7 +725,7 @@ gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
 	iov.iov_len = (u8 *)argv->iov_base - (u8 *)rpcstart;
 	xdr_buf_from_iov(&iov, &rpchdr);
 
-	*authp = rpc_autherr_badverf;
+	rqstp->rq_auth_stat = rpc_autherr_badverf;
 	if (argv->iov_len < 4)
 		return SVC_DENIED;
 	flavor = svc_getnl(argv);
@@ -737,13 +737,13 @@ gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
 	if (rqstp->rq_deferred) /* skip verification of revisited request */
 		return SVC_OK;
 	if (gss_verify_mic(ctx_id, &rpchdr, &checksum) != GSS_S_COMPLETE) {
-		*authp = rpcsec_gsserr_credproblem;
+		rqstp->rq_auth_stat = rpcsec_gsserr_credproblem;
 		return SVC_DENIED;
 	}
 
 	if (gc->gc_seq > MAXSEQ) {
 		trace_rpcgss_svc_seqno_large(rqstp, gc->gc_seq);
-		*authp = rpcsec_gsserr_ctxproblem;
+		rqstp->rq_auth_stat = rpcsec_gsserr_ctxproblem;
 		return SVC_DENIED;
 	}
 	if (!gss_check_seq_num(rqstp, rsci, gc->gc_seq))
@@ -1142,7 +1142,7 @@ static void gss_free_in_token_pages(struct gssp_in_token *in_token)
 }
 
 static int gss_read_proxy_verf(struct svc_rqst *rqstp,
-			       struct rpc_gss_wire_cred *gc, __be32 *authp,
+			       struct rpc_gss_wire_cred *gc,
 			       struct xdr_netobj *in_handle,
 			       struct gssp_in_token *in_token)
 {
@@ -1151,7 +1151,7 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 	int pages, i, res, pgto, pgfrom;
 	size_t inlen, to_offs, from_offs;
 
-	res = gss_read_common_verf(gc, argv, authp, in_handle);
+	res = gss_read_common_verf(gc, argv, &rqstp->rq_auth_stat, in_handle);
 	if (res)
 		return res;
 
@@ -1227,7 +1227,7 @@ gss_write_resv(struct kvec *resv, size_t size_limit,
  * Otherwise, drop the request pending an answer to the upcall.
  */
 static int svcauth_gss_legacy_init(struct svc_rqst *rqstp,
-			struct rpc_gss_wire_cred *gc, __be32 *authp)
+				   struct rpc_gss_wire_cred *gc)
 {
 	struct kvec *argv = &rqstp->rq_arg.head[0];
 	struct kvec *resv = &rqstp->rq_res.head[0];
@@ -1236,7 +1236,7 @@ static int svcauth_gss_legacy_init(struct svc_rqst *rqstp,
 	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
 	memset(&rsikey, 0, sizeof(rsikey));
-	ret = gss_read_verf(gc, argv, authp,
+	ret = gss_read_verf(gc, argv, &rqstp->rq_auth_stat,
 			    &rsikey.in_handle, &rsikey.in_token);
 	if (ret)
 		return ret;
@@ -1339,7 +1339,7 @@ static int gss_proxy_save_rsc(struct cache_detail *cd,
 }
 
 static int svcauth_gss_proxy_init(struct svc_rqst *rqstp,
-			struct rpc_gss_wire_cred *gc, __be32 *authp)
+				  struct rpc_gss_wire_cred *gc)
 {
 	struct kvec *resv = &rqstp->rq_res.head[0];
 	struct xdr_netobj cli_handle;
@@ -1351,8 +1351,7 @@ static int svcauth_gss_proxy_init(struct svc_rqst *rqstp,
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
 
 	memset(&ud, 0, sizeof(ud));
-	ret = gss_read_proxy_verf(rqstp, gc, authp,
-				  &ud.in_handle, &ud.in_token);
+	ret = gss_read_proxy_verf(rqstp, gc, &ud.in_handle, &ud.in_token);
 	if (ret)
 		return ret;
 
@@ -1525,7 +1524,7 @@ static void destroy_use_gss_proxy_proc_entry(struct net *net) {}
  * response here and return SVC_COMPLETE.
  */
 static int
-svcauth_gss_accept(struct svc_rqst *rqstp, __be32 *authp)
+svcauth_gss_accept(struct svc_rqst *rqstp)
 {
 	struct kvec	*argv = &rqstp->rq_arg.head[0];
 	struct kvec	*resv = &rqstp->rq_res.head[0];
@@ -1538,7 +1537,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp, __be32 *authp)
 	int		ret;
 	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
-	*authp = rpc_autherr_badcred;
+	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	if (!svcdata)
 		svcdata = kmalloc(sizeof(*svcdata), GFP_KERNEL);
 	if (!svcdata)
@@ -1575,22 +1574,22 @@ svcauth_gss_accept(struct svc_rqst *rqstp, __be32 *authp)
 	if ((gc->gc_proc != RPC_GSS_PROC_DATA) && (rqstp->rq_proc != 0))
 		goto auth_err;
 
-	*authp = rpc_autherr_badverf;
+	rqstp->rq_auth_stat = rpc_autherr_badverf;
 	switch (gc->gc_proc) {
 	case RPC_GSS_PROC_INIT:
 	case RPC_GSS_PROC_CONTINUE_INIT:
 		if (use_gss_proxy(SVC_NET(rqstp)))
-			return svcauth_gss_proxy_init(rqstp, gc, authp);
+			return svcauth_gss_proxy_init(rqstp, gc);
 		else
-			return svcauth_gss_legacy_init(rqstp, gc, authp);
+			return svcauth_gss_legacy_init(rqstp, gc);
 	case RPC_GSS_PROC_DATA:
 	case RPC_GSS_PROC_DESTROY:
 		/* Look up the context, and check the verifier: */
-		*authp = rpcsec_gsserr_credproblem;
+		rqstp->rq_auth_stat = rpcsec_gsserr_credproblem;
 		rsci = gss_svc_searchbyctx(sn->rsc_cache, &gc->gc_ctx);
 		if (!rsci)
 			goto auth_err;
-		switch (gss_verify_header(rqstp, rsci, rpcstart, gc, authp)) {
+		switch (gss_verify_header(rqstp, rsci, rpcstart, gc)) {
 		case SVC_OK:
 			break;
 		case SVC_DENIED:
@@ -1600,7 +1599,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp, __be32 *authp)
 		}
 		break;
 	default:
-		*authp = rpc_autherr_rejectedcred;
+		rqstp->rq_auth_stat = rpc_autherr_rejectedcred;
 		goto auth_err;
 	}
 
@@ -1616,13 +1615,13 @@ svcauth_gss_accept(struct svc_rqst *rqstp, __be32 *authp)
 		svc_putnl(resv, RPC_SUCCESS);
 		goto complete;
 	case RPC_GSS_PROC_DATA:
-		*authp = rpcsec_gsserr_ctxproblem;
+		rqstp->rq_auth_stat = rpcsec_gsserr_ctxproblem;
 		svcdata->verf_start = resv->iov_base + resv->iov_len;
 		if (gss_write_verf(rqstp, rsci->mechctx, gc->gc_seq))
 			goto auth_err;
 		rqstp->rq_cred = rsci->cred;
 		get_group_info(rsci->cred.cr_group_info);
-		*authp = rpc_autherr_badcred;
+		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		switch (gc->gc_svc) {
 		case RPC_GSS_SVC_NONE:
 			break;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 0de918cb3d90..360dab62b6b4 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1283,7 +1283,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	struct svc_process_info process;
 	__be32			*statp;
 	u32			prog, vers;
-	__be32			auth_stat, rpc_stat;
+	__be32			rpc_stat;
 	int			auth_res;
 	__be32			*reply_statp;
 
@@ -1326,14 +1326,14 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	 * We do this before anything else in order to get a decent
 	 * auth verifier.
 	 */
-	auth_res = svc_authenticate(rqstp, &auth_stat);
+	auth_res = svc_authenticate(rqstp);
 	/* Also give the program a chance to reject this call: */
 	if (auth_res == SVC_OK && progp) {
-		auth_stat = rpc_autherr_badcred;
+		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		auth_res = progp->pg_authenticate(rqstp);
 	}
 	if (auth_res != SVC_OK)
-		trace_svc_authenticate(rqstp, auth_res, auth_stat);
+		trace_svc_authenticate(rqstp, auth_res);
 	switch (auth_res) {
 	case SVC_OK:
 		break;
@@ -1392,8 +1392,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 			goto release_dropit;
 		if (*statp == rpc_garbage_args)
 			goto err_garbage;
-		auth_stat = svc_get_autherr(rqstp, statp);
-		if (auth_stat != rpc_auth_ok)
+		rqstp->rq_auth_stat = svc_get_autherr(rqstp, statp);
+		if (rqstp->rq_auth_stat != rpc_auth_ok)
 			goto err_release_bad_auth;
 	} else {
 		dprintk("svc: calling dispatcher\n");
@@ -1450,13 +1450,14 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	if (procp->pc_release)
 		procp->pc_release(rqstp);
 err_bad_auth:
-	dprintk("svc: authentication failed (%d)\n", ntohl(auth_stat));
+	dprintk("svc: authentication failed (%d)\n",
+		be32_to_cpu(rqstp->rq_auth_stat));
 	serv->sv_stats->rpcbadauth++;
 	/* Restore write pointer to location of accept status: */
 	xdr_ressize_check(rqstp, reply_statp);
 	svc_putnl(resv, 1);	/* REJECT */
 	svc_putnl(resv, 1);	/* AUTH_ERROR */
-	svc_putnl(resv, ntohl(auth_stat));	/* status */
+	svc_putu32(resv, rqstp->rq_auth_stat);	/* status */
 	goto sendit;
 
 err_bad_prog:
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index 998b196b6176..5a8b8e03fdd4 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -59,12 +59,12 @@ svc_put_auth_ops(struct auth_ops *aops)
 }
 
 int
-svc_authenticate(struct svc_rqst *rqstp, __be32 *authp)
+svc_authenticate(struct svc_rqst *rqstp)
 {
 	rpc_authflavor_t	flavor;
 	struct auth_ops		*aops;
 
-	*authp = rpc_auth_ok;
+	rqstp->rq_auth_stat = rpc_auth_ok;
 
 	flavor = svc_getnl(&rqstp->rq_arg.head[0]);
 
@@ -72,7 +72,7 @@ svc_authenticate(struct svc_rqst *rqstp, __be32 *authp)
 
 	aops = svc_get_auth_ops(flavor);
 	if (aops == NULL) {
-		*authp = rpc_autherr_badcred;
+		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		return SVC_DENIED;
 	}
 
@@ -80,7 +80,7 @@ svc_authenticate(struct svc_rqst *rqstp, __be32 *authp)
 	init_svc_cred(&rqstp->rq_cred);
 
 	rqstp->rq_authop = aops;
-	return aops->accept(rqstp, authp);
+	return aops->accept(rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_authenticate);
 
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 35b7966ac3b3..eacfebf326dd 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -725,7 +725,7 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
 EXPORT_SYMBOL_GPL(svcauth_unix_set_client);
 
 static int
-svcauth_null_accept(struct svc_rqst *rqstp, __be32 *authp)
+svcauth_null_accept(struct svc_rqst *rqstp)
 {
 	struct kvec	*argv = &rqstp->rq_arg.head[0];
 	struct kvec	*resv = &rqstp->rq_res.head[0];
@@ -736,12 +736,12 @@ svcauth_null_accept(struct svc_rqst *rqstp, __be32 *authp)
 
 	if (svc_getu32(argv) != 0) {
 		dprintk("svc: bad null cred\n");
-		*authp = rpc_autherr_badcred;
+		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		return SVC_DENIED;
 	}
 	if (svc_getu32(argv) != htonl(RPC_AUTH_NULL) || svc_getu32(argv) != 0) {
 		dprintk("svc: bad null verf\n");
-		*authp = rpc_autherr_badverf;
+		rqstp->rq_auth_stat = rpc_autherr_badverf;
 		return SVC_DENIED;
 	}
 
@@ -785,7 +785,7 @@ struct auth_ops svcauth_null = {
 
 
 static int
-svcauth_unix_accept(struct svc_rqst *rqstp, __be32 *authp)
+svcauth_unix_accept(struct svc_rqst *rqstp)
 {
 	struct kvec	*argv = &rqstp->rq_arg.head[0];
 	struct kvec	*resv = &rqstp->rq_res.head[0];
@@ -827,7 +827,7 @@ svcauth_unix_accept(struct svc_rqst *rqstp, __be32 *authp)
 	}
 	groups_sort(cred->cr_group_info);
 	if (svc_getu32(argv) != htonl(RPC_AUTH_NULL) || svc_getu32(argv) != 0) {
-		*authp = rpc_autherr_badverf;
+		rqstp->rq_auth_stat = rpc_autherr_badverf;
 		return SVC_DENIED;
 	}
 
@@ -839,7 +839,7 @@ svcauth_unix_accept(struct svc_rqst *rqstp, __be32 *authp)
 	return SVC_OK;
 
 badcred:
-	*authp = rpc_autherr_badcred;
+	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	return SVC_DENIED;
 }
 


