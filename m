Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A211339904
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 22:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhCLVS5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 16:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbhCLVSe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 16:18:34 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD8C061761
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:18:33 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id h13so4971460qvu.6
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzNFTGct5MhKKiBQpMofrakEf443iloQC0nODv3x+L4=;
        b=NVRMiEy6/+Ut5EICf6B/eN9+F6xTdeaWivoUQ8YW3D4Ix5ixVSPlE85U72pTryDp1e
         ZHbpeL2BhorjdFrwMG/Fq7qTFE5DC9NkhJD1B2ge/C40FcrhwtPCwh+czrYEaUIsy3Wr
         xDP8Eha5ZZXNHGe+HokLADxLoqF1rwKeqP/Fwt82nb9DO0QpnxeZuIY/EARVh/KGwCKj
         4l1/A9wcWaFs5LfDurigSTUoANEf7yc3E84YKsoW9RvGOzd+dpXzrSEOYk/8ejeKMX4Q
         /KpuZFmtVOSwSsuy77xDnZHMRaPsVaSJvnGUVjKOzj76bMz17uqNzxvY1pfbIGwn88p5
         Jruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BzNFTGct5MhKKiBQpMofrakEf443iloQC0nODv3x+L4=;
        b=HeowwfQ+52QRHb5JMXfLi8xtPfpIvEF3Vm54xZTuV5IZ4zBvA0UY+M7BsiRYHni21x
         r2hRX4iNCPyxBDKyrkz9hC0z4UROqxhiO+OfIhm9GsFm+ur/5KWWMw2Q9zgbiryxlONf
         DIUxPwG665zqxtSc07zsyOYScFmx5v23h8K9fd138fK91PDfU9zR1E5DQiQ5Ui5HeI7O
         gikYTAa9bIFla52lwMDuKdVzPMZ7SUoJTc1g3SBpb68Syezb5qbnLtSaLY8vqw56nmVs
         unbc46hnFmqZzvdboSiqEM0RqYPLHk25hPu/0IURD1xwNSLpH6IhU6M/W/H6+UO54nMe
         6dwg==
X-Gm-Message-State: AOAM530eEWJ0NUlAnXBaMaqTgIu6nsmRMlsn2g6WFeRcpXjZuQN2s3OW
        zFISQGuzEH5ZdBSTX5QyqEC+2MNoPHYRYA==
X-Google-Smtp-Source: ABdhPJwKd5C+9grOEfQ1SKXSAZFuZC3yyvvtnPHpuufX8+QkvyfpUoMg2bdJmLhzxX/IppY3Y885Kg==
X-Received: by 2002:ad4:4e23:: with SMTP id dm3mr14199333qvb.4.1615583912690;
        Fri, 12 Mar 2021 13:18:32 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id d24sm5177490qko.54.2021.03.12.13.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 13:18:32 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 5/5] sunrpc: Create a per-rpc_clnt file for managing the destination IP address
Date:   Fri, 12 Mar 2021 16:18:26 -0500
Message-Id: <20210312211826.360959-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
References: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
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
v3: Fix suspicious RCU usage warnings
    Fix up xprt locking and reference counting
    s/netns/sysfs/
    Unconditionally create files instead of looking at protocol type
        during client setup (this makes it easier for userspace tools)
    Add a newline character to the buffer returned in "show" handler
v2: Change filename and related functions from "address" to "dstaddr"
    Combine patches for reading and writing to this file
---
 net/sunrpc/sysfs.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h |  1 +
 2 files changed, 71 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index abfe8c0b3108..1ae15c4729c0 100644
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
 
@@ -55,6 +57,64 @@ int rpc_sysfs_init(void)
 	return 0;
 }
 
+static inline struct rpc_xprt *rpc_sysfs_client_kobj_get_xprt(struct kobject *kobj)
+{
+	struct rpc_sysfs_client *c = container_of(kobj,
+				struct rpc_sysfs_client, kobject);
+	struct rpc_xprt *xprt;
+
+	rcu_read_lock();
+	xprt = xprt_get(rcu_dereference(c->clnt->cl_xprt));
+	rcu_read_unlock();
+	return xprt;
+}
+
+static ssize_t rpc_sysfs_dstaddr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_client_kobj_get_xprt(kobj);
+	ssize_t ret;
+
+	if (!xprt)
+		return 0;
+	if (!(xprt->prot & (IPPROTO_TCP | XPRT_TRANSPORT_RDMA)))
+		ret = sprintf(buf, "Not Supported");
+	else
+		ret = rpc_ntop((struct sockaddr *)&xprt->addr, buf, PAGE_SIZE);
+	buf[ret] = '\n';
+	xprt_put(xprt);
+	return ret + 1;
+}
+
+static ssize_t rpc_sysfs_dstaddr_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_client_kobj_get_xprt(kobj);
+	struct sockaddr *saddr;
+	int port;
+
+	if (!xprt)
+		return 0;
+	if (!(xprt->prot & (IPPROTO_TCP | XPRT_TRANSPORT_RDMA))) {
+		xprt_put(xprt);
+		return -ENOTSUPP;
+	}
+
+	wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE);
+	saddr = (struct sockaddr *)&xprt->addr;
+	port = rpc_get_port(saddr);
+
+	kfree(xprt->address_strings[RPC_DISPLAY_ADDR]);
+	xprt->address_strings[RPC_DISPLAY_ADDR] = kstrndup(buf, count - 1, GFP_KERNEL);
+	xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr, sizeof(*saddr));
+	rpc_set_port(saddr, port);
+
+	xprt->ops->connect(xprt, NULL);
+	clear_bit(XPRT_LOCKED, &xprt->state);
+	xprt_put(xprt);
+	return count;
+}
+
 static void rpc_sysfs_client_release(struct kobject *kobj)
 {
 	struct rpc_sysfs_client *c;
@@ -68,8 +128,17 @@ static const void *rpc_sysfs_client_namespace(struct kobject *kobj)
 	return container_of(kobj, struct rpc_sysfs_client, kobject)->net;
 }
 
+static struct kobj_attribute rpc_sysfs_client_dstaddr = __ATTR(dstaddr,
+		0644, rpc_sysfs_dstaddr_show, rpc_sysfs_dstaddr_store);
+
+static struct attribute *rpc_sysfs_client_attrs[] = {
+	&rpc_sysfs_client_dstaddr.attr,
+	NULL,
+};
+
 static struct kobj_type rpc_sysfs_client_type = {
 	.release = rpc_sysfs_client_release,
+	.default_attrs = rpc_sysfs_client_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_client_namespace,
 };
@@ -104,6 +173,7 @@ void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net)
 	rpc_client = rpc_sysfs_client_alloc(rpc_sunrpc_client_kobj, net, clnt->cl_clid);
 	if (rpc_client) {
 		clnt->cl_sysfs = rpc_client;
+		rpc_client->clnt = clnt;
 		kobject_uevent(&rpc_client->kobject, KOBJ_ADD);
 	}
 }
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index 443679d71f38..5093f93a83cb 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -8,6 +8,7 @@
 struct rpc_sysfs_client {
 	struct kobject kobject;
 	struct net *net;
+	struct rpc_clnt *clnt;
 };
 
 extern int rpc_sysfs_init(void);
-- 
2.29.2

