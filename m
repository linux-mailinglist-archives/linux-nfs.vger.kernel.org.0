Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CD231C0D1
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 18:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhBORlS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 12:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhBORkw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 12:40:52 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749A6C061788
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id y26so12462432eju.13
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+mPZIGjaM6z+1A3zSLRNc6/eBHpbPT5IAsVWg1K64U=;
        b=jfpHf66T/7XIYphGMhf1IufHW+u5zu6HAX8mwLHh0zz14Ep/oHH3vHIXBYNbQWVhdK
         zWCJVovoPpvQuTTRVeKm5gawmb26C0HX5Fa/zPejUnrHrZzTjGcRLDhR88WmD7QnRlPb
         Wnh58x5xsd8WG2ISL3fbC9PNKEms9htYv5czeyWHIPryFxbhUU+oL4Uaf4gCULSDHLZQ
         5WmdGHZkmtLxQWYfDVOfw0ZVtm3unxbflABycvjQco7/w+NCQ6lajgsTnephX5lMRrf+
         gDfBHwvuDiZY+s4lqQ4bye+A4tygUf3khlcWiVIWzxAASp7DzMtxDLUcGpvbykEs7rql
         C1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+mPZIGjaM6z+1A3zSLRNc6/eBHpbPT5IAsVWg1K64U=;
        b=oELnmZc42JXP5bQIVtMBlC+f3gL15slvcRMyK1mOpmJtRh8TRj6PrArKd1bNK0xPcq
         cuuf8HpB/2tpzOD6NubtXk5IHuJbjgKfZtiNlFVENX3gE0X/JoN3QAOvd7tKKc/BRiD1
         HOrG5pY4gOUNzccVVD00IALDpZICdF43YOyePSXZvv7jI16YjNbFzglFP8b0i8uxteeb
         cn1uI/kzk6F2DmlSe6sAic4Ki7vR5Ye2duXQS55TC7J0JpvqEzALhWcGoZsIvu4qW0tT
         WT4iQqXcYyS4ge5PDyw+SZebNsQbtsuu2vQWHgnkDTAH2BzFYRi7nTLYoae6IS4TOu2L
         jXoQ==
X-Gm-Message-State: AOAM531PXkSa78BzdNK7/SLe8uKQlZodUcgqJMaXmrnlS/iWUzh0fja6
        Rdl9yWalqihI2RGNodceSoB6bcjxbdq/tg==
X-Google-Smtp-Source: ABdhPJy7ZaSo9uY3aCbQA4eanVVzrtdqFnS23X0aQauleD3LiVhDdiU/AF+Q+XW74JL0cWf5ikubHA==
X-Received: by 2002:a17:906:708e:: with SMTP id b14mr10042084ejk.325.1613410809913;
        Mon, 15 Feb 2021 09:40:09 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id e11sm11257485ejz.94.2021.02.15.09.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:40:09 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH v1 4/8] sunrpc: have client directory a symlink to the root transport
Date:   Mon, 15 Feb 2021 19:39:58 +0200
Message-Id: <20210215174002.2376333-5-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210215174002.2376333-1-dan@kernelim.com>
References: <20210215174002.2376333-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Instead of duplicating `dstaddr` in client directory, we add a symlink
to the relevant transport directory which now hosts a `dstaddr`.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 net/sunrpc/sysfs.c | 44 ++++++--------------------------------------
 1 file changed, 6 insertions(+), 38 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 687d4470b90d..ae608235d7e0 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -69,37 +69,6 @@ int rpc_sysfs_init(void)
 	return -ENOMEM;
 }
 
-static ssize_t rpc_netns_dstaddr_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct rpc_netns_client *c = container_of(kobj,
-				struct rpc_netns_client, kobject);
-	struct rpc_clnt *clnt = c->clnt;
-	struct rpc_xprt *xprt = rcu_dereference(clnt->cl_xprt);
-
-	return rpc_ntop((struct sockaddr *)&xprt->addr, buf, PAGE_SIZE);
-}
-
-static ssize_t rpc_netns_dstaddr_store(struct kobject *kobj,
-		struct kobj_attribute *attr, const char *buf, size_t count)
-{
-	struct rpc_netns_client *c = container_of(kobj,
-				struct rpc_netns_client, kobject);
-	struct rpc_clnt *clnt = c->clnt;
-	struct rpc_xprt *xprt = rcu_dereference(clnt->cl_xprt);
-	struct sockaddr *saddr = (struct sockaddr *)&xprt->addr;
-	int port = rpc_get_port(saddr);
-
-	xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr, sizeof(*saddr));
-	rpc_set_port(saddr, port);
-
-	kfree(xprt->address_strings[RPC_DISPLAY_ADDR]);
-	xprt->address_strings[RPC_DISPLAY_ADDR] = kstrndup(buf, count - 1, GFP_KERNEL);
-
-	xprt->ops->connect(xprt, NULL);
-	return count;
-}
-
 static void rpc_netns_client_release(struct kobject *kobj)
 {
 	struct rpc_netns_client *c;
@@ -113,11 +82,7 @@ static const void *rpc_netns_client_namespace(struct kobject *kobj)
 	return container_of(kobj, struct rpc_netns_client, kobject)->net;
 }
 
-static struct kobj_attribute rpc_netns_client_dstaddr = __ATTR(dstaddr,
-		0644, rpc_netns_dstaddr_show, rpc_netns_dstaddr_store);
-
 static struct attribute *rpc_netns_client_attrs[] = {
-	&rpc_netns_client_dstaddr.attr,
 	NULL,
 };
 
@@ -156,12 +121,14 @@ void rpc_netns_client_sysfs_setup(struct rpc_clnt *clnt, struct net *net)
 {
 	struct rpc_netns_client *rpc_client;
 	struct rpc_xprt *xprt = rcu_dereference(clnt->cl_xprt);
-
-	if (!(xprt->prot & (IPPROTO_TCP | XPRT_TRANSPORT_RDMA)))
-		return;
+	struct rpc_netns_xprt *rpc_xprt;
+	int ret;
 
 	rpc_client = rpc_netns_client_alloc(rpc_client_kobj, net, clnt->cl_clid);
 	if (rpc_client) {
+		rpc_xprt = xprt->sysfs;
+		ret = sysfs_create_link_nowarn(&rpc_client->kobject,
+					 &rpc_xprt->kobject, "transport");
 		clnt->cl_sysfs = rpc_client;
 		rpc_client->clnt = clnt;
 		kobject_uevent(&rpc_client->kobject, KOBJ_ADD);
@@ -173,6 +140,7 @@ void rpc_netns_client_sysfs_destroy(struct rpc_clnt *clnt)
 	struct rpc_netns_client *rpc_client = clnt->cl_sysfs;
 
 	if (rpc_client) {
+		sysfs_remove_link(&rpc_client->kobject, "transport");
 		kobject_uevent(&rpc_client->kobject, KOBJ_REMOVE);
 		kobject_del(&rpc_client->kobject);
 		kobject_put(&rpc_client->kobject);
-- 
2.26.2

