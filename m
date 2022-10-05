Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB385F5AC7
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 22:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJEUE2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 16:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJEUE2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 16:04:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37722CDDE
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 13:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CA966177A
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 20:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C94EC433B5;
        Wed,  5 Oct 2022 20:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665000266;
        bh=/hGsOVRgWEOQk3P0KkZujE1MDhTp7WPH2M3vlQ5rAIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WE8Ykwi16+7e7VSCZtHtS9HKQraFSKGvGI9mJQ1gHXDNoA6EIra6L/10SnJm6vZn9
         jYMchD2Joel0K54Cv03y32LPTr4H5xqv2cvS8j1opnOP0s+XH25Q5vrYKTBCM8dbbR
         RUjzAbf1JTBifxdgcuTAzOydnDn+I3GcfP9TeoWfwwUeQGwsRvs6hyiR69FQSFHkvP
         7eU2FYMmwE79O/FaGJeFVPqGuEv0Jr6hs6AG5TGyyHaz4/dICkS1NVuDVyvLYh8AD6
         Jt/7VxWLQtKK8iZoCgANt6oTvS8wyNeKf7ybtPERFs5nhn7AP9ptEh+4CjbGhjkTzO
         v5W0qqcnswxeA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] SUNRPC: Add API to force the client to disconnect
Date:   Wed,  5 Oct 2022 15:57:37 -0400
Message-Id: <20221005195738.4552-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005195738.4552-3-trondmy@kernel.org>
References: <20221005195738.4552-1-trondmy@kernel.org>
 <20221005195738.4552-2-trondmy@kernel.org>
 <20221005195738.4552-3-trondmy@kernel.org>
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

Allow the caller to force a disconnection of the RPC client so that we
can clear any pending requests that are buffered in the socket.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 75eea5ebb179..770ef2cb5775 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -246,6 +246,7 @@ void rpc_clnt_xprt_switch_remove_xprt(struct rpc_clnt *, struct rpc_xprt *);
 bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
 			const struct sockaddr *sap);
 void rpc_clnt_xprt_set_online(struct rpc_clnt *clnt, struct rpc_xprt *xprt);
+void rpc_clnt_disconnect(struct rpc_clnt *clnt);
 void rpc_cleanup_clids(void);
 
 static inline int rpc_reply_expected(struct rpc_task *task)
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 3bee30cf8a7d..f3bb20db3265 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -910,6 +910,20 @@ unsigned long rpc_cancel_tasks(struct rpc_clnt *clnt, int error,
 }
 EXPORT_SYMBOL_GPL(rpc_cancel_tasks);
 
+static int rpc_clnt_disconnect_xprt(struct rpc_clnt *clnt,
+				    struct rpc_xprt *xprt, void *dummy)
+{
+	if (xprt_connected(xprt))
+		xprt_force_disconnect(xprt);
+	return 0;
+}
+
+void rpc_clnt_disconnect(struct rpc_clnt *clnt)
+{
+	rpc_clnt_iterate_for_each_xprt(clnt, rpc_clnt_disconnect_xprt, NULL);
+}
+EXPORT_SYMBOL_GPL(rpc_clnt_disconnect);
+
 /*
  * Properly shut down an RPC client, terminating all outstanding
  * requests.
-- 
2.37.3

