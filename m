Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA52C361865
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 05:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbhDPDxE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 23:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbhDPDxE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 23:53:04 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2237CC061574
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:40 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id ef17so7178434qvb.0
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ts5a+/x/koZ8NpRDhRMR3xSogau9X7QWc2VvH/vpP3Q=;
        b=KJg/6KnXARA3MvHgnGs1ndzYCK3b4hCnWN2cme11u/43S7ITw5aKdAKpHSAgIFTsVL
         jyj4v3N5+1QC3ty3bAB3K9uDF0L0ApJT45gSNcV4Ar4FwFZyKi9/Tm7/kbwIsrja0Pmd
         7tH8cv0x+NO0fzwM8Lv/JosFh0/rJtA43imsCcVNAblM4Xc92qe/JYOl7iq9nMkfBxIq
         RdJSxBRYlMKaA8EPUftCM0xET1sIWHCQtHhES6tO9Pmli/GmzINiALKRPO+EqBQHPYbv
         zoAD30P7UuC98ZciCgjJvi+DgloGG8p+JhQGtz3HafcvC5TjxCvKXyduTX66kpMoNwDW
         mSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ts5a+/x/koZ8NpRDhRMR3xSogau9X7QWc2VvH/vpP3Q=;
        b=NikbAt/Dbu1n8AzQgcsiOvBbsis48HkofLLfbrP1rmd4JcsBQ+SWc3IJmzNe3pUDUw
         jq2ug/VxnXCc6B1ralYc//7Q/Vv1GuEogMKrED+v7b0XE1NjDze9/VzpvkkuEJOZJSi0
         MY+ap40CvJpEHb59eXlRd90O+zyV+gWrn0CiUqfWF6ntubgB+hdxFBJ8jyLbzQsxjRor
         AS6p2ocMsPnO19lfLDwj1FXBYvlytjYyC4OR3FVjxhR139abjUTC4Qf+OKpiUwGUF3zK
         hNFrJPXHeqllIB43lHqChyC/NTumqzre8UfGGUK8mNMuYujsT1Z7eah08u0Rps9S7HXa
         QSWQ==
X-Gm-Message-State: AOAM530D+V3p+HslQ/hIkSJfHiWg9mDAZv73LjQ470AIn+/WS4we1HUN
        rJumdqw4eBtZoBwFhaAPQLct3XF5vVQ=
X-Google-Smtp-Source: ABdhPJwX3w0QB2NI9tC9mqL5n6i4jVJjGNYNFnxOWjetSBXeIXuxNyDeNxRnhY+keJbCx2nRyuty7g==
X-Received: by 2002:ad4:458b:: with SMTP id x11mr6527838qvu.36.1618545159365;
        Thu, 15 Apr 2021 20:52:39 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id x82sm3500913qkb.0.2021.04.15.20.52.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 20:52:38 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 09/13] sunrpc: add a symlink from rpc-client directory to the xprt_switch
Date:   Thu, 15 Apr 2021 23:52:22 -0400
Message-Id: <20210416035226.53588-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
References: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/sysfs.c | 25 +++++++++++++++++++++++--
 net/sunrpc/sysfs.h |  6 +++++-
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index ceb8d19d4cb4..fad87dba5114 100644
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
index 0c34330714ab..ce2cad1b6aa6 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -149,14 +149,30 @@ rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
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
+		char name[23];
+		struct rpc_sysfs_xprt_switch *xswitch =
+			(struct rpc_sysfs_xprt_switch *)xprt_switch->xps_sysfs;
+		int ret;
+
 		clnt->cl_sysfs = rpc_client;
+		rpc_client->clnt = clnt;
+		rpc_client->xprt_switch = xprt_switch;
 		kobject_uevent(&rpc_client->kobject, KOBJ_ADD);
+		snprintf(name, sizeof(name), "switch-%d", xprt_switch->xps_id);
+		ret = sysfs_create_link_nowarn(&rpc_client->kobject,
+					       &xswitch->kobject, name);
+		if (ret)
+			pr_warn("can't create link to %s in sysfs (%d)\n",
+				name, ret);
 	}
 }
 
@@ -186,6 +202,11 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
 	struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
 
 	if (rpc_client) {
+		char name[23];
+
+		snprintf(name, sizeof(name), "switch-%d",
+			 rpc_client->xprt_switch->xps_id);
+		sysfs_remove_link(&rpc_client->kobject, name);
 		kobject_uevent(&rpc_client->kobject, KOBJ_REMOVE);
 		kobject_del(&rpc_client->kobject);
 		kobject_put(&rpc_client->kobject);
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index 9b6acd3fd3dc..9a0625b1cd65 100644
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
 				 struct rpc_xprt *xprt);
-- 
2.27.0

