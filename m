Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753AF4E6A5A
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 22:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352459AbiCXVl1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 17:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349593AbiCXVl0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 17:41:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473B564BE5
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 14:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4AAAB82649
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 21:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DDEC340EC
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 21:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648157991;
        bh=rix6ZfMLXe62BFLdDMPJ/Nhi6jVLo5mSerSc1Ys1UQk=;
        h=From:To:Subject:Date:From;
        b=YfB+4YJ0BDWR/pf5zQw5vL1bZHBxayr8AvQ+FKEVcYMemjOrEBOnNMtrzdj1fl/qh
         MXMMmmoLmFP96p68VHXBEBvjX8KBaVQZ2rtn23umJ7f8npg1iufmRiimiPXlk3lMtj
         y8enscaWnOfiVqIbU1eaffIoef7sgoPaHY1bqTND2JHCzBOuNzaYw4ddVNOze80Nuj
         063nPhMaYyDeN5PH882OMmNrP3pSoJw0XkMW0+2phOfxdmGam4b1zZCcLauTzH5TXZ
         fMyKUBDDKNYY1UD6ng0FFNu2zTDZFcESQeaGHig6OI8GNl2SzgMNsgy35t9COlOw2a
         D6UD0nHx+tD9w==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] SUNRPC: Do not dereference non-socket transports in sysfs
Date:   Thu, 24 Mar 2022 17:33:44 -0400
Message-Id: <20220324213345.5833-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Do not cast the struct xprt to a sock_xprt unless we know it is a UDP or
TCP transport. Otherwise the call to lock the mutex will scribble over
whatever structure is actually there. This has been seen to cause hard
system lockups when the underlying transport was RDMA.

Fixes: e44773daf851 ("SUNRPC: Add srcaddr as a file in sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/sysfs.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 05c758da6a92..8ce053f84421 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -107,22 +107,34 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
 	struct sockaddr_storage saddr;
 	struct sock_xprt *sock;
+	const char *fmt = "<closed>\n";
 	ssize_t ret = -1;
 
-	if (!xprt || !xprt_connected(xprt)) {
-		xprt_put(xprt);
-		return -ENOTCONN;
-	}
+	if (!xprt || !xprt_connected(xprt))
+		goto out;
 
-	sock = container_of(xprt, struct sock_xprt, xprt);
-	mutex_lock(&sock->recv_mutex);
-	if (sock->sock == NULL ||
-	    kernel_getsockname(sock->sock, (struct sockaddr *)&saddr) < 0)
+	switch (xprt->xprt_class->ident) {
+	case XPRT_TRANSPORT_UDP:
+	case XPRT_TRANSPORT_TCP:
+		break;
+	default:
+		fmt = "<not a socket>\n";
 		goto out;
+	};
 
-	ret = sprintf(buf, "%pISc\n", &saddr);
-out:
+	sock = container_of(xprt, struct sock_xprt, xprt);
+	mutex_lock(&sock->recv_mutex);
+	if (sock->sock != NULL) {
+		ret = kernel_getsockname(sock->sock, (struct sockaddr *)&saddr);
+		if (ret >= 0) {
+			ret = sprintf(buf, "%pISc\n", &saddr);
+			fmt = NULL;
+		}
+	}
 	mutex_unlock(&sock->recv_mutex);
+out:
+	if (fmt)
+		ret = sprintf(buf, fmt);
 	xprt_put(xprt);
 	return ret + 1;
 }
-- 
2.35.1

