Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7765A30CA56
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 19:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbhBBSp2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 13:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238885AbhBBSna (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 13:43:30 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE141C06178A
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 10:42:49 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d85so20823417qkg.5
        for <linux-nfs@vger.kernel.org>; Tue, 02 Feb 2021 10:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75jpej1TQ9Hzb65iteJ+9BRTqwnRgVEfPYAU4FruI/w=;
        b=V+MaJkgg2euLrFA8OK7wvIWiTRWMd44RJh8w3W8OlYj43jnd6Z3ROIPOXQMc6fQYo5
         s3zzSZ7kdabPAEHcPY8Ik5my92wqFi5j+PkJKATIRoB1sshpKbiJ34viCEtcqmiPi1kn
         0PZdiuTWJse+fw0RpV1KVkbagcEF3Bsuky8SdtSLqKoIWbhw5dt/AyiUyNAk5hjM2BTO
         AWw0UI9S/DaAXjwrgqhls1Y7Jg+W7lhlN1scxhg6aUpyU1kJz1HbRRs4n42+fPSctD4O
         jRKdwu3WQFsShBfjrYwGzcT7EI6s3NygrmqnEjd1hzn6qiHhA65mQioRamCaMaFMTzog
         s9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=75jpej1TQ9Hzb65iteJ+9BRTqwnRgVEfPYAU4FruI/w=;
        b=oOFaFivFoUlV/lBXaIy+5ArYchKCjIGWMovKKm1UDv/jJK13+4+WgVNKuptc5De0JJ
         sEm4vv5IwVwtq/rg4fT39puZAeefr2gkW9IpSJYsxyS7HrWuJQ6YAkW2XrofzzNYbdAM
         /im/FUfaVGOVaVl7/PKY/uCYfS6CddVgiTXt/PbcUx9z5EDvdL5g9k+rQl29UJcfQdvV
         1YoOfC2sRyVzum5uRu4QCRcazJ2IAtQmZAJQsYw9LQultLc5VvkY4hVAwp8wuGV+yNDz
         ybesuqnWZQ/gcNm6BJEtanz+2doqu6Ss/D0+s6Zk81kqFrLm3YG2WSqxOKPhKVvpwok4
         58Ww==
X-Gm-Message-State: AOAM531r6SR+nkcyiLrixhSk6gvfFgdF/UoakeM2z1i4La8HI2pcYHVr
        z9mGNyn+v1prdh1yTUBnDudq6n7R9bNYuw==
X-Google-Smtp-Source: ABdhPJxyyLRnObFfY71gh1XOdlTFpAFNXVEJ+8HDVSVqYI0C16Ay93H7JvCNvx5+IPix9E9UuQJAsw==
X-Received: by 2002:ae9:dfc4:: with SMTP id t187mr21859371qkf.299.1612291368877;
        Tue, 02 Feb 2021 10:42:48 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id k4sm7415906qtq.13.2021.02.02.10.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:42:48 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 2/5] sunrpc: Create a net/ subdirectory in the sunrpc sysfs
Date:   Tue,  2 Feb 2021 13:42:41 -0500
Message-Id: <20210202184244.288898-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

For network namespace separation.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index fbb8db50eb29..ad6a5de5927c 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -2,19 +2,60 @@
 /*
  * Copyright (c) 2020 Anna Schumaker <Anna.Schumaker@Netapp.com>
  */
+#include <linux/sunrpc/clnt.h>
 #include <linux/kobject.h>
 
+struct kobject *rpc_client_kobj;
 static struct kset *rpc_client_kset;
 
+static void rpc_netns_object_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
+static const struct kobj_ns_type_operations *rpc_netns_object_child_ns_type(
+		struct kobject *kobj)
+{
+	return &net_ns_type_operations;
+}
+
+static struct kobj_type rpc_netns_object_type = {
+	.release = rpc_netns_object_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.child_ns_type = rpc_netns_object_child_ns_type,
+};
+
+static struct kobject *rpc_netns_object_alloc(const char *name,
+		struct kset *kset, struct kobject *parent)
+{
+	struct kobject *kobj;
+	kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
+	if (kobj) {
+		kobj->kset = kset;
+		if (kobject_init_and_add(kobj, &rpc_netns_object_type,
+					parent, "%s", name) == 0)
+			return kobj;
+		kobject_put(kobj);
+	}
+	return NULL;
+}
+
 int rpc_sysfs_init(void)
 {
 	rpc_client_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
 	if (!rpc_client_kset)
 		return -ENOMEM;
+	rpc_client_kobj = rpc_netns_object_alloc("net", rpc_client_kset, NULL);
+	if (!rpc_client_kobj) {
+		kset_unregister(rpc_client_kset);
+		rpc_client_kset = NULL;
+		return -ENOMEM;
+	}
 	return 0;
 }
 
 void rpc_sysfs_exit(void)
 {
+	kobject_put(rpc_client_kobj);
 	kset_unregister(rpc_client_kset);
 }
-- 
2.29.2

