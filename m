Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3504D36B7F8
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbhDZRUs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 13:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbhDZRUj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 13:20:39 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D150C061342
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:19:57 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id t21so5943964iob.2
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Fg1CTEpqXVj95kKutPWoBVqcxEtRPxgNEonrsSkYnU=;
        b=T+bZ1Pi+9f1+8SNltSJWUMZ3WPt8l+x0e+1Y+blH9uONSfWta8ZlZcYps5kc5QFR45
         dFk6B9V4uIA5FQhnukDbi5vDXGacarIJfPbMgkIp3TcogKpZOvfVx8PuuFJe/wPoojEc
         LUtkczjj+ef2QOZ/qpK4Cog2Qel8yv2atTIjrViemZElmKGTR8LtqEeaIRObaRnX55iW
         TYSPNniIJL8dNyldrQ9d0QzT5TxtDAGloG6PkjiqKHFUo5e/2GZ1l3AbarRPI9uJFAOP
         MzUllNfYPFOe6ki6vMulKIcPAATHsj5yocWnuO3oWghp9Wlw2lgVBgHfViiCK7X48b32
         sG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Fg1CTEpqXVj95kKutPWoBVqcxEtRPxgNEonrsSkYnU=;
        b=I6Mmbt0EkaU31f21l6nVgTBoQ0uG8ppGbGwt+Wxfa/5ETJWZ8Xqs/iQO3krcjhCuWu
         O2JSHF+VaSg+DxUfG8olxZKnO2XSzGyDUbQpu+NBtQF+SE8QT6cbMuRHH7ATa6Tp2dXQ
         uUFYzHVjOIQRJULarZv+ZFyl1AcLpoGrwu+p6ckg3ws17ZLHMYD7ZoG4zD69SMXKZLXr
         aIwf4FYYvhFp/3ycNNH05SrpzW6naVbl496nUneZRNmnMQXZtCqiVP6MCq6h8oodAYOa
         yZmQLmOuDQvviMLjTmRzioCr+hwwhtOPfUgjIp3lLiTAMuXPne6vKfIXyZEIFrT7WowJ
         y9RA==
X-Gm-Message-State: AOAM533fqanAPM52BglLWqhRCwJQbojkrpc/rxqDDq/39/r/NSfYHmUi
        iBx7aCyQ3S1ZchUnwiCugyY=
X-Google-Smtp-Source: ABdhPJyFNC0H8XAj/meYUgoFh6LBMjCHXuw1+HLOiUbAZQevA3c7/1BwTgbtJn6sNyvT6UIuHHnRrQ==
X-Received: by 2002:a05:6602:1641:: with SMTP id y1mr8853731iow.54.1619457596903;
        Mon, 26 Apr 2021 10:19:56 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x13sm207297ilq.85.2021.04.26.10.19.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:19:56 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 06/13] sunrpc: add IDs to multipath
Date:   Mon, 26 Apr 2021 13:19:40 -0400
Message-Id: <20210426171947.99233-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
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

