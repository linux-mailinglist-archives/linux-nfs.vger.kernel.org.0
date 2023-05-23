Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152A070DF3B
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 16:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbjEWObO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 10:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjEWObN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 10:31:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D62F119
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 07:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B02626331B
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 14:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96836C433D2;
        Tue, 23 May 2023 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684852269;
        bh=KwzLoOUAz/qQMUuX22LqTi45EsrZFW5E9YpM7VTUPDM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TqXEagHSzdrqMB1oa8qUwDDDxfR6i4ijZMSVU6OmUWn6MV47AdYqcrkkCnHjlwnhf
         uMniWoKFohRq6RrTSq6omjPYEZv72kU9Lnn6rVYaq2uinJuKtZkir3VtUJfB6nRCZN
         U8D6aSiSDbxH0/4JhV7tLTlqJyesiRnph05qLNpEx61kDrYzVl6Jbfzzw0p0daQmO0
         gxAfkZdTLu3l7E+e15pjFfl/YKRMNVBkQgrUhvL6p4SP9QFX36mmMpF+jn+4FBwEPN
         TG9dXSEiIyFEQshtQx5DpWHtpNNjUS+w6qi4zCRy8zA82ruDA6f6f5sXHZzKHp6/4M
         ORDZTKKEg4HGA==
Subject: [PATCH v2 03/11] SUNRPC: Trace the rpc_create_args
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, jlayton@redhat.com,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 23 May 2023 10:30:57 -0400
Message-ID: <168485224750.6613.4286173587001829717.stgit@oracle-102.nfsv4bat.org>
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

Pass the upper layer's rpc_create_args to the rpc_clnt_new()
tracepoint so additional parts of the upper layer's request can be
recorded.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


