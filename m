Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6B1375CE8
	for <lists+linux-nfs@lfdr.de>; Thu,  6 May 2021 23:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhEFVfv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 May 2021 17:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhEFVfv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 May 2021 17:35:51 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07705C061574
        for <linux-nfs@vger.kernel.org>; Thu,  6 May 2021 14:34:52 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id c3so6017435ils.5
        for <linux-nfs@vger.kernel.org>; Thu, 06 May 2021 14:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NdIF16hwxX1xLzz9f2x/koEJXUTRdl3IYu5Oe8Rfy7M=;
        b=dbd0btb/XydcuBMmnCisjoT5ECLnFG38zSDHTgxUzulyI5P1UWXfRUUT2v+3NbHfTy
         Xmz8fyRX1aDXSVQt9emSQcIJg45nHitemEM5Ux3j1+hMWmEMfpElbekgBb61sgl6stYa
         SN8n7pQ5+5ZuDLy6q+ZsQluoyC5VQVSgyw8Q0bkU2dVioS/MKUBjjzVEmqLJBM8SgvwQ
         mhAsxRPixJZ+wvbU7ps8kMJYwFxhwjsdoWuLJXoQIPusvH0PhvIP4FiK2D5bGP2mw/KE
         MAjooS2OXQrM9KEICzZE2ECU491eCxqPxDa14UCRwC87fiKAjnkYA3EFAHXH9NkDqEJu
         joIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NdIF16hwxX1xLzz9f2x/koEJXUTRdl3IYu5Oe8Rfy7M=;
        b=M0kiHS9HBiPeT7gScMCj200A1AIVPZ1pRP31sc11e0js9mZ6lAhiO+Bw9WJcQSSK/P
         rDKOPk689mxIFyfqF5+VXPwxk+3iiDvh8JyRdcsHN2DF5CxfkeuktCR1TNa2lRJBfxKO
         SWxkLXbIy7EJipH+xOIN0WcEM3BP9vboa/AqH5QaX1OOnV9KQdmBxiuuEg5O29Rzu9P3
         K1ujMtGvqdgGSTywZ9CJ0ZyLo3W7fTp/NdocTd0QAIJS4yUdutRmdQRX+O2iggYQ5NrO
         SjPbBNyo6rU9EhdQ1ApTtqrL4UVyFE+yhMg/t2x0q4fBVdBS1iFO33V+CStSlsswR5dz
         mEfw==
X-Gm-Message-State: AOAM530ZwbowXJBMNBlA44mqPIdkab652O+Cvg2sQpKmQp5h8t9Bpnc5
        nl0klamBvMG0YYmlZxALl/A=
X-Google-Smtp-Source: ABdhPJwPd3R36HYfxojjn414kRf0JDVv5j4g2Dzrt2jpZYsF2Wud8g/7RRLL/rKpJmLsUTHR3Yfq0g==
X-Received: by 2002:a92:cd52:: with SMTP id v18mr6323644ilq.308.1620336891483;
        Thu, 06 May 2021 14:34:51 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id 6sm1486019iog.36.2021.05.06.14.34.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 14:34:50 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 12/12] sunrpc: provide multipath info in the sysfs directory
Date:   Thu,  6 May 2021 17:34:35 -0400
Message-Id: <20210506213435.42457-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
References: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
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
index c771b9ed76a9..87b7617cee29 100644
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
@@ -262,6 +288,14 @@ static struct attribute *rpc_sysfs_xprt_attrs[] = {
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
@@ -270,6 +304,7 @@ static struct kobj_type rpc_sysfs_client_type = {
 
 static struct kobj_type rpc_sysfs_xprt_switch_type = {
 	.release = rpc_sysfs_xprt_switch_release,
+	.default_attrs = rpc_sysfs_xprt_switch_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_switch_namespace,
 };
-- 
2.27.0

