Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489DA53E971
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jun 2022 19:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240050AbiFFOvM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiFFOvK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 10:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9A16F91A
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 07:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59AF0614B3
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 14:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE5AC3411C;
        Mon,  6 Jun 2022 14:51:08 +0000 (UTC)
Subject: [PATCH v2 06/15] SUNRPC: Trace the rpc_create_args
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 06 Jun 2022 10:51:07 -0400
Message-ID: <165452706752.1496.657240546600966342.stgit@oracle-102.nfsv4.dev>
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

Pass the upper layer's rpc_create_args to the rpc_clnt_new()
tracepoint so additional parts of the upper layer's request can be
recorded.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   53 +++++++++++++++++++++++++++++++++--------
 net/sunrpc/clnt.c             |    2 +-
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index a66aa1f59ed8..986e135e314f 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -139,36 +139,69 @@ DEFINE_RPC_CLNT_EVENT(release);
 DEFINE_RPC_CLNT_EVENT(replace_xprt);
 DEFINE_RPC_CLNT_EVENT(replace_xprt_err);
 
+TRACE_DEFINE_ENUM(RPC_XPRTSEC_NONE);
+TRACE_DEFINE_ENUM(RPC_XPRTSEC_TLS_X509);
+TRACE_DEFINE_ENUM(RPC_XPRTSEC_TLS_PSK);
+
+#define rpc_show_xprtsec_policy(policy)					\
+	__print_symbolic(policy,					\
+		{ RPC_XPRTSEC_NONE,		"none" },		\
+		{ RPC_XPRTSEC_TLS_X509,		"tls-x509" },		\
+		{ RPC_XPRTSEC_TLS_PSK,		"tls-psk" })
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
+		__entry->xprtsec = args->xprtsec;
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
index 6dcc88d45f5d..0ca86c92968f 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -435,7 +435,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	if (parent)
 		refcount_inc(&parent->cl_count);
 
-	trace_rpc_clnt_new(clnt, xprt, program->name, args->servername);
+	trace_rpc_clnt_new(clnt, xprt, args);
 	return clnt;
 
 out_no_path:


