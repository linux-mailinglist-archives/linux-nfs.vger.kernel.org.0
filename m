Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C71F360009
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 04:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhDOC2m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 22:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhDOC2l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 22:28:41 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D464CC061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:19 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id x16so22744118iob.1
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHn8kyaxpvuxiGlh5h7Y6bmqsgwXzLA56QHLJITMaS8=;
        b=MsT+FnrwVLVUy4JgdcfK54CTNeEuPH86MikhVENR39H3flI+IA//BIJNccqGgmteqq
         i4P3bjNKnKjRs/kGIh7EI/2aGE50AH/+R3RJnHQPnGdVPORP4PO09e1zcwWnyJjzD5HS
         KnLJKyZ6p5vOxh+v1/XVSFVgdLVwfriZJnajHOx5LkVlWKzRCIgWNVl5xoqr+AtZTPgA
         ZW1Ku0kB9ksRkFXpG2Kpwh0mx9NxuA+VTiXU1J2V8Zmjub/dHPlMcccSB65R0ggNN3Vk
         +sWArHoWZDRgQkMJNzgx2f1SZDfxziKkyMwuProbz2OM0KIpmN/jw0tIskb2HmzPZ5cg
         kXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHn8kyaxpvuxiGlh5h7Y6bmqsgwXzLA56QHLJITMaS8=;
        b=Ppd5wliAr9du0bWog1sWkyAuX4eaauZ+L2CGDDKNLz0mRDDR6yvlcgdui05DtX019g
         sYSjY4EAAuWF7ufCmvFbF33V2uwLioIzZ9MO8Rqk7bo/AnvumWavw619JU1IRQ6blN8W
         tzsbbRIXP00TQFfk3EADe2oAVMOImx/eM1m45CDE/wfU9igY8QiJzioWebp8tYvMFMDo
         o46STAlfJYEIlkX27bcRqnaCOj3z1LXr4WkeFMCJ2RJzSlDzPaxtiCfTQRzgXQFp6tqE
         PWfEyAOfnN9LWB+rQ8z4AVuiPagUO9wXE/CJhEH+VdDX1ix6kX/jhdTIuQ14gGEFds/l
         Y63g==
X-Gm-Message-State: AOAM5323wxazCplPtNLQGcPSM8NUULfTl4QQLXf/9e4p5P/16nMbqX0M
        VMgLzcwNjNjeZXo4lkR7MUY=
X-Google-Smtp-Source: ABdhPJwsOqDo8+JP5dux0oEHH3037jbgPQfbwfBJap9Ihj3w5ujvikCyg1sBn7AZKZd8Ij4iYuOljQ==
X-Received: by 2002:a5d:8893:: with SMTP id d19mr832859ioo.167.1618453699328;
        Wed, 14 Apr 2021 19:28:19 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm608917ilh.47.2021.04.14.19.28.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:28:18 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 13/13] sunrpc: provide multipath info in the sysfs directory
Date:   Wed, 14 Apr 2021 22:28:02 -0400
Message-Id: <20210415022802.31692-14-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
References: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/sysfs.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 7a56e30b92c5..94b47d6c6b79 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -58,6 +58,19 @@ rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
 	return xprt;
 }
 
+static inline struct rpc_xprt_switch *
+rpc_sysfs_xprt_switch_kobj_get_xprt(struct kobject *kobj)
+{
+	struct rpc_sysfs_xprt_switch *x = container_of(kobj,
+		struct rpc_sysfs_xprt_switch, kobject);
+	struct rpc_xprt_switch *xprt_switch;
+
+	rcu_read_lock();
+	xprt_switch = xprt_switch_get(rcu_dereference(x->xprt_switch));
+	rcu_read_unlock();
+	return xprt_switch;
+}
+
 static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
 					   struct kobj_attribute *attr,
 					   char *buf)
@@ -126,6 +139,24 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
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
+	ret = sprintf(buf, "num_xprts=%u\nnum_active=%u\nqueue_len=%ld",
+		      xprt_switch->xps_nxprts, xprt_switch->xps_nactive,
+		      atomic_long_read(&xprt_switch->xps_queuelen));
+	buf[ret] = '\n';
+	xprt_switch_put(xprt_switch);
+	return ret + 1;
+}
+
 static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
 					    struct kobj_attribute *attr,
 					    const char *buf, size_t count)
@@ -234,6 +265,14 @@ static struct attribute *rpc_sysfs_xprt_attrs[] = {
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
@@ -242,6 +281,7 @@ static struct kobj_type rpc_sysfs_client_type = {
 
 static struct kobj_type rpc_sysfs_xprt_switch_type = {
 	.release = rpc_sysfs_xprt_switch_release,
+	.default_attrs = rpc_sysfs_xprt_switch_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_switch_namespace,
 };
-- 
2.27.0

