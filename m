Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7916360002
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 04:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhDOC2f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 22:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDOC2f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 22:28:35 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB116C061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:12 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e186so22726946iof.7
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qRdpiHoavL/giiAlZ2MhLMoCIxtj1P8713oUh2Q7kDY=;
        b=CBIxmexeqTr+k2EIEO9D5OVrjnn29SE2Olb3gxP8Dkk34vNP4uXb9GBJxWirrO1mnL
         E9nFY3WIW9Zg2N8W2vGXc2na5lLRI4IlwDDR6yO3sti6zdSFCZAFRSillN1hT9Me7Ohp
         slxF2u+EjwT3QHPthPhxrdXoUev5r1uL9AGpoLV6+e+DRK7/YiyU5fdRJuwMBAb4/9uM
         fNeAp4YBfJxbQ+y/lzZdma9Ld8yuRgEZFDKJ0iefAJScUbjMiSEKIM9g2WkjvTW4yAiq
         0805HJsKp20Ofa+39pv2mQlEULq/OD6tkFaU+IykXn8YCLUoNN+8UhJi/tVJT3qC52Yl
         vfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRdpiHoavL/giiAlZ2MhLMoCIxtj1P8713oUh2Q7kDY=;
        b=NGDp+o3+3160wUmFVf0Pc/7+cs0EVH279QtmXhV/qiEHwlodFOLQ1HcQuj1bENFCZ6
         NyfAIFPly1ivrd2pcn9Lpj5WAyAmvSBIeubI/wz+kh3OGsNjzTq296X5587e8pcl1cnM
         6u+hRZ4Sz2+9tsQj1OkgqwrxtzYHYYLAQar2D2yPzv1VQMUOsKFt6yicjEYSXrgF2BbY
         ZBPdc6pMgHKLDVYBkVW01iShJ3w6DE01ieK3BTyksEz5Rb3+OS3CWW9B9pcHC7l/CdxN
         BOvC/2FKYz5FN68KrBwLDmalKkxjbTPGDVlDZCHYrlSGipz1Hbg0A7HX8xnAIWMHCcJB
         /3uQ==
X-Gm-Message-State: AOAM532lAx6SVRzL5EoXFtxYA8dkyFG4BVvoSeploxPuil6OHv1wtki7
        95q7GShXy4r3wreTTy2IctE=
X-Google-Smtp-Source: ABdhPJz2jrgfYL+7IDkwAEaqushl+bd8k02rNzYkT7Y/dhnjrR6ag62yx+5DANZhEwDGSYlOE43S3Q==
X-Received: by 2002:a05:6602:2d04:: with SMTP id c4mr862304iow.182.1618453692105;
        Wed, 14 Apr 2021 19:28:12 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm608917ilh.47.2021.04.14.19.28.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:28:11 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 06/13] sunrpc: add IDs to multipath
Date:   Wed, 14 Apr 2021 22:27:55 -0400
Message-Id: <20210415022802.31692-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
References: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This is used to uniquely identify sunrpc multipath objects in /sys.

Signed-off-by: Dan Aloni <dan@kernelim.com>
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
index 78c075a68c04..b71dd95ad7de 100644
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
+static int xprt_switch_alloc_id(struct rpc_xprt_switch *xps)
+{
+	int id;
+
+	id = ida_simple_get(&rpc_xprtswitch_ids, 0, 0, GFP_KERNEL);
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
+		xprt_switch_alloc_id(xps);
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

