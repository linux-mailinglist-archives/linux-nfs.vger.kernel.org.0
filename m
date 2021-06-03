Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C71D39ADE0
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFCWWq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhFCWWp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:22:45 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E16DC06175F
        for <linux-nfs@vger.kernel.org>; Thu,  3 Jun 2021 15:20:52 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id h20so7523075qko.11
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94soqXL6YeuBIGDbnyeIBNAXPOYxIGr0JRdKAVfQ/L8=;
        b=iP+4Io6ARksRuoqeENob+LPD4Qt3Q5SCFcFPCCZRBIZUekjmvZdKMJB3HwVXe5c1VQ
         40aDiBSSV48VXMmnBt1ek0GMdhuaMREq65eSMmw/YLONR9oB0l/L/vL0FZ8EfXirw/Ax
         ICTpdY8wJb8duQ/XkOsjFQlTGHbXwfLKieRfrMo7/9YOEK3qECnAcnYnKiUMWpYzgJd3
         HnqFnFQklolbcDHv+KmZ+0plv6GfNsU3NW9rleZwciJtrSEJVCS60kQq+MMRtnpi5VVM
         TlZTVTFadCsF8VlrYkFPAVZ9PDMfViChOihKUemBPIlKbtv1kJI3XUVXdVcv/al1smqC
         ePJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94soqXL6YeuBIGDbnyeIBNAXPOYxIGr0JRdKAVfQ/L8=;
        b=nehYEfjRDk5oIObMZZnBmR7DS5cil/2HiHyFqemNuP5aCr1GqPJmAt1MOch3Rm2Bh7
         eWrhgEuKkT7RI1zpDujFIPm9oC2yezsrvVtLxXP4SXMZun7HkM84gv7t8vVKK7rX3ia9
         STcp+ccOIGAZXRcLjuoIBrmY/bWHVRLgrmDWJ9ErHcNhaAskRdYeA38HOuF7leqoevRR
         XgipWqZ8JMetx/WTamGRecz/82Nv/5UNQBlK8HDzw1qMZD0e55I6qI3k4fGv+t71Ih/2
         t5RFxcKqsMzmkKE/F2HW+KrUDnkFNddYqbtyUFwVNYVC44PFXx3PzvYMrMSlkQ0Cpggq
         ko0g==
X-Gm-Message-State: AOAM5316HNN7phWrKyv1MK7k6Wt6x06GiVlB1vwD9zzE1ieKb/bRpKRb
        nBjpIYSOJ4k4RWKActcPaPCk7z0swP8=
X-Google-Smtp-Source: ABdhPJzK0vTsrq+1QsWqwqpr5pn9P/ffqtw/XZwtpc79wmtJkJPwF61qDV96L3VuBlnXmZBCV/v8Qw==
X-Received: by 2002:a05:620a:29c2:: with SMTP id s2mr1514756qkp.79.1622758851489;
        Thu, 03 Jun 2021 15:20:51 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:51 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 08/13] sunrpc: add a symlink from rpc-client directory to the xprt_switch
Date:   Thu,  3 Jun 2021 18:20:34 -0400
Message-Id: <20210603222039.19182-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

An rpc client uses a transport switch and one ore more transports
associated with that switch. Since transports are shared among
rpc clients, create a symlink into the xprt_switch directory
instead of duplicating entries under each rpc client.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/clnt.c  |  2 +-
 net/sunrpc/sysfs.c | 22 ++++++++++++++++++++--
 net/sunrpc/sysfs.h |  6 +++++-
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 6f3f840a2ea3..9bf820bad84c 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -301,7 +301,6 @@ static int rpc_client_register(struct rpc_clnt *clnt,
 	int err;
 
 	rpc_clnt_debugfs_register(clnt);
-	rpc_sysfs_client_setup(clnt, net);
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
@@ -426,6 +425,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	/* save the nodename */
 	rpc_clnt_set_nodename(clnt, nodename);
 
+	rpc_sysfs_client_setup(clnt, xps, rpc_net_ns(clnt));
 	err = rpc_client_register(clnt, args->authflavor, args->client_name);
 	if (err)
 		goto out_no_path;
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index ed9f7131543f..0aa63747f496 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -151,14 +151,29 @@ rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
 	return NULL;
 }
 
-void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net)
+void rpc_sysfs_client_setup(struct rpc_clnt *clnt,
+			    struct rpc_xprt_switch *xprt_switch,
+			    struct net *net)
 {
 	struct rpc_sysfs_client *rpc_client;
 
-	rpc_client = rpc_sysfs_client_alloc(rpc_sunrpc_client_kobj, net, clnt->cl_clid);
+	rpc_client = rpc_sysfs_client_alloc(rpc_sunrpc_client_kobj,
+					    net, clnt->cl_clid);
 	if (rpc_client) {
+		char name[] = "switch";
+		struct rpc_sysfs_xprt_switch *xswitch =
+			(struct rpc_sysfs_xprt_switch *)xprt_switch->xps_sysfs;
+		int ret;
+
 		clnt->cl_sysfs = rpc_client;
+		rpc_client->clnt = clnt;
+		rpc_client->xprt_switch = xprt_switch;
 		kobject_uevent(&rpc_client->kobject, KOBJ_ADD);
+		ret = sysfs_create_link_nowarn(&rpc_client->kobject,
+					       &xswitch->kobject, name);
+		if (ret)
+			pr_warn("can't create link to %s in sysfs (%d)\n",
+				name, ret);
 	}
 }
 
@@ -189,6 +204,9 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
 	struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
 
 	if (rpc_client) {
+		char name[] = "switch";
+
+		sysfs_remove_link(&rpc_client->kobject, name);
 		kobject_uevent(&rpc_client->kobject, KOBJ_REMOVE);
 		kobject_del(&rpc_client->kobject);
 		kobject_put(&rpc_client->kobject);
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index 52ec472bd4a9..760f0582aee5 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -8,6 +8,8 @@
 struct rpc_sysfs_client {
 	struct kobject kobject;
 	struct net *net;
+	struct rpc_clnt *clnt;
+	struct rpc_xprt_switch *xprt_switch;
 };
 
 struct rpc_sysfs_xprt_switch {
@@ -20,7 +22,9 @@ struct rpc_sysfs_xprt_switch {
 int rpc_sysfs_init(void);
 void rpc_sysfs_exit(void);
 
-void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net);
+void rpc_sysfs_client_setup(struct rpc_clnt *clnt,
+			    struct rpc_xprt_switch *xprt_switch,
+			    struct net *net);
 void rpc_sysfs_client_destroy(struct rpc_clnt *clnt);
 void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
 				 struct rpc_xprt *xprt, gfp_t gfp_flags);
-- 
2.27.0

