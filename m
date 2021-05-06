Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A902375CDE
	for <lists+linux-nfs@lfdr.de>; Thu,  6 May 2021 23:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhEFVfl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 May 2021 17:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhEFVfj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 May 2021 17:35:39 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218B9C061761
        for <linux-nfs@vger.kernel.org>; Thu,  6 May 2021 14:34:41 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c3so6017052ils.5
        for <linux-nfs@vger.kernel.org>; Thu, 06 May 2021 14:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=TttQIeqJ62PdTm2irDE+zSonN6b0+p0I6D0DAt6Rs0h8+ZmfACeeO+BvQ7vh3Q2+Ze
         mLLJEfpQEzvO8ECWFIqjKEyv+fnXRzfzKV9sCamNtuTByQsM9IHfhvDqxvsY1BsIRVeR
         3E3B/lINOq2qwz4kgSiqWNBtKjRBDxuDshHTRfxHc4sWxCZbup3vsVxp97h+TDy7zx3N
         73lYr37xSc5oSIpIyMUnALJkt90le01EdCbXbLVcmgLXGI1URlWAyCvGGHxsz3Uz+NJV
         o9lnQP9Rh3hLQ4FWnxmpyiAZumh66j5YJCHmMmyrueUvuTHzMTbV+tRVmmOYBuREJNYT
         M3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=h9AG1H6R0U2Nbam+tW0SF4h4nFbLjE/EZ/yFrsUbuJVLPebkVzrHpMkDbAfycNjtiM
         HzXMZvFmo6JAj0fVr+NAF93wUPK/a7eucPN9B1Ggq3p2ujkFD3wQceUt1bHrUt1qBvjX
         4UoVo9AIXNgZLBRB+Ol2BTd+451bNTYEqCDJewLkLW/UBfcH/AFJ3xoMIquLpShNaZT8
         Hg8myEacLSLkqeGUhPr0GAN1gp8cbkIJQ4F0dIBeib+1W+C4o8NSHsyPMJpT+Svc3kaP
         QhTlDh8uR6eUajbmeeX+8wl5yPvnPmIuL87qPU2REXArRCCWugQ705Zpw83YFrYV986D
         4GZw==
X-Gm-Message-State: AOAM531oUP2zbizMTobIMaKGmgbfsBMilB9CNnyMSGKNcYQ/8EWAOFSC
        KvljHU8I5WisVOjMjS9VCSua6Q2ngC8ZeA==
X-Google-Smtp-Source: ABdhPJwWLSqAH+uavZKKfBEpdXOHFvMhIsrAmpg0/4YbmwFNEOxiQa/2PACmF7/httTFOeznTZSgkQ==
X-Received: by 2002:a92:1a0f:: with SMTP id a15mr6614525ila.266.1620336880662;
        Thu, 06 May 2021 14:34:40 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id 6sm1486019iog.36.2021.05.06.14.34.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 14:34:40 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 02/12] sunrpc: Create a client/ subdirectory in the sunrpc sysfs
Date:   Thu,  6 May 2021 17:34:25 -0400
Message-Id: <20210506213435.42457-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
References: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
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

