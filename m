Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1F036B7FF
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 19:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhDZRU4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbhDZRUp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 13:20:45 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DD5C061343
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:20:02 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b17so47242386ilh.6
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6jRwlsL6aSk9MpyGV4uCBh4PTylU34tEaFkoBLSTFnQ=;
        b=pnl1gnvjruDWEDyTSrrs2r4/OQS2vr0EQFjRr/i9cEgEZLfD4BD2jQaLD2z5tYTKTC
         G20700O4pf16mEq1KOrv4Ho9oL02TcJiM8fcAsPB0fxrZgAf8gOPBkW/7naKCTjYBZFD
         LUUfsKK/pfvGMNqBsgMSUZBtxrndKl7S1SyeVj1RZNK9unnFh3DIMWp7P+5WWrNwCFG+
         wsIAV9ZDgHUjI/EwlSBSXoy5PbgVh1VOUx0HYxugjQBRcxfPi2WkjMQkl98eHFb3sf0/
         ywsclaI9eLG0KHTLasNkhsqDCpuSYOMsw6MFZv3HBua7KRue7dNAkUJNvFFHbxSMTrdG
         04tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6jRwlsL6aSk9MpyGV4uCBh4PTylU34tEaFkoBLSTFnQ=;
        b=ZXVElDy2RR9RGpw/Yc/9dCkRoSSI/QZNCslQtFaDeajDq46BzFizcfQoWVVbGxMhTx
         /J7zd720/9QCQZCVwvPK8ACKt30WchxTjKqI9o1WMpJONI1zIi6Np+U1lymq1I6wHujo
         ajL4IK6gSJtPcVOCgfXpAgrhicOkQvDJ45ht42XI9gra899vJEg5baPn5ep7Nv8wB29E
         1dtkiMHHaXwjCtJjszOPJ9eiVxKHtL8hUacx0jInQJ/N8tofQAG5xW8n8TnwegumdHYZ
         8z6KqFvzW+hZGLrh641CSm85MtCmvX69bvdZKSrFpaTGiVyQ5K+cdW8rcIFTC90idFNz
         w5DA==
X-Gm-Message-State: AOAM533BZ3Ynnx233v0ZWTEViRuw79kQwVo7QTm7ZWm0IkHHaT97YF1M
        clCc3U/0Y7Sxn0GK3moXhDk=
X-Google-Smtp-Source: ABdhPJywApHBv/YVE+SJ/UUuhtCt9OOwNrbsv+ddLA69gyLLQ6S4+aXAvpdqQ/zjEbnZ4aaoBIGTcQ==
X-Received: by 2002:a05:6e02:10c6:: with SMTP id s6mr15636274ilj.15.1619457602151;
        Mon, 26 Apr 2021 10:20:02 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x13sm207297ilq.85.2021.04.26.10.20.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:20:01 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 11/13] sunrpc: add dst_attr attributes to the sysfs xprt directory
Date:   Mon, 26 Apr 2021 13:19:45 -0400
Message-Id: <20210426171947.99233-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
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
index 682def4293f2..076f777db3cd 100644
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

