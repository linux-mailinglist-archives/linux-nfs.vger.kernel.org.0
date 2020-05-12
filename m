Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2AE1D006A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgELVNK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725950AbgELVNJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:13:09 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9FBC061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c24so5990719qtw.7
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MlI3aCQuid91c6vQ5hCKayRz+Psh8/Dqm4yp5F6dV+o=;
        b=jq2mDa2Gp7me2wjaG54mvbm38o9PhiMeu2RfQ/ZC+inGWEiwuo7NQZ41CjoSypK7Ax
         qm1DLewWN5X/en6GWhlqTUpqKQ3J+x5kXlHu+3fJU0f5RXwiY3O7WBoomrJ5aF/bFzRI
         ++vWynU6O4B3J9ce/eVL5T+0YkDWm07LdaeHoR4ufacwLWQG3PcHH1aJS/qpZskOYztt
         G0DYqOCAfwk/xpsAw6DJmDYcNRS8IKvU9vQ+kjJg40iFHiYORubpMloNmh+VLe9JqKVF
         t5EZEfxKhjjhB2ZF9LEkolhDpejmHxvz9Oy07m1vhtSy5rdvAryVHgjdLYzeI2NrF1b4
         BuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=MlI3aCQuid91c6vQ5hCKayRz+Psh8/Dqm4yp5F6dV+o=;
        b=teBfp1+0qYXvOtwuGfyw+Mo6QtKDFtWvOvilGU/HVrTJWdnBKKZqOdZnvCpNjtvOM7
         6xSaxNM6WHrYdMVSbwKj2biAdEBKOM9bqcjO015iCPl2ML0GH8/KSZVfqwjtpxULGExF
         nZRdfm3sAmZl0zMmDJM/cpmAXIcH8QE0gnO5svQYeJ5ZZNOjBxG4bXelPw4JdIjzGMqp
         A8U+AHFV/t8R09VhJdESCZefyUFixcBVX0zyBQIyDo36q7eQwwAq67h+Qe7JBbMM9adH
         G7FvnNfvapSFBhx0U40GULrLQqrnP3t+nJukM0loCuLbAfL39yXJZm376zETj1BOie6e
         W+2Q==
X-Gm-Message-State: AGi0PuZX8EUPDWf6a1zy479G90obX0sTnc8LS9Oxs3g1JAQj0KT6tpOz
        GmFHK8mcayaMc5OcQyNjwayou593
X-Google-Smtp-Source: APiQypKmJmtoGd3COnFkow2kkHzjSMGq9ENauaDa0FVzcsDyIuriM7ErUnhlThnODWESGM0YBsXs/w==
X-Received: by 2002:ac8:c8b:: with SMTP id n11mr24409409qti.49.1589317988780;
        Tue, 12 May 2020 14:13:08 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i41sm478285qte.15.2020.05.12.14.13.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:13:08 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLD7Qj009792;
        Tue, 12 May 2020 21:13:07 GMT
Subject: [PATCH v1 03/15] SUNRPC: Trace GSS context lifetimes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:13:07 -0400
Message-ID: <20200512211307.3288.68000.stgit@manet.1015granger.net>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcgss.h  |   55 +++++++++++++++++++++++++++++++++++++---
 net/sunrpc/auth_gss/auth_gss.c |   10 ++++---
 net/sunrpc/auth_gss/trace.c    |    1 +
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index 421b14db87ae..b9b51a4b1db1 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -17,6 +17,16 @@
  ** GSS-API related trace events
  **/
 
+TRACE_DEFINE_ENUM(RPC_GSS_SVC_NONE);
+TRACE_DEFINE_ENUM(RPC_GSS_SVC_INTEGRITY);
+TRACE_DEFINE_ENUM(RPC_GSS_SVC_PRIVACY);
+
+#define show_gss_service(x)						\
+	__print_symbolic(x,						\
+		{ RPC_GSS_SVC_NONE,		"none" },		\
+		{ RPC_GSS_SVC_INTEGRITY,	"integrity" },		\
+		{ RPC_GSS_SVC_PRIVACY,		"privacy" })
+
 TRACE_DEFINE_ENUM(GSS_S_BAD_MECH);
 TRACE_DEFINE_ENUM(GSS_S_BAD_NAME);
 TRACE_DEFINE_ENUM(GSS_S_BAD_NAMETYPE);
@@ -126,6 +136,40 @@
 DEFINE_GSSAPI_EVENT(wrap);
 DEFINE_GSSAPI_EVENT(unwrap);
 
+DECLARE_EVENT_CLASS(rpcgss_ctx_class,
+	TP_PROTO(
+		const struct gss_cred *gc
+	),
+
+	TP_ARGS(gc),
+
+	TP_STRUCT__entry(
+		__field(const void *, cred)
+		__field(unsigned long, service)
+		__string(principal, gc->gc_principal)
+	),
+
+	TP_fast_assign(
+		__entry->cred = gc;
+		__entry->service = gc->gc_service;
+		__assign_str(principal, gc->gc_principal)
+	),
+
+	TP_printk("cred=%p service=%s principal='%s'",
+		__entry->cred, show_gss_service(__entry->service),
+		__get_str(principal))
+);
+
+#define DEFINE_CTX_EVENT(name)						\
+	DEFINE_EVENT(rpcgss_ctx_class, rpcgss_ctx_##name,		\
+			TP_PROTO(					\
+				const struct gss_cred *gc		\
+			),						\
+			TP_ARGS(gc))
+
+DEFINE_CTX_EVENT(init);
+DEFINE_CTX_EVENT(destroy);
+
 TRACE_EVENT(rpcgss_svc_accept_upcall,
 	TP_PROTO(
 		__be32 xid,
@@ -405,6 +449,7 @@
 
 TRACE_EVENT(rpcgss_context,
 	TP_PROTO(
+		u32 window_size,
 		unsigned long expiry,
 		unsigned long now,
 		unsigned int timeout,
@@ -412,12 +457,13 @@
 		const u8 *data
 	),
 
-	TP_ARGS(expiry, now, timeout, len, data),
+	TP_ARGS(window_size, expiry, now, timeout, len, data),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, expiry)
 		__field(unsigned long, now)
 		__field(unsigned int, timeout)
+		__field(u32, window_size)
 		__field(int, len)
 		__string(acceptor, data)
 	),
@@ -426,13 +472,14 @@
 		__entry->expiry = expiry;
 		__entry->now = now;
 		__entry->timeout = timeout;
+		__entry->window_size = window_size;
 		__entry->len = len;
 		strncpy(__get_str(acceptor), data, len);
 	),
 
-	TP_printk("gc_expiry=%lu now=%lu timeout=%u acceptor=%.*s",
-		__entry->expiry, __entry->now, __entry->timeout,
-		__entry->len, __get_str(acceptor))
+	TP_printk("win_size=%u expiry=%lu now=%lu timeout=%u acceptor=%.*s",
+		__entry->window_size, __entry->expiry, __entry->now,
+		__entry->timeout, __entry->len, __get_str(acceptor))
 );
 
 
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 5f097c8cacd1..429f17459ae3 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -254,7 +254,7 @@ struct gss_auth {
 	if (IS_ERR(p))
 		goto err;
 done:
-	trace_rpcgss_context(ctx->gc_expiry, now, timeout,
+	trace_rpcgss_context(window_size, ctx->gc_expiry, now, timeout,
 			     ctx->gc_acceptor.len, ctx->gc_acceptor.data);
 err:
 	return p;
@@ -697,10 +697,12 @@ static void warn_gssd(void)
 		}
 		schedule();
 	}
-	if (gss_msg->ctx)
+	if (gss_msg->ctx) {
+		trace_rpcgss_ctx_init(gss_cred);
 		gss_cred_set_ctx(cred, gss_msg->ctx);
-	else
+	} else {
 		err = gss_msg->msg.errno;
+	}
 	spin_unlock(&pipe->lock);
 out_intr:
 	finish_wait(&gss_msg->waitqueue, &wait);
@@ -1284,6 +1286,7 @@ static void gss_pipe_free(struct gss_pipe *p)
 	if (new) {
 		ctx->gc_proc = RPC_GSS_PROC_DESTROY;
 
+		trace_rpcgss_ctx_destroy(gss_cred);
 		task = rpc_call_null(gss_auth->client, &new->gc_base,
 				RPC_TASK_ASYNC|RPC_TASK_SOFT);
 		if (!IS_ERR(task))
@@ -1349,7 +1352,6 @@ static void gss_pipe_free(struct gss_pipe *p)
 static void
 gss_destroy_cred(struct rpc_cred *cred)
 {
-
 	if (test_and_clear_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags) != 0)
 		gss_send_destroy_context(cred);
 	gss_destroy_nullcred(cred);
diff --git a/net/sunrpc/auth_gss/trace.c b/net/sunrpc/auth_gss/trace.c
index 5576f1e66de9..49fa583d7f91 100644
--- a/net/sunrpc/auth_gss/trace.c
+++ b/net/sunrpc/auth_gss/trace.c
@@ -6,6 +6,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/sched.h>
 #include <linux/sunrpc/gss_err.h>
+#include <linux/sunrpc/auth_gss.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/rpcgss.h>

