Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2034E6A56
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 22:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352361AbiCXVl0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 17:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349593AbiCXVlZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 17:41:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039446473C
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 14:39:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 914436139D
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 21:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE47EC340EE
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 21:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648157992;
        bh=KuIxCCcIK5THBRyx1gYe+BY1fxdHeSRRZ1i3INheoJI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XvF7Yfi5EOxzOfLstsznYSX/sJbKOGL8edozo0+akPwiw29IjAfWQh2l4rxaGqOhM
         vQuHXJMGH+2lJIMC5lf+ogN5fiGF98qCpbNFQ7c4mxfIE6Xu3f5JHwvkFQlv6cuCwd
         U33kbADOzE/SQep1Fa33zsi5ImxrSDv0zCatKrFOnQZi349MaLvOXqfxaFIbrr3eip
         JPkJfEoS2YLUlkIU5vf/yrMuiDpAO9I3Laze1wWjr3hTizEO/Htt7qkY8OUtm4hfPP
         Jdxg/F+CaDFZdUErVIX2yrskBA9zao4kRp/GwytgV3C3rJedbA82gbDC0PnfH3QIXG
         3bH4Ciams0T1Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] SUNRPC: Don't return error values in sysfs read of closed files
Date:   Thu, 24 Mar 2022 17:33:45 -0400
Message-Id: <20220324213345.5833-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324213345.5833-1-trondmy@kernel.org>
References: <20220324213345.5833-1-trondmy@kernel.org>
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
 net/sunrpc/sysfs.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 8ce053f84421..796e0f141282 100644
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
 
@@ -147,8 +150,8 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 	ssize_t ret;
 
 	if (!xprt || !xprt_connected(xprt)) {
-		xprt_put(xprt);
-		return -ENOTCONN;
+		ret = sprintf(buf, "<closed>\n");
+		goto out;
 	}
 
 	ret = sprintf(buf, "last_used=%lu\ncur_cong=%lu\ncong_win=%lu\n"
@@ -165,6 +168,7 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 		       atomic_long_read(&xprt->queuelen),
 		       (xprt->xprt_class->ident == XPRT_TRANSPORT_TCP) ?
 				xprt->address_strings[RPC_DISPLAY_PORT] : "0");
+out:
 	xprt_put(xprt);
 	return ret + 1;
 }
@@ -178,10 +182,7 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
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

