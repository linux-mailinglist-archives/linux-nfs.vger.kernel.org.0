Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C806361867
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 05:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhDPDxI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 23:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbhDPDxH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 23:53:07 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE7EC061756
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q136so6680307qka.7
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhUKnhhQeCh3QJQf/+9hIM+apAgNWCwoddh+vtDioQY=;
        b=QVzOejow4qEO0MZKhv+M7dsi7rYZvHnnYznKd6zUmsIkuoxpQAgfyRbDywnm8RsLuo
         DdN3LIhW4Wyq2mObpOtDaHlkHOlVxEWGVkTD4e4qUp+W/Zomg9UeB056Dr58qZHq+Lm3
         XdEtpd8cSqbVwaUnFfWxTx0uXYjUnt+exYs1D5rYiwEKlP3xfwHeI5oDnAmQVPkegm8A
         rVdPnd45a/qqKSwAYAuD731oJHvLKJZx6jRn4s/8ZB+ZWXzzXMp+tODUrSRIy+taYYkI
         h7dHIunB+NjYm2H+DVuk/nhrsYEFw7qxPCbXSOwK+8pSgyplAaFY8XpGMl78UATRxkqm
         prDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhUKnhhQeCh3QJQf/+9hIM+apAgNWCwoddh+vtDioQY=;
        b=Mp5DUr1H0EMQ5SqWe8cZM10d7b7LHP2g7+I+4+737Eqts4AZopUiJb1pEfQCTPWGOl
         oG11Z1GpopcRPyGpsbFC5/BEU5K5/ExRNy1OhDZAu1epgyGI+i7Rt8O/MG2gDCp+cg8O
         qgrC2iddJNWxUpuo6vC5bY3TZQA3KG4cO29V6HrdLBMlM2n1JPZ7Z1bJvCkHrHFK8w8P
         tYRSdHNEuCF93oJ/h72/q1uLae0hPIUQ32L0AueIbEAfF6yQzenaTqrtkOK05JYyNKhW
         W085IAeavr4bOz3tmIafFwPrqk9T80w9lvI5s31bENhxEYfcVqpgAlgRBIBRKk4jg3P2
         kaOg==
X-Gm-Message-State: AOAM530vP4NSkSJuKeRPphCGPP3LBcwhGM84yYuwdrliLd9wvy1wOawG
        gQP8n8m39wFhH0DsjS6/Uxpi/VRx0Ag=
X-Google-Smtp-Source: ABdhPJyGz0FctfeCdtQtXp59Clt3yhiuaEN1b/A3w6N+YYzrl/I0R9RL+DZaoTaWZJvd3v01SEbhHw==
X-Received: by 2002:a37:9a0f:: with SMTP id c15mr6989543qke.14.1618545161774;
        Thu, 15 Apr 2021 20:52:41 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id x82sm3500913qkb.0.2021.04.15.20.52.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 20:52:41 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 11/13] sunrpc: add dst_attr attributes to the sysfs xprt directory
Date:   Thu, 15 Apr 2021 23:52:24 -0400
Message-Id: <20210416035226.53588-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
References: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Allow to query and set the destination's address of a transport.
Setting of the destination address is allowed only for TCP or RDMA
based connections.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/sysfs.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 5410d8fe1181..20c622c3330e 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -4,6 +4,9 @@
  */
 #include <linux/sunrpc/clnt.h>
 #include <linux/kobject.h>
+#include <linux/sunrpc/addr.h>
+#include <linux/sunrpc/xprtsock.h>
+
 #include "sysfs.h"
 
 static struct kset *rpc_sunrpc_kset;
@@ -42,6 +45,66 @@ static struct kobject *rpc_sysfs_object_alloc(const char *name,
 	return NULL;
 }
 
+static inline struct rpc_xprt *
+rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
+{
+	struct rpc_sysfs_xprt_switch_xprt *x = container_of(kobj,
+		struct rpc_sysfs_xprt_switch_xprt, kobject);
+
+	return xprt_get(x->xprt);
+}
+
+static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   char *buf)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	ssize_t ret;
+
+	if (!xprt)
+		return 0;
+	if (xprt->xprt_class->ident == XPRT_TRANSPORT_LOCAL)
+		ret = sprintf(buf, "localhost");
+	else
+		ret = rpc_ntop((struct sockaddr *)&xprt->addr, buf, PAGE_SIZE);
+	buf[ret] = '\n';
+	xprt_put(xprt);
+	return ret + 1;
+}
+
+static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	struct sockaddr *saddr;
+	int port;
+
+	if (!xprt)
+		return 0;
+	if (!(xprt->xprt_class->ident == XPRT_TRANSPORT_TCP ||
+	      xprt->xprt_class->ident == XPRT_TRANSPORT_RDMA)) {
+		xprt_put(xprt);
+		return -EOPNOTSUPP;
+	}
+
+	wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE);
+	saddr = (struct sockaddr *)&xprt->addr;
+	port = rpc_get_port(saddr);
+
+	kfree(xprt->address_strings[RPC_DISPLAY_ADDR]);
+	xprt->address_strings[RPC_DISPLAY_ADDR] = kstrndup(buf, count - 1,
+							   GFP_KERNEL);
+	xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr,
+				 sizeof(*saddr));
+	rpc_set_port(saddr, port);
+
+	xprt->ops->connect(xprt, NULL);
+	clear_bit(XPRT_LOCKED, &xprt->state);
+	xprt_put(xprt);
+	return count;
+}
+
 int rpc_sysfs_init(void)
 {
 	rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
@@ -105,6 +168,14 @@ static const void *rpc_sysfs_xprt_switch_xprt_namespace(struct kobject *kobj)
 			    kobject)->net;
 }
 
+static struct kobj_attribute rpc_sysfs_xprt_dstaddr = __ATTR(dstaddr,
+	0644, rpc_sysfs_xprt_dstaddr_show, rpc_sysfs_xprt_dstaddr_store);
+
+static struct attribute *rpc_sysfs_xprt_attrs[] = {
+	&rpc_sysfs_xprt_dstaddr.attr,
+	NULL,
+};
+
 static struct kobj_type rpc_sysfs_client_type = {
 	.release = rpc_sysfs_client_release,
 	.sysfs_ops = &kobj_sysfs_ops,
@@ -119,6 +190,7 @@ static struct kobj_type rpc_sysfs_xprt_switch_type = {
 
 static struct kobj_type rpc_sysfs_xprt_switch_xprt_type = {
 	.release = rpc_sysfs_xprt_switch_xprt_release,
+	.default_attrs = rpc_sysfs_xprt_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_switch_xprt_namespace,
 };
-- 
2.27.0

