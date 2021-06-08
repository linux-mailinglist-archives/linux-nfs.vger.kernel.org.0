Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C8B3A04DA
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhFHUBk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhFHUBk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:01:40 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A75C061789
        for <linux-nfs@vger.kernel.org>; Tue,  8 Jun 2021 12:59:30 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l7so16264397qtk.5
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=nOgpzEGh6U3+xuM89PoENzYnpNXGq2wJEbAv5Ylk1xFaVGhZBn4mblhoQL2lFgN4n9
         XOfQckW766jcwEbfJuZIQr5RkUHDMxoMb1DalmuJZD8fi9V5VRfs9a9JXgqX4JU3T+o+
         stjX4uLWRXaZDhwS1Yc9WCzSj5uJRG4HxaeCHR/6JCa36aOg+UiCkwB3tpMmRhQThNZg
         fnXCOCfe44+zmxrEysHucl8Jwp6Fdx7n1qErpx57frrI1HwqvsI24yrQpw/lHis2K5Tn
         AQ4MSsEBVOr6NyX0IvKlhanwPbZ/mN/EDthDHJMYZdSVBZeHlTJUapbhBNF2HuZ4sCT0
         AMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=bRRy6ybLHAxp5/Z+YEwlG7bzRKiKjiw4jJ+18wxOAwEaotJ/EWN0161JKvHVegcMmm
         +woWAu2Q1wJRt6WLl4Jv/sPRUn81IVQe057WON+Vtzl2qD10JyHcqIn+CzuY8yLRlR1T
         h0ZhjFVgpw4H+fcolFn+i+UOYRgViMSKEUkKhAnyVkXRbCKBl5voxj4JVSUfqgrZyErC
         DaDoEjTnKo2UTG877QP90wTmE+xps03yA5mOyVi6/PRIakVjqYtC7bffneZLYVccexOd
         Zg++qgM4Wnb+tpNIKIJk9TyrK8FzYNQHAevGw3PEZnCH+fxJxUxONB8WeFH6EtlGj/uZ
         rniA==
X-Gm-Message-State: AOAM532DuaeCS0KBxOGM/de3jnc3dj7ShZTRp3lyIAT6qgF7O+q0C7P5
        kO/delE1/7IaKDC16mOTlc8=
X-Google-Smtp-Source: ABdhPJwXQgYxhf86Mv+60OW0LZKKNL5lMLj6QQZ5QP0IGEHVaO9cKMo7WJX4E6du8fg9l3NJFexulA==
X-Received: by 2002:ac8:12c6:: with SMTP id b6mr22824258qtj.352.1623182369461;
        Tue, 08 Jun 2021 12:59:29 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id j127sm12952765qke.90.2021.06.08.12.59.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:59:27 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 02/13] sunrpc: Create a client/ subdirectory in the sunrpc sysfs
Date:   Tue,  8 Jun 2021 15:59:11 -0400
Message-Id: <20210608195922.88655-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
References: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

For network namespace separation.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/sysfs.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 27eda180ac5e..fa03e2ef836a 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -2,19 +2,62 @@
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
+					      struct kset *kset,
+					      struct kobject *parent)
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

