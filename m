Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41576397C45
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 00:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhFAWLd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 18:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhFAWLc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 18:11:32 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C5FC061574
        for <linux-nfs@vger.kernel.org>; Tue,  1 Jun 2021 15:09:50 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g17so412174qtk.9
        for <linux-nfs@vger.kernel.org>; Tue, 01 Jun 2021 15:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UEc9XKgTDg04PxnNNdoApLDsaEagyPtlfadpwjys6qU=;
        b=SCKtRufS8DP970nUVx7gZtOgKavzousHvLuWVl+krRd6g1Lz//bnesAXBXMm1ZC9CF
         RHzrWDizMJ0vPg/ApK4ivOgIHU/Kqcj5rq8EELZA7btd79GCB0morawF0IhM1L1wMraO
         NWcOtF+jnBBG1Q9xj+mSXmdSaEwmcDwmbCp8QvjYp30PfROhCsCXBpy9Ce/lB1fw+KUV
         YsL7dQSlmd19CPWwpaeVXQB/RXLc+0N5OoS0+aqeEcIVGK3l1oLLbdG3F10KdZKXsK/b
         UCx1mHBn0AgAUJPiqDzU1zy/BlHy9kFMwaYM7bNFDeYj2bZAu/q5GYEkWcc2aX9smXhZ
         FjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UEc9XKgTDg04PxnNNdoApLDsaEagyPtlfadpwjys6qU=;
        b=mJoL52aom6u1FUKge2hjhv8e1P2WCrQVuBagMvGTgb56hs4TK7QWuU+Q1o8ukrP+L+
         TElwPWErJNR4JT9o2gnjAlGBM6yEBsqDTuFx+i2Vm8XR8zWaXu7mHG85qT/cVzRI8QND
         whKr89AxmjMpqtSoZosVjwDSi7ClE8Ygt5/6H9mJhlgYj6SCYEt6sabqRdwhlg9hz+xE
         +NjBgLDiFrj/4ETx4732+C/D+v5ZO+HMxF9MZKPdi+4MFNp3I5QvE/8+zX+BawBJ2qma
         UV/4BlpVUy9d4kgFLvdw7cFiujer2yb9fV+pywi+gYwnxxQvlRxUR0lkprC0ak8IDyby
         kdpw==
X-Gm-Message-State: AOAM533Pg+aK3y6C3T6KFgZNPvc1sCogEADGh/mfqjcVZYtFdBcpLSsC
        KEq70t2Se8sO4K+AQSbHmXA=
X-Google-Smtp-Source: ABdhPJyHVdpTD8f+HSDLvzTTa6PrBEPgToU2QaTiy1KzJsF1tKSdZY3ww8OuqyW6vlx5YhM+xHsIzQ==
X-Received: by 2002:ac8:4698:: with SMTP id g24mr21681634qto.112.1622585389520;
        Tue, 01 Jun 2021 15:09:49 -0700 (PDT)
Received: from kolga-mac-1.lan (50-124-240-218.alma.mi.frontiernet.net. [50.124.240.218])
        by smtp.gmail.com with ESMTPSA id q13sm12419789qkn.10.2021.06.01.15.09.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 15:09:49 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 12/13] sunrpc: provide multipath info in the sysfs directory
Date:   Tue,  1 Jun 2021 18:09:14 -0400
Message-Id: <20210601220915.18975-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
References: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
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
index dc97c16e4ff6..db2ae28bd0c3 100644
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
@@ -103,6 +112,23 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
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
@@ -230,6 +256,14 @@ static struct attribute *rpc_sysfs_xprt_attrs[] = {
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
@@ -238,6 +272,7 @@ static struct kobj_type rpc_sysfs_client_type = {
 
 static struct kobj_type rpc_sysfs_xprt_switch_type = {
 	.release = rpc_sysfs_xprt_switch_release,
+	.default_attrs = rpc_sysfs_xprt_switch_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_switch_namespace,
 };
-- 
2.27.0

