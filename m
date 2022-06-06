Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29053E9A7
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jun 2022 19:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbiFFOvG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiFFOvF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 10:51:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC36116FEE3
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 07:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88CCBB81A7A
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 14:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37361C34115;
        Mon,  6 Jun 2022 14:51:02 +0000 (UTC)
Subject: [PATCH v2 05/15] SUNRPC: Plumb an API for setting transport layer
 security
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 06 Jun 2022 10:51:01 -0400
Message-ID: <165452706106.1496.9556038561796216812.stgit@oracle-102.nfsv4.dev>
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

Add an initial set of policies along with fields for upper layers to
pass the requested policy down to the transport layer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/clnt.h |    9 +++++++++
 include/linux/sunrpc/xprt.h |    2 ++
 net/sunrpc/clnt.c           |    4 ++++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index cbdd20dc84b7..85c2f810d4bb 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -58,6 +58,7 @@ struct rpc_clnt {
 				cl_noretranstimeo: 1,/* No retransmit timeouts */
 				cl_autobind : 1,/* use getport() */
 				cl_chatty   : 1;/* be verbose */
+	unsigned int		cl_xprtsec;	/* transport security policy */
 
 	struct rpc_rtt *	cl_rtt;		/* RTO estimator data */
 	const struct rpc_timeout *cl_timeout;	/* Timeout strategy */
@@ -139,6 +140,7 @@ struct rpc_create_args {
 	struct svc_xprt		*bc_xprt;	/* NFSv4.1 backchannel */
 	const struct cred	*cred;
 	unsigned int		max_connect;
+	unsigned int		xprtsec;
 };
 
 struct rpc_add_xprt_test {
@@ -162,6 +164,13 @@ struct rpc_add_xprt_test {
 #define RPC_CLNT_CREATE_REUSEPORT	(1UL << 11)
 #define RPC_CLNT_CREATE_CONNECTED	(1UL << 12)
 
+/* RPC transport layer security policies */
+enum {
+	RPC_XPRTSEC_NONE = 0,
+	RPC_XPRTSEC_TLS_X509,
+	RPC_XPRTSEC_TLS_PSK,
+};
+
 struct rpc_clnt *rpc_create(struct rpc_create_args *args);
 struct rpc_clnt	*rpc_bind_new_program(struct rpc_clnt *,
 				const struct rpc_program *, u32);
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 522bbf937957..d091ad2b7340 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -228,6 +228,7 @@ struct rpc_xprt {
 	 */
 	unsigned long		bind_timeout,
 				reestablish_timeout;
+	unsigned int		xprtsec;
 	unsigned int		connect_cookie;	/* A cookie that gets bumped
 						   every time the transport
 						   is reconnected */
@@ -332,6 +333,7 @@ struct xprt_create {
 	struct svc_xprt		*bc_xprt;	/* NFSv4.1 backchannel */
 	struct rpc_xprt_switch	*bc_xps;
 	unsigned int		flags;
+	unsigned int		xprtsec;
 };
 
 struct xprt_class {
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 8fd45de66882..6dcc88d45f5d 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -385,6 +385,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	if (!clnt)
 		goto out_err;
 	clnt->cl_parent = parent ? : clnt;
+	clnt->cl_xprtsec = args->xprtsec;
 
 	err = rpc_alloc_clid(clnt);
 	if (err)
@@ -532,6 +533,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		.addrlen = args->addrsize,
 		.servername = args->servername,
 		.bc_xprt = args->bc_xprt,
+		.xprtsec = args->xprtsec,
 	};
 	char servername[48];
 	struct rpc_clnt *clnt;
@@ -726,6 +728,7 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt,
 	struct rpc_clnt *parent;
 	int err;
 
+	args->xprtsec = clnt->cl_xprtsec;
 	xprt = xprt_create_transport(args);
 	if (IS_ERR(xprt))
 		return PTR_ERR(xprt);
@@ -2973,6 +2976,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 
 	if (!xprtargs->ident)
 		xprtargs->ident = ident;
+	xprtargs->xprtsec = clnt->cl_xprtsec;
 	xprt = xprt_create_transport(xprtargs);
 	if (IS_ERR(xprt)) {
 		ret = PTR_ERR(xprt);


