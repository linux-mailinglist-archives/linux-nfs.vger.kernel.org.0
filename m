Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3C6375CE6
	for <lists+linux-nfs@lfdr.de>; Thu,  6 May 2021 23:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhEFVfs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 May 2021 17:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhEFVfs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 May 2021 17:35:48 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CE2C061574
        for <linux-nfs@vger.kernel.org>; Thu,  6 May 2021 14:34:49 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j12so6015603ils.4
        for <linux-nfs@vger.kernel.org>; Thu, 06 May 2021 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uc30rTB22VBqZZwwvHJvgC3Hu0FpHXkFUIP9vgybToQ=;
        b=uotX6ah1iQPPmlXQxc4HGDehSS2a9NxItl2ytVasMkFlMGjFtNZQcZfMyNfcdvUJ+Q
         opTq/LLApsjdjce/8DN1U7m7uzDMymCCKLDJWSuYH+V3S2XkC1Rga7VHAY3Sx2LV34UN
         1AV7rbifRif0z4YcrJpxrtdl3MrTaY47ftKotWXkIhabltZ5SZjDCNQ2wpPQaSGT306+
         9Xw7nd5x5ebx6RUu9mTCb1pIWBk9AyzjDQJ56NJqtBvwgJQUBARoEFdWAuzyCEf8kZXE
         ca2XC1pTBIbEI7Xwa4sQB5PvULMRnCvkvcSt0WByNRs5vvAjiwl4ctmV9DY/fRh9Le9M
         AGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uc30rTB22VBqZZwwvHJvgC3Hu0FpHXkFUIP9vgybToQ=;
        b=KouH6Uz8j2iEdvomsK5Lbdm0i+MmCG+5YsnJNah4NjeX2DvKAhl/e9nKZsgWKK5NB9
         jrtkSkXvTcK2U42XjBo5Nn3zlIgWBCx+KNQqIHF8cjD2LDpiMlHdgoQ4qA5VhLJXlWxr
         tPGWOnu9cNpk9TJbefcZnB5peB08r85nz6dDrIWgxI3dm6d4PCrg1SF4xPc0g02/ueSg
         PVJdg18IGANwO/Sk9AdJcZWIRtbZeKqq4FY0RayF1aRXVLsQqiwZ1fDWPF0xQnMJhR+4
         ZIF/aHsxQjWEznBX/fGPTg4tpaA+o4J79LMaK0dO5hAv1xT48frI/c8Mol32Kf1HRK0l
         9+XQ==
X-Gm-Message-State: AOAM530+SHLRMcf7l4trG8PcuVkO3eUVz/xnetn16B6dyX5TIKXQZwyy
        nq1iI9eYvxF+FmFchjW7baI=
X-Google-Smtp-Source: ABdhPJxmoZUmsU+T04ilQSNGWrSxI5nVGImv29wlSWwdZze6yhHNsXRAgoq97EcISlDj2RtUbzZ0hA==
X-Received: by 2002:a92:3203:: with SMTP id z3mr6169025ile.22.1620336889373;
        Thu, 06 May 2021 14:34:49 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id 6sm1486019iog.36.2021.05.06.14.34.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 14:34:48 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 10/12] sunrpc: add dst_attr attributes to the sysfs xprt directory
Date:   Thu,  6 May 2021 17:34:33 -0400
Message-Id: <20210506213435.42457-11-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
References: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/sysfs.c | 104 +++++++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/xprt.c  |   3 +-
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 78c0ff879424..664caa91e4d2 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -4,8 +4,24 @@
  */
 #include <linux/sunrpc/clnt.h>
 #include <linux/kobject.h>
+#include <linux/sunrpc/addr.h>
+#include <linux/sunrpc/xprtsock.h>
+
 #include "sysfs.h"
 
+struct xprt_addr {
+	const char *addr;
+	struct rcu_head rcu;
+};
+
+static void free_xprt_addr(struct rcu_head *head)
+{
+	struct xprt_addr *addr = container_of(head, struct xprt_addr, rcu);
+
+	kfree(addr->addr);
+	kfree(addr);
+}
+
 static struct kset *rpc_sunrpc_kset;
 static struct kobject *rpc_sunrpc_client_kobj, *rpc_sunrpc_xprt_switch_kobj;
 
@@ -43,6 +59,85 @@ static struct kobject *rpc_sysfs_object_alloc(const char *name,
 	return NULL;
 }
 
+static inline struct rpc_xprt *
+rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
+{
+	struct rpc_sysfs_xprt *x = container_of(kobj,
+		struct rpc_sysfs_xprt, kobject);
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
+	ret = sprintf(buf, "%s\n", xprt->address_strings[RPC_DISPLAY_ADDR]);
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
+	char *dst_addr;
+	int port;
+	struct xprt_addr *saved_addr;
+	struct rpc_task sysfs_task = { 0 };
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
+	dst_addr = kstrndup(buf, count - 1, GFP_KERNEL);
+	if (!dst_addr)
+		goto out_err;
+	saved_addr = kzalloc(sizeof(*saved_addr), GFP_KERNEL);
+	if (!saved_addr)
+		goto out_err_free;
+	saved_addr->addr =
+		rcu_dereference_raw(xprt->address_strings[RPC_DISPLAY_ADDR]);
+	rcu_assign_pointer(xprt->address_strings[RPC_DISPLAY_ADDR], dst_addr);
+	call_rcu(&saved_addr->rcu, free_xprt_addr);
+	xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr,
+				 sizeof(*saddr));
+	rpc_set_port(saddr, port);
+
+	xprt_force_disconnect(xprt);
+	sysfs_task.tk_rqstp = kzalloc(sizeof(*sysfs_task.tk_rqstp), GFP_KERNEL);
+	if (!sysfs_task.tk_rqstp)
+		goto out_err;
+	sysfs_task.tk_rqstp->rq_xprt = xprt;
+	xprt->snd_task = &sysfs_task;
+	xprt_connect(&sysfs_task);
+	xprt_unlock_connect(xprt, &sysfs_task);
+out:
+	clear_bit(XPRT_LOCKED, &xprt->state);
+	xprt_put(xprt);
+	return count;
+out_err_free:
+	kfree(dst_addr);
+out_err:
+	count = -ENOMEM;
+	goto out;
+}
+
 int rpc_sysfs_init(void)
 {
 	rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
@@ -106,6 +201,14 @@ static const void *rpc_sysfs_xprt_namespace(struct kobject *kobj)
 			    kobject)->xprt->xprt_net;
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
@@ -120,6 +223,7 @@ static struct kobj_type rpc_sysfs_xprt_switch_type = {
 
 static struct kobj_type rpc_sysfs_xprt_type = {
 	.release = rpc_sysfs_xprt_release,
+	.default_attrs = rpc_sysfs_xprt_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_namespace,
 };
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index fd58a3a16add..ff061be00e68 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -911,7 +911,8 @@ void xprt_connect(struct rpc_task *task)
 
 	if (!xprt_connected(xprt)) {
 		task->tk_rqstp->rq_connect_cookie = xprt->connect_cookie;
-		rpc_sleep_on_timeout(&xprt->pending, task, NULL,
+		if (task->tk_client)
+			rpc_sleep_on_timeout(&xprt->pending, task, NULL,
 				xprt_request_timeout(task->tk_rqstp));
 
 		if (test_bit(XPRT_CLOSING, &xprt->state))
-- 
2.27.0

