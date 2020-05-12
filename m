Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50F61D0068
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgELVNE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725950AbgELVNE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:13:04 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0D8C061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f13so14642860qkh.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=36KUCgQVAjjJzTiEwEPxn3OQGkVQJZCiA1sT6sRsF2w=;
        b=tvNJgmqTXR5F2ivRA7/1OsyEFXl6L1ew7nUBZ6zRzxOFT97u1rmiEupSPQIS7Z7r+S
         VQMG//xXMPzz/5Es4cMZdR8QOu7ZYpiQ24ikbF1kQJsgKByQeVhfxc52ePEVqyMs4HCc
         yJd/TevE06/BLFjJ4dMn46cSiVO4Ywc+SQSna81irO08fJZHvZcZBmIc2N8NFkzAdS7Q
         z5+0NFhmV3ooHzHouBfTES7iYxfzyOHRJ9SDblznnP6kZmghCtD9lP5iHEmSDIMp3Exc
         /2KtA4VWzW2SnMCZmpy5jUmdjHTyQAp8Xmb47CJxIrMUcQ5kk0mSRS8ptnRDRRlCi9ql
         aK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=36KUCgQVAjjJzTiEwEPxn3OQGkVQJZCiA1sT6sRsF2w=;
        b=oht46Ts6BV836zrXr38CmFiMczzeyXWDv0xK3tN0olMobIoFoYuGTgnNVmSGlJHYNC
         xOiSzzkkcSE7SwNl++FtDWIGPImpBExz5kiYU5zEVcQvo0F8DpVaOs4gn4SLC9aYRDZ5
         9NkGY9Wjx1grqdu0pxXCx2v8UYfrhi5HsAw9e6Nkj2G9BViNSUqsVV397FVMZ2WVCaFR
         solTir2SiBX9mKdPaGRepmtO1uSZn+x+pVH950SMtb3cM4b5EStm9SD4Rp1GpMjZWm5B
         BuLYaYQPpBY848I97atSB2KRhJn9LFPm07VT89MOLyRsCA56GmoONdu6SWHszL6tSjuT
         ERmQ==
X-Gm-Message-State: AGi0PuZIyrSNWHwJLM1WZv5A98LwTNYEvdrTx8IKvugEgeVTdrkB3Z+u
        ba82w41hY8CPbeW84Vljky8=
X-Google-Smtp-Source: APiQypJAUhvqpTJ3dpKrCzf7URcnc6Is9j/Y9f1xn4GJjAkzjMF2Fp7yMHgOAXBz5qteKEdC2XKkbw==
X-Received: by 2002:a05:620a:2049:: with SMTP id d9mr24923216qka.449.1589317983382;
        Tue, 12 May 2020 14:13:03 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s125sm12141689qkh.51.2020.05.12.14.13.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:13:02 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLD11R009789;
        Tue, 12 May 2020 21:13:01 GMT
Subject: [PATCH v1 02/15] SUNRPC: receive buffer size estimation values
 almost never change
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:13:01 -0400
Message-ID: <20200512211301.3288.78856.stgit@manet.1015granger.net>
In-Reply-To: <20200512210724.3288.15187.stgit@manet.1015granger.net>
References: <20200512210724.3288.15187.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Avoid unnecessary cache sloshing by placing the buffer size
estimation update logic behind an atomic bit flag.

The size of GSS information included in each wrapped Reply does
not change during the lifetime of a GSS context. Therefore, the
au_rslack and au_ralign fields need to be updated only once after
establishing a fresh GSS credential.

Thus a slack size update must occur after a cred is created,
duplicated, renewed, or expires. I'm not sure I have this exactly
right. A trace point is introduced to track updates to these
variables to enable troubleshooting the problem if I missed a spot.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/auth.h    |    5 +++--
 include/trace/events/rpcgss.h  |   34 +++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/auth_gss.c |   44 +++++++++++++++++++++++++++-------------
 net/sunrpc/xprtrdma/rpc_rdma.c |    4 ++--
 4 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
index 4f6b28487f28..98da816b5fc2 100644
--- a/include/linux/sunrpc/auth.h
+++ b/include/linux/sunrpc/auth.h
@@ -76,7 +76,7 @@ struct rpc_auth {
 	unsigned int		au_verfsize;	/* size of reply verifier */
 	unsigned int		au_ralign;	/* words before UL header */
 
-	unsigned int		au_flags;
+	unsigned long		au_flags;
 	const struct rpc_authops *au_ops;
 	rpc_authflavor_t	au_flavor;	/* pseudoflavor (note may
 						 * differ from the flavor in
@@ -89,7 +89,8 @@ struct rpc_auth {
 };
 
 /* rpc_auth au_flags */
-#define RPCAUTH_AUTH_DATATOUCH	0x00000002
+#define RPCAUTH_AUTH_DATATOUCH		(1)
+#define RPCAUTH_AUTH_UPDATE_SLACK	(2)
 
 struct rpc_auth_create_args {
 	rpc_authflavor_t pseudoflavor;
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index 32d88c4fb063..421b14db87ae 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -291,6 +291,40 @@
 		__entry->ret ? "" : "un")
 );
 
+TRACE_EVENT(rpcgss_update_slack,
+	TP_PROTO(
+		const struct rpc_task *task,
+		const struct rpc_auth *auth
+	),
+
+	TP_ARGS(task, auth),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(u32, xid)
+		__field(const void *, auth)
+		__field(unsigned int, rslack)
+		__field(unsigned int, ralign)
+		__field(unsigned int, verfsize)
+	),
+
+	TP_fast_assign(
+		__entry->task_id = task->tk_pid;
+		__entry->client_id = task->tk_client->cl_clid;
+		__entry->xid = be32_to_cpu(task->tk_rqstp->rq_xid);
+		__entry->auth = auth;
+		__entry->rslack = auth->au_rslack;
+		__entry->ralign = auth->au_ralign;
+		__entry->verfsize = auth->au_verfsize;
+	),
+
+	TP_printk("task:%u@%u xid=0x%08x auth=%p rslack=%u ralign=%u verfsize=%u\n",
+		__entry->task_id, __entry->client_id, __entry->xid,
+		__entry->auth, __entry->rslack, __entry->ralign,
+		__entry->verfsize)
+);
+
 DECLARE_EVENT_CLASS(rpcgss_svc_seqno_class,
 	TP_PROTO(
 		__be32 xid,
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index ac5cac0dd24b..5f097c8cacd1 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1054,11 +1054,11 @@ static void gss_pipe_free(struct gss_pipe *p)
 	auth->au_rslack = GSS_KRB5_MAX_SLACK_NEEDED >> 2;
 	auth->au_verfsize = GSS_VERF_SLACK >> 2;
 	auth->au_ralign = GSS_VERF_SLACK >> 2;
-	auth->au_flags = 0;
+	__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &auth->au_flags);
 	auth->au_ops = &authgss_ops;
 	auth->au_flavor = flavor;
 	if (gss_pseudoflavor_to_datatouch(gss_auth->mech, flavor))
-		auth->au_flags |= RPCAUTH_AUTH_DATATOUCH;
+		__set_bit(RPCAUTH_AUTH_DATATOUCH, &auth->au_flags);
 	refcount_set(&auth->au_count, 1);
 	kref_init(&gss_auth->kref);
 
@@ -1613,6 +1613,7 @@ static int gss_renew_cred(struct rpc_task *task)
 	new = gss_lookup_cred(auth, &acred, RPCAUTH_LOOKUP_NEW);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
+
 	task->tk_rqstp->rq_cred = new;
 	put_rpccred(oldcred);
 	return 0;
@@ -1709,7 +1710,8 @@ static int gss_cred_is_negative_entry(struct rpc_cred *cred)
 
 	/* We leave it to unwrap to calculate au_rslack. For now we just
 	 * calculate the length of the verifier: */
-	cred->cr_auth->au_verfsize = XDR_QUADLEN(len) + 2;
+	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags))
+		cred->cr_auth->au_verfsize = XDR_QUADLEN(len) + 2;
 	status = 0;
 out:
 	gss_put_ctx(ctx);
@@ -1927,13 +1929,30 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 	return status;
 }
 
-static int
-gss_unwrap_resp_auth(struct rpc_cred *cred)
+/**
+ * gss_update_rslack - Possibly update RPC receive buffer size estimates
+ * @task: rpc_task for incoming RPC Reply being unwrapped
+ * @cred: controlling rpc_cred for @task
+ * @before: XDR words needed before each RPC Reply message
+ * @after: XDR words needed following each RPC Reply message
+ *
+ */
+static void gss_update_rslack(struct rpc_task *task, struct rpc_cred *cred,
+			      unsigned int before, unsigned int after)
 {
 	struct rpc_auth *auth = cred->cr_auth;
 
-	auth->au_rslack = auth->au_verfsize;
-	auth->au_ralign = auth->au_verfsize;
+	if (test_and_clear_bit(RPCAUTH_AUTH_UPDATE_SLACK, &auth->au_flags)) {
+		auth->au_ralign = auth->au_verfsize + before;
+		auth->au_rslack = auth->au_verfsize + after;
+		trace_rpcgss_update_slack(task, auth);
+	}
+}
+
+static int
+gss_unwrap_resp_auth(struct rpc_task *task, struct rpc_cred *cred)
+{
+	gss_update_rslack(task, cred, 0, 0);
 	return 0;
 }
 
@@ -1956,7 +1975,6 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 		      struct xdr_stream *xdr)
 {
 	struct xdr_buf gss_data, *rcv_buf = &rqstp->rq_rcv_buf;
-	struct rpc_auth *auth = cred->cr_auth;
 	u32 len, offset, seqno, maj_stat;
 	struct xdr_netobj mic;
 	int ret;
@@ -2005,8 +2023,7 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_mic;
 
-	auth->au_rslack = auth->au_verfsize + 2 + 1 + XDR_QUADLEN(mic.len);
-	auth->au_ralign = auth->au_verfsize + 2;
+	gss_update_rslack(task, cred, 2, 2 + 1 + XDR_QUADLEN(mic.len));
 	ret = 0;
 
 out:
@@ -2031,7 +2048,6 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 {
 	struct xdr_buf *rcv_buf = &rqstp->rq_rcv_buf;
 	struct kvec *head = rqstp->rq_rcv_buf.head;
-	struct rpc_auth *auth = cred->cr_auth;
 	u32 offset, opaque_len, maj_stat;
 	__be32 *p;
 
@@ -2058,8 +2074,8 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 	 */
 	xdr_init_decode(xdr, rcv_buf, p, rqstp);
 
-	auth->au_rslack = auth->au_verfsize + 2 + ctx->gc_gss_ctx->slack;
-	auth->au_ralign = auth->au_verfsize + 2 + ctx->gc_gss_ctx->align;
+	gss_update_rslack(task, cred, 2 + ctx->gc_gss_ctx->align,
+			  2 + ctx->gc_gss_ctx->slack);
 
 	return 0;
 unwrap_failed:
@@ -2130,7 +2146,7 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 		goto out_decode;
 	switch (gss_cred->gc_service) {
 	case RPC_GSS_SVC_NONE:
-		status = gss_unwrap_resp_auth(cred);
+		status = gss_unwrap_resp_auth(task, cred);
 		break;
 	case RPC_GSS_SVC_INTEGRITY:
 		status = gss_unwrap_resp_integ(task, cred, ctx, rqstp, xdr);
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 3c627dc685cc..2081c8fbfa48 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -892,8 +892,8 @@ inline int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
 	 * or privacy, direct data placement of individual data items
 	 * is not allowed.
 	 */
-	ddp_allowed = !(rqst->rq_cred->cr_auth->au_flags &
-						RPCAUTH_AUTH_DATATOUCH);
+	ddp_allowed = !test_bit(RPCAUTH_AUTH_DATATOUCH,
+				&rqst->rq_cred->cr_auth->au_flags);
 
 	/*
 	 * Chunks needed for results?

