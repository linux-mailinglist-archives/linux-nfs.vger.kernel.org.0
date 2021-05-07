Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2EF3768A6
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbhEGQ0Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbhEGQ0X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 12:26:23 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CC8C061574
        for <linux-nfs@vger.kernel.org>; Fri,  7 May 2021 09:25:22 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e14so8108758ils.12
        for <linux-nfs@vger.kernel.org>; Fri, 07 May 2021 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=Mnw2KohkUDKT1zIMI5fQfdn1xUheVhCXk4wWZ+X1r2imzhMHnd+gz8PWqa7T2lGm9O
         AxpT/5dOtCZRSo0t+ivdYBRZFIOc6jCe91lyWCLjKyYT2eNCRGpYFhVWQtGevjD7KkB5
         L25GuIeudm7Q/TQK2DDw2bS/BCSh0SxS5naoU3PNuSlFmnDbh5iuQ4JA56RedOFI3ry2
         CpGAPMPNWu+oHQDQUvlYevtlftvLJfNVAfhTKArjLeXmceWiBn71WNtRWcK4w9TpUUEr
         KOF3eokGfY9HBxVg+fVfwrANXNVxxMq/Vvy3c/Ov/79jWIBtCqIB6VhWuxZIT/US5kta
         AR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=mHbFaLpjrofaTeZ0a2+I6jx7gxahwVF0ecFhDif9iGN/mI+tFCtgHQjZVu/R2vH0Lg
         qB0VtNETatpn14a2CjpM9rYl6oJPIm7vvcokhkQCp9eSN/QSXZgjQN3T7yc3IOumE6i5
         3vYKQptxQWDRUe3pREbt9D1bTXmE+u4O/c+nAAzt16mX4c+d9Q4CKLvRnzZSEsGoGxGs
         9SEjinj27WH2SHpLQsoqh9h0iIAEAfbJtP3CM05QHZiS+EaNFCaWKPtE4n5sjVs83ScI
         gCFzZeqylFMJssGfDfmgRL61f4xm7YyBfu6wuod7XjGubiQ8n0K5K4ipOVa1jqgh7wYF
         olXw==
X-Gm-Message-State: AOAM530xAvy7NmSOVPnWTFkK6DilOnj9I86v6aKoSfyjveQm7NhGXgPN
        bHYwxqwHie4IThc1+INfsZscA5B/J5skqQ==
X-Google-Smtp-Source: ABdhPJym3QuNAgjXWqvcJlnMrq2B9IUxYdg6GAK1UptiwzCHFe8ryHP0QhhgjZEP59Xtzahmi5oQlQ==
X-Received: by 2002:a05:6e02:8f0:: with SMTP id n16mr9947413ilt.7.1620404722232;
        Fri, 07 May 2021 09:25:22 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v2sm2451000ioe.22.2021.05.07.09.25.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 09:25:21 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 02/12] sunrpc: Create a client/ subdirectory in the sunrpc sysfs
Date:   Fri,  7 May 2021 12:25:08 -0400
Message-Id: <20210507162518.51520-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
References: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
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

