Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B7A1D0075
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgELVNm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728351AbgELVNm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:13:42 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B4CC061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:41 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id z5so5226785qvw.4
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YV5n4SkC9nd6oKutJOA9/j+hXloVejchKDWBOqD3zek=;
        b=c/iD+jQ6+RimZI/cQG0nORMbX8GInBGaJauu373KoFgg+UMdjPI4Ius9WoncYh8aEz
         C4bHrSOzgTxWLRjPRzhUugtzamxka6Njue5tObYDgQfkt276VcwiTzKbVwwfAXCQhvhu
         g1cibwpwjwOXSKw66gBAuU7UCIMQx/+o97kuDEBlkQrx/bNXrl1m8q9JLy5vtv0HLylo
         lC4iULxtsQtbALlSUFxZ2E+hl6EAYzxcneDfQntWHUTT9gPDRIZ6I8EodR/Qo9skTSyK
         cOnQ8dKNk3BMVuPNOVdjH3GxpdfmxrFYGnMSWAT0qbHbnPS5yj8O7pjsHsP9E6sT18vV
         TSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=YV5n4SkC9nd6oKutJOA9/j+hXloVejchKDWBOqD3zek=;
        b=nZqmUTPAOKyYCBto0xUSiaw1YsswrYc0Afqws+HDq7i9Sq6cPNFttbVYfBYNo6PvD4
         SevHBsQ0o6pG9TFz0nkMtBnZ5WqDr0ys9jBq90EJBYKP7C3nuN2UWE9cRjtIdZEw4rDE
         OAmp6gWzobngwax4ThVxkWB27kpxOvJiriGom+vkEIFL/N4hc18E3X41eS+c9zEOu4Ek
         Y+0nalqkJ4G3FkY5qIbf+Ais1uakA3oUsH6k+5/MIZX6Vv/SYL0Zev04lIY6cz4W/En4
         UmDNB88vQOAx6Z03O1vo2sKE3Nd56BLKNN/sYHFbl+hiH2d+oq94Y2wgTRLOLsAHOIsP
         PW5w==
X-Gm-Message-State: AGi0Puah7PLNLccNCa/XQ0hSojGoNY/XR4vrKGAZlGc9v5eXUEVswVjx
        21aMsBgkSOiYZz6bpRZEObw=
X-Google-Smtp-Source: APiQypK5H4ZX9nn2oN/kEdRwzoUQ3KZalimMcYH2ntcRo7pKYXjWSb7aYhl2ye4hphnMYD0m8lWuRg==
X-Received: by 2002:a05:6214:1152:: with SMTP id b18mr10755740qvt.13.1589318020986;
        Tue, 12 May 2020 14:13:40 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d9sm12404166qtj.77.2020.05.12.14.13.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:13:40 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLDdCA009810;
        Tue, 12 May 2020 21:13:39 GMT
Subject: [PATCH v1 09/15] SUNRPC: trace RPC client lifetime events
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:13:39 -0400
Message-ID: <20200512211339.3288.37402.stgit@manet.1015granger.net>
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

The "create" tracepoint records parts of the rpc_create arguments,
and the shutdown tracepoint records when the rpc_clnt is about to
signal pending tasks and destroy auths.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |  111 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/clnt.c             |   39 ++++++--------
 2 files changed, 126 insertions(+), 24 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index fc8a969ba306..098c84750fb7 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -65,6 +65,117 @@
 DEFINE_RPCXDRBUF_EVENT(reply_pages);
 
 
+DECLARE_EVENT_CLASS(rpc_clnt_class,
+	TP_PROTO(
+		const struct rpc_clnt *clnt
+	),
+
+	TP_ARGS(clnt),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, client_id)
+	),
+
+	TP_fast_assign(
+		__entry->client_id = clnt->cl_clid;
+	),
+
+	TP_printk("clid=%u", __entry->client_id)
+);
+
+#define DEFINE_RPC_CLNT_EVENT(name)					\
+		DEFINE_EVENT(rpc_clnt_class,				\
+				rpc_clnt_##name,			\
+				TP_PROTO(				\
+					const struct rpc_clnt *clnt	\
+				),					\
+				TP_ARGS(clnt))
+
+DEFINE_RPC_CLNT_EVENT(free);
+DEFINE_RPC_CLNT_EVENT(killall);
+DEFINE_RPC_CLNT_EVENT(shutdown);
+DEFINE_RPC_CLNT_EVENT(release);
+DEFINE_RPC_CLNT_EVENT(replace_xprt);
+DEFINE_RPC_CLNT_EVENT(replace_xprt_err);
+
+TRACE_EVENT(rpc_clnt_new,
+	TP_PROTO(
+		const struct rpc_clnt *clnt,
+		const struct rpc_xprt *xprt,
+		const char *program,
+		const char *server
+	),
+
+	TP_ARGS(clnt, xprt, program, server),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, client_id)
+		__string(addr, xprt->address_strings[RPC_DISPLAY_ADDR])
+		__string(port, xprt->address_strings[RPC_DISPLAY_PORT])
+		__string(program, program)
+		__string(server, server)
+	),
+
+	TP_fast_assign(
+		__entry->client_id = clnt->cl_clid;
+		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
+		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
+		__assign_str(program, program)
+		__assign_str(server, server)
+	),
+
+	TP_printk("client=%u peer=[%s]:%s program=%s server=%s",
+		__entry->client_id, __get_str(addr), __get_str(port),
+		__get_str(program), __get_str(server))
+);
+
+TRACE_EVENT(rpc_clnt_new_err,
+	TP_PROTO(
+		const char *program,
+		const char *server,
+		int error
+	),
+
+	TP_ARGS(program, server, error),
+
+	TP_STRUCT__entry(
+		__field(int, error)
+		__string(program, program)
+		__string(server, server)
+	),
+
+	TP_fast_assign(
+		__entry->error = error;
+		__assign_str(program, program)
+		__assign_str(server, server)
+	),
+
+	TP_printk("program=%s server=%s error=%d",
+		__get_str(program), __get_str(server), __entry->error)
+);
+
+TRACE_EVENT(rpc_clnt_clone_err,
+	TP_PROTO(
+		const struct rpc_clnt *clnt,
+		int error
+	),
+
+	TP_ARGS(clnt, error),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, client_id)
+		__field(int, error)
+	),
+
+	TP_fast_assign(
+		__entry->client_id = clnt->cl_clid;
+		__entry->error = error;
+	),
+
+	TP_printk("client=%u error=%d", __entry->client_id, __entry->error)
+);
+
+
 TRACE_DEFINE_ENUM(RPC_AUTH_OK);
 TRACE_DEFINE_ENUM(RPC_AUTH_BADCRED);
 TRACE_DEFINE_ENUM(RPC_AUTH_REJECTEDCRED);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index c600628efa91..73d53b9898e6 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -370,10 +370,6 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	const char *nodename = args->nodename;
 	int err;
 
-	/* sanity check the name before trying to print it */
-	dprintk("RPC:       creating %s client for %s (xprt %p)\n",
-			program->name, args->servername, xprt);
-
 	err = rpciod_up();
 	if (err)
 		goto out_no_rpciod;
@@ -436,6 +432,8 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 		goto out_no_path;
 	if (parent)
 		atomic_inc(&parent->cl_count);
+
+	trace_rpc_clnt_new(clnt, xprt, program->name, args->servername);
 	return clnt;
 
 out_no_path:
@@ -450,6 +448,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 out_no_rpciod:
 	xprt_switch_put(xps);
 	xprt_put(xprt);
+	trace_rpc_clnt_new_err(program->name, args->servername, err);
 	return ERR_PTR(err);
 }
 
@@ -634,10 +633,8 @@ static struct rpc_clnt *__rpc_clone_client(struct rpc_create_args *args,
 	args->nodename = clnt->cl_nodename;
 
 	new = rpc_new_client(args, xps, xprt, clnt);
-	if (IS_ERR(new)) {
-		err = PTR_ERR(new);
-		goto out_err;
-	}
+	if (IS_ERR(new))
+		return new;
 
 	/* Turn off autobind on clones */
 	new->cl_autobind = 0;
@@ -650,7 +647,7 @@ static struct rpc_clnt *__rpc_clone_client(struct rpc_create_args *args,
 	return new;
 
 out_err:
-	dprintk("RPC:       %s: returned error %d\n", __func__, err);
+	trace_rpc_clnt_clone_err(clnt, err);
 	return ERR_PTR(err);
 }
 
@@ -723,11 +720,8 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt,
 	int err;
 
 	xprt = xprt_create_transport(args);
-	if (IS_ERR(xprt)) {
-		dprintk("RPC:       failed to create new xprt for clnt %p\n",
-			clnt);
+	if (IS_ERR(xprt))
 		return PTR_ERR(xprt);
-	}
 
 	xps = xprt_switch_alloc(xprt, GFP_KERNEL);
 	if (xps == NULL) {
@@ -767,7 +761,7 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt,
 		rpc_release_client(parent);
 	xprt_switch_put(oldxps);
 	xprt_put(old);
-	dprintk("RPC:       replaced xprt for clnt %p\n", clnt);
+	trace_rpc_clnt_replace_xprt(clnt);
 	return 0;
 
 out_revert:
@@ -777,7 +771,7 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt,
 	rpc_client_register(clnt, pseudoflavor, NULL);
 	xprt_switch_put(xps);
 	xprt_put(xprt);
-	dprintk("RPC:       failed to switch xprt for clnt %p\n", clnt);
+	trace_rpc_clnt_replace_xprt_err(clnt);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rpc_switch_client_transport);
@@ -844,10 +838,11 @@ void rpc_killall_tasks(struct rpc_clnt *clnt)
 
 	if (list_empty(&clnt->cl_tasks))
 		return;
-	dprintk("RPC:       killing all tasks for client %p\n", clnt);
+
 	/*
 	 * Spin lock all_tasks to prevent changes...
 	 */
+	trace_rpc_clnt_killall(clnt);
 	spin_lock(&clnt->cl_lock);
 	list_for_each_entry(rovr, &clnt->cl_tasks, tk_task)
 		rpc_signal_task(rovr);
@@ -863,9 +858,7 @@ void rpc_shutdown_client(struct rpc_clnt *clnt)
 {
 	might_sleep();
 
-	dprintk_rcu("RPC:       shutting down %s client for %s\n",
-			clnt->cl_program->name,
-			rcu_dereference(clnt->cl_xprt)->servername);
+	trace_rpc_clnt_shutdown(clnt);
 
 	while (!list_empty(&clnt->cl_tasks)) {
 		rpc_killall_tasks(clnt);
@@ -884,6 +877,8 @@ static void rpc_free_client_work(struct work_struct *work)
 {
 	struct rpc_clnt *clnt = container_of(work, struct rpc_clnt, cl_work);
 
+	trace_rpc_clnt_free(clnt);
+
 	/* These might block on processes that might allocate memory,
 	 * so they cannot be called in rpciod, so they are handled separately
 	 * here.
@@ -899,9 +894,7 @@ static void rpc_free_client_work(struct work_struct *work)
 {
 	struct rpc_clnt *parent = NULL;
 
-	dprintk_rcu("RPC:       destroying %s client for %s\n",
-			clnt->cl_program->name,
-			rcu_dereference(clnt->cl_xprt)->servername);
+	trace_rpc_clnt_release(clnt);
 	if (clnt->cl_parent != clnt)
 		parent = clnt->cl_parent;
 	rpc_unregister_client(clnt);
@@ -945,8 +938,6 @@ static void rpc_free_client_work(struct work_struct *work)
 void
 rpc_release_client(struct rpc_clnt *clnt)
 {
-	dprintk("RPC:       rpc_release_client(%p)\n", clnt);
-
 	do {
 		if (list_empty(&clnt->cl_tasks))
 			wake_up(&destroy_wait);

