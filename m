Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99540380B49
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 16:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhENOOu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhENOOu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 10:14:50 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D69C061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:38 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id o21so27813544iow.13
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkHFWwgIT/D/iLTUtBd1vgh14SkTObnUzS9TxcYtD9w=;
        b=rlPMGB9SGjPkQOjoeKdpk+otWNr/g430FYech1ph/2l1I1daW4PWz1HrMeFVKvZMgw
         L026Jm5v3yNZjL5/AhpDAsjd/5hAoAyMftcPLga0Ei8EC+9EIGqz+r31EL3eSpFjxVPQ
         ufA/DMH2KsUA96HzBDjVsgsdg9Qt+m8NRlkFOesC70w+gyL72Axd0IsxWAfvRbzmupcc
         WHvJgi+nRJEHxCoX7SFCGqEaeq4Zuv7BDn7FEYvZRIMeHR9imnMQTikRET9eB4JelvSR
         btk4IjHVvDF4niDwWGTU6Q90R8ii61WUJid0KsQfsWoMvU+dlkdocMRpe5UtqRABy1If
         b/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkHFWwgIT/D/iLTUtBd1vgh14SkTObnUzS9TxcYtD9w=;
        b=uVHzZf7Unudc1tMdFFLuVGOSYJ5qxqazx4xekM6chQbZSknvnuan2efykCkL3xHq/V
         9FXTVa0x17GAgrYzaZUi93IicQqHcbkHwwMRU+Ak4VpI+HF4U3FFKnLYkbXzJYkyREVc
         2yqg43SDlPWWOUq9TO3mIu8ficG2XnLAYmvgxtykYDw+qqAkmQjBLwn6eF/NPDPGnlPy
         dG7akDRF4uEUM6Q/zeNV4tMrAB3OMcPiWFSM67zKjEsI1Of4zXLBVsQgsqVnBnIvkmF0
         g6Wg6jodwftqZmJi2+HtcL2/dJjOBigtabR2TGluqgSoOKSZbWvrngSAjrdTFbQ26UZW
         NtWQ==
X-Gm-Message-State: AOAM530BjYrcF/kv8/qUqZ7n0NfB5DUXUVkLe6EyFzhHtQwPGbulH1gv
        j7o+PQeTF9q3Z4s8vQIv6HRWunMTz+6apg==
X-Google-Smtp-Source: ABdhPJyev+LTcojfhY4kFaeFKhVMFXsuacFTglnVucxj/9FuW7GoSs/H+H/a7wdETtbJqAnC1Phf9A==
X-Received: by 2002:a6b:5402:: with SMTP id i2mr35145885iob.66.1621001618233;
        Fri, 14 May 2021 07:13:38 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:a4f7:32c8:9c05:11a7])
        by smtp.gmail.com with ESMTPSA id b189sm2639263iof.48.2021.05.14.07.13.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 May 2021 07:13:37 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 12/12] sunrpc: provide multipath info in the sysfs directory
Date:   Fri, 14 May 2021 10:13:23 -0400
Message-Id: <20210514141323.67922-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
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
index f1936effa5a0..6da86bdad844 100644
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
@@ -258,6 +284,14 @@ static struct attribute *rpc_sysfs_xprt_attrs[] = {
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
@@ -266,6 +300,7 @@ static struct kobj_type rpc_sysfs_client_type = {
 
 static struct kobj_type rpc_sysfs_xprt_switch_type = {
 	.release = rpc_sysfs_xprt_switch_release,
+	.default_attrs = rpc_sysfs_xprt_switch_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_switch_namespace,
 };
-- 
2.27.0

