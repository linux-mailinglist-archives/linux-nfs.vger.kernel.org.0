Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768B236E0F6
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Apr 2021 23:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhD1Vc7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Apr 2021 17:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhD1Vc5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Apr 2021 17:32:57 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDED1C06138D
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:09 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id l2so13669158qvb.7
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=XzzWuFKIaoKfV4JIv/pPthtov6glXCXuCdB28d7RUgoiOgAydvClvE76eZPV543bs8
         y2QsWmEsdF8GH3D03RBa4IP7eERM6j4b1DWhtIu3ilTycPLHziNjkxlGmfAu/QaBYUzE
         oYxaHfkm/q7Ee8SsPPyghoZadhVeqU3n4G4DiPeCmOBCMEHDP7dJJ1gGIaDA9mkTuRFt
         1bBf8/kWpopQhhxHTUa3ozj4PGPDKAVOVlx+Q38N6j7iCX1cKvu/jshDX492t4P5GhWz
         y2fCXkg9FBcpY6w0+FMKv8a64KURovwkW+RDnFNEnXdpLq32NG/Uy5L8tOsuvtC08RvO
         LnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=IM+pJBqPUDUAR+nLQfGRKEus7xYh6w2gOo7N0eGc+FZteZTZ77nPjo9doHcYDhI+q6
         K/NJYtwi9WKizPxdAF90xieXyBSUIai2QHTOfdMknk49MC/518RfcT2IuUun58BJZPoO
         xuK3+6raIc8Hv9pJL0UHAsDUFSlHX76NSJmnov0tCb+73NlxdHEzhJT+Mi1JaqRJNEzs
         GNe+j9AavRq8NJo1G3TlC1qG79gaMrVsFmK7LcB4LuwI+8/1MwD9f6c18+3A9cxvnPNY
         y/rXb/k004dH2cqwM90C9Q1f4vqi/gX5e1zjGoVf3YwnXa64MMOuk+S54m+Aig53MOY5
         lSLA==
X-Gm-Message-State: AOAM53149P5sKllOdKkpOENLx0350wRXw+fhgiETuiNa3WdXf1Nay7aA
        jROp+VvAEI7qDEmqIce5MOqLQDhm8mZvbg==
X-Google-Smtp-Source: ABdhPJyVNZuvB0Hgo4+Xym7mFbhZQRN1XgCLsXVVIOQ+yaXtArzo1nUUSuPceAa+4yRQc0fqFDbdLA==
X-Received: by 2002:a0c:cd10:: with SMTP id b16mr3334075qvm.0.1619645529060;
        Wed, 28 Apr 2021 14:32:09 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-11.netapp.com. [216.240.30.11])
        by smtp.gmail.com with ESMTPSA id v3sm710269qkb.124.2021.04.28.14.32.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 14:32:08 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 02/13] sunrpc: Create a client/ subdirectory in the sunrpc sysfs
Date:   Wed, 28 Apr 2021 17:31:52 -0400
Message-Id: <20210428213203.40059-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
References: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
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

