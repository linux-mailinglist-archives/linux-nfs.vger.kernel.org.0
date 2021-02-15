Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C8831C0CF
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhBORlH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 12:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhBORkv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 12:40:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43836C061786
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v9so4721827edw.8
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vOEnK2HsKBbY/sCYpmM2/D5Q9BpmbWCzs85+zBCCgE=;
        b=MJ9dtjaFn157TCktfgAYZ+5dgsyU5H8/VqNXdE2m0D9zXfNn4xe32xgRnuBT1yvJJJ
         /E7VbLo6E+C0MGlqtsBSSfwwx4dezgy3nvRRqwu2j2a9cVqXoKE8PDFuMh3r3IiEOdAt
         bGyZXlO6k5VWCeVs5EdNe6awWpNRwvi6os+JzYjb0MZHKDgvlIixMed8/wCKb7NOijqx
         sw6mkc2GOUZaJYTw8IZUV2j7EHF/+3K9PRcYf9DK6/FZlAYN2pfnyIhywuezpY6ey8iq
         Q9FE995nTqpL4aqkErQhrBKI779DU3UPRv6sKTdObZG9EO2mmoAO994qi/RbGVFRZYyb
         4Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vOEnK2HsKBbY/sCYpmM2/D5Q9BpmbWCzs85+zBCCgE=;
        b=JoJr5jHXzGsX78doOKv9Aea+FIhUZG95oxgjKNXoOYHgsODw08z17OYcOE8Vw4+91+
         gE9mnPb9n6V3M48hhBgJXdAXRKo3YJbAAWTNAnN4cvEWhzw/lHYxipvE3JkEb/BnEgZQ
         no884tyTr0qaYcysj6EIxsmx5HlV87ZT9Rl7Cfb8LlYDikD+FVaTUVWkNQcsWthRJsIM
         9nQ51RY+0rXnxjtLT1swWgDURI5t4iJaxvhNZ2YlQeMWBz7tsbTpukXVxFMcFESMKe0k
         avnFEB3BoHJzKugnlQb3aXPrMHqZQ4bWAdu33wxE4XmnsZ4YLXpvVjuK2sxsif5jPWDS
         6cNA==
X-Gm-Message-State: AOAM533b+oPvAeN3DfM2OvcBNeZsTAzx3gOuZVKsnrK3pPiqkjWRXGEi
        VsoHU0sAl9VyfZBQelu+YelyywkOMisF3g==
X-Google-Smtp-Source: ABdhPJzubm601LVYfs/wpUSj76p1RNRzUtW9CZux+8+I5eQjCjib95SSpAusR6dgKF+GBvtOQ2l1dw==
X-Received: by 2002:aa7:cd8d:: with SMTP id x13mr16545579edv.286.1613410808805;
        Mon, 15 Feb 2021 09:40:08 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id e11sm11257485ejz.94.2021.02.15.09.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:40:08 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH v1 3/8] sunrpc: add a directory per sunrpc xprt
Date:   Mon, 15 Feb 2021 19:39:57 +0200
Message-Id: <20210215174002.2376333-4-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210215174002.2376333-1-dan@kernelim.com>
References: <20210215174002.2376333-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This uses much of the code from the per-client directory, except that
now we have direct access to the transport struct. The per-client
direct is adjusted in a subsequent commit.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 include/linux/sunrpc/xprt.h |   1 +
 net/sunrpc/sysfs.c          | 131 ++++++++++++++++++++++++++++++++++--
 net/sunrpc/sysfs.h          |   9 +++
 net/sunrpc/xprt.c           |   3 +
 4 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index fbf57a87dc47..df0252de58f4 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -260,6 +260,7 @@ struct rpc_xprt {
 						 * items */
 	struct list_head	bc_pa_list;	/* List of preallocated
 						 * backchannel rpc_rqst's */
+	void			*sysfs;         /* /sys/kernel/sunrpc/xprt/<id> */
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 
 	struct rb_root		recv_queue;	/* Receive queue */
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 3fe814795ed9..687d4470b90d 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -9,6 +9,7 @@
 #include "sysfs.h"
 
 struct kobject *rpc_client_kobj;
+struct kobject *rpc_xprt_kobj;
 static struct kset *rpc_sunrpc_kset;
 
 static void rpc_netns_object_release(struct kobject *kobj)
@@ -48,13 +49,24 @@ int rpc_sysfs_init(void)
 	rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
 	if (!rpc_sunrpc_kset)
 		return -ENOMEM;
+
 	rpc_client_kobj = rpc_netns_object_alloc("client", rpc_sunrpc_kset, NULL);
-	if (!rpc_client_kobj) {
-		kset_unregister(rpc_sunrpc_kset);
-		rpc_sunrpc_kset = NULL;
-		return -ENOMEM;
-	}
+	if (!rpc_client_kobj)
+		goto err_kset;
+
+	rpc_xprt_kobj = rpc_netns_object_alloc("transport", rpc_sunrpc_kset, NULL);
+	if (!rpc_xprt_kobj)
+		goto err_client;
+
 	return 0;
+
+err_client:
+	kobject_put(rpc_client_kobj);
+	rpc_client_kobj = NULL;
+err_kset:
+	kset_unregister(rpc_sunrpc_kset);
+	rpc_sunrpc_kset = NULL;
+	return -ENOMEM;
 }
 
 static ssize_t rpc_netns_dstaddr_show(struct kobject *kobj,
@@ -118,6 +130,7 @@ static struct kobj_type rpc_netns_client_type = {
 
 void rpc_sysfs_exit(void)
 {
+	kobject_put(rpc_xprt_kobj);
 	kobject_put(rpc_client_kobj);
 	kset_unregister(rpc_sunrpc_kset);
 }
@@ -166,3 +179,111 @@ void rpc_netns_client_sysfs_destroy(struct rpc_clnt *clnt)
 		clnt->cl_sysfs = NULL;
 	}
 }
+
+static ssize_t rpc_netns_xprt_dstaddr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct rpc_netns_xprt *c = container_of(kobj,
+				struct rpc_netns_xprt, kobject);
+	struct rpc_xprt *xprt = c->xprt;
+
+	if (!(xprt->prot & (IPPROTO_TCP | XPRT_TRANSPORT_RDMA))) {
+		sprintf(buf, "N/A");
+		return 0;
+	}
+
+	return rpc_ntop((struct sockaddr *)&xprt->addr, buf, PAGE_SIZE);
+}
+
+static ssize_t rpc_netns_xprt_dstaddr_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct rpc_netns_xprt *c = container_of(kobj,
+				struct rpc_netns_xprt, kobject);
+	struct rpc_xprt *xprt = c->xprt;
+	struct sockaddr *saddr = (struct sockaddr *)&xprt->addr;
+	int port;
+
+	if (!(xprt->prot & (IPPROTO_TCP | XPRT_TRANSPORT_RDMA)))
+		return -EINVAL;
+
+	port = rpc_get_port(saddr);
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
+static void rpc_netns_xprt_release(struct kobject *kobj)
+{
+	struct rpc_netns_xprt *c;
+
+	c = container_of(kobj, struct rpc_netns_xprt, kobject);
+	kfree(c);
+}
+
+static const void *rpc_netns_xprt_namespace(struct kobject *kobj)
+{
+	return container_of(kobj, struct rpc_netns_xprt, kobject)->net;
+}
+
+static struct kobj_attribute rpc_netns_xprt_dstaddr = __ATTR(dstaddr,
+		0644, rpc_netns_xprt_dstaddr_show, rpc_netns_xprt_dstaddr_store);
+
+static struct attribute *rpc_netns_xprt_attrs[] = {
+	&rpc_netns_xprt_dstaddr.attr,
+	NULL,
+};
+
+static struct kobj_type rpc_netns_xprt_type = {
+	.release = rpc_netns_xprt_release,
+	.default_attrs = rpc_netns_xprt_attrs,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.namespace = rpc_netns_xprt_namespace,
+};
+
+static struct rpc_netns_xprt *rpc_netns_xprt_alloc(struct kobject *parent,
+						   struct net *net, int id)
+{
+	struct rpc_netns_xprt *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (p) {
+		p->net = net;
+		p->kobject.kset = rpc_sunrpc_kset;
+		if (kobject_init_and_add(&p->kobject, &rpc_netns_xprt_type,
+					 parent, "%d", id) == 0)
+			return p;
+		kobject_put(&p->kobject);
+	}
+	return NULL;
+}
+
+void rpc_netns_xprt_sysfs_setup(struct rpc_xprt *xprt, struct net *net)
+{
+	struct rpc_netns_xprt *rpc_xprt;
+
+	rpc_xprt = rpc_netns_xprt_alloc(rpc_xprt_kobj, net, xprt->id);
+	if (rpc_xprt) {
+		xprt->sysfs = rpc_xprt;
+		rpc_xprt->xprt = xprt;
+		kobject_uevent(&rpc_xprt->kobject, KOBJ_ADD);
+	}
+}
+
+void rpc_netns_xprt_sysfs_destroy(struct rpc_xprt *xprt)
+{
+	struct rpc_netns_xprt *rpc_xprt = xprt->sysfs;
+
+	if (rpc_xprt) {
+		kobject_uevent(&rpc_xprt->kobject, KOBJ_REMOVE);
+		kobject_del(&rpc_xprt->kobject);
+		kobject_put(&rpc_xprt->kobject);
+		xprt->sysfs = NULL;
+	}
+}
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index ab75c3cc91b6..e08dd7f6a1ec 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -11,12 +11,21 @@ struct rpc_netns_client {
 	struct rpc_clnt *clnt;
 };
 
+struct rpc_netns_xprt {
+	struct kobject kobject;
+	struct net *net;
+	struct rpc_xprt *xprt;
+};
+
 extern struct kobject *rpc_client_kobj;
+extern struct kobject *rpc_xprt_kobj;
 
 extern int rpc_sysfs_init(void);
 extern void rpc_sysfs_exit(void);
 
 void rpc_netns_client_sysfs_setup(struct rpc_clnt *clnt, struct net *net);
 void rpc_netns_client_sysfs_destroy(struct rpc_clnt *clnt);
+void rpc_netns_xprt_sysfs_setup(struct rpc_xprt *xprt, struct net *net);
+void rpc_netns_xprt_sysfs_destroy(struct rpc_xprt *xprt);
 
 #endif
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index e30acd1f0e31..4098cb6b1453 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -55,6 +55,7 @@
 #include <trace/events/sunrpc.h>
 
 #include "sunrpc.h"
+#include "sysfs.h"
 
 /*
  * Local variables
@@ -1768,6 +1769,7 @@ struct rpc_xprt *xprt_alloc(struct net *net, size_t size,
 		xprt->max_reqs = num_prealloc;
 	xprt->min_reqs = num_prealloc;
 	xprt->num_reqs = num_prealloc;
+	rpc_netns_xprt_sysfs_setup(xprt, net);
 
 	return xprt;
 
@@ -1780,6 +1782,7 @@ EXPORT_SYMBOL_GPL(xprt_alloc);
 
 void xprt_free(struct rpc_xprt *xprt)
 {
+	rpc_netns_xprt_sysfs_destroy(xprt);
 	put_net(xprt->xprt_net);
 	xprt_free_all_slots(xprt);
 	xprt_free_id(xprt);
-- 
2.26.2

