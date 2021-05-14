Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE6A380B3E
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 16:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhENOOk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 10:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhENOOk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 10:14:40 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8867C061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:28 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id i7so20752309ioa.12
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=Lq2XcgD8KBuwcg654vEmDSzfSYzKMm3uSbkI/2G/ULacmGHTcMgzbVbCwP7NKSr4oJ
         5pAIZd5rvFxik5SX8mCJsXunvCjZepvmIG0aZsFOZYhKknDAB1XmpbnA1CyrO8/3Str8
         ncxq7X6I1CiNFao2GztmwzTAS7e+hENqdDQyj8bVSn8GYCYQhJwZKyP98F2PSNNANfhJ
         PvAmyJ24BXEggzWI0URslx8e1fHDnzVtdWr8Gg6kM3+qRukQ2Sxe0v9MPYvQAfH5Gchq
         VkPlXJjceOSnKNUpMyiWLp9SWt2Qh6jbpSNDkkroQzYKHDj49WEkmgorzWvbaW+dHej5
         oExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=tSPZkHdMRcRKlE4DS0PwTozmgaRhylL5j1mRXVCnrsPk0P5umHuhmSlwaaPKA/prH7
         Jfn0vfgRBF7W9KVGnFy9+xD04kZOnciY2mDWBUX6lhGySnGgovwVJkna9zOMM7wxZB0T
         OK54TU8+Sd5x7q+5NI3C3UBOw1rWVT5ytQ9t/KlFL1rooleQC4lXtqHvzpLcJZeKTtzZ
         hk8915gBXm2KA6vennCLjjS6UFvN3AOHYbJaldvuKI8h5NKun6MaI+E2HmMpRYDgPFZP
         d3y/qkQlIlnJdB37W6JyJc6U480Q86ssa8LlWJD15FHuTAMWakhBSewnUtXZ6h/MsOVp
         892Q==
X-Gm-Message-State: AOAM531QG3YZtGlxa4FlJH69LKi3beIhH0xGJ8uP0QxfHdasRzxA2HCn
        r/e+KD6X4W8psHcGrbmcBtqOCnG2Rulp9w==
X-Google-Smtp-Source: ABdhPJzjTP8okmwI1gXbwfw1le6LC+rCYgghirwM06mw9uGmCcAub+btVP1LBTwDImK1jKZzKxlaxA==
X-Received: by 2002:a6b:d20e:: with SMTP id q14mr35353521iob.200.1621001608333;
        Fri, 14 May 2021 07:13:28 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:a4f7:32c8:9c05:11a7])
        by smtp.gmail.com with ESMTPSA id b189sm2639263iof.48.2021.05.14.07.13.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 May 2021 07:13:27 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 02/12] sunrpc: Create a client/ subdirectory in the sunrpc sysfs
Date:   Fri, 14 May 2021 10:13:13 -0400
Message-Id: <20210514141323.67922-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
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

