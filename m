Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC8F3768B1
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbhEGQ0z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 12:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbhEGQ0j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 12:26:39 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD80C0613ED
        for <linux-nfs@vger.kernel.org>; Fri,  7 May 2021 09:25:33 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h6so8133129ila.7
        for <linux-nfs@vger.kernel.org>; Fri, 07 May 2021 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+R8zJdVn2kB1C+HMv1jEHa9gyeLof9AKrrYY1eZWVbU=;
        b=qy+eR2ti9T5FGYWgut5L47y0QowFx1WlinIkaeqviHmAZD7YqEOvUt79GkBgcq9tNb
         93xeyeW7ha7KVAaYzGxhRZOMAP1B199QRtyuGmmXrDwzDiub5YBWSXDGCjzktaRXp1qT
         HXcQdjyMGFpXxoCr/BrrLwVzPzOlnAksHfMk2IzlEXeaIwe5NlnH5smdOZJmosy7N5vU
         HrkEYpQc7QhmPMK6aacteJ/wdrFvyqSI0VK05qNTi9jFPA+cAmW27jzJLVWJAh0m54IC
         x08x3y+eQloOSqw3KneTzhNGwordk/OJOaUzj1ekaaeWcXDysuNB/CyVWlF/2sUrpZbr
         k7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+R8zJdVn2kB1C+HMv1jEHa9gyeLof9AKrrYY1eZWVbU=;
        b=qoVfAEv9rYSU4OwyBovLvLe4Wzxh1Rfv3YM5o2Naoht05R/DSTDUiaIwSPLStIddgS
         /PHly55EitJhjdKx/BoLyQINfm810qsGc2juIoQ1kWLqerN/FN7V2EGTIdjsnBfJjC+x
         WAn3rUuMRLGrnqSoHEvGpH1zCGXl019830J7aB8OjWlLW0G5z/IyhL8qUp7/FT8yDDSt
         TPhSbB9A9pnqIOtfcMF5YF6brFRFeycQSZmFs4j2DWOaPAtE4yKCsxDnZ1UlwrNZd8+W
         yQSs7HWgz8i2hTljMovrNI0+rqEI51WZh0x2EPx7NCstXUq0xVFLMCTBZLZUW1oQA4pm
         sPDg==
X-Gm-Message-State: AOAM531+WotXb3RP6Qz1FiLe7Rec/tCQ2zRf53nGddDI5zY5hstst/hc
        RlcVgp/akXS1SOIyuDBEmMo=
X-Google-Smtp-Source: ABdhPJworjoKfEzNaKManfHTtdwcA1YDspsaCI3tuKCnX0ydhZvCFGTwgOX9h4jz/w5dbvPwKILScA==
X-Received: by 2002:a92:d409:: with SMTP id q9mr10220858ilm.276.1620404733187;
        Fri, 07 May 2021 09:25:33 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v2sm2451000ioe.22.2021.05.07.09.25.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 09:25:32 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 12/12] sunrpc: provide multipath info in the sysfs directory
Date:   Fri,  7 May 2021 12:25:18 -0400
Message-Id: <20210507162518.51520-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
References: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
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
index 785b5f4a4178..77edaf0ea9b6 100644
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

