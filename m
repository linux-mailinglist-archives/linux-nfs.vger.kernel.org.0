Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB112F2201
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 22:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbhAKVm3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 16:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731409AbhAKVm3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 16:42:29 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A334C06179F
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:49 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id o20so132097ilj.11
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2qZ+/NHu9qitlfY9CsT899PIat5X/YwJzyn52LaTMlU=;
        b=SgEG4Ah5oe/eIPnpOQz8mmW/sjCrJTFcA43O7Xbk2c+7C0+Zbnj4T04z4mUppl6jIf
         9jOyzFRvewZXFM6XxZS5T0JCLQCryI6OF7jYdTSTh123188m6qR0MRDPZ0oSp4B/VvtN
         xQQ346DZU9YZUim/FlKimi60dS6okHtrjCc9mjKNcIGphYkpqIiFu0ogwHJ4Rn1JdR3D
         c6mNG6wifQ1K8VbHKG9Iy2d4a8TpUL+2+mFyh89Z7c/BANiTMwREAZNZPur+1fZ9D3gG
         mdQrLdOFBRCimPUUIqpr2DmN185u3ZSQBmKzEMTkArlgmOlvRrm+VK78KhAFeYLFaM3A
         g9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2qZ+/NHu9qitlfY9CsT899PIat5X/YwJzyn52LaTMlU=;
        b=ATB+RoMiTd9BhBUbP7qwB9MII3wVSobpV95WI0adABQLpWn9zqBUkcvN2zqRNjNNox
         lTsQbZoFusqzLsNfpobqw6eVIOD2LiOLbXzNonyDYzVPZyaEAz8AeWgdAAk+fJNYYTVG
         Lrhkp/fugnUwpLHzuzVukUKI3ARQ7GkN87xe83aI5DtBIj4TplYUyizpQUnZXxLYkhVK
         z5AM4MOIplP97x1WTSftdvR1X1qaTkeNW1XFqt49Q2O9sg7JLCI/X9EmethBqlmGjXa2
         YsMMBxwYiDLd2A6iWhd8ODl85Ow3Rmp9snY263dTwV/kVPtp44ANqymKU2LJlmDd2zDH
         Xrlg==
X-Gm-Message-State: AOAM5303roQHuuCIORUlXlMiJf7DUlqAyPDxsauk2aWQ/5MjiqsFdqxg
        wXW/949Sl9ovkttAMXCf0rsQdGYnWILi3w==
X-Google-Smtp-Source: ABdhPJzWDbZYl1hFPuwRVhcvixCzoiE/x61uAACC/zJ6EDvScJ0vcX2YpSDEuMrbeoHzNFKvSXTUrg==
X-Received: by 2002:a05:6e02:80b:: with SMTP id u11mr1040603ilm.43.1610401308231;
        Mon, 11 Jan 2021 13:41:48 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 143sm681712ila.4.2021.01.11.13.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:41:47 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 3/7] sunrpc: Create a net/ subdirectory in the sunrpc sysfs
Date:   Mon, 11 Jan 2021 16:41:39 -0500
Message-Id: <20210111214143.553479-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

For network namespace separation.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/sysfs.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index efff6977095c..afeaec79a9c7 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -4,18 +4,57 @@
  */
 #include <net/sock.h>
 
-//struct kobject *rpc_client_kobj;
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
 	rpc_client_kset = kset_create_and_add("sunrpc", NULL, net_kobj);
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

