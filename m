Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5608539ADEB
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhFCWXq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:23:46 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:46747 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFCWXp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:23:45 -0400
Received: by mail-qt1-f182.google.com with SMTP id m13so5553590qtk.13
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=LrbvzImF6I7Xgn2Vg1Zi8Cku9wNHZP4faNlNIbMtNwFmla4Yk1s5qMNM4TqYVwbo0C
         ALCo1EY3LfPoftaFt8QnQjxn9cU60+/xm+COCD+druqaukp1w8iqnblAQeKQZk1JsWGn
         9SR/VSfzZEi2ha230k5+G6wlNG928lMkvRUhPsfHksk8pkc4if7WxzmSuZl4Dc3QQ5zg
         LznVEMwoL+lbaKev3D3NubOT6nev/9TR8pfvDMdThUwLmLuervezrE/crLY6MB+fyPA0
         Ga8AbfrFFkXjk+RZ9zQoVS0vqEWguCRcNvKyH/M8GhAYFA3lDGl/S5iK66wFcxDdfkN8
         WnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=p7GNUswrZDRNgxlYHoHp8H4n2BpJSZkrAJiQsDHDjXK4DQbl7fV37p9OtnSjJQe4Ur
         W+1qaQnqHvzKiGZSdKHwr+0XTCPLO4wYGS4ZS3J7HTx0tnq3o0KZy7aS5SBnqinRulyc
         ZJ9i8Zge9YE45R1C+ZRGLo7P4egYVU9l0XDewJrKQ3wdm2JcT1s2L0qjyAoo8RPjoawG
         Lbk8IilhMC1R0ic3d1qfg/tss4wBuFnqrfujLqcTLgSdtaNQAS7g8gGz7i6UJIV3tLWX
         VFLJRIHOyKDzcaoSRqIs7YNv0B7CBlLyXlSefcGr7sxEZ3RKb438FS2PwnpMDnh9a7Eh
         oo6w==
X-Gm-Message-State: AOAM531gv3rQcPqV4BBqcqfropYUMQ3sYDDwTIgePkVT5XUMPQAqh5Ph
        cjuiwS5PYgvQkCGdhL1NNM0=
X-Google-Smtp-Source: ABdhPJxYwbMIeYBBzWJfyz/QqrG/2Cf6aJq05aHdNu/JUMtMex6O/Wg+E+xwYC+yr6QCeSU5bPcDdA==
X-Received: by 2002:ac8:58c9:: with SMTP id u9mr1736231qta.58.1622758844376;
        Thu, 03 Jun 2021 15:20:44 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:43 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 02/13] sunrpc: Create a client/ subdirectory in the sunrpc sysfs
Date:   Thu,  3 Jun 2021 18:20:28 -0400
Message-Id: <20210603222039.19182-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
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

