Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5A3705799
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 21:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjEPTlN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 15:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjEPTlM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 15:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B6F8A72
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 12:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E59F63273
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 19:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3C3C433D2;
        Tue, 16 May 2023 19:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265998;
        bh=YFNT+tS9tqcMFilxZf/DaNOvD9Sck4L+1ffoNW2z5gA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RqcUMBzteHdsceY4GO4ZNp2SDHk1FedXJmbjmixbxB2YUwk2Dk7GmEDXVgX9Qfc5X
         +9Rc+Rg4wKaFE3xTsbs7u3L73ZmaU9iyaNMs1x4ipVdL4/9LTH8Qy2jsNHi5GE2dXR
         O67ke6U47WciieVOkg3CK7UXegS2LvK1lxj3iVBZncFpCzchrZEjM4Q8DDv+xCsCe1
         gsjcKzQcq7jHIgmXF1LD5X4QrjHF49JcIkkiocleFOYQLwn/nlOQKIMRx5q7bfrXZG
         0LKydQtDShCPvR+LTiAE23KAJduU0d9+Oddifjg3LNUjZY1e4E8rLnMyYcsUnNWiCz
         TpuIY2u03heWA==
Subject: [PATCH RFC 03/12] SUNRPC: Trace the rpc_create_args
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 16 May 2023 15:39:46 -0400
Message-ID: <168426597655.74246.3692414718858133506.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
References: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Pass the upper layer's rpc_create_args to the rpc_clnt_new()
tracepoint so additional parts of the upper layer's request can be
recorded.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   52 +++++++++++++++++++++++++++++++++--------
 net/sunrpc/clnt.c             |    2 +-
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 31bc7025cb44..34784f29a63d 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -139,36 +139,68 @@ DEFINE_RPC_CLNT_EVENT(release);
 DEFINE_RPC_CLNT_EVENT(replace_xprt);
 DEFINE_RPC_CLNT_EVENT(replace_xprt_err);
 
+TRACE_DEFINE_ENUM(RPC_XPRTSEC_NONE);
+TRACE_DEFINE_ENUM(RPC_XPRTSEC_TLS_X509);
+
+#define rpc_show_xprtsec_policy(policy)					\
+	__print_symbolic(policy,					\
+		{ RPC_XPRTSEC_NONE,		"none" },		\
+		{ RPC_XPRTSEC_TLS_ANON,		"tls-anon" },		\
+		{ RPC_XPRTSEC_TLS_X509,		"tls-x509" })
+
+#define rpc_show_create_flags(flags)					\
+	__print_flags(flags, "|",					\
+		{ RPC_CLNT_CREATE_HARDRTRY,	"HARDRTRY" },		\
+		{ RPC_CLNT_CREATE_AUTOBIND,	"AUTOBIND" },		\
+		{ RPC_CLNT_CREATE_NONPRIVPORT,	"NONPRIVPORT" },	\
+		{ RPC_CLNT_CREATE_NOPING,	"NOPING" },		\
+		{ RPC_CLNT_CREATE_DISCRTRY,	"DISCRTRY" },		\
+		{ RPC_CLNT_CREATE_QUIET,	"QUIET" },		\
+		{ RPC_CLNT_CREATE_INFINITE_SLOTS,			\
+						"INFINITE_SLOTS" },	\
+		{ RPC_CLNT_CREATE_NO_IDLE_TIMEOUT,			\
+						"NO_IDLE_TIMEOUT" },	\
+		{ RPC_CLNT_CREATE_NO_RETRANS_TIMEOUT,			\
+						"NO_RETRANS_TIMEOUT" },	\
+		{ RPC_CLNT_CREATE_SOFTERR,	"SOFTERR" },		\
+		{ RPC_CLNT_CREATE_REUSEPORT,	"REUSEPORT" })
+
 TRACE_EVENT(rpc_clnt_new,
 	TP_PROTO(
 		const struct rpc_clnt *clnt,
 		const struct rpc_xprt *xprt,
-		const char *program,
-		const char *server
+		const struct rpc_create_args *args
 	),
 
-	TP_ARGS(clnt, xprt, program, server),
+	TP_ARGS(clnt, xprt, args),
 
 	TP_STRUCT__entry(
 		__field(unsigned int, client_id)
+		__field(unsigned long, xprtsec)
+		__field(unsigned long, flags)
+		__string(program, clnt->cl_program->name)
+		__string(server, xprt->servername)
 		__string(addr, xprt->address_strings[RPC_DISPLAY_ADDR])
 		__string(port, xprt->address_strings[RPC_DISPLAY_PORT])
-		__string(program, program)
-		__string(server, server)
 	),
 
 	TP_fast_assign(
 		__entry->client_id = clnt->cl_clid;
+		__entry->xprtsec = args->xprtsec.policy;
+		__entry->flags = args->flags;
+		__assign_str(program, clnt->cl_program->name);
+		__assign_str(server, xprt->servername);
 		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
 		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
-		__assign_str(program, program);
-		__assign_str(server, server);
 	),
 
-	TP_printk("client=" SUNRPC_TRACE_CLID_SPECIFIER
-		  " peer=[%s]:%s program=%s server=%s",
+	TP_printk("client=" SUNRPC_TRACE_CLID_SPECIFIER " peer=[%s]:%s"
+		" program=%s server=%s xprtsec=%s flags=%s",
 		__entry->client_id, __get_str(addr), __get_str(port),
-		__get_str(program), __get_str(server))
+		__get_str(program), __get_str(server),
+		rpc_show_xprtsec_policy(__entry->xprtsec),
+		rpc_show_create_flags(__entry->flags)
+	)
 );
 
 TRACE_EVENT(rpc_clnt_new_err,
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a18074f8edf2..4cdb539b5854 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -435,7 +435,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	if (parent)
 		refcount_inc(&parent->cl_count);
 
-	trace_rpc_clnt_new(clnt, xprt, program->name, args->servername);
+	trace_rpc_clnt_new(clnt, xprt, args);
 	return clnt;
 
 out_no_path:


