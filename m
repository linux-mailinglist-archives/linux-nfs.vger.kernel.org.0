Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3218C36E100
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Apr 2021 23:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhD1VdK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Apr 2021 17:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhD1VdJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Apr 2021 17:33:09 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF68C06138B
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:23 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z2so28212231qkb.9
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AxvYse25p7mVDdXqMW4p7/vI14ekoXGgbKFLyeBgpMg=;
        b=UZI3Is3OSmFpiGlN2dBjAehltS+tJZinARLNSHuBkPnuJjrOOs7F1L1koneGvP9yB/
         bOHj4MX5gm6nxfRMVQMS/CSZ028cEVWg5k4sEmWWNSnOkTXM3PheCJ8Qobsny7hX3Jsh
         azVf7fAn6AUPIpbJOZxfCHb27OwS4DwUL4uMYAivUQh4c+ifb9TU5VHe8RbFPBEJDEnr
         uqDpmOKxdi4Lo7Mnpl219/bnyEjUX2pvQfpUGpwR8mV3gRE/2RWDZwPbEZjWbhPrYb/X
         ePG7sQ7/3PjvTSh0u3oqeQtNDa8GEwGz0E1akf5VNgfCcA8uAfry8CD5vzVxyuUQDkMg
         iHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AxvYse25p7mVDdXqMW4p7/vI14ekoXGgbKFLyeBgpMg=;
        b=p5FXEsdzCvW/uZkpBFBk/LJWn0/v8mjK/5MkhlJS8HGxSmObcF3Ab5ol0EJI9eoXvv
         HQsHmhTd5RbFcba8j7iC63EMh9eycSQiZHP0pgsDwF7r8ZzAQ626JfGbB4X3Xfiu5K3v
         bYaOqW3XbQBDhYRNuLOgVdtIKIejOYFvkqDWc/LUj5GphDPSeqwjB6GRCBA5sUmKZ0PS
         uLO/CVbCZLwFfQGDSlvLECYcLzCvmFF8GDnVWy4O6pjrk357y22foTDRfyl5oudxZk7t
         ZOGMMFUrm69ijN7p2ZE8HMXqWsBemVvhlP4GhFJpkZ8gHLaAvB4MwQsXDYrWah5mrfLG
         pBVA==
X-Gm-Message-State: AOAM5307YwigtkPIBB1/SGRUBkDDFevzNrVx6IH+/hiJwy49LHNWOAFX
        jD/NkGUiruFi9ojf1XFHyc0xL/h7LYbTQA==
X-Google-Smtp-Source: ABdhPJwnEbCY+2Ws+pNug9wpHVzDVe/gugJDEBqA6N4ore3VXugvwnfFkHmDe/DLrluAIe3ohXXBrw==
X-Received: by 2002:ae9:ec0b:: with SMTP id h11mr30545682qkg.224.1619645542310;
        Wed, 28 Apr 2021 14:32:22 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-11.netapp.com. [216.240.30.11])
        by smtp.gmail.com with ESMTPSA id v3sm710269qkb.124.2021.04.28.14.32.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 14:32:21 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 13/13] sunrpc: provide multipath info in the sysfs directory
Date:   Wed, 28 Apr 2021 17:32:03 -0400
Message-Id: <20210428213203.40059-14-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
References: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Allow to query xrpt_switch attributes. Currently showing the following
fields of the rpc_xprt_switch structure: xps_nxprts, xps_nactive,
xps_queuelen.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/sysfs.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 4febc7008dc0..d452c6b3fba0 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -68,6 +68,15 @@ rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
 	return xprt_get(x->xprt);
 }
 
+static inline struct rpc_xprt_switch *
+rpc_sysfs_xprt_switch_kobj_get_xprt(struct kobject *kobj)
+{
+	struct rpc_sysfs_xprt_switch *x = container_of(kobj,
+		struct rpc_sysfs_xprt_switch, kobject);
+
+	return xprt_switch_get(x->xprt_switch);
+}
+
 static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
 					   struct kobj_attribute *attr,
 					   char *buf)
@@ -131,6 +140,23 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 	return ret + 1;
 }
 
+static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
+					       struct kobj_attribute *attr,
+					       char *buf)
+{
+	struct rpc_xprt_switch *xprt_switch =
+		rpc_sysfs_xprt_switch_kobj_get_xprt(kobj);
+	ssize_t ret;
+
+	if (!xprt_switch)
+		return 0;
+	ret = sprintf(buf, "num_xprts=%u\nnum_active=%u\nqueue_len=%ld\n",
+		      xprt_switch->xps_nxprts, xprt_switch->xps_nactive,
+		      atomic_long_read(&xprt_switch->xps_queuelen));
+	xprt_switch_put(xprt_switch);
+	return ret + 1;
+}
+
 static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
 					    struct kobj_attribute *attr,
 					    const char *buf, size_t count)
@@ -246,6 +272,14 @@ static struct attribute *rpc_sysfs_xprt_attrs[] = {
 	NULL,
 };
 
+static struct kobj_attribute rpc_sysfs_xprt_switch_info =
+	__ATTR(xprt_switch_info, 0444, rpc_sysfs_xprt_switch_info_show, NULL);
+
+static struct attribute *rpc_sysfs_xprt_switch_attrs[] = {
+	&rpc_sysfs_xprt_switch_info.attr,
+	NULL,
+};
+
 static struct kobj_type rpc_sysfs_client_type = {
 	.release = rpc_sysfs_client_release,
 	.sysfs_ops = &kobj_sysfs_ops,
@@ -254,6 +288,7 @@ static struct kobj_type rpc_sysfs_client_type = {
 
 static struct kobj_type rpc_sysfs_xprt_switch_type = {
 	.release = rpc_sysfs_xprt_switch_release,
+	.default_attrs = rpc_sysfs_xprt_switch_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_switch_namespace,
 };
-- 
2.27.0

