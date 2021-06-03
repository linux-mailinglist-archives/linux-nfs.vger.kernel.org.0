Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C8439ADED
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFCWXy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:23:54 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:41759 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhFCWXy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:23:54 -0400
Received: by mail-qk1-f173.google.com with SMTP id c124so7554500qkd.8
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2O1Rc0B4MaLiF4ddNBhSLPgkvvRZV1wupfBsBB9Mo8=;
        b=MtDjiGnEPwZFldAaoYreFeThzRSn5N8nEbn0SRYpDQULALGoTBoBRz3UBu2u3G5c0E
         1CVsbCySWiLhl8CUCTWLA1y7teAuoYdGK/ZV+Y3RAnLVZAtmX3tBQUsWhMltLzL+qNNQ
         UOy3/N6ZGQWR3ACc6QYiG9UjOTJNBsO8FZowGHtoMxSK4ZoEQ/76GoyRK/VKr5nlQJ5J
         rEdrBQKLIG/9//4e9NmkUm52gr58fa8kw62fp+RTGWMF5pdECW1uWUCryCAi6gdUdejb
         /wzThGwVlte0+14b/atzc+FaMghh54pBFDEl770gP/x4FyiBZYMFss/9fIIZnQwsMkVZ
         eoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2O1Rc0B4MaLiF4ddNBhSLPgkvvRZV1wupfBsBB9Mo8=;
        b=cBrNMezpdopbOb65IZ92jJ+9sFKm+mxuKG8b3DjCaE1xG68dfuGjuOuzOzxWRdbDGV
         aTaLIFPAjmyNm37ujjc4AlKDMSkNqyRnrOk2/OTkg89DTKgzsPJho4lu+DLc0VpQWi6L
         POJiAqpM2xP8MBqML9D75wjG2MSvJp4wUghcVpewmepN1J6h1Wy8ttuTEYZfvGF14hm9
         PaU7WqteyQLuhk01bNFv6LXbPFh0hQsq0dTunyrBVaUfDYdaQ1GvQMQqXKEdhBuEHTIx
         CdQ1KwowteELp33SDwtpWw5Y0cTJc7p0tCH3xWWfN7ChtfY98XYKOFaRVl2SRfUxXMeB
         qChA==
X-Gm-Message-State: AOAM531k7G5194m9+j8VT28nIKnNH/qcz52fruOpLnQSBLcOBHMQBP2N
        1rTaUS7P7o0luSSWrQwwDN0=
X-Google-Smtp-Source: ABdhPJwo8uRGA2CR/OEG+iLGvcUR38JvXkwC5D0P5jXo8wZUljhewDjQOtF/Hfims3ydNz2MCjEadw==
X-Received: by 2002:ae9:f310:: with SMTP id p16mr1467184qkg.267.1622758856045;
        Thu, 03 Jun 2021 15:20:56 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:55 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 12/13] sunrpc: provide multipath info in the sysfs directory
Date:   Thu,  3 Jun 2021 18:20:38 -0400
Message-Id: <20210603222039.19182-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
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
index 23a3eb08b5b1..819134f28a4c 100644
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
@@ -229,6 +255,14 @@ static struct attribute *rpc_sysfs_xprt_attrs[] = {
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
@@ -237,6 +271,7 @@ static struct kobj_type rpc_sysfs_client_type = {
 
 static struct kobj_type rpc_sysfs_xprt_switch_type = {
 	.release = rpc_sysfs_xprt_switch_release,
+	.default_attrs = rpc_sysfs_xprt_switch_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_switch_namespace,
 };
-- 
2.27.0

