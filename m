Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7D82F2208
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 22:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbhAKVnH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 16:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387864AbhAKVnG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 16:43:06 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A93C0617A3
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:51 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id y19so95345iov.2
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNu8WUHkgCExXTRUQefb0Olb+YUVP8ZChf3nHMznEj4=;
        b=JX3bPo2OZz8Y5XbZ22cEob2HRUYaprcQIVGsuQIKCi87xFu+VVXruwReXpQqc1Kfwf
         IATPqI46KmcqHh4feqW4wepHvtD+jN7YEk3mzVGodcoXiyfmhXXNDxnT97xc/DJDwZ9R
         RhktBxTZig8lcZowCcBV8FBJhM2TDtKwgGNwU9t7t7s/uhdF5kRx1bajMR4SG2eBxmxt
         Cgr+gnPjr7hilrWbCQPKFz4soYLKUjToSduka3er8nz6N0mYFeIm5h5h41Po87oNCDmU
         dwbu/SPk3Nq+9fObn7UzVaQSSsGIneGXhAN+VtWOMKavwVBi8fLlTMS22aYhZE1UWcZQ
         VuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bNu8WUHkgCExXTRUQefb0Olb+YUVP8ZChf3nHMznEj4=;
        b=UclsLrAV7NmZMtc6EfkwyQZnVx6397DdQTe5ag3FPliJj+ovvoL+UQ44xmuAlME4Oq
         qBYxiZQPiu1RmXfxnWnuUkjXhtHwvJtCeRnCIQ0Rf5U1tvFG+mv9Uf0D9DK/58uqzDPX
         Os+0n3WBwmSQbGku/9wVjndl7vw0wM9g0yIhIfD/WgfNguNwTDddW/g3QKqteO5JvLwI
         S+XGiDmk701J4GFiY/O2KNAPvsSEBAhq9tqdbwBo1iTsbfe2DeFTU5JMkphyxK86kU0m
         umh5Mm8WJFwrDJzCOCdhgdfEwvtafLoq4XpmXzA7G+Zms0aGaFDb0EaigNJA85UHEQdr
         Bb5w==
X-Gm-Message-State: AOAM53131giIX+TWtOzR1OtusLmjceupULFRts0HoQy3Ce1gGZ2bOngD
        nP2ULa1SmzngnP5syz/5XOm3AVCLGSqyJg==
X-Google-Smtp-Source: ABdhPJw/xxss9W1+wQhuj14BElzPZeXj2sqSSUJWaP2ZK7YNvbyew0SZn8SYWhpVp94G+ZyYvpK6+w==
X-Received: by 2002:a5e:de08:: with SMTP id e8mr944325iok.203.1610401310289;
        Mon, 11 Jan 2021 13:41:50 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 143sm681712ila.4.2021.01.11.13.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:41:49 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 5/7] sunrpc: Create a per-rpc_clnt file for managing the IP address
Date:   Mon, 11 Jan 2021 16:41:41 -0500
Message-Id: <20210111214143.553479-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

And since we're using IP here, restrict to only creating sysfs files for
TCP and RDMA connections.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/sysfs.c | 32 ++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index dd298b9c13e8..537d83635670 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2020 Anna Schumaker <Anna.Schumaker@Netapp.com>
  */
 #include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/addr.h>
 #include <net/sock.h>
 #include "sysfs.h"
 
@@ -55,6 +56,23 @@ int rpc_sysfs_init(void)
 	return 0;
 }
 
+static ssize_t rpc_netns_address_show(struct kobject *kobj,
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
+static ssize_t rpc_netns_address_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	return count;
+}
+
 static void rpc_netns_client_release(struct kobject *kobj)
 {
 	struct rpc_netns_client *c;
@@ -68,8 +86,17 @@ static const void *rpc_netns_client_namespace(struct kobject *kobj)
 	return container_of(kobj, struct rpc_netns_client, kobject)->net;
 }
 
+static struct kobj_attribute rpc_netns_client_address = __ATTR(address,
+		0644, rpc_netns_address_show, rpc_netns_address_store);
+
+static struct attribute *rpc_netns_client_attrs[] = {
+	&rpc_netns_client_address.attr,
+	NULL,
+};
+
 static struct kobj_type rpc_netns_client_type = {
 	.release = rpc_netns_client_release,
+	.default_attrs = rpc_netns_client_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_netns_client_namespace,
 };
@@ -100,10 +127,15 @@ static struct rpc_netns_client *rpc_netns_client_alloc(struct kobject *parent,
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

