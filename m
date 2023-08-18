Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E98D780CEE
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 15:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbjHRNth (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 09:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377464AbjHRNtV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 09:49:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A4A44BB
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 06:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8046767173
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 13:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D098C433C7;
        Fri, 18 Aug 2023 13:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366501;
        bh=WXYcNQYZ2MGYsz3MP5lGdDi8+xZgq19+WnGR0HlyUAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PF4B1kt19mAFbLf3A88dR0g07WHSq+iEmlbR+A4HsWRFCamLueUcCOU2Ln2UyOdgV
         zk2BA5VLK8f74CebMkph4tBdIKEHDyWkbkBuMfseB+9htcICehvdI1snacIZcPAi55
         E/emsQpNckS4RifmVeC3rMJIYTCk9hYB4EiqRoW+G9dq4QbtdZtAh+UViVINqcSMo6
         qkALOwtj2l5bqdH6BTeXs7CmWMm8Q5+jKx4CSZxeAHJQFKlnQXlVxw+068FoI5KnQk
         9zHCPbYegvZmOfmThCrytLz2d+DzPUGCyoBL+7T3nZx7kQni+6WjJe27wsit13vBQh
         SAXCAbGvmpQfA==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] SUNRPC: Allow specification of TCP client connect timeout at setup
Date:   Fri, 18 Aug 2023 09:41:49 -0400
Message-ID: <20230818134150.23485-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818134150.23485-3-trondmy@kernel.org>
References: <20230818134150.23485-1-trondmy@kernel.org>
 <20230818134150.23485-2-trondmy@kernel.org>
 <20230818134150.23485-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we create a TCP transport, the connect timeout parameters are
currently fixed to be 90s. This is problematic in the pNFS flexfiles
case, where we may have multiple mirrors, and we would like to fail over
quickly to the next mirror if a data server is down.

This patch adds the ability to specify the connection parameters at RPC
client creation time.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/clnt.h | 2 ++
 include/linux/sunrpc/xprt.h | 2 ++
 net/sunrpc/clnt.c           | 2 ++
 net/sunrpc/xprtsock.c       | 9 +++++++--
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 4f41d839face..af7358277f1c 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -148,6 +148,8 @@ struct rpc_create_args {
 	const struct cred	*cred;
 	unsigned int		max_connect;
 	struct xprtsec_parms	xprtsec;
+	unsigned long		connect_timeout;
+	unsigned long		reconnect_timeout;
 };
 
 struct rpc_add_xprt_test {
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index b52411bcfe4e..4ecc89301eb7 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -351,6 +351,8 @@ struct xprt_create {
 	struct rpc_xprt_switch	*bc_xps;
 	unsigned int		flags;
 	struct xprtsec_parms	xprtsec;
+	unsigned long		connect_timeout;
+	unsigned long		reconnect_timeout;
 };
 
 struct xprt_class {
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d7c697af3762..9edebfdb5ce1 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -534,6 +534,8 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		.servername = args->servername,
 		.bc_xprt = args->bc_xprt,
 		.xprtsec = args->xprtsec,
+		.connect_timeout = args->connect_timeout,
+		.reconnect_timeout = args->reconnect_timeout,
 	};
 	char servername[48];
 	struct rpc_clnt *clnt;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index f1909c22cea3..77420362e525 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2291,8 +2291,6 @@ static void xs_tcp_set_connect_timeout(struct rpc_xprt *xprt,
 		unsigned long reconnect_timeout)
 {
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
-	struct rpc_timeout to;
-	unsigned long initval;
 
 	spin_lock(&xprt->transport_lock);
 	if (reconnect_timeout < xprt->max_reconnect_timeout)
@@ -3351,8 +3349,15 @@ static struct rpc_xprt *xs_setup_tcp(struct xprt_create *args)
 	xprt->timeout = &xs_tcp_default_timeout;
 
 	xprt->max_reconnect_timeout = xprt->timeout->to_maxval;
+	if (args->reconnect_timeout &&
+	    args->reconnect_timeout < xprt->max_reconnect_timeout)
+		xprt->max_reconnect_timeout = args->reconnect_timeout;
+
 	xprt->connect_timeout = xprt->timeout->to_initval *
 		(xprt->timeout->to_retries + 1);
+	if (args->connect_timeout &&
+	    args->connect_timeout < xprt->connect_timeout)
+		xs_tcp_do_set_connect_timeout(xprt, args->connect_timeout);
 
 	INIT_WORK(&transport->recv_worker, xs_stream_data_receive_workfn);
 	INIT_WORK(&transport->error_worker, xs_error_handle);
-- 
2.41.0

