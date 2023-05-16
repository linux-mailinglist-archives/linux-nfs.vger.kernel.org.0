Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743CA7057AF
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 21:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjEPTnX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 15:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjEPTnX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 15:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06050DC46
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 12:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1CCE6340C
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 19:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BD8C433EF;
        Tue, 16 May 2023 19:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266177;
        bh=vcjrEnERJLjeZ1eWbL7eCvmWtj0HQV4kugyziIkFrhc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qTvv1r5HWbshaebtCL7x32eWLPeXFKY/nvFnqs8xXi5BYCI7y8bikjhEc+P1/zX9H
         fStBbJmCU+5n6U0JDDoUlY8KeQDGHaG7YkwCcBWsTuJGzAkQPJNnBRLoIn5PydFqh4
         N31Yq5/mkzFGQg5G+xQ+IXn66lutyHLP5+IrTDw6HFtKEstMZV/hUzHhZDkE3FaeDI
         jH4aHzzh09Kudb7zZrS8S9qkKkxV0J4Wl6POgxNRDaQhstMqoh1o9g/SnJnN1w4Pei
         gTACE+LDGOfHZip+j63mINN+UggWAfvusxtqAbtwfNkxVIh6U3EIVwhJoLlZ8Mpg3F
         oxxWCqSnI0i1Q==
Subject: [PATCH RFC 10/12] SUNRPC: Add RPC-with-TLS tracepoints
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake@lists.linux.dev
Date:   Tue, 16 May 2023 15:42:45 -0400
Message-ID: <168426615568.74246.14196813436403192718.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
References: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

RFC 9289 makes auditing TLS handshakes mandatory-to-implement.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   44 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/xprtsock.c         |    5 ++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 34784f29a63d..7cd4bbd6904c 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1525,6 +1525,50 @@ TRACE_EVENT(rpcb_unregister,
 	)
 );
 
+/**
+ ** RPC-over-TLS tracepoints
+ **/
+
+DECLARE_EVENT_CLASS(rpc_tls_class,
+	TP_PROTO(
+		const struct rpc_clnt *clnt,
+		const struct rpc_xprt *xprt
+	),
+
+	TP_ARGS(clnt, xprt),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, requested_policy)
+		__field(u32, version)
+		__string(servername, xprt->servername)
+		__string(progname, clnt->cl_program->name)
+	),
+
+	TP_fast_assign(
+		__entry->requested_policy = clnt->cl_xprtsec.policy;
+		__entry->version = clnt->cl_vers;
+		__assign_str(servername, xprt->servername);
+		__assign_str(progname, clnt->cl_program->name)
+	),
+
+	TP_printk("server=%s %sv%u requested_policy=%s",
+		__get_str(servername), __get_str(progname), __entry->version,
+		rpc_show_xprtsec_policy(__entry->requested_policy)
+	)
+);
+
+#define DEFINE_RPC_TLS_EVENT(name) \
+	DEFINE_EVENT(rpc_tls_class, rpc_tls_##name, \
+			TP_PROTO( \
+				const struct rpc_clnt *clnt, \
+				const struct rpc_xprt *xprt \
+			), \
+			TP_ARGS(clnt, xprt))
+
+DEFINE_RPC_TLS_EVENT(unavailable);
+DEFINE_RPC_TLS_EVENT(not_started);
+
+
 /* Record an xdr_buf containing a fully-formed RPC message */
 DECLARE_EVENT_CLASS(svc_xdr_msg_class,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 686dd313f89f..7ade414aa1cb 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2630,6 +2630,7 @@ static void xs_tls_connect(struct work_struct *work)
 	/* This implicitly sends an RPC_AUTH_TLS probe */
 	lower_clnt = rpc_create(&args);
 	if (IS_ERR(lower_clnt)) {
+		trace_rpc_tls_unavailable(upper_clnt, upper_xprt);
 		clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_state);
 		xprt_clear_connecting(upper_xprt);
 		xprt_wake_pending_tasks(upper_xprt, PTR_ERR(lower_clnt));
@@ -2645,8 +2646,10 @@ static void xs_tls_connect(struct work_struct *work)
 	lower_xprt = rcu_dereference(lower_clnt->cl_xprt);
 	rcu_read_unlock();
 	status = xs_tls_handshake_sync(lower_xprt, &upper_xprt->xprtsec);
-	if (status)
+	if (status) {
+		trace_rpc_tls_not_started(upper_clnt, upper_xprt);
 		goto out_close;
+	}
 
 	status = xs_tls_finish_connecting(lower_xprt, upper_transport);
 	if (status)


