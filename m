Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C23736B7FB
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 19:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhDZRUv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 13:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbhDZRUk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 13:20:40 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA49C06138B
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:19:52 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b17so47242000ilh.6
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4aCM5UfvziQ7sazTrpdsnh7+wCB9a6RVTMhW0Gm1zc=;
        b=ffZvDwU1ENdQqreRESHRB+LFUyL5IZiKEOjqdpt/K1bRrFMoKEpeBlAYkz1vupRrnn
         cuMfvP7Fvk2pysTVBjh8MBsm2Ki30QUDkBTSAgrXmX//t29CgQGv57LCXX8DLeqv5hcP
         m39xzxXY8b+aG22Te+3lEMIAR5f+dkmowCFWOWkruA3iza8QMwA2hfnKDIBHhYbZnTol
         vvhbyqutPI37BtaiXWGa8orYZqjfgnwgdaZQyh2D/ErPwf8muiK7hqES41RskcdjsteC
         fgqgB6tykCNoEWkViRAiojir8FObden9vAF/aG0kVin7XkXz0upkR54nDVxXKoAyMOrl
         Zoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4aCM5UfvziQ7sazTrpdsnh7+wCB9a6RVTMhW0Gm1zc=;
        b=CGDkkPMjqvQ9plOh3RTaQDOJJi2uBgOWOwU1kC76L48uXvvQ6dm4HPTNn8X1AEVNwY
         dxv3mP57a8/yKUDVVx4zZTvEpOLMuqy43R3yEmt5A3MDUvwnOP99wKa+8NM6r2VxXEOu
         G0NlDgstSKdR4gCXJf43/7eXBHCa5jeowcTMziafHRwkR/7JMulS0P137V+mMm456hP9
         rrMa9mJ7p3goTS2v333OIuAB4kls5YE4kx5Rxl/1d7rrFJ5sgziu+YPgGWxxXEyeECvg
         Z+AVfvszUyT34riqTS4EyHnclwTZWRVh+qxHPXkY7dBR+aqG57Tsu4r88/jkI1M4e4PD
         3DiQ==
X-Gm-Message-State: AOAM530+va1kItKyvwqQg7FM8bA/5QwxcsYHg/XyMMnL2PAtKyoZ0Cck
        JgtLjDEmxzPUgc6939+iRVQ=
X-Google-Smtp-Source: ABdhPJyVoke10QqZCUc3380HQpowbxEcYslijblTtH+43h/qjhJYnmXgVtia/YaTPYMgVVesCYk8wA==
X-Received: by 2002:a92:ab01:: with SMTP id v1mr9397159ilh.190.1619457592135;
        Mon, 26 Apr 2021 10:19:52 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x13sm207297ilq.85.2021.04.26.10.19.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:19:51 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 02/13] sunrpc: Create a client/ subdirectory in the sunrpc sysfs
Date:   Mon, 26 Apr 2021 13:19:36 -0400
Message-Id: <20210426171947.99233-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
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

