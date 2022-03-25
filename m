Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5154E7DB8
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Mar 2022 01:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiCYUB4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Mar 2022 16:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiCYUBn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Mar 2022 16:01:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C623B24A765
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 12:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F3CA61BF8
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 18:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802B5C34100
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648231328;
        bh=wsVaQ6U8G7kdvaF7wHDkqDE5b0eb1ZOqOyqtvCNtpgI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i1/tS+HSyaMQ3iqq4UXga+zRsIHLxPqWh15biVft7z8h8jhxhzflekjUmMVoEoPTw
         K16lCHBjchm3cCe9F88i4KU9jR0RN+hO5VE+28jFBr9Xt8tmzJQUiAGW5vXFIo1LU/
         winbaneRPrOhSuzQtvMpvaV026/UtLetjykjATD6uRFhtyCLQr4aGFK2jNrvGaqEaL
         lmwyLDGhxdVOlFekGRpq9P2Inxhw5bGduw/JvbT6/qFYqYm7WJkqKvgArl/sOiMwZZ
         fEKYLtgpHgecSQcuVpZCxZZw74XgZEIZ11FuwQ99oSo7ZpOggctyf2gqOzxjkGu4wq
         fH91GULeQq5XA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/2] SUNRPC: Don't return error values in sysfs read of closed files
Date:   Fri, 25 Mar 2022 13:55:21 -0400
Message-Id: <20220325175521.561344-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325175521.561344-1-trondmy@kernel.org>
References: <20220325175521.561344-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Instead of returning an error value, which ends up being the return
value for the read() system call, it is more elegant to simply return
the error as a string value.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
v2: Rewrite to use transport switch
v3: remove '\0' from the pseudo-file

 net/sunrpc/sysfs.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 9d8a7d9f3e41..a3a2f8aeb80e 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -93,10 +93,13 @@ static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
 	ssize_t ret;
 
-	if (!xprt)
-		return 0;
+	if (!xprt) {
+		ret = sprintf(buf, "<closed>\n");
+		goto out;
+	}
 	ret = sprintf(buf, "%s\n", xprt->address_strings[RPC_DISPLAY_ADDR]);
 	xprt_put(xprt);
+out:
 	return ret;
 }
 
@@ -106,10 +109,10 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
 {
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
 	size_t buflen = PAGE_SIZE;
-	ssize_t ret = -ENOTSOCK;
+	ssize_t ret;
 
 	if (!xprt || !xprt_connected(xprt)) {
-		ret = -ENOTCONN;
+		ret = sprintf(buf, "<closed>\n");
 	} else if (xprt->ops->get_srcaddr) {
 		ret = xprt->ops->get_srcaddr(xprt, buf, buflen);
 		if (ret > 0) {
@@ -118,8 +121,10 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
 				ret++;
 				buf[ret] = '\0';
 			}
-		}
-	}
+		} else
+			ret = sprintf(buf, "<closed>\n");
+	} else
+		ret = sprintf(buf, "<not a socket>\n");
 	xprt_put(xprt);
 	return ret;
 }
@@ -133,8 +138,8 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 	ssize_t ret;
 
 	if (!xprt || !xprt_connected(xprt)) {
-		xprt_put(xprt);
-		return -ENOTCONN;
+		ret = sprintf(buf, "<closed>\n");
+		goto out;
 	}
 
 	if (xprt->ops->get_srcport)
@@ -152,6 +157,7 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 		       xprt->backlog.qlen, xprt->main, srcport,
 		       atomic_long_read(&xprt->queuelen),
 		       xprt->address_strings[RPC_DISPLAY_PORT]);
+out:
 	xprt_put(xprt);
 	return ret;
 }
@@ -165,10 +171,7 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 	int locked, connected, connecting, close_wait, bound, binding,
 	    closing, congested, cwnd_wait, write_space, offline, remove;
 
-	if (!xprt)
-		return 0;
-
-	if (!xprt->state) {
+	if (!(xprt && xprt->state)) {
 		ret = sprintf(buf, "state=CLOSED\n");
 	} else {
 		locked = test_bit(XPRT_LOCKED, &xprt->state);
-- 
2.35.1

