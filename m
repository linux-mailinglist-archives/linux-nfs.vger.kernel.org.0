Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1A75520C0
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbiFTPZz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiFTPZW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:22 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA07CF9
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:32 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 88so12811540qva.9
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HQd2B/YkNYnZSu99acmqUXErKGwuXvN6tYgl+XEJ6A=;
        b=mLlyN5eCfD9MyWiqDlYWwU19roYac7YV5tk4wFbec8JWtlL3XTXOfnQ2H1uvzaNosF
         cxSfbc9hi61M9TmIFOXEuySFWqH+yNodeAuaRlXlq1fbheSdN8WXo4NYKaIAS7f5kOd4
         dMLGysIoZMGtAKvJV4SlykJRfj+0QtgUmIROH5KZDbsRTbMeCv3K8h9ywhqqnNoLgfyp
         080CIbLiBU0+ON057KDmfo8t45OLMRsWGON5BYn1Wl2+4PsOTudblCjeM4uShlZPJ10o
         oHIiTEzh3xUJsLQWWNg1Q36W3asXYCHaeo6KUDs1n2BIh6ubcxzqDMQOz3ONKJEifKFw
         NQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HQd2B/YkNYnZSu99acmqUXErKGwuXvN6tYgl+XEJ6A=;
        b=Bmd1dRb0tmBCxUBGU9I07kh7JqUexuauPwnBveCEsIg+9t/JmyCFnzU+vuB+u5ZK5l
         enndJyK2bNrjWnWrSKKpQ0MVx85dYSq/N5xjio+ZKgWX3h9Mo1KYFE9UTOGFleq9PkGP
         4+UoxpoXMwGR7+LxX9L/dH+BDmIafilqSDUskHS4uWB/W0hLxvTWeX1mUsWgM5uS2Sup
         IJe63rOmklajsH2Lac5gSevBc2LZIt3kQJHZ+R0RhonJOpeE1lEKpYLxibDKAmk4bebm
         yl7H/eJPGy1hwJuGYrXAJSVt5LSDWgp8Vv9/yjBsj+YZUU13lIOgILhzb4LTvwLFY0ss
         PubQ==
X-Gm-Message-State: AJIora8d8DvrsVbFuHmyoX4s0qHEduSqcxGVOPXL/7Y29TccI3ffwiG3
        /UJCzp8Lvc34IdYeDnZEf7w=
X-Google-Smtp-Source: AGRyM1tdIO+ZJ33ED4UEwRmrCf2wDOSTbUkCSoiGyGHPLIJL9Y/32nfT4FKWrhUkuHtSf+6va+e6zQ==
X-Received: by 2002:ac8:5d87:0:b0:305:bbf:cd85 with SMTP id d7-20020ac85d87000000b003050bbfcd85mr20398526qtx.618.1655738671755;
        Mon, 20 Jun 2022 08:24:31 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:31 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 01/12] SUNRPC expose functions for offline remote xprt functionality
Date:   Mon, 20 Jun 2022 11:23:56 -0400
Message-Id: <20220620152407.63127-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
References: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Re-arrange the code that make offline transport and delete transport
callable functions.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprt.h |  3 +++
 net/sunrpc/sysfs.c          | 28 +++++-----------------------
 net/sunrpc/xprt.c           | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 23 deletions(-)

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
index 86d62cffba0d..6480ae324b27 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -2152,3 +2152,38 @@ void xprt_put(struct rpc_xprt *xprt)
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
+EXPORT_SYMBOL(xprt_set_offline_locked);
+
+void xprt_set_online_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps)
+{
+	if (test_and_clear_bit(XPRT_OFFLINE, &xprt->state)) {
+		spin_lock(&xps->xps_lock);
+		xps->xps_nactive++;
+		spin_unlock(&xps->xps_lock);
+	}
+}
+EXPORT_SYMBOL(xprt_set_online_locked);
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
+EXPORT_SYMBOL(xprt_delete_locked);
-- 
2.27.0

