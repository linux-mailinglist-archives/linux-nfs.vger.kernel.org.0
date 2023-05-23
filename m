Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3682E70DF4F
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 16:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjEWOdp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 10:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbjEWOdn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 10:33:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54458E9
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 07:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D910463324
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 14:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF08C433EF;
        Tue, 23 May 2023 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684852421;
        bh=1Wk5rfVwPa3m8SSE4H+g89TYBlCdLdMsbGfj+mXdmuY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YX18L1HH9XtVGJGrBkkcA160ClVHcp8za8sOHLiwkDjlyUp3iinpMu+fkuNcg2rgF
         +7vjgJ73QRLjK1NZYCaQHDMhQCicUC0bQLXSpcTUh6k+yYNzwIk4nrB6AiH3cJf9jz
         hsloOzx+glSpSBZj/UMIFdvrPUSGZqKwXTebqAeHm+ct1bnYoOsMcvPVjh3XSLTpPf
         vnKzclak762k1OyvP9l0XjPDQw9HHXqCMNjTL/oTgS/af0/BDY4Erw/RG89Ujh56N2
         y86LEvCVmFEaN+xDCgZNPUMeaKD74CSY4dia310HRTGt+gseTabQfP3pMRov/Z3/EQ
         vEiu+xWRcseSQ==
Subject: [PATCH v2 09/11] SUNRPC: Add RPC-with-TLS tracepoints
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, jlayton@redhat.com,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 23 May 2023 10:33:29 -0400
Message-ID: <168485239971.6613.8469609569894808288.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168485183242.6613.7025123558596119858.stgit@oracle-102.nfsv4bat.org>
References: <168485183242.6613.7025123558596119858.stgit@oracle-102.nfsv4bat.org>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


