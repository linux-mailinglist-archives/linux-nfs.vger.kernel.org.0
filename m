Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB7939ADE1
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhFCWWs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhFCWWs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:22:48 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2202C061756
        for <linux-nfs@vger.kernel.org>; Thu,  3 Jun 2021 15:20:48 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c124so7554191qkd.8
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Fg1CTEpqXVj95kKutPWoBVqcxEtRPxgNEonrsSkYnU=;
        b=g+ffLOyFoBI+RWPhxWnSBnDciqEU23Yyys12glu/s6avATpxhse7ObaD9ZQDLM6ix5
         aqz5idACwqzUFzBZS65RSe2CnweVI8N7RBumHqYb3lK2hVd65TkDhd+Uw8UOQ/TopJ5E
         NCH3D0qOxAaXq34Stvzf53N3PGpkuPf0f+7oOiIgSRFFom62odRp1VshxTO8A9wO26a+
         RqaM5bDZqYO6olQmsvps6LMOlYHLKQ3Xylut40JisymvDaMWSSCijmSlZDMGeVaCcxbS
         9yLEECERFW5MaT4AurTauczIi4w/KH+B6iRDfO/549m3bT1/SQC7ljI1MXXvCmdNy2+c
         RUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Fg1CTEpqXVj95kKutPWoBVqcxEtRPxgNEonrsSkYnU=;
        b=Aa0hTzttEND6Jq1ykidiOqCuyR4ZVZRXCs/T8gplSlO88iinkMlYpfBpq41QrY5wJQ
         zUPOgjKeydqtWgtEF5kpxBDCBPpqddFsg+WxFek3AlWmMJoya88/dzDx6DMceNI5qY8U
         Ov4mHdHRCXYH2+DrgkWj7PLp5oYtLv/xBvG87r0m5c/dLQYrlbudf4fdDOQqqhQaU6NP
         2L+KMJZMBDQC0NxpEY4gm7oMsnbQ7tyRjyumQmxLs6kGSuIajpEZniEcmRv+uujhWXR8
         eeZlaYz4dooVIV99fVH/F+c9dnqOn/UKGK0UrxJXDjHhpy2b9Wp2JcriWA+SgHd99THn
         zDBQ==
X-Gm-Message-State: AOAM532mWoy+YfBj+FGs7Y4YPeZzJBkJ5PivrnGWGaokybU2lXCXfYpt
        HXk1b+xq9GsL9Z1x7bSi9HU=
X-Google-Smtp-Source: ABdhPJztq1T/F1iv8TCTFNXhI69JpDOxLs9LsEXWIxamwGFjX3LaQgS1LiYHsNeQj+QqvIyGy7oJFQ==
X-Received: by 2002:a37:ac17:: with SMTP id e23mr1526235qkm.184.1622758847860;
        Thu, 03 Jun 2021 15:20:47 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:47 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 05/13] sunrpc: add IDs to multipath
Date:   Thu,  3 Jun 2021 18:20:31 -0400
Message-Id: <20210603222039.19182-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This is used to uniquely identify sunrpc multipath objects in /sys.

Signed-off-by: Dan Aloni <dan@kernelim.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprtmultipath.h |  4 ++++
 net/sunrpc/sunrpc_syms.c             |  1 +
 net/sunrpc/xprtmultipath.c           | 26 ++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index c6cce3fbf29d..ef95a6f18ccf 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -14,6 +14,7 @@ struct rpc_xprt_switch {
 	spinlock_t		xps_lock;
 	struct kref		xps_kref;
 
+	unsigned int		xps_id;
 	unsigned int		xps_nxprts;
 	unsigned int		xps_nactive;
 	atomic_long_t		xps_queuelen;
@@ -71,4 +72,7 @@ extern struct rpc_xprt *xprt_iter_get_next(struct rpc_xprt_iter *xpi);
 
 extern bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
 		const struct sockaddr *sap);
+
+extern void xprt_multipath_cleanup_ids(void);
+
 #endif
diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
index b61b74c00483..691c0000e9ea 100644
--- a/net/sunrpc/sunrpc_syms.c
+++ b/net/sunrpc/sunrpc_syms.c
@@ -134,6 +134,7 @@ cleanup_sunrpc(void)
 	rpc_sysfs_exit();
 	rpc_cleanup_clids();
 	xprt_cleanup_ids();
+	xprt_multipath_cleanup_ids();
 	rpcauth_remove_module();
 	cleanup_socket_xprt();
 	svc_cleanup_xprt_sock();
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 78c075a68c04..4969a4c216f7 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -86,6 +86,30 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
 	xprt_put(xprt);
 }
 
+static DEFINE_IDA(rpc_xprtswitch_ids);
+
+void xprt_multipath_cleanup_ids(void)
+{
+	ida_destroy(&rpc_xprtswitch_ids);
+}
+
+static int xprt_switch_alloc_id(struct rpc_xprt_switch *xps, gfp_t gfp_flags)
+{
+	int id;
+
+	id = ida_simple_get(&rpc_xprtswitch_ids, 0, 0, gfp_flags);
+	if (id < 0)
+		return id;
+
+	xps->xps_id = id;
+	return 0;
+}
+
+static void xprt_switch_free_id(struct rpc_xprt_switch *xps)
+{
+	ida_simple_remove(&rpc_xprtswitch_ids, xps->xps_id);
+}
+
 /**
  * xprt_switch_alloc - Allocate a new struct rpc_xprt_switch
  * @xprt: pointer to struct rpc_xprt
@@ -103,6 +127,7 @@ struct rpc_xprt_switch *xprt_switch_alloc(struct rpc_xprt *xprt,
 	if (xps != NULL) {
 		spin_lock_init(&xps->xps_lock);
 		kref_init(&xps->xps_kref);
+		xprt_switch_alloc_id(xps, gfp_flags);
 		xps->xps_nxprts = xps->xps_nactive = 0;
 		atomic_long_set(&xps->xps_queuelen, 0);
 		xps->xps_net = NULL;
@@ -136,6 +161,7 @@ static void xprt_switch_free(struct kref *kref)
 			struct rpc_xprt_switch, xps_kref);
 
 	xprt_switch_free_entries(xps);
+	xprt_switch_free_id(xps);
 	kfree_rcu(xps, xps_rcu);
 }
 
-- 
2.27.0

