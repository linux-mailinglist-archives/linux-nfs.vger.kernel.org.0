Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F8235FFFE
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 04:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhDOC2d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 22:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDOC2a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 22:28:30 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C892C061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:08 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id a9so11863349ioc.8
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nom4IkQ3SY1Lnfz/M9qTAf+h9BHJgOxm0EDZubW34+U=;
        b=aZ824QguDiImUhPn8iV1xsQdgMueZyWH2szwtX4BLZJhfarYU8kRHP+dHR3LqhNOD2
         lZx0Wl1NgDlU/WbYa66PXR0ZBzrZUkPQa17M+jsHobfU7ELYRYH6PbxqCXm5+fA4TVs6
         EMkqeC5nFEORNaG4bGYoBwfeOeBDVrw8w3vkHAWBw9zZIi2dA+A8kv4ihZlgeec0t5nI
         XIzWvEl2tAaf8w/zTBz0JNc1gYQljG2CqMWUDqzLG/rODxXY9X938PKrhpQ0bsKqA8Qw
         ppQd88XF6YrV7gUziCamVgAsS9wIIlZS+fUHR/RGCmVNDyAU7oT2HKc+k4pnBFllwOXd
         Xoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nom4IkQ3SY1Lnfz/M9qTAf+h9BHJgOxm0EDZubW34+U=;
        b=OAbRK8lF6AlQ2EL9H537BukkzQtBUN/2XizqDaQCXXJ6EgQ5HMjwW0XqRC8Rl9HFIh
         yJaDluyMLumJEFGExYVGU6grMHejMBNTXXdcWoBKuTNp6wELGoZRxP5FnIjSvQzj4ioI
         a5eOCTwpky9hEtn0iNSQe218jEBbiaK12iFfTenfvBOxYOJ731ld23jGJSNAjFhJwPVw
         pJlkAi7BMaEGNoZM4LKm307Jt0dxQ/b0EGgNj8qJK59AujFTRkL1aNBpRX4H8oPTl2ei
         sND2iC8nH9u+KzRDwdNVLBvl+GePinx+/nHIFhbKvru5gF95729Vq3FORNDf9dGfU1qg
         /Q9Q==
X-Gm-Message-State: AOAM533/Vm4CluK+JAaYzia+Bohu60OdeV6EiWe3XQs83Tpg0rRrVSko
        PamBEAo5Roi5W+UuIQcNAecdOSA8gmg=
X-Google-Smtp-Source: ABdhPJzCHgtunFWK7H8XK9/hz4DUHL9C/zAHgYAi+ZOPGweEyKNC0ZTKuZqV4ZEAI6Csxd6AvLls+g==
X-Received: by 2002:a05:6638:168e:: with SMTP id f14mr857326jat.49.1618453687834;
        Wed, 14 Apr 2021 19:28:07 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm608917ilh.47.2021.04.14.19.28.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:28:07 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 02/13] sunrpc: Create a client/ subdirectory in the sunrpc sysfs
Date:   Wed, 14 Apr 2021 22:27:51 -0400
Message-Id: <20210415022802.31692-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
References: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

For network namespace separation.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/sysfs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 27eda180ac5e..6be3f4cfac95 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -2,19 +2,61 @@
 /*
  * Copyright (c) 2020 Anna Schumaker <Anna.Schumaker@Netapp.com>
  */
+#include <linux/sunrpc/clnt.h>
 #include <linux/kobject.h>
 
 static struct kset *rpc_sunrpc_kset;
+static struct kobject *rpc_sunrpc_client_kobj;
+
+static void rpc_sysfs_object_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
+static const struct kobj_ns_type_operations *
+rpc_sysfs_object_child_ns_type(struct kobject *kobj)
+{
+	return &net_ns_type_operations;
+}
+
+static struct kobj_type rpc_sysfs_object_type = {
+	.release = rpc_sysfs_object_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.child_ns_type = rpc_sysfs_object_child_ns_type,
+};
+
+static struct kobject *rpc_sysfs_object_alloc(const char *name,
+		struct kset *kset, struct kobject *parent)
+{
+	struct kobject *kobj;
+
+	kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
+	if (kobj) {
+		kobj->kset = kset;
+		if (kobject_init_and_add(kobj, &rpc_sysfs_object_type,
+					 parent, "%s", name) == 0)
+			return kobj;
+		kobject_put(kobj);
+	}
+	return NULL;
+}
 
 int rpc_sysfs_init(void)
 {
 	rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
 	if (!rpc_sunrpc_kset)
 		return -ENOMEM;
+	rpc_sunrpc_client_kobj = rpc_sysfs_object_alloc("client", rpc_sunrpc_kset, NULL);
+	if (!rpc_sunrpc_client_kobj) {
+		kset_unregister(rpc_sunrpc_kset);
+		rpc_sunrpc_client_kobj = NULL;
+		return -ENOMEM;
+	}
 	return 0;
 }
 
 void rpc_sysfs_exit(void)
 {
+	kobject_put(rpc_sunrpc_client_kobj);
 	kset_unregister(rpc_sunrpc_kset);
 }
-- 
2.27.0

