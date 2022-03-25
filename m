Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941FF4E78C9
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Mar 2022 17:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350083AbiCYQTp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Mar 2022 12:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354969AbiCYQTn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Mar 2022 12:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93EA2634
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 09:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6587A6195E
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 16:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9641BC340EE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648225085;
        bh=yT7k4sUpBRY+2reRl9B0zDvpuVLwS1wH51qi5QKyEbo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UKmLfqdTa98/D8GCT+Y+ccQeL+bhkAsH9MrFM5UtCzFjttRcdxOW24x+fkMx/thyu
         HdsiczHaVNvPfGddcnDvP0HXUTjEF0ZFupsE0UpHa1r9Y7+bjLYUqQVWB2PLLnTWBh
         o/I93e1FD8UMVreW30FPiv4PU6PREdX0wVl0Etf0WV3kT681rFq8aLUTlUzDxZYaRt
         Sc37apKS5i8Tf0FmP1qNQpN2lT4ONS3cOF+Z+6JuLnp8TJuHDPMdQ/hpXPP6H6FCbD
         C0hLKSJ3vK4AZ37sdu1/8vbcnqy0uNM3TWdcRn+EuMx2aqcpF2Y2vYQ7bGK8FDzeM8
         vGVNcYhnmSZZw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] SUNRPC: Don't return error values in sysfs read of closed files
Date:   Fri, 25 Mar 2022 12:11:38 -0400
Message-Id: <20220325161138.249905-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325161138.249905-1-trondmy@kernel.org>
References: <20220325161138.249905-1-trondmy@kernel.org>
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
 net/sunrpc/sysfs.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 60ff32296da3..7a9ff2e6261a 100644
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
 	return ret + 1;
 }
 
@@ -106,10 +109,10 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
 {
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
 	size_t buflen = PAGE_SIZE;
-	ssize_t ret = -ENOTSOCK;
+	ssize_t ret;
 
 	if (!xprt || !xprt_connected(xprt)) {
-		ret = -ENOTCONN;
+		ret = sprintf(buf, "<closed>\n") + 1;
 	} else if (xprt->ops->get_srcaddr) {
 		ret = xprt->ops->get_srcaddr(xprt, buf, buflen);
 		if (ret > 0) {
@@ -121,8 +124,10 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
 				buf[ret] = '\0';
 				ret++;
 			}
-		}
-	}
+		} else
+			ret = sprintf(buf, "<closed>\n") + 1;
+	} else
+		ret = sprintf(buf, "<not a socket>\n") + 1;
 	xprt_put(xprt);
 	return ret;
 }
@@ -136,8 +141,8 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 	ssize_t ret;
 
 	if (!xprt || !xprt_connected(xprt)) {
-		xprt_put(xprt);
-		return -ENOTCONN;
+		ret = sprintf(buf, "<closed>\n");
+		goto out;
 	}
 
 	if (xprt->ops->get_srcport)
@@ -155,6 +160,7 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 		       xprt->backlog.qlen, xprt->main, srcport,
 		       atomic_long_read(&xprt->queuelen),
 		       xprt->address_strings[RPC_DISPLAY_PORT]);
+out:
 	xprt_put(xprt);
 	return ret + 1;
 }
@@ -168,10 +174,7 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
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

