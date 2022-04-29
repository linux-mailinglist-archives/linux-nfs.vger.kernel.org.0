Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2815751527E
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 19:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379320AbiD2RqC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 13:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379775AbiD2Rp7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 13:45:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E94D3D99
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 10:42:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1EABB8376B
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 17:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E669AC385A4;
        Fri, 29 Apr 2022 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651254157;
        bh=5YPb4LWePLYlCNdOWjz2GW/FS+Um7vpp2gAcdBl86lY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iK1TFaiq8T3gL7GGIgpkxnJtD1tOQZa3HxxdGVEevbFyTa3PtsBk8Ry2qzjuAEXws
         De+eaViIBw29dvB+WKCajQxuENCfsWYIbk7SYyYjSu5bMvpoT3yGEZVgNzPPO6RDwu
         pXqWBQo8as25yZky2cAxI08p4pf18xpB+/A7GTNkEo8ea9E6pNwsxC7UtRYGyPm3iX
         r4ftZ1afBBX5cVC2XAHzqq0krK6Os5cEdgoiuUXjZ6e2g2QPq5Q9bEWI04q6ikfPVY
         5TdLvrJfrz99N1e0SSORw2m5SjYoOdAlc8wjfZVSCTOCiBxI/YwJ6EQZl69fdUtX2M
         Cea/+7wsmrgxg==
From:   trondmy@kernel.org
To:     "wanghai (M)" <wanghai38@huawei.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/4] SUNRPC: Ensure gss-proxy connects on setup
Date:   Fri, 29 Apr 2022 13:36:28 -0400
Message-Id: <20220429173629.621418-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429173629.621418-2-trondmy@kernel.org>
References: <20220429173629.621418-1-trondmy@kernel.org>
 <20220429173629.621418-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

For reasons best known to the author, gss-proxy does not implement a
NULL procedure, and returns RPC_PROC_UNAVAIL. However we still want to
ensure that we connect to the service at setup time.
So add a quirk-flag specially for this case.

Fixes: 1d658336b05f ("SUNRPC: Add RPC based upcall mechanism for RPCGSS auth")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/clnt.h          | 1 +
 net/sunrpc/auth_gss/gss_rpc_upcall.c | 2 +-
 net/sunrpc/clnt.c                    | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 267b7aeaf1a6..db5149567305 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -160,6 +160,7 @@ struct rpc_add_xprt_test {
 #define RPC_CLNT_CREATE_NO_RETRANS_TIMEOUT	(1UL << 9)
 #define RPC_CLNT_CREATE_SOFTERR		(1UL << 10)
 #define RPC_CLNT_CREATE_REUSEPORT	(1UL << 11)
+#define RPC_CLNT_CREATE_IGNORE_NULL_UNAVAIL (1UL << 12)
 
 struct rpc_clnt *rpc_create(struct rpc_create_args *args);
 struct rpc_clnt	*rpc_bind_new_program(struct rpc_clnt *,
diff --git a/net/sunrpc/auth_gss/gss_rpc_upcall.c b/net/sunrpc/auth_gss/gss_rpc_upcall.c
index 61c276bddaf2..8ca1d809b78d 100644
--- a/net/sunrpc/auth_gss/gss_rpc_upcall.c
+++ b/net/sunrpc/auth_gss/gss_rpc_upcall.c
@@ -97,7 +97,7 @@ static int gssp_rpc_create(struct net *net, struct rpc_clnt **_clnt)
 		 * timeout, which would result in reconnections being
 		 * done without the correct namespace:
 		 */
-		.flags		= RPC_CLNT_CREATE_NOPING |
+		.flags		= RPC_CLNT_CREATE_IGNORE_NULL_UNAVAIL |
 				  RPC_CLNT_CREATE_NO_IDLE_TIMEOUT
 	};
 	struct rpc_clnt *clnt;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 98133aa54f19..22c28cf43eba 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -479,6 +479,9 @@ static struct rpc_clnt *rpc_create_xprt(struct rpc_create_args *args,
 
 	if (!(args->flags & RPC_CLNT_CREATE_NOPING)) {
 		int err = rpc_ping(clnt);
+		if ((args->flags & RPC_CLNT_CREATE_IGNORE_NULL_UNAVAIL) &&
+		    err == -EOPNOTSUPP)
+			err = 0;
 		if (err != 0) {
 			rpc_shutdown_client(clnt);
 			return ERR_PTR(err);
-- 
2.35.1

