Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13047781BA0
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Aug 2023 02:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjHTATD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Aug 2023 20:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjHTASj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Aug 2023 20:18:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE489E28F7
        for <linux-nfs@vger.kernel.org>; Sat, 19 Aug 2023 14:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7573E60AB9
        for <linux-nfs@vger.kernel.org>; Sat, 19 Aug 2023 21:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEDFC433C8;
        Sat, 19 Aug 2023 21:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692481154;
        bh=yLnfJs0YfhcZXlPCWYoc0+cFQb1558aLBHuxwac0FYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERRHlnygm44ACBkx6QvJxmYvw4oecGtf5BUD9xIf70ObQshn6DdwpkuJlgmxG1F+1
         qZ84bOUdItJ8YWifiHiIp6iEnNksqHqxWBqQVnWvzOEI7riJZuPilzIXvo7IrPq0lg
         /WTR/kYveCv/RbFSadntolHU+gagZiaq0OdJTu2iSuI2l1/8yRnsSgUTNk0A/QNAS0
         LCtXtSrHEGI9A5yBTL4Mtzle9qjNkiVU8ok6PpNAO7JAkhusl0BpV6cmWLGk4Kje37
         mwWoV0qOdng9fLIZ48Ve/98JQ+pClPGv5YdLh5iyEqjgQ3p1rA4ab2FotsSJGWS1jS
         hZw8zsMfkOd/A==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/5] SUNRPC: Allow specification of TCP client connect timeout at setup
Date:   Sat, 19 Aug 2023 17:32:23 -0400
Message-ID: <20230819213225.731214-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230819213225.731214-3-trondmy@kernel.org>
References: <20230819213225.731214-1-trondmy@kernel.org>
 <20230819213225.731214-2-trondmy@kernel.org>
 <20230819213225.731214-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 net/sunrpc/xprtsock.c       | 7 +++++--
 4 files changed, 11 insertions(+), 2 deletions(-)

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
index e558f0024fe5..6e845e51cbf3 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2290,8 +2290,6 @@ static void xs_tcp_set_connect_timeout(struct rpc_xprt *xprt,
 		unsigned long reconnect_timeout)
 {
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
-	struct rpc_timeout to;
-	unsigned long initval;
 
 	spin_lock(&xprt->transport_lock);
 	if (reconnect_timeout < xprt->max_reconnect_timeout)
@@ -3350,8 +3348,13 @@ static struct rpc_xprt *xs_setup_tcp(struct xprt_create *args)
 	xprt->timeout = &xs_tcp_default_timeout;
 
 	xprt->max_reconnect_timeout = xprt->timeout->to_maxval;
+	if (args->reconnect_timeout)
+		xprt->max_reconnect_timeout = args->reconnect_timeout;
+
 	xprt->connect_timeout = xprt->timeout->to_initval *
 		(xprt->timeout->to_retries + 1);
+	if (args->connect_timeout)
+		xs_tcp_do_set_connect_timeout(xprt, args->connect_timeout);
 
 	INIT_WORK(&transport->recv_worker, xs_stream_data_receive_workfn);
 	INIT_WORK(&transport->error_worker, xs_error_handle);
-- 
2.41.0

