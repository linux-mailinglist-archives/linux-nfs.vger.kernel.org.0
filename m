Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7942957D67D
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 00:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiGUWHU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 18:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiGUWHU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 18:07:20 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E886B93C25
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:18 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p81so2445553iod.2
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zm65GAC++NE5htCbklv3UxxIt3spNpISQjRrzlmkFBM=;
        b=BOZZyrXonGsS7ADll1NTuWFhuv4Ig1yuXuZfLtsTnNrR1c1V2LYrQuyXPtDrg6DXD+
         qItWVTtlFXbb+CC4yXahpu3iaurnM6ZkOVlRyzpyrljO95fs3nbxYHKwOxiPtZqHGL8+
         3M6qalK+250iVghpSz7jR1nvygALsD0ITsewN2JscR1P++pgc7gpj13zreBfCF3eXuOI
         y9pfMQnFIkRqy3xhkH7VElgl5hmRQWYNaTd2s3mP2+qhPq3k5YiWemTvIARIBZi3dBDz
         6gi1MLIRv9HL4QZvZb6Nu/D/XN0shVspZtWihHY66cAGygmF6+QKoD78H3dwBAGYKirN
         KgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zm65GAC++NE5htCbklv3UxxIt3spNpISQjRrzlmkFBM=;
        b=31ij5n46muwFn25aeusv3lHDSntJIgH0Nv4UzE0DLETKWx7O+bPOr/wvl4Js6XKKYE
         temYQCa+ofzLFGBha78MERdUpA4L3VioJ2Wci2GypVWY3GHSFmcCTCQmWuz0FDGTMVVI
         AO6ZNYxL5Ny6RunBjmUQWkLAvadZb+Ui+KP7xnk11d2hzizPCs8epTXLd+fxBV8fGG6+
         ddmQlQS1mW3mGUkGNQmlJj3MfdH8iR0w4bbUZszB23Yydj+RAhOj6tWbsZRfrul9OjrU
         RNrYFz4PHQqoxUFJcpSFSrhbRp9L7VptmkfyL8bFevmEw/1lOKKPSJQiM6/STovtiot1
         u0Mg==
X-Gm-Message-State: AJIora/miOlpW03VrC9WclLILKiNR/Mk6R22dDDPwoxSny1D50dowIye
        aGjykmbGA8ISK5OnzQ/mwVM=
X-Google-Smtp-Source: AGRyM1sWpRlM/BzgrtmEWNEbhAvjPKT41VeISoZ+FxTNe/SnFmZKDXZaCrWSGqJZIfMIiB7X3IsJWg==
X-Received: by 2002:a05:6602:2c13:b0:669:7f63:a2d7 with SMTP id w19-20020a0566022c1300b006697f63a2d7mr212933iov.169.1658441238328;
        Thu, 21 Jul 2022 15:07:18 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id g11-20020a05663811cb00b00341668383cfsm1281105jas.33.2022.07.21.15.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:07:17 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 01/11] SUNRPC expose functions for offline remote xprt functionality
Date:   Thu, 21 Jul 2022 18:07:04 -0400
Message-Id: <20220721220714.22620-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
References: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
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

