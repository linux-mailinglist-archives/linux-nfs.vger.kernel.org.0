Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1AE3768AA
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 18:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbhEGQ02 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 12:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238113AbhEGQ01 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 12:26:27 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D364DC061761
        for <linux-nfs@vger.kernel.org>; Fri,  7 May 2021 09:25:25 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p8so8422705iol.11
        for <linux-nfs@vger.kernel.org>; Fri, 07 May 2021 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Fg1CTEpqXVj95kKutPWoBVqcxEtRPxgNEonrsSkYnU=;
        b=H+K3WbPAdb5jodzriAKwOm5bOYS0zi+DMWmJ5SPk/WVtKTOHknE9IFKp8lvNXEgW+x
         o+rtHVY0U6y6rMMjzbKp9/r3e6H5TTSYgmi/n/NlGBhEPknrk0+SeKt1Y2aN3rLNH89t
         41YgU+efau9IL1SMYQjOocU9gLtUR4KH0kt7k2mJMN9Ee5Oety9T/M6zrGJA148FggGe
         UCuQVm0ioDpylnLbemOFZatF9AjyH8qhK84kkquIYRkoi/1PiNn9jIrrpH8aZ1mHOIKK
         tpJXQXSVL3fntx4WSaJMZsgIVQ0pT4ufM8AjVqrEUVoYiOkOpVnQt0OGup66Yya5gZiB
         nsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Fg1CTEpqXVj95kKutPWoBVqcxEtRPxgNEonrsSkYnU=;
        b=iiCbKSpbsIaZJduN3fubAss4JB9aba9uw7WuI01J6R45rr9lBvpuwT3o7MezpFSWW8
         8ExOERBFqD4NfyF4C+CovymhiGfafOXsWY8JRfullTfKwOf2CUnnOcyyo9Rp0nL+aQP9
         MfYm9f4GA20JshxDNYftRCpsr7C/IWn9El85z19uSYKvIDV02+vhJWWHMKEs13mnpAMS
         9WgWRRbnk2u7MaKKOPXbIdBoe42jpuN8j/uR6oV2yTRdT99oOB6ZvDtuyifdmzqrQu8D
         13Ku68rja2vEysp4bxNnMaFOUmZnqGrG/Dujko7m+PhLbTUy1mAQ87SeFmCNibdpZr6G
         1bZQ==
X-Gm-Message-State: AOAM530BqjzKaJwye7pS8GOLvacal9Bpi5BONUh+nChQN7G8S4RlrIg7
        U+TcC2wMJTPcCiHNkHGkHpo=
X-Google-Smtp-Source: ABdhPJzeG4GWWCx7ZEAY5ooUeKBFfT4+GdIavV4e/3dPcQmsmr9BCtCc6Bpkf0LxR7Q/inXY/YBphw==
X-Received: by 2002:a02:cbad:: with SMTP id v13mr9822951jap.28.1620404725333;
        Fri, 07 May 2021 09:25:25 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v2sm2451000ioe.22.2021.05.07.09.25.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 09:25:24 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 05/12] sunrpc: add IDs to multipath
Date:   Fri,  7 May 2021 12:25:11 -0400
Message-Id: <20210507162518.51520-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
References: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
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

