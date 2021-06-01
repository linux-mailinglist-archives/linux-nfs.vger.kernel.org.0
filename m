Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7BB397C3B
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 00:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhFAWLO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 18:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhFAWLM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 18:11:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAC2C06174A
        for <linux-nfs@vger.kernel.org>; Tue,  1 Jun 2021 15:09:29 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id t20so418581qtx.8
        for <linux-nfs@vger.kernel.org>; Tue, 01 Jun 2021 15:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=StKpaURjIifFv38T4RDNKDc59Tc+maD3I6nlPXd0BLF0PKZcBq+TPAZGJg6hXpSVP2
         8OQwGi8yHWXzuGfbTH7d0Qf7ssTJ8tFE3+IXM/k0gQUQg3AbL1UmRQnz78VC+nCk+d2L
         x2Kz8Kk8fWZ3p8i0jHGxjjW+zbWIhxNOYqSuCh0Fs7KMWShGI5PvEYkvVtgnLvtyUgoB
         CSGpFkD4Snr/bVzYPdwUv4kKIWnAhyNTTrb06auWOpzw/uhBayWczwTvURvX7cNp669/
         OeVWjkNsiwCPly5I+Vz1ayPv/gS0n3xZFbWjzsrz6h+zPFytpebPpzfQz08fzWlFcQXU
         aTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujEDos81NUbHnHXtpykY5JrCoGurJBkkkPFV1HlWdwc=;
        b=oHZwcBF2YOhdpX5kr5AlzZUYsGLyUU0WNXFaGXBfVcNb9aYZvymWXvoGXuHXKh1UCE
         NMoU4mzkX8DdnOCi+gp7V/DQ+tlMOeHGRvCcE61VSsheOxjQExwLNwApCdjzvBPHUc3h
         X3Q+diMKCnXLzQqinZjIDTLQzTu9i+++thr+zMWq1q3/pUmLE6Pvwjl1RL07+x2bCR5u
         i20miuHwk8ennjCzhlmJ5NM/qRWcoQIFF/08WOwFMmpliL07eN0kb60ngxhd2Tbv0m7r
         S8uzy6hRilP9I0hmGsb3k6oxBUTI/84xy//LX5sQsrXSXu+V0OuP6t9bZDti8qzUT5Yw
         GLjw==
X-Gm-Message-State: AOAM530QCGzahRcdXTKd23/K1ch70HmJG3Uea9uuI99wjYNjBDUsedyP
        VSQ83JGJL1TvPckM9vUm/sc=
X-Google-Smtp-Source: ABdhPJy8rBcj1/bNnSGPevaNClbdwUQyT7XVUl45ceKbdd3WsLthPhgzNJPbUuy2mz5X0ldJ0KO6zg==
X-Received: by 2002:ac8:4a95:: with SMTP id l21mr5432981qtq.317.1622585368216;
        Tue, 01 Jun 2021 15:09:28 -0700 (PDT)
Received: from kolga-mac-1.lan (50-124-240-218.alma.mi.frontiernet.net. [50.124.240.218])
        by smtp.gmail.com with ESMTPSA id q13sm12419789qkn.10.2021.06.01.15.09.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 15:09:27 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 02/13] sunrpc: Create a client/ subdirectory in the sunrpc sysfs
Date:   Tue,  1 Jun 2021 18:09:04 -0400
Message-Id: <20210601220915.18975-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
References: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
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

