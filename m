Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE41C1B95
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgEARW0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729018AbgEARW0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:22:26 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02548C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:22:25 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id h124so9863819qke.11
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3smaq2iCn3Tu/s4k3PSIfvNs8Fu/L9t/4Kr7kucluJs=;
        b=qSwMsiFVscMEUMYUHNMVlxsPgqOD3f2E/cckbFVnTTkcU6w6RuGc83bfTeIy1VsnEs
         t79oqN/hAvw/RFEW7TburdMEw0u8Bj+D7mgkrpuCIH4Ccdtucbu3Uu1Z9BPZu/1RL9DD
         j/J9CQMYOUim/myi4bwEd/8/eTTVBed20Cxx9aKB2IkhPw8wijN44uf25twBAKGVc1XJ
         2ae4RN9sOonoFGD/mAeSJJXhS77r08TXH99SvWFcl+rKke1NqB8ccRRTXSjXBtKBRDD7
         A+xu8YZqPblzUZkhqMQDziHJ7TbGhcFMyJE1wfOVU0oG5Ofh2hrwEd4hCc79AqDx+VSa
         dgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=3smaq2iCn3Tu/s4k3PSIfvNs8Fu/L9t/4Kr7kucluJs=;
        b=dKEJ1X466I+yAztj3gtmyCwHvHwIKmT+E7Bd5196pt4fCstQufFqm+AqhQQjYyg0Y2
         N7I9I6cmN4HzMmqVEseGj0SPiSPy9VvUqtYOdT+6Lv3wfJ4t28kNF/gQ9LC2LoSfmQxs
         UCWf3xyKLu+JZ0pNo8qdNXsHI423T9rQRj2mMSWDr5r7WK7J9e2D5hPQe7i3PMGLlzBU
         v4VrTl8MxJtzW5sqhTPrhrrfdIGoHE9vlVzNRKWX//xdhsGyP6ghh1PVseW9X6QoYyFj
         /MNlIqJX1DmsRn/w8Aq+7gVNJ+h0BS/WEs8qS/x6J+gPrMYl8Fi1QZkrqpbeqN8DbN4e
         J6Cg==
X-Gm-Message-State: AGi0PubFeW2mR6GViEEBktmmrMABtY2S51MJpcJCaek7nXQU4tnBMk8n
        IBJWt2k3qLJmpXKZ+gQYafrqLR99
X-Google-Smtp-Source: APiQypI90CtISp+mTfe/TRA1BcCIBWMztoI1raDnGOKGGSwrsPcISzu/Xh3a4Nxw3tW+KFg/eL3nuQ==
X-Received: by 2002:a37:5c81:: with SMTP id q123mr4299561qkb.136.1588353743832;
        Fri, 01 May 2020 10:22:23 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q32sm3240662qta.13.2020.05.01.10.22.23
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:22:23 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HMM1K026681
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:22:22 GMT
Subject: [PATCH v1 3/4] NFSD: Add tracepoints for monitoring NFSD callbacks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:22:22 -0400
Message-ID: <20200501172222.3764.50810.stgit@klimt.1015granger.net>
In-Reply-To: <20200501171750.3764.7676.stgit@klimt.1015granger.net>
References: <20200501171750.3764.7676.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |   37 +++++++-----
 fs/nfsd/nfs4state.c    |    6 +-
 fs/nfsd/trace.h        |  153 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 5cf91322de0f..966ca75418c8 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -38,6 +38,7 @@
 #include "nfsd.h"
 #include "state.h"
 #include "netns.h"
+#include "trace.h"
 #include "xdr4cb.h"
 #include "xdr4.h"
 
@@ -904,16 +905,20 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 
 	if (clp->cl_minorversion == 0) {
 		if (!clp->cl_cred.cr_principal &&
-				(clp->cl_cred.cr_flavor >= RPC_AUTH_GSS_KRB5))
+		    (clp->cl_cred.cr_flavor >= RPC_AUTH_GSS_KRB5)) {
+			trace_nfsd_cb_setup_err(clp, -EINVAL);
 			return -EINVAL;
+		}
 		args.client_name = clp->cl_cred.cr_principal;
 		args.prognumber	= conn->cb_prog;
 		args.protocol = XPRT_TRANSPORT_TCP;
 		args.authflavor = clp->cl_cred.cr_flavor;
 		clp->cl_cb_ident = conn->cb_ident;
 	} else {
-		if (!conn->cb_xprt)
+		if (!conn->cb_xprt) {
+			trace_nfsd_cb_setup_err(clp, -EINVAL);
 			return -EINVAL;
+		}
 		clp->cl_cb_conn.cb_xprt = conn->cb_xprt;
 		clp->cl_cb_session = ses;
 		args.bc_xprt = conn->cb_xprt;
@@ -925,32 +930,27 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 	/* Create RPC client */
 	client = rpc_create(&args);
 	if (IS_ERR(client)) {
-		dprintk("NFSD: couldn't create callback client: %ld\n",
-			PTR_ERR(client));
+		trace_nfsd_cb_setup_err(clp, PTR_ERR(client));
 		return PTR_ERR(client);
 	}
 	cred = get_backchannel_cred(clp, client, ses);
 	if (!cred) {
+		trace_nfsd_cb_setup_err(clp, -ENOMEM);
 		rpc_shutdown_client(client);
 		return -ENOMEM;
 	}
 	clp->cl_cb_client = client;
 	clp->cl_cb_cred = cred;
+	trace_nfsd_cb_setup(clp);
 	return 0;
 }
 
-static void warn_no_callback_path(struct nfs4_client *clp, int reason)
-{
-	dprintk("NFSD: warning: no callback path to client %.*s: error %d\n",
-		(int)clp->cl_name.len, clp->cl_name.data, reason);
-}
-
 static void nfsd4_mark_cb_down(struct nfs4_client *clp, int reason)
 {
 	if (test_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags))
 		return;
 	clp->cl_cb_state = NFSD4_CB_DOWN;
-	warn_no_callback_path(clp, reason);
+	trace_nfsd_cb_state(clp);
 }
 
 static void nfsd4_mark_cb_fault(struct nfs4_client *clp, int reason)
@@ -958,17 +958,20 @@ static void nfsd4_mark_cb_fault(struct nfs4_client *clp, int reason)
 	if (test_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags))
 		return;
 	clp->cl_cb_state = NFSD4_CB_FAULT;
-	warn_no_callback_path(clp, reason);
+	trace_nfsd_cb_state(clp);
 }
 
 static void nfsd4_cb_probe_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_client *clp = container_of(calldata, struct nfs4_client, cl_cb_null);
 
+	trace_nfsd_cb_done(clp, task->tk_status);
 	if (task->tk_status)
 		nfsd4_mark_cb_down(clp, task->tk_status);
-	else
+	else {
 		clp->cl_cb_state = NFSD4_CB_UP;
+		trace_nfsd_cb_state(clp);
+	}
 }
 
 static void nfsd4_cb_probe_release(void *calldata)
@@ -993,6 +996,7 @@ static const struct rpc_call_ops nfsd4_cb_probe_ops = {
 void nfsd4_probe_callback(struct nfs4_client *clp)
 {
 	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
+	trace_nfsd_cb_state(clp);
 	set_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags);
 	nfsd4_run_cb(&clp->cl_cb_null);
 }
@@ -1009,6 +1013,7 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
 	spin_lock(&clp->cl_lock);
 	memcpy(&clp->cl_cb_conn, conn, sizeof(struct nfs4_cb_conn));
 	spin_unlock(&clp->cl_lock);
+	trace_nfsd_cb_state(clp);
 }
 
 /*
@@ -1165,8 +1170,7 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 	struct nfsd4_callback *cb = calldata;
 	struct nfs4_client *clp = cb->cb_clp;
 
-	dprintk("%s: minorversion=%d\n", __func__,
-		clp->cl_minorversion);
+	trace_nfsd_cb_done(clp, task->tk_status);
 
 	if (!nfsd4_cb_sequence_done(task, cb))
 		return;
@@ -1271,6 +1275,7 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 	 * kill the old client:
 	 */
 	if (clp->cl_cb_client) {
+		trace_nfsd_cb_shutdown(clp);
 		rpc_shutdown_client(clp->cl_cb_client);
 		clp->cl_cb_client = NULL;
 		put_cred(clp->cl_cb_cred);
@@ -1314,6 +1319,8 @@ nfsd4_run_cb_work(struct work_struct *work)
 	struct rpc_clnt *clnt;
 	int flags;
 
+	trace_nfsd_cb_work(clp, cb->cb_msg.rpc_proc->p_name);
+
 	if (cb->cb_need_restart) {
 		cb->cb_need_restart = false;
 	} else {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 04d80f9e2f91..88433be551b7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2842,14 +2842,12 @@ gen_callback(struct nfs4_client *clp, struct nfsd4_setclientid *se, struct svc_r
 	conn->cb_prog = se->se_callback_prog;
 	conn->cb_ident = se->se_callback_ident;
 	memcpy(&conn->cb_saddr, &rqstp->rq_daddr, rqstp->rq_daddrlen);
+	trace_nfsd_cb_args(clp, conn);
 	return;
 out_err:
 	conn->cb_addr.ss_family = AF_UNSPEC;
 	conn->cb_addrlen = 0;
-	dprintk("NFSD: this client (clientid %08x/%08x) "
-		"will not receive delegations\n",
-		clp->cl_clientid.cl_boot, clp->cl_clientid.cl_id);
-
+	trace_nfsd_cb_nodelegs(clp);
 	return;
 }
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 654a27649207..848044ad82b4 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -624,6 +624,159 @@ TRACE_EVENT(nfsd_drc_mismatch,
 		__entry->ingress)
 );
 
+TRACE_EVENT(nfsd_cb_args,
+	TP_PROTO(
+		const struct nfs4_client *clp,
+		const struct nfs4_cb_conn *conn
+	),
+	TP_ARGS(clp, conn),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, prog)
+		__field(u32, ident)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		__entry->prog = conn->cb_prog;
+		__entry->ident = conn->cb_ident;
+		memcpy(__entry->addr, &conn->cb_addr,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("client %08x:%08x callback addr=%pISpc prog=%u ident=%u",
+		__entry->cl_boot, __entry->cl_id,
+		__entry->addr, __entry->prog, __entry->ident)
+);
+
+TRACE_EVENT(nfsd_cb_nodelegs,
+	TP_PROTO(const struct nfs4_client *clp),
+	TP_ARGS(clp),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+	),
+	TP_fast_assign(
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+	),
+	TP_printk("client %08x:%08x", __entry->cl_boot, __entry->cl_id)
+)
+
+TRACE_DEFINE_ENUM(NFSD4_CB_UP);
+TRACE_DEFINE_ENUM(NFSD4_CB_UNKNOWN);
+TRACE_DEFINE_ENUM(NFSD4_CB_DOWN);
+TRACE_DEFINE_ENUM(NFSD4_CB_FAULT);
+
+#define show_cb_state(val)						\
+	__print_symbolic(val,						\
+		{ NFSD4_CB_UP,		"UP" },				\
+		{ NFSD4_CB_UNKNOWN,	"UNKNOWN" },			\
+		{ NFSD4_CB_DOWN,	"DOWN" },			\
+		{ NFSD4_CB_FAULT,	"FAULT"})
+
+DECLARE_EVENT_CLASS(nfsd_cb_class,
+	TP_PROTO(const struct nfs4_client *clp),
+	TP_ARGS(clp),
+	TP_STRUCT__entry(
+		__field(unsigned long, state)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->state = clp->cl_cb_state;
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("addr=%pISpc client %08x:%08x state=%s",
+		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		show_cb_state(__entry->state))
+);
+
+#define DEFINE_NFSD_CB_EVENT(name)			\
+DEFINE_EVENT(nfsd_cb_class, nfsd_cb_##name,		\
+	TP_PROTO(const struct nfs4_client *clp),	\
+	TP_ARGS(clp))
+
+DEFINE_NFSD_CB_EVENT(setup);
+DEFINE_NFSD_CB_EVENT(state);
+DEFINE_NFSD_CB_EVENT(shutdown);
+
+TRACE_EVENT(nfsd_cb_setup_err,
+	TP_PROTO(
+		const struct nfs4_client *clp,
+		long error
+	),
+	TP_ARGS(clp, error),
+	TP_STRUCT__entry(
+		__field(long, error)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->error = error;
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("addr=%pISpc client %08x:%08x error=%ld",
+		__entry->addr, __entry->cl_boot, __entry->cl_id, __entry->error)
+);
+
+TRACE_EVENT(nfsd_cb_work,
+	TP_PROTO(
+		const struct nfs4_client *clp,
+		const char *procedure
+	),
+	TP_ARGS(clp, procedure),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__string(procedure, procedure)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		__assign_str(procedure, procedure)
+		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("addr=%pISpc client %08x:%08x procedure=%s",
+		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__get_str(procedure))
+);
+
+TRACE_EVENT(nfsd_cb_done,
+	TP_PROTO(
+		const struct nfs4_client *clp,
+		int status
+	),
+	TP_ARGS(clp, status),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(int, status)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		__entry->status = status;
+		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("addr=%pISpc client %08x:%08x status=%d",
+		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__entry->status)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH

