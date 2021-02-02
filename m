Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A3D30CA55
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 19:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbhBBSpZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 13:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbhBBSnd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 13:43:33 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7745C061793
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 10:42:52 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id l23so15664252qtq.13
        for <linux-nfs@vger.kernel.org>; Tue, 02 Feb 2021 10:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQb0xnCqDeXmHQy6ABEXqRVe5Ozah2A2c9Qh6FPP7/Q=;
        b=eZ8/hXeezCtmm+7fZodHs9faaMKa8Rab1GNPLN/4VOsZwBvhD6qkkVfEXQ5I9Sbr+B
         QVX+vh7pal25wROgfLWkVgMWcEi3hakTF8Jr1L38XraL+mu+Qw5KcJAnFGX8gmyyMHHw
         wyVpBVQo4lp/H2cLJXV0NazuMl0hjW5k3gBapRFRyKLmD2bXt/IeoPBwmOtMPlCw2nEC
         zHtNmafr4aHQ+dzsVLyS4gVBlAi0zn3rnjkr4YwNQxcWDxHWFluXBjKH01iR94inKaZl
         a/EmwC67ZsD08S8eI2JZWRLifO9dKj6eXkZQds/y6YzTMq4/JA3euHaf1OLPADrTYNpq
         2LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dQb0xnCqDeXmHQy6ABEXqRVe5Ozah2A2c9Qh6FPP7/Q=;
        b=EYdYJLVc3OLcmtiPgpnas4WMAebABE1pgT81L1JwHVD4npzGRkA4hoQxhI+fcx0p3r
         Suq0rnA90Od3ZMxf6xmaOdYTx7WK5Xjv+V9yuaEWIQWfF9gPKKHS5kyTx8oSispj2e6d
         KGPTu8LamQuST7KHad5Xp6Kj5XOwKDj7bHh4ui6GlguOASczapk22QY8lVeWGBSYKzVc
         6OchJjZ2MVqApO49vQtKsjeij17sIDMCfKdlOHUibuen900Oa48YVLQ9Yosvx2/aG5gO
         UBiFxRUZ+UjwNs13hBQdjLdroVOiM8b6BgQh+AY+jTfAehRaTp69nikodKbFl+RyuCKI
         WFrQ==
X-Gm-Message-State: AOAM533+MMpWTMOVP1Y52gLAgpp5t55EzI0b5sYnCW6+DdonPtMddMZJ
        QiOZle/Qrh6rwE3OfuorUfsCRuHQxFTccw==
X-Google-Smtp-Source: ABdhPJz11lHvyzKEeIKu5kDaol/z5QI8/k9PEMgAh53peNvq7TaOQsoZEyqEnqfV+n7e/2dAYt7mAw==
X-Received: by 2002:ac8:6bcf:: with SMTP id b15mr21167736qtt.34.1612291371897;
        Tue, 02 Feb 2021 10:42:51 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id k4sm7415906qtq.13.2021.02.02.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:42:51 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 5/5] sunrpc: Create a per-rpc_clnt file for managing the destination IP address
Date:   Tue,  2 Feb 2021 13:42:44 -0500
Message-Id: <20210202184244.288898-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Reading the file displays the current destination address, and writing
to it allows users to change the address.

And since we're using IP here, restrict to only creating sysfs files for
TCP and RDMA connections.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v2: Change filename and related functions from "address" to "dstaddr"
    Combine patches for reading and writing to this file
---
 net/sunrpc/sysfs.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h |  1 +
 2 files changed, 48 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 42a690f8bb52..8b01b4df64ee 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2020 Anna Schumaker <Anna.Schumaker@Netapp.com>
  */
 #include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/addr.h>
+#include <linux/sunrpc/xprtsock.h>
 #include <linux/kobject.h>
 #include "sysfs.h"
 
@@ -55,6 +57,37 @@ int rpc_sysfs_init(void)
 	return 0;
 }
 
+static ssize_t rpc_netns_dstaddr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct rpc_netns_client *c = container_of(kobj,
+				struct rpc_netns_client, kobject);
+	struct rpc_clnt *clnt = c->clnt;
+	struct rpc_xprt *xprt = rcu_dereference(clnt->cl_xprt);
+
+	return rpc_ntop((struct sockaddr *)&xprt->addr, buf, PAGE_SIZE);
+}
+
+static ssize_t rpc_netns_dstaddr_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct rpc_netns_client *c = container_of(kobj,
+				struct rpc_netns_client, kobject);
+	struct rpc_clnt *clnt = c->clnt;
+	struct rpc_xprt *xprt = rcu_dereference(clnt->cl_xprt);
+	struct sockaddr *saddr = (struct sockaddr *)&xprt->addr;
+	int port = rpc_get_port(saddr);
+
+	xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr, sizeof(*saddr));
+	rpc_set_port(saddr, port);
+
+	kfree(xprt->address_strings[RPC_DISPLAY_ADDR]);
+	xprt->address_strings[RPC_DISPLAY_ADDR] = kstrndup(buf, count - 1, GFP_KERNEL);
+
+	xprt->ops->connect(xprt, NULL);
+	return count;
+}
+
 static void rpc_netns_client_release(struct kobject *kobj)
 {
 	struct rpc_netns_client *c;
@@ -68,8 +101,17 @@ static const void *rpc_netns_client_namespace(struct kobject *kobj)
 	return container_of(kobj, struct rpc_netns_client, kobject)->net;
 }
 
+static struct kobj_attribute rpc_netns_client_dstaddr = __ATTR(dstaddr,
+		0644, rpc_netns_dstaddr_show, rpc_netns_dstaddr_store);
+
+static struct attribute *rpc_netns_client_attrs[] = {
+	&rpc_netns_client_dstaddr.attr,
+	NULL,
+};
+
 static struct kobj_type rpc_netns_client_type = {
 	.release = rpc_netns_client_release,
+	.default_attrs = rpc_netns_client_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_netns_client_namespace,
 };
@@ -100,10 +142,15 @@ static struct rpc_netns_client *rpc_netns_client_alloc(struct kobject *parent,
 void rpc_netns_sysfs_setup(struct rpc_clnt *clnt, struct net *net)
 {
 	struct rpc_netns_client *rpc_client;
+	struct rpc_xprt *xprt = rcu_dereference(clnt->cl_xprt);
+
+	if (!(xprt->prot & (IPPROTO_TCP | XPRT_TRANSPORT_RDMA)))
+		return;
 
 	rpc_client = rpc_netns_client_alloc(rpc_client_kobj, net, clnt->cl_clid);
 	if (rpc_client) {
 		clnt->cl_sysfs = rpc_client;
+		rpc_client->clnt = clnt;
 		kobject_uevent(&rpc_client->kobject, KOBJ_ADD);
 	}
 }
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index 279a836594e7..137a12c87954 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -8,6 +8,7 @@
 struct rpc_netns_client {
 	struct kobject kobject;
 	struct net *net;
+	struct rpc_clnt *clnt;
 };
 
 extern struct kobject *rpc_client_kobj;
-- 
2.29.2

