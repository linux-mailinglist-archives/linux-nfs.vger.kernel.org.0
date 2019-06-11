Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 330BB3D545
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406851AbfFKSMG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 14:12:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35250 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406685AbfFKSMC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 14:12:02 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so10722463ioo.2
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2019 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DWd/c8QEyTQVmbnPKbobpMg+XF2mkuTzRh+MjRTbsXo=;
        b=RHXLmA3e+3Hl/mh6qMdjIfj+fUoJTenxQscuXVeX6yhhMsURKDGxTLnxOwSxWAF6sf
         6vfAC2EBHOKT8iAnRaXdokrTSHziYcVnR5fb7OZRbnV7ZJz/fzP76idcAHBR4jgoPXAu
         We0QiLKfQrPRX2mR0OMHela9xLt9eofwUAkaMMuO73Yt45OUeR1erbpsbq6f5qNkEOyJ
         ouJq9VDByNoF6NyLU6EMYXsUBlkrQf5P6n+ehCiDWDbYnjp+5w9SK9ASm+TRAR5eRA5A
         MdhyLuGw6GnpC39yzMfyQ5MOWFspC6baQW0WyBq+9thWJ4rbQ3NEQ+e2aYZlaFgNnQva
         IoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWd/c8QEyTQVmbnPKbobpMg+XF2mkuTzRh+MjRTbsXo=;
        b=J2X0Rw3yI9p4dinHvgVKcND7zwy8bYWZcoG/j8iJ6bxBEJLZKNrjcPlPtdS5eSV9FF
         8e9IFZNr1klk+b2UHJN5Xk6Mm+BPT8YNi2IcUDwFCuLU027G4yzUAwwNA9NFM10pVWTM
         XsKYnSlrGluUoPu3MRKhsAeE+lt6HZRTjCd0DlaVRHZsBrdQwkWgTtEIuyfq/5cTWdW0
         Io36SoTc6L1t1fBuC6dX2lKDmTNevOqBFgQT/8eDZS8NpSv90PDVl+NucQgcgWMLSl2q
         KknRQTvqDkr9u7UfXNnN5kMjSLTaOWVOuTKfmgTtcVQzvzhg//EixmGoBZVTS4R9spEW
         72Gw==
X-Gm-Message-State: APjAAAWtV1/pGqA7kaz1rIp9nNuyxm/Xw5JEZqyZfcqykXfr2sdM5Q1P
        zd7aViBzICREBUZMCdqZQNXz1X4=
X-Google-Smtp-Source: APXvYqzGHWMAd3p6JMQ7eJLV7/NVm6wquOvV9moIidb6Ru4jUcwwgwPx5QyK0vaNPNGDA6BRmb7kSQ==
X-Received: by 2002:a6b:c915:: with SMTP id z21mr44702871iof.182.1560276721607;
        Tue, 11 Jun 2019 11:12:01 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id f4sm4900212iok.56.2019.06.11.11.12.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 11:12:01 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Add sysfs support for per-container identifier
Date:   Tue, 11 Jun 2019 14:08:32 -0400
Message-Id: <20190611180832.119488-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611180832.119488-3-trond.myklebust@hammerspace.com>
References: <20190611180832.119488-1-trond.myklebust@hammerspace.com>
 <20190611180832.119488-2-trond.myklebust@hammerspace.com>
 <20190611180832.119488-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In order to identify containers to the NFS client, we add a per-net
sysfs attribute that udev can fill with the appropriate identifier.
The identifier could be a unique hostname, but in most cases it
will probably be a persisted uuid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c |   4 ++
 fs/nfs/netns.h  |   3 ++
 fs/nfs/sysfs.c  | 118 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/sysfs.h  |  10 ++++
 4 files changed, 135 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 0acb104f7b00..6e7aeb543f6a 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -49,6 +49,7 @@
 #include "pnfs.h"
 #include "nfs.h"
 #include "netns.h"
+#include "sysfs.h"
 
 #define NFSDBG_FACILITY		NFSDBG_CLIENT
 
@@ -1072,12 +1073,15 @@ void nfs_clients_init(struct net *net)
 #endif
 	spin_lock_init(&nn->nfs_client_lock);
 	nn->boot_time = ktime_get_real();
+
+	nfs_netns_sysfs_setup(nn, net);
 }
 
 void nfs_clients_exit(struct net *net)
 {
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
 
+	nfs_netns_sysfs_destroy(nn);
 	nfs_cleanup_cb_ident_idr(net);
 	WARN_ON_ONCE(!list_empty(&nn->nfs_client_list));
 	WARN_ON_ONCE(!list_empty(&nn->nfs_volume_list));
diff --git a/fs/nfs/netns.h b/fs/nfs/netns.h
index fc9978c58265..c8374f74dce1 100644
--- a/fs/nfs/netns.h
+++ b/fs/nfs/netns.h
@@ -15,6 +15,8 @@ struct bl_dev_msg {
 	uint32_t major, minor;
 };
 
+struct nfs_netns_client;
+
 struct nfs_net {
 	struct cache_detail *nfs_dns_resolve;
 	struct rpc_pipe *bl_device_pipe;
@@ -29,6 +31,7 @@ struct nfs_net {
 	unsigned short nfs_callback_tcpport6;
 	int cb_users[NFS4_MAX_MINOR_VERSION + 1];
 #endif
+	struct nfs_netns_client *nfs_client;
 	spinlock_t nfs_client_lock;
 	ktime_t boot_time;
 #ifdef CONFIG_PROC_FS
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 7070711ff6c5..4f3390b20239 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -9,7 +9,12 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/netdevice.h>
+#include <linux/string.h>
+#include <linux/nfs_fs.h>
+#include <linux/rcupdate.h>
 
+#include "nfs4_fs.h"
+#include "netns.h"
 #include "sysfs.h"
 
 struct kobject *nfs_client_kobj;
@@ -67,3 +72,116 @@ void nfs_sysfs_exit(void)
 	kobject_put(nfs_client_kobj);
 	kset_unregister(nfs_client_kset);
 }
+
+static ssize_t nfs_netns_identifier_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct nfs_netns_client *c = container_of(kobj,
+			struct nfs_netns_client,
+			kobject);
+	return scnprintf(buf, PAGE_SIZE, "%s\n", c->identifier);
+}
+
+/* Strip trailing '\n' */
+static size_t nfs_string_strip(const char *c, size_t len)
+{
+	while (len > 0 && c[len-1] == '\n')
+		--len;
+	return len;
+}
+
+static ssize_t nfs_netns_identifier_store(struct kobject *kobj,
+		struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct nfs_netns_client *c = container_of(kobj,
+			struct nfs_netns_client,
+			kobject);
+	const char *old;
+	char *p;
+	size_t len;
+
+	len = nfs_string_strip(buf, min_t(size_t, count, CONTAINER_ID_MAXLEN));
+	if (!len)
+		return 0;
+	p = kmemdup_nul(buf, len, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	old = xchg(&c->identifier, p);
+	if (old) {
+		synchronize_rcu();
+		kfree(old);
+	}
+	return count;
+}
+
+static void nfs_netns_client_release(struct kobject *kobj)
+{
+	struct nfs_netns_client *c = container_of(kobj,
+			struct nfs_netns_client,
+			kobject);
+
+	if (c->identifier)
+		kfree(c->identifier);
+	kfree(c);
+}
+
+static const void *nfs_netns_client_namespace(struct kobject *kobj)
+{
+	return container_of(kobj, struct nfs_netns_client, kobject)->net;
+}
+
+static struct kobj_attribute nfs_netns_client_id = __ATTR(identifier,
+		0644, nfs_netns_identifier_show, nfs_netns_identifier_store);
+
+static struct attribute *nfs_netns_client_attrs[] = {
+	&nfs_netns_client_id.attr,
+	NULL,
+};
+
+static struct kobj_type nfs_netns_client_type = {
+	.release = nfs_netns_client_release,
+	.default_attrs = nfs_netns_client_attrs,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.namespace = nfs_netns_client_namespace,
+};
+
+static struct nfs_netns_client *nfs_netns_client_alloc(struct kobject *parent,
+		struct net *net)
+{
+	struct nfs_netns_client *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (p) {
+		p->net = net;
+		p->kobject.kset = nfs_client_kset;
+		if (kobject_init_and_add(&p->kobject, &nfs_netns_client_type,
+					parent, "nfs_client") == 0)
+			return p;
+		kobject_put(&p->kobject);
+	}
+	return NULL;
+}
+
+void nfs_netns_sysfs_setup(struct nfs_net *netns, struct net *net)
+{
+	struct nfs_netns_client *clp;
+
+	clp = nfs_netns_client_alloc(nfs_client_kobj, net);
+	if (clp) {
+		netns->nfs_client = clp;
+		kobject_uevent(&clp->kobject, KOBJ_ADD);
+	}
+}
+
+void nfs_netns_sysfs_destroy(struct nfs_net *netns)
+{
+	struct nfs_netns_client *clp = netns->nfs_client;
+
+	if (clp) {
+		kobject_uevent(&clp->kobject, KOBJ_REMOVE);
+		kobject_del(&clp->kobject);
+		kobject_put(&clp->kobject);
+		netns->nfs_client = NULL;
+	}
+}
diff --git a/fs/nfs/sysfs.h b/fs/nfs/sysfs.h
index 666f8db2ba92..f1b27411dcc0 100644
--- a/fs/nfs/sysfs.h
+++ b/fs/nfs/sysfs.h
@@ -6,10 +6,20 @@
 #ifndef __NFS_SYSFS_H
 #define __NFS_SYSFS_H
 
+#define CONTAINER_ID_MAXLEN (64)
+
+struct nfs_netns_client {
+	struct kobject kobject;
+	struct net *net;
+	const char *identifier;
+};
 
 extern struct kobject *nfs_client_kobj;
 
 extern int nfs_sysfs_init(void);
 extern void nfs_sysfs_exit(void);
 
+void nfs_netns_sysfs_setup(struct nfs_net *netns, struct net *net);
+void nfs_netns_sysfs_destroy(struct nfs_net *netns);
+
 #endif
-- 
2.21.0

