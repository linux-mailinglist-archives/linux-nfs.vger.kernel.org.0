Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF11339901
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 22:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhCLVSz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 16:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbhCLVSc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 16:18:32 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0AFC061574
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:18:31 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id l4so25867389qkl.0
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RtzjEJB5ms/fI+WQZNcMRSa9eOpSN3/2cnTyDn6MbtE=;
        b=GuhMspjYbQ7uwOjDBLSA9IHXS/hjOWvlH4/ZLcWVgFzxJ5l1Kcvnz1CArZTqPvsvSj
         7Dv0+Its/1WcNBzSKpZxXs8UpOLGFfsou9MDSMMsBJUgpoFng/ze3NlhCAHcQlzDqdI/
         wy+34IC6uQCRV9j8tRWJW/PenZ9qBut1ME2ZZvdA8e1Ped/ZlAl5IfrrvI6V1rRisqlI
         MABSHEEqLDeaJ1oj5oLpIeCX6vWRutE+pkABrWR0q2g43wv4bKh3bqgbyHFGDmLv199n
         KiUp+YHWFvkNpTxra6t8lEeRloBjZoKZBuoFFFhiE1JPfJOXL2DsAMvk5lfEsPZoQ1Og
         AzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RtzjEJB5ms/fI+WQZNcMRSa9eOpSN3/2cnTyDn6MbtE=;
        b=gW2vLXAoFmhLuGjVEuJI7gPTWs+3l4Cob6XZRDbC3pVTgQPaiyvKzvwWZQvlwRAmJQ
         uSXVoQulK5TRWC91H4Okj0LI0V82NHjLSJQMy4J37CO/wfWKNuh7ekUy4Burb8dR8xvk
         BKtTQDWpI3v4Zs0nHKbUFjOfH2NBdULFgYEnJlPUBruEdMRjuzKGdTwjkQzMUgl7j1av
         HdWRHUvINH25PVXRdei1MnbLc52POPOqHTHHV7YFyBKJ7dFpInhc36bVfK0ZEzJVh5i1
         nYFcAHX4uAi3ZsPDTGusn+wag76ZEtfuOn/7ZfJ9FE27hJAMICIATk08/sd7yCxjIVhx
         G0Sw==
X-Gm-Message-State: AOAM533zYG6fnYeNgR44bZAW7UuPLC/1P3BIPOZsbKCFyNTiAP8+fxp5
        3098lS67B2Lo0gnE5UinrUGnf8rZtV7oCA==
X-Google-Smtp-Source: ABdhPJyq6qIPT8oGhkjhLnovxC9hp1G7gOOCo9sp7PXGSH7pvdq0qWGlConIYdOYBjc8PRw6E1pF/Q==
X-Received: by 2002:a37:2e46:: with SMTP id u67mr14947053qkh.488.1615583910304;
        Fri, 12 Mar 2021 13:18:30 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id d24sm5177490qko.54.2021.03.12.13.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 13:18:30 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 2/5] sunrpc: Create a client/ subdirectory in the sunrpc sysfs
Date:   Fri, 12 Mar 2021 16:18:23 -0500
Message-Id: <20210312211826.360959-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
References: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

For network namespace separation.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v3: Rename net/ directory to client/
    Rename rpc_client_kobj to rpc_sunrpc_client_kobj
    s/netns/sysfs/
---
 net/sunrpc/sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 27eda180ac5e..350b2b1628e7 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -2,19 +2,60 @@
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
+static const struct kobj_ns_type_operations *rpc_sysfs_object_child_ns_type(
+		struct kobject *kobj)
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
+	kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
+	if (kobj) {
+		kobj->kset = kset;
+		if (kobject_init_and_add(kobj, &rpc_sysfs_object_type,
+					parent, "%s", name) == 0)
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
2.29.2

