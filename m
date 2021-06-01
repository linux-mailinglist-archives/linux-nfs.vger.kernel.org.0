Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F44397C41
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 00:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhFAWL1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 18:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhFAWL0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 18:11:26 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8C4C061756
        for <linux-nfs@vger.kernel.org>; Tue,  1 Jun 2021 15:09:43 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j189so468333qkf.2
        for <linux-nfs@vger.kernel.org>; Tue, 01 Jun 2021 15:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94soqXL6YeuBIGDbnyeIBNAXPOYxIGr0JRdKAVfQ/L8=;
        b=INc0oQYh6rkAZusupnjujy+Jb5IgHyvxdjjeVQPVQfUuo699QaFvgtKlqtkmtyBNv1
         xTT7vH8Hk0zDVKyEeNBqpDrDCyucPRulRDgk2LxyOj+dI3LPtyUm/D4+i6tQ1sWbFWcj
         WpEUl+bFD9qDhEfnVmYscWLkDOgY3OcyLsA1DrTLGqdl3fcXws/HPoN4CGhgQ46VifS2
         kx4FKsuw8WMvQCDv3OHswHYTxEIKFYrj2hqivb8fkCS+FWaz+m2N0vrRCI1KdzDWojcM
         9Jke2reBxLi8DQzFVlu5TtETCusW2MNGbw6coZGWrQ8TaMptZbjJ99in1ijQ7MEadpAN
         e5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94soqXL6YeuBIGDbnyeIBNAXPOYxIGr0JRdKAVfQ/L8=;
        b=DjjziYo5fjNwPxqHWor9/h+GWuzN3B/Svnq8PxZinByDVDC3F/Pg3Ma2jtnFiuqdCr
         /YUAXXenOuKqSnnIPl9fOSuzgK5kBwy3NlctoQ1rNjdSSKz2N+cELJ3kYOW1nZBDMSqt
         LcXD2q73wweEdfUTWSyNAIRXJk9RJSoc0ci56BlGBGProVnP61z1wbC0Y6gWCH6621F2
         eO9qG5sR2Hr6c5cu+EsSDFa+P6JyxznKxz4dJlZyvKsLH86A6S6sfF2wepH649wk4p2/
         zdL6NMIKkLqXaAS4fC77yqwreu3wtTmQPZczBfcdvCb76h9LA/+Q0xZqE3eKkS/NM2oX
         /m5w==
X-Gm-Message-State: AOAM533qbkrtT5AvftT9WSBR+ZyxpXQ/jr6zq/FzqynSOVq/ecpaHn02
        hcedqOLoicxTC4hn6s1FD3U=
X-Google-Smtp-Source: ABdhPJzJxJBQS4WVrQ4DUfxYGkDIRfsB4jGUcxkU5j5i22K0/Fh5P1dZuoAzzNdZ0m0eo9CKJk47Fg==
X-Received: by 2002:a37:f60e:: with SMTP id y14mr4247963qkj.459.1622585382687;
        Tue, 01 Jun 2021 15:09:42 -0700 (PDT)
Received: from kolga-mac-1.lan (50-124-240-218.alma.mi.frontiernet.net. [50.124.240.218])
        by smtp.gmail.com with ESMTPSA id q13sm12419789qkn.10.2021.06.01.15.09.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 15:09:42 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 08/13] sunrpc: add a symlink from rpc-client directory to the xprt_switch
Date:   Tue,  1 Jun 2021 18:09:10 -0400
Message-Id: <20210601220915.18975-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
References: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
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

