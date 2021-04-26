Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE0136B802
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbhDZRVA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 13:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbhDZRUt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 13:20:49 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584C3C06138E
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:20:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c3so1057206ils.5
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iicQx4bDLuTjkCEVSj6SiyY4lXvt0S/vEsARNB2sm5Y=;
        b=suFIgpmfy+x2/ICzER3GwqU5GYLiPdHUL8zxweZ+nz+huyB9bG+1INTygPXv2ks8J0
         tqSUKD46NKchB8sYg0GZNc57SyR7zRCK9CJtI+IDi1vo7dhU2BJlfvQ9pHtKH5bHllQE
         uTs0Iy1QI6zXE/TQ08lEHhLNk4W0WaGcQioM8VCXtAce+z5Ua9g12853KMYATBnfQ0hP
         VQOdeEM8ohRRjMGMdYNYNcOoe5XVxDKRl/ZwyZJVtDa+SvWAY/ahWVsTBWOP0dybxpJt
         djSydLYXlGYbwC1uX4CZ4gi4GtPLkeE369T0EbIIHCRE4Tu+qt55TZi/oysucaG+VeyM
         i0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iicQx4bDLuTjkCEVSj6SiyY4lXvt0S/vEsARNB2sm5Y=;
        b=qn0MR/uVCeJ+1TnutK8ADVGM7m3IidiIlevCRoJlzKjNxPh19HsXfXOOMdz1Z13HNt
         zcLXKwHMPgLo5J7qjykiAWRdYYT88qLljxV6gFJbaaa6oxaeSkBvnBoVbPm7JbaJYVAW
         hsbBXM9ySYjajJh73Hi4vftExb/4LWq2FKOQH+2evCuyRF33/Elu8ex2S7I3mFA/wT6h
         7v7EuPvWV5FNS+3IGNs273Dcx9wlAnNhKO0atH6Le8UU6c4eXnX8lm/nkZrYijxgguD8
         OxFv7EglB2RhuTKgHlt8w80ErvHneNA/e1E22G07f7STxlm6sDsSJMl8Rc7mWTB2eXqH
         uGUQ==
X-Gm-Message-State: AOAM530dU4R2wLCp8tv8s5qXcKJsNw4XiZn2phvNO/vpKXE8gt83+vQ0
        AFxh5iLhpEPM5z2IK1ESEZQ=
X-Google-Smtp-Source: ABdhPJwo1FVIZrAaTeX3uG5g+sDuEDiT5HmNNzAZ7H9K0zNwf/dDNgFZwGHlb26OOGFM/WZrs+fvYw==
X-Received: by 2002:a92:d087:: with SMTP id h7mr8220978ilh.83.1619457604448;
        Mon, 26 Apr 2021 10:20:04 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x13sm207297ilq.85.2021.04.26.10.20.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:20:03 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 13/13] sunrpc: provide multipath info in the sysfs directory
Date:   Mon, 26 Apr 2021 13:19:47 -0400
Message-Id: <20210426171947.99233-14-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/sysfs.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 93d4111f6ee3..eeac19907c43 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -54,6 +54,15 @@ rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
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
@@ -122,6 +131,24 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
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
@@ -230,6 +257,14 @@ static struct attribute *rpc_sysfs_xprt_attrs[] = {
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
@@ -238,6 +273,7 @@ static struct kobj_type rpc_sysfs_client_type = {
 
 static struct kobj_type rpc_sysfs_xprt_switch_type = {
 	.release = rpc_sysfs_xprt_switch_release,
+	.default_attrs = rpc_sysfs_xprt_switch_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_switch_namespace,
 };
-- 
2.27.0

