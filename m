Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6A19DF53
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 22:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgDCUZD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Apr 2020 16:25:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34101 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgDCUZD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Apr 2020 16:25:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id 14so7388246qtp.1
        for <linux-nfs@vger.kernel.org>; Fri, 03 Apr 2020 13:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cBV/xmpwxOImi2oaF/uunnn045ey6mibPZVyZ30JygY=;
        b=gEYkL0Sn8+AZ8Wsa9vrh6Zwx4kze6U8WH2l5DVz5oFc/U+BOdHGOt4qgcnozkYvazt
         5mE6VxxvuQKnnfO4yPBhcSKvnC8tdYCePEgCgDjqv1Jjxc+sbi/av6SG4AzafkoWYAe4
         /w0TglVYBkKBxfmXM90VIsM1cuP815xW5/c/cwzUe5qhpsOU7TPE8ayXCG/no7ojLgZw
         8xnAEcxCkIN0aTIv8Ekbz9wo13meu5hsMHW7oW503JbRyIHwwBFtJGVR3T5hfX2n5lCp
         pjxmXgwmKI6qm4DwlStHkpBzMryoUFrZg6rJ6UiaiJ0KZYVV3M0hWMqawJrkVCCNy5CR
         UsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cBV/xmpwxOImi2oaF/uunnn045ey6mibPZVyZ30JygY=;
        b=XMnWdc9KCleM4C4ZiQpUdcuhYyKgkWsKa8j2K7RjccrGAXIZMnoM54epRC6iR2y2Y1
         nhDvR28JXP+OCe8wCOGGETvmqFkI6T8heJaLGXWORxKrv53I29hLLmb4uXE8tVv4/RL4
         YkISw8a0fWTDsqZ+qXvei4jBR/Qq5Q4QXHS14i4N/4JpimBVXLjNXrFBAcU/ozPPV12j
         rs+Qp2IehSBz6Caxbcfh743zIs9Prc0+zFn+LsAEYY172dgAGnJxC9nbY8zSeUF5y2cT
         JxB0ivrIFafmYeHFHMpiQxN1CGdRIZz622YD0y+qIQq82cjdEJd3Dd5nj8cuxGI75751
         2FAw==
X-Gm-Message-State: AGi0PuYPpqYiMKRUyyCiDvfpV3098X3HKJdnqBhHvJz8+O02iPE4x6UY
        SYFLIoS6jNz3nsvZAFizgLy/3rsF
X-Google-Smtp-Source: APiQypKifizNTFd1qbFUVLF7bvNc/krkR14UTJ5NhyIm0og6M5PKufslxbCOvi+FIiizg+ZKm70cvw==
X-Received: by 2002:ac8:72ce:: with SMTP id o14mr10386662qtp.226.1585945500761;
        Fri, 03 Apr 2020 13:25:00 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v17sm7057577qkf.83.2020.04.03.13.24.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 13:24:59 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 033KOvad029598
        for <linux-nfs@vger.kernel.org>; Fri, 3 Apr 2020 20:24:58 GMT
Subject: [PATCH RFC] SUNRPC: receive buffer size estimation values almost
 never change
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 03 Apr 2020 16:24:57 -0400
Message-ID: <20200403202435.26340.11743.stgit@manet.1015granger.net>
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
 include/linux/sunrpc/auth.h    |    5 +++-
 include/trace/events/rpcgss.h  |   34 ++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/auth_gss.c |   48 ++++++++++++++++++++++++++--------------
 net/sunrpc/xprtrdma/rpc_rdma.c |    4 ++-
 4 files changed, 70 insertions(+), 21 deletions(-)

Here's more -rc fodder. Comments welcome.

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
index 9827f535f032..9217f58fc122 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -268,6 +268,40 @@
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
 /**
  ** gssd upcall related trace events
  **/
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 45707a306f20..b5a3f645d478 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1053,11 +1053,11 @@ static void gss_pipe_free(struct gss_pipe *p)
 	auth->au_rslack = GSS_VERF_SLACK >> 2;
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
 
@@ -1612,6 +1612,7 @@ static int gss_renew_cred(struct rpc_task *task)
 	new = gss_lookup_cred(auth, &acred, RPCAUTH_LOOKUP_NEW);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
+
 	task->tk_rqstp->rq_cred = new;
 	put_rpccred(oldcred);
 	return 0;
@@ -1708,7 +1709,8 @@ static int gss_cred_is_negative_entry(struct rpc_cred *cred)
 
 	/* We leave it to unwrap to calculate au_rslack. For now we just
 	 * calculate the length of the verifier: */
-	cred->cr_auth->au_verfsize = XDR_QUADLEN(len) + 2;
+	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags))
+		cred->cr_auth->au_verfsize = XDR_QUADLEN(len) + 2;
 	status = 0;
 out:
 	gss_put_ctx(ctx);
@@ -1926,13 +1928,30 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
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
 
@@ -1955,7 +1974,6 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 		      struct xdr_stream *xdr)
 {
 	struct xdr_buf gss_data, *rcv_buf = &rqstp->rq_rcv_buf;
-	struct rpc_auth *auth = cred->cr_auth;
 	u32 len, offset, seqno, maj_stat;
 	struct xdr_netobj mic;
 	int ret;
@@ -2004,8 +2022,7 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_mic;
 
-	auth->au_rslack = auth->au_verfsize + 2 + 1 + XDR_QUADLEN(mic.len);
-	auth->au_ralign = auth->au_verfsize + 2;
+	gss_update_rslack(task, cred, 2, 2 + 1 + XDR_QUADLEN(mic.len));
 	ret = 0;
 
 out:
@@ -2030,8 +2047,7 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 {
 	struct xdr_buf *rcv_buf = &rqstp->rq_rcv_buf;
 	struct kvec *head = rqstp->rq_rcv_buf.head;
-	struct rpc_auth *auth = cred->cr_auth;
-	unsigned int savedlen = rcv_buf->len;
+	unsigned int slack, savedlen = rcv_buf->len;
 	u32 offset, opaque_len, maj_stat;
 	__be32 *p;
 
@@ -2058,10 +2074,8 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 	 */
 	xdr_init_decode(xdr, rcv_buf, p, rqstp);
 
-	auth->au_rslack = auth->au_verfsize + 2 +
-			  XDR_QUADLEN(savedlen - rcv_buf->len);
-	auth->au_ralign = auth->au_verfsize + 2 +
-			  XDR_QUADLEN(savedlen - rcv_buf->len);
+	slack = 2 + XDR_QUADLEN(savedlen - rcv_buf->len);
+	gss_update_rslack(task, cred, slack, slack);
 	return 0;
 unwrap_failed:
 	trace_rpcgss_unwrap_failed(task);
@@ -2131,7 +2145,7 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 		goto out_decode;
 	switch (gss_cred->gc_service) {
 	case RPC_GSS_SVC_NONE:
-		status = gss_unwrap_resp_auth(cred);
+		status = gss_unwrap_resp_auth(task, cred);
 		break;
 	case RPC_GSS_SVC_INTEGRITY:
 		status = gss_unwrap_resp_integ(task, cred, ctx, rqstp, xdr);
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index d1af48e0139c..adc998dc5c32 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -911,8 +911,8 @@ inline int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
 	 * or privacy, direct data placement of individual data items
 	 * is not allowed.
 	 */
-	ddp_allowed = !(rqst->rq_cred->cr_auth->au_flags &
-						RPCAUTH_AUTH_DATATOUCH);
+	ddp_allowed = !test_bit(RPCAUTH_AUTH_DATATOUCH,
+				&rqst->rq_cred->cr_auth->au_flags);
 
 	/*
 	 * Chunks needed for results?

