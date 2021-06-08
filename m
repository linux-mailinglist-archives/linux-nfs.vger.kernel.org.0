Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168B33A04D9
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhFHUBf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhFHUBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:01:35 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4144C061574
        for <linux-nfs@vger.kernel.org>; Tue,  8 Jun 2021 12:59:41 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l17so12099196qtq.12
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pbi7uOuzeEl+VgFXrG3Aana1E02g2MQcsvlTjQXriG4=;
        b=n/XPFComesxQfpoygdV+MxbihlUYsSaUE+qfxp1kOKeIyiYlu3TpO0sF4qT3lg0XAC
         UM7Lh+62wnRWje3JcXhoZIYwXcAZiaeUd2pO+FrMBIjf66cAY8Ci6tJ+Ya5jwGKaN9qB
         OaD2k36q+Sw4H2NLpZfar7mXGL+DQhQPbwicJtRrSdyE200gi0xHA3LFFbDd6mmHVlAC
         ZncPBD6wKP6jafEbmKBGfCZ1TPHucJJ3qWUrJosu5R3pXsxr28SKRP51c+r6OgtQN3GJ
         hAMWy+W6GNVDrtU+TbG67R938afZ8dW04Ws3X9DT3HnU5Wces23BJD04H1lr1bQTMU14
         ro+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pbi7uOuzeEl+VgFXrG3Aana1E02g2MQcsvlTjQXriG4=;
        b=FOcI5sfqGgfkwNyQF5Cv3Mj0UgQ5if2F4g726vvlh69lY8pOa5+kwqvV0Eqb7mqT3K
         Hn8d7UMLqHofElFtCeKyEm/kDAEjIQJmlhnMfxx4NRMew7WlIOwY8xIxvONGMjHYfYYy
         C4lMlXtu1Tz/2Fo7puxxlJZ0cRR9Q+lnNdwFWdSGih10r8j9IxkiBdKaSvcrL2nsWLZN
         p9mKHp8X3a2f0Qjfd4iPKvutKHnwNzVg+gclJgCibcHIbvrcp7ezRgiTgoCsFrvVrt45
         tIZx2oBvGn205JWkzqTLsnhiE2mMXalNbd5J77KDsmRK0oWx4qMqDeRcCv8J48L6ohWW
         QOIw==
X-Gm-Message-State: AOAM531vuLLvqvdiHWkLKR6BWUEOT5db5Y5ojVgy0yjqOtPJkqChH0uv
        D/Z0Ib/AMm5P+kEiot3dMamIbr+FIh0=
X-Google-Smtp-Source: ABdhPJwyyRZyq1MmyFiXCjP1q6nxj+G/PAG+76b7KFL5ZJAYxC9d+X6/RcRxXTHbnlYgLG4SjQDECw==
X-Received: by 2002:ac8:60d4:: with SMTP id i20mr22699815qtm.36.1623182380994;
        Tue, 08 Jun 2021 12:59:40 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id j127sm12952765qke.90.2021.06.08.12.59.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:59:40 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 12/13] sunrpc: provide multipath info in the sysfs directory
Date:   Tue,  8 Jun 2021 15:59:21 -0400
Message-Id: <20210608195922.88655-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
References: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
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
index f770eb7301b5..b3bc76bbc2a0 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -67,6 +67,15 @@ rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
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
@@ -102,6 +111,23 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
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
@@ -235,6 +261,14 @@ static struct attribute *rpc_sysfs_xprt_attrs[] = {
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
@@ -243,6 +277,7 @@ static struct kobj_type rpc_sysfs_client_type = {
 
 static struct kobj_type rpc_sysfs_xprt_switch_type = {
 	.release = rpc_sysfs_xprt_switch_release,
+	.default_attrs = rpc_sysfs_xprt_switch_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_switch_namespace,
 };
-- 
2.27.0

