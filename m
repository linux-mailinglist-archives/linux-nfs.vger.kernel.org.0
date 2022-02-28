Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C811D4C7A9E
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 21:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiB1Uit (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 15:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiB1Uis (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 15:38:48 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FA317E0C
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:38:09 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id bm39so11408218qkb.0
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cNagKDysBsf6UvnFDztIqGvr1Ndg7lq6E+bzhf9XLvk=;
        b=Uu3W/c6PkQDtf/JPsuhlHGUsjTpFsaEfELDDUx+Vlspm4YkpFOMpDCZS6wOqzRhBBl
         NM8lIZ0TNE50fW/wHcZhb9IYwNXhYsFaRV9xLes7HnNlvdlx52J+AN4Z7PJup5t09Emm
         WQrUzht9aN61mkJ2ekGSZd4RufNXSFwBpIOlyz4z8gEbZV98tkz4coVpyxld+aORiqK4
         mO4OKoiVYX4YEYyhBIJA7EJkJwUkhGQiaacrvx0fEThcNhK64lTqFPAvdQ4FQoWrY/UJ
         xj2PiTCJIcpgbJOaHi+xcLx8rquZNQD55roJ7a3mWC78/boPHfSGsQwIwX0L+CLNTO7Z
         l/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cNagKDysBsf6UvnFDztIqGvr1Ndg7lq6E+bzhf9XLvk=;
        b=ihm+Jttag6OvUDOquPenl7O/bvBG8814fx81EmBYURDMMMmPTYamRr7OcHmCkxShAE
         LnhowZT0eDhNTFnGM5V7dOuF8HcAMZSsT2HAnuKxUBczgJjNlqLLhQJrFVdvPniyAi1Y
         h21L7nS4drXa6YlBjyazGlc0XCwumgihTpNxOnMSPNfCVPwOh3MrMhC2H21Dt51pbDLZ
         fWCQJNm0vjYlS/SfTOa4ZHRzF7sQmw3dL4ECJPEFhuPbSJN9Z/KmaheVBm3kHdMueA/Q
         Nqor+1J5MxjkcBmpokrLoESjQjVSRqWnAgymNmperNVi+JzfX/MC4rpcPmntq1me48X4
         YddQ==
X-Gm-Message-State: AOAM5308MvCepfYyC4v8sWrSzFIKEasnmqvem4yY/rXOt1O2LTiAjE7e
        wriVUhaGjo1xLSfIQLzrqbA=
X-Google-Smtp-Source: ABdhPJxF/t6a62sVZH2GF70YMokEjFKjqC65YRGpAidmmQbGGizUdrYFiLdUqr4VyHe+u16NuMtFkg==
X-Received: by 2002:ae9:e711:0:b0:648:e0ca:13fa with SMTP id m17-20020ae9e711000000b00648e0ca13famr12603635qka.300.1646080688072;
        Mon, 28 Feb 2022 12:38:08 -0800 (PST)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:4cc0:8dcd:bb8c:75c2])
        by smtp.gmail.com with ESMTPSA id p20-20020a05620a22b400b00648ca1458b4sm5457606qkh.5.2022.02.28.12.38.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:38:07 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 1/3] SUNRPC provide accessible functions for offline remote xprt functionality
Date:   Mon, 28 Feb 2022 15:38:02 -0500
Message-Id: <20220228203804.61803-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220228203804.61803-1-olga.kornievskaia@gmail.com>
References: <20220228203804.61803-1-olga.kornievskaia@gmail.com>
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
 include/linux/sunrpc/xprt.h |  2 ++
 net/sunrpc/sysfs.c          | 23 +++++------------------
 net/sunrpc/xprt.c           | 25 +++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 955ea4d7af0b..201c58991d4a 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -502,4 +502,6 @@ static inline int xprt_test_and_set_binding(struct rpc_xprt *xprt)
 	return test_and_set_bit(XPRT_BINDING, &xprt->state);
 }
 
+void xprt_set_offline_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps);
+void xprt_delete_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps);
 #endif /* _LINUX_SUNRPC_XPRT_H */
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 05c758da6a92..4a6488dd1608 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -6,6 +6,7 @@
 #include <linux/kobject.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/xprtsock.h>
+//#include <linux/sunrpc/xprt.h>
 
 #include "sysfs.h"
 
@@ -312,11 +313,7 @@ static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
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
 		if (test_and_clear_bit(XPRT_OFFLINE, &xprt->state)) {
 			spin_lock(&xps->xps_lock);
@@ -324,20 +321,10 @@ static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
 			spin_unlock(&xps->xps_lock);
 		}
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
index 9f0025e0742c..16d4435b61b4 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -2151,3 +2151,28 @@ void xprt_put(struct rpc_xprt *xprt)
 		kref_put(&xprt->kref, xprt_destroy_kref);
 }
 EXPORT_SYMBOL_GPL(xprt_put);
+
+void xprt_set_offline_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps)
+{
+        if (!test_and_set_bit(XPRT_OFFLINE, &xprt->state)) {
+                spin_lock(&xps->xps_lock);
+                xps->xps_nactive--;
+                spin_unlock(&xps->xps_lock);
+        }
+}
+EXPORT_SYMBOL(xprt_set_offline_locked);
+
+void xprt_delete_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps)
+{
+        if (test_and_set_bit(XPRT_REMOVE, &xprt->state))
+                return;
+
+        xprt_force_disconnect(xprt);
+        if (!test_bit(XPRT_CONNECTED, &xprt->state))
+                return;
+
+        if (!xprt->sending.qlen && !xprt->pending.qlen &&
+		!xprt->backlog.qlen && !atomic_long_read(&xprt->queuelen))
+                rpc_xprt_switch_remove_xprt(xps, xprt);
+}
+EXPORT_SYMBOL(xprt_delete_locked);
-- 
2.27.0

