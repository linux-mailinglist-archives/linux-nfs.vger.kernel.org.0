Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491A27057A0
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 21:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjEPTmN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 15:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjEPTmI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 15:42:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8181C903B
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 12:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24B3F6359F
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 19:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECD4C433EF;
        Tue, 16 May 2023 19:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266051;
        bh=1xDuoKCw30jACcDvDWDLVKEVwZUrFpImKL9ean80B2Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PXfaxCyyzefaOgPRpTjJxnfR5D9DeTvqmG+0PGM25buSp723AZpApoLxe2zVnV+x9
         9UCJjLTWF0kclAT3b2ccG//yAnfqkrI2roNVuVU5nML6XTAeRwy+QXkw2smVcr7UR6
         DL2rppr3+csGLKVoqlrTSbQKj4S1Gm2yhrk23cT4YcN6p2evNXMYy00V205nOd4fF4
         MzvYwOhTYD0zWF3RzrVs6eyvZWd5uiAlp3quqBt9DlxmjZA2EXU7sWYsP2h52F7+O7
         oQE+kVv/f3dXi7MoRMscK2Plcv42Aj9AG0NHbgPDelqjOHmMV/TQiFO0aObFyGQOlb
         KGrJ+YAdl+MhA==
Subject: [PATCH RFC 05/12] SUNRPC: Add RPC client support for the RPC_AUTH_TLS
 auth flavor
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake@lists.linux.dev
Date:   Tue, 16 May 2023 15:40:40 -0400
Message-ID: <168426603009.74246.9526591886250096230.stgit@oracle-102.nfsv4bat.org>
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

The new authentication flavor is used only to discover peer support
for RPC-over-TLS.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/auth.h |    1 
 net/sunrpc/Makefile         |    2 -
 net/sunrpc/auth.c           |    2 -
 net/sunrpc/auth_tls.c       |  120 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/auth_tls.c

diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
index 3e6ce288a7fc..1f13d923f439 100644
--- a/include/linux/sunrpc/auth.h
+++ b/include/linux/sunrpc/auth.h
@@ -144,6 +144,7 @@ struct rpc_credops {
 
 extern const struct rpc_authops	authunix_ops;
 extern const struct rpc_authops	authnull_ops;
+extern const struct rpc_authops	authtls_ops;
 
 int __init		rpc_init_authunix(void);
 int __init		rpcauth_init_module(void);
diff --git a/net/sunrpc/Makefile b/net/sunrpc/Makefile
index 1c8de397d6ad..f89c10fe7e6a 100644
--- a/net/sunrpc/Makefile
+++ b/net/sunrpc/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_SUNRPC_GSS) += auth_gss/
 obj-$(CONFIG_SUNRPC_XPRT_RDMA) += xprtrdma/
 
 sunrpc-y := clnt.o xprt.o socklib.o xprtsock.o sched.o \
-	    auth.o auth_null.o auth_unix.o \
+	    auth.o auth_null.o auth_tls.o auth_unix.o \
 	    svc.o svcsock.o svcauth.o svcauth_unix.o \
 	    addr.o rpcb_clnt.o timer.o xdr.o \
 	    sunrpc_syms.o cache.o rpc_pipe.o sysfs.o \
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index fb75a883503f..2f16f9d17966 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -32,7 +32,7 @@ static unsigned int auth_hashbits = RPC_CREDCACHE_DEFAULT_HASHBITS;
 static const struct rpc_authops __rcu *auth_flavors[RPC_AUTH_MAXFLAVOR] = {
 	[RPC_AUTH_NULL] = (const struct rpc_authops __force __rcu *)&authnull_ops,
 	[RPC_AUTH_UNIX] = (const struct rpc_authops __force __rcu *)&authunix_ops,
-	NULL,			/* others can be loadable modules */
+	[RPC_AUTH_TLS]  = (const struct rpc_authops __force __rcu *)&authtls_ops,
 };
 
 static LIST_HEAD(cred_unused);
diff --git a/net/sunrpc/auth_tls.c b/net/sunrpc/auth_tls.c
new file mode 100644
index 000000000000..cf4185f188e9
--- /dev/null
+++ b/net/sunrpc/auth_tls.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, 2022 Oracle.  All rights reserved.
+ *
+ * The AUTH_TLS credential is used only to probe a remote peer
+ * for RPC-over-TLS support.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/sunrpc/clnt.h>
+
+static const char *starttls_token = "STARTTLS";
+static const size_t starttls_len = 8;
+
+static struct rpc_auth tls_auth;
+static struct rpc_cred tls_cred;
+
+static struct rpc_auth *tls_create(const struct rpc_auth_create_args *args,
+				   struct rpc_clnt *clnt)
+{
+	refcount_inc(&tls_auth.au_count);
+	return &tls_auth;
+}
+
+static void tls_destroy(struct rpc_auth *auth)
+{
+}
+
+static struct rpc_cred *tls_lookup_cred(struct rpc_auth *auth,
+					struct auth_cred *acred, int flags)
+{
+	return get_rpccred(&tls_cred);
+}
+
+static void tls_destroy_cred(struct rpc_cred *cred)
+{
+}
+
+static int tls_match(struct auth_cred *acred, struct rpc_cred *cred, int taskflags)
+{
+	return 1;
+}
+
+static int tls_marshal(struct rpc_task *task, struct xdr_stream *xdr)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, 4 * XDR_UNIT);
+	if (!p)
+		return -EMSGSIZE;
+	/* Credential */
+	*p++ = rpc_auth_tls;
+	*p++ = xdr_zero;
+	/* Verifier */
+	*p++ = rpc_auth_null;
+	*p   = xdr_zero;
+	return 0;
+}
+
+static int tls_refresh(struct rpc_task *task)
+{
+	set_bit(RPCAUTH_CRED_UPTODATE, &task->tk_rqstp->rq_cred->cr_flags);
+	return 0;
+}
+
+static int tls_validate(struct rpc_task *task, struct xdr_stream *xdr)
+{
+	__be32 *p;
+	void *str;
+
+	p = xdr_inline_decode(xdr, XDR_UNIT);
+	if (!p)
+		return -EIO;
+	if (*p != rpc_auth_null)
+		return -EIO;
+	if (xdr_stream_decode_opaque_inline(xdr, &str, starttls_len) != starttls_len)
+		return -EIO;
+	if (memcmp(str, starttls_token, starttls_len))
+		return -EIO;
+	return 0;
+}
+
+const struct rpc_authops authtls_ops = {
+	.owner		= THIS_MODULE,
+	.au_flavor	= RPC_AUTH_TLS,
+	.au_name	= "NULL",
+	.create		= tls_create,
+	.destroy	= tls_destroy,
+	.lookup_cred	= tls_lookup_cred,
+};
+
+static struct rpc_auth tls_auth = {
+	.au_cslack	= NUL_CALLSLACK,
+	.au_rslack	= NUL_REPLYSLACK,
+	.au_verfsize	= NUL_REPLYSLACK,
+	.au_ralign	= NUL_REPLYSLACK,
+	.au_ops		= &authtls_ops,
+	.au_flavor	= RPC_AUTH_TLS,
+	.au_count	= REFCOUNT_INIT(1),
+};
+
+static const struct rpc_credops tls_credops = {
+	.cr_name	= "AUTH_TLS",
+	.crdestroy	= tls_destroy_cred,
+	.crmatch	= tls_match,
+	.crmarshal	= tls_marshal,
+	.crwrap_req	= rpcauth_wrap_req_encode,
+	.crrefresh	= tls_refresh,
+	.crvalidate	= tls_validate,
+	.crunwrap_resp	= rpcauth_unwrap_resp_decode,
+};
+
+static struct rpc_cred tls_cred = {
+	.cr_lru		= LIST_HEAD_INIT(tls_cred.cr_lru),
+	.cr_auth	= &tls_auth,
+	.cr_ops		= &tls_credops,
+	.cr_count	= REFCOUNT_INIT(2),
+	.cr_flags	= 1UL << RPCAUTH_CRED_UPTODATE,
+};


