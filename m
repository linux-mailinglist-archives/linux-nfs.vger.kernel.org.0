Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ADE57FFDD
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiGYNcj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiGYNci (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:32:38 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E312AB0
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:35 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 125so10665397vsd.5
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zm65GAC++NE5htCbklv3UxxIt3spNpISQjRrzlmkFBM=;
        b=BCNSC1WOn+Tj3xbCumjUim4k+wf2JFSxWUSscbxjBqCEKIcY5sLKlun8BFJR9MKMR3
         BfyV3umNRihC7mjTDhffUMRmrx3lIU4jQOLW+Nx2PoPbiIljpcje3olsguvQumCQl1eO
         M48eQulrakP2pxeUTuGDOWX1LNu0fiICLShxURoHQbJlTu79+RQ35yoVhlXA5adrpIgT
         g2MV5/vD7UkjDd1ZHySc7lwLignV4e26+Ey7R/sPB7bLxir/P4DeMpaT5WdbDPJN3/CG
         hP6lyXy12x3s0Qwb4JjpHeuvi0738LwOI1XZEkoRpYdC6wW4gZ8CbNarmjF/o3OHLIJ/
         6xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zm65GAC++NE5htCbklv3UxxIt3spNpISQjRrzlmkFBM=;
        b=sx0gjT26qm33P70KgdPFdQCakrUdhuvj/2oufliw30pMdOK6wH8RGUFZ/a8z5HGIbK
         u0TK2jKjnecG/bSQNJ6ORBIlgSw5XrdVCgvXnDz6DtW7rG4FAUR00eZSYI0JCx0HDaeH
         Evr7M0H3THftktdlwPxr4o6LOQa4PrBiz+w76QToyiK6/OaIXz7X9VbCVY6kkx976rlM
         2i9FSMETpbeM7SsxMwtpZOzBSbuSrNPLf/ApRD13mvDUt96T8laP3nEnp4duXN7CvzY6
         l8BimaOrnbZB3jmAbJ095Soxlxc9ahzJKO66FRIb8bM5hcxdUQA65+WMQjvZu5xRsO8P
         TbCw==
X-Gm-Message-State: AJIora+5gg6CT2YDAKEBhGyIL4aWcrYTMdEZCd1p3E5jHy27361doEfa
        6C3cZd1ODfV2HcxQ+DHe6+g=
X-Google-Smtp-Source: AGRyM1vW5Zz4SHbpxzeLD/bNptjPvCute3FA0kYjzEu4qsukGTgwskVIGVnvKuxE66tX8FVLO2bt3g==
X-Received: by 2002:a05:6102:3d29:b0:357:64aa:811f with SMTP id i41-20020a0561023d2900b0035764aa811fmr3197181vsv.58.1658755954915;
        Mon, 25 Jul 2022 06:32:34 -0700 (PDT)
Received: from localhost.localdomain (071-047-011-047.res.spectrum.com. [71.47.11.47])
        by smtp.gmail.com with ESMTPSA id a6-20020ab06306000000b00383aeb53100sm2128826uap.16.2022.07.25.06.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:34 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 01/11] SUNRPC expose functions for offline remote xprt functionality
Date:   Mon, 25 Jul 2022 09:32:21 -0400
Message-Id: <20220725133231.4279-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
References: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Re-arrange the code that make offline transport and delete transport
callable functions.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprt.h |  3 +++
 net/sunrpc/sysfs.c          | 28 +++++-----------------------
 net/sunrpc/xprt.c           | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 522bbf937957..0d51b9f9ea37 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -505,4 +505,7 @@ static inline int xprt_test_and_set_binding(struct rpc_xprt *xprt)
 	return test_and_set_bit(XPRT_BINDING, &xprt->state);
 }
 
+void xprt_set_offline_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps);
+void xprt_set_online_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps);
+void xprt_delete_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps);
 #endif /* _LINUX_SUNRPC_XPRT_H */
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index a3a2f8aeb80e..7330eb9a70cf 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -314,32 +314,14 @@ static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
 		goto release_tasks;
 	}
 	if (offline) {
-		if (!test_and_set_bit(XPRT_OFFLINE, &xprt->state)) {
-			spin_lock(&xps->xps_lock);
-			xps->xps_nactive--;
-			spin_unlock(&xps->xps_lock);
-		}
+		xprt_set_offline_locked(xprt, xps);
 	} else if (online) {
-		if (test_and_clear_bit(XPRT_OFFLINE, &xprt->state)) {
-			spin_lock(&xps->xps_lock);
-			xps->xps_nactive++;
-			spin_unlock(&xps->xps_lock);
-		}
+		xprt_set_online_locked(xprt, xps);
 	} else if (remove) {
-		if (test_bit(XPRT_OFFLINE, &xprt->state)) {
-			if (!test_and_set_bit(XPRT_REMOVE, &xprt->state)) {
-				xprt_force_disconnect(xprt);
-				if (test_bit(XPRT_CONNECTED, &xprt->state)) {
-					if (!xprt->sending.qlen &&
-					    !xprt->pending.qlen &&
-					    !xprt->backlog.qlen &&
-					    !atomic_long_read(&xprt->queuelen))
-						rpc_xprt_switch_remove_xprt(xps, xprt);
-				}
-			}
-		} else {
+		if (test_bit(XPRT_OFFLINE, &xprt->state))
+			xprt_delete_locked(xprt, xps);
+		else
 			count = -EINVAL;
-		}
 	}
 
 release_tasks:
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 86d62cffba0d..8f8e3c952f24 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -2152,3 +2152,35 @@ void xprt_put(struct rpc_xprt *xprt)
 		kref_put(&xprt->kref, xprt_destroy_kref);
 }
 EXPORT_SYMBOL_GPL(xprt_put);
+
+void xprt_set_offline_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps)
+{
+	if (!test_and_set_bit(XPRT_OFFLINE, &xprt->state)) {
+		spin_lock(&xps->xps_lock);
+		xps->xps_nactive--;
+		spin_unlock(&xps->xps_lock);
+	}
+}
+
+void xprt_set_online_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps)
+{
+	if (test_and_clear_bit(XPRT_OFFLINE, &xprt->state)) {
+		spin_lock(&xps->xps_lock);
+		xps->xps_nactive++;
+		spin_unlock(&xps->xps_lock);
+	}
+}
+
+void xprt_delete_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps)
+{
+	if (test_and_set_bit(XPRT_REMOVE, &xprt->state))
+		return;
+
+	xprt_force_disconnect(xprt);
+	if (!test_bit(XPRT_CONNECTED, &xprt->state))
+		return;
+
+	if (!xprt->sending.qlen && !xprt->pending.qlen &&
+	    !xprt->backlog.qlen && !atomic_long_read(&xprt->queuelen))
+		rpc_xprt_switch_remove_xprt(xps, xprt);
+}
-- 
2.27.0

