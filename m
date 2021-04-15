Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBF1360007
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 04:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhDOC2l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 22:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhDOC2k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 22:28:40 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9085C061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:17 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r5so10730491ilb.2
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7e2Uku8Qwn+tDIg2fezrb9mpCWvmkj+bjrtpzR8Rlkk=;
        b=Nq0Zv6yD40H0oIdUYQgDr0piH3fBlv/cv4vgpGGQE+if2W5IEc9RBoU1vqoDYRXPjb
         znveWqOaLnbq94TcKAhxxsMW8J4kM0vKdCMJ48U+124aHtjYMRhBz6TIejcNohN3hD/i
         kHRVwoxCHiNX4qYLr2+b/2Sh1KRo1F5wRXyJByNJQUYM3O/qoK/FwScMcR11BgWbuB+O
         i7zAMB7pzsEwfP1kTZfpuyh+sQRVqwC+DhqKBBo9sM1t0yl0RS5zmHPeyFvoSJB3I9rE
         LUVo8oR4pwoDLPv2FrhrwOKGb+FSJH4s/ow2+3Blz7bbaMeCUVlqNI2H3GCUvmqRjuUk
         /66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7e2Uku8Qwn+tDIg2fezrb9mpCWvmkj+bjrtpzR8Rlkk=;
        b=Rv29bDwcjhYT7Z6s3BjcmOXdynj8w5BNtpaEqQ3UnrriQw14XYVVqN+T7EkzHdG1hc
         aH/7OCuL9t4h3drbupQpRXlszCNx36WiWZsgDmgSesSLhaN2+iqY/jSVNlOZ1onYXXrn
         ZnHeT2OBxtbkQ/Vj4PtF8epnUX0B5d9s4G8fAWuX6RzCVlKsDEvEDG1kAbAWSWZevCzl
         AgBUTS0l2aqpKQRN83WHWM/U2L0SN2c41YK6wA2IUwF0nkdgiCeokScGGIa+pnZioKVB
         PZxPMGt/c+BtpcNdNRZsSSnxU22TYtL1gZj36OzOjEyTs6Gy2fyaCNqIh5Q9GMEl6uDC
         9pgw==
X-Gm-Message-State: AOAM533jT2RBR0wIKD6s/eXMMaNd8WrZNz/4n7XLYxZK27UuAqzvvmk4
        P2Zit/kc6jS70tWeovw804I=
X-Google-Smtp-Source: ABdhPJyGuCm/pjAHvApo3mscSGEyZDRha9nNkfTLKzigwZueP68JkoQK+u8NPVT6bpW1cIAFL6ucTQ==
X-Received: by 2002:a05:6e02:e0a:: with SMTP id a10mr939416ilk.271.1618453697371;
        Wed, 14 Apr 2021 19:28:17 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm608917ilh.47.2021.04.14.19.28.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:28:16 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 11/13] sunrpc: add dst_attr attributes to the sysfs xprt directory
Date:   Wed, 14 Apr 2021 22:28:00 -0400
Message-Id: <20210415022802.31692-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
References: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/sysfs.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 897939184f11..35d8109931cb 100644
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
@@ -42,6 +45,70 @@ static struct kobject *rpc_sysfs_object_alloc(const char *name,
 	return NULL;
 }
 
+static inline struct rpc_xprt *
+rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
+{
+	struct rpc_sysfs_xprt_switch_xprt *x = container_of(kobj,
+		struct rpc_sysfs_xprt_switch_xprt, kobject);
+	struct rpc_xprt *xprt;
+
+	rcu_read_lock();
+	xprt = xprt_get(rcu_dereference(x->xprt));
+	rcu_read_unlock();
+	return xprt;
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
@@ -105,6 +172,14 @@ static const void *rpc_sysfs_xprt_switch_xprt_namespace(struct kobject *kobj)
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
@@ -119,6 +194,7 @@ static struct kobj_type rpc_sysfs_xprt_switch_type = {
 
 static struct kobj_type rpc_sysfs_xprt_switch_xprt_type = {
 	.release = rpc_sysfs_xprt_switch_xprt_release,
+	.default_attrs = rpc_sysfs_xprt_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_switch_xprt_namespace,
 };
-- 
2.27.0

