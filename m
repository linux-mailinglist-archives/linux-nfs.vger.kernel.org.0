Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F0E53EB09
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jun 2022 19:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiFFOwA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 10:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240077AbiFFOv5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 10:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94131912E2
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 07:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A96A4614B5
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 14:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E401AC34115;
        Mon,  6 Jun 2022 14:51:53 +0000 (UTC)
Subject: [PATCH v2 13/15] SUNRPC: Add RPC-with-TLS tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 06 Jun 2022 10:51:52 -0400
Message-ID: <165452711267.1496.9330208346164485020.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Auditing TLS handshakes is mandatory-to-implement for RPC-with-TLS.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   44 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/xprtsock.c         |   10 +++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index d7d07f3b850e..594e3188dfcd 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1566,6 +1566,50 @@ TRACE_EVENT(rpcb_unregister,
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
+		__entry->requested_policy = clnt->cl_xprtsec;
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
index 63fe97ede573..508a7698c2e4 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2608,15 +2608,21 @@ static void xs_tls_connect(struct work_struct *work)
 	xs_stream_start_connect(transport);
 
 	clnt = rpc_create(&args);
-	if (IS_ERR(clnt))
+	if (IS_ERR(clnt)) {
+		trace_rpc_tls_unavailable(transport->xprtsec_clnt,
+					  &transport->xprt);
 		goto out_unlock;
+	}
 	rcu_read_lock();
 	xprt = xprt_get(rcu_dereference(clnt->cl_xprt));
 	rcu_read_unlock();
 
 	status = xs_tls_handshake_sync(xprt, transport->xprt.xprtsec);
-	if (status)
+	if (status) {
+		trace_rpc_tls_not_started(transport->xprtsec_clnt,
+					  &transport->xprt);
 		goto out_close;
+	}
 
 	status = xs_tls_finish_connecting(xprt, transport);
 	if (status)


