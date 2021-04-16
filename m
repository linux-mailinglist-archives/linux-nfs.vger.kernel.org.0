Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2998936185E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 05:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbhDPDw4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 23:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbhDPDwz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 23:52:55 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A6FC061574
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:31 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id d15so14621827qkc.9
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nom4IkQ3SY1Lnfz/M9qTAf+h9BHJgOxm0EDZubW34+U=;
        b=VM0cpG21eH03pDx3QaZrhQsf4I5ZUMmPBUSPTO8HMd/fNLerFqzrjxVTJBNpsEbiI9
         zts+5aIcivdl+OtSAvnmejAukW0kqU30z1sCqGEtaHxOg8ESv58VmkxbKQUS5nor/QHi
         9pK+XVRg+a9ZSY47eP8oHnNqTeiMZdE2qBNQkdRcBfTElG2N2EhJOsdJRQpN38mEJsh2
         wntS0z12AUF/WplwAiYml9tTPC3OMyn1Gq2J6WAdN+B7arerOqtQBKUvJzlDS5dj4ZZP
         6VvRG6HNgyBDZoFq+2W1h27oYNlLVns86FxJTyptBc0kKd+BV5O4rbN+eTxWkDvtqOfd
         KX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nom4IkQ3SY1Lnfz/M9qTAf+h9BHJgOxm0EDZubW34+U=;
        b=N1R0zWW7jGPVI4J1xcVEyu2PRbo4J4QqljTgo2WaKzE2hoC1oOv2q5OvFY50ea61xr
         o7u6Lg0FwIBveUIn/k6PDpfV/2SK1IM5CBVCHiScwkJiJz1b7xklZNrpl90RmEDUHb55
         SO9Lm4P+J9fO3QPpOGpjOExFpxL4izPA8aSc4zWaHrrBKJ/qnNjUBYBxjrTb01tA0ycf
         SqSSo8M1Ih4MxLp74SPCM7Hpup23ZLJAIskeai1lMO+RjOQztgt02DDWLwJ99rDvRtJ3
         EFrGsbbIEedWVxiz87BwxLM6gW7PI4AEXyg35+9XjQLSKKrDUN1MCooa1t2db3vB0ERj
         6/BA==
X-Gm-Message-State: AOAM533/zvnq048nZ2FjkyQ53sGr+LjBEtDq6CNr7z1q0H9GXepsHeyj
        Xzx6/XNYaPRLjLGbmeDGxNo=
X-Google-Smtp-Source: ABdhPJyZqu/flp56ajWxW2ob1NWJJXorIbuhg8mbCUhoz2k55QY/rHSZ/GwIv/eMglUhC2EKv9HYTw==
X-Received: by 2002:a05:620a:15f0:: with SMTP id p16mr6998820qkm.448.1618545151198;
        Thu, 15 Apr 2021 20:52:31 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id x82sm3500913qkb.0.2021.04.15.20.52.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 20:52:30 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 02/13] sunrpc: Create a client/ subdirectory in the sunrpc sysfs
Date:   Thu, 15 Apr 2021 23:52:15 -0400
Message-Id: <20210416035226.53588-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
References: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
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

