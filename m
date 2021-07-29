Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7120E3DADF8
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jul 2021 22:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhG2U7z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jul 2021 16:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhG2U7y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jul 2021 16:59:54 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA05BC0613C1
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jul 2021 13:59:50 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f22so7348728qke.10
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jul 2021 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQ87HFGJygj9MSqYTR0hscBamCmFUciEElaDGRe1T6g=;
        b=mW7DF7DTUdRZmJYDN0gbINOQFFYddiKE67XjBJgtrh2sGZnLYt5E7IMFwvo28xAFMC
         Yxcnxfg4EX+ULt6Ra00quP5csdRmm5ZJusJFWELwngHffXhwMtRU+0cWKXb5V0nMFPwz
         1W0zONd/4G4hj1n6SGFISG7s4PF8fiGUi0rc0IhVzl9tpSvIYXCr10EaAbgIUwmEmQxG
         e+0r4ASsVku+vxrA/8S9qt3QjexD9d6PT98R8mSLDeDpZUZTOIBXnOkXxN5z/6c4QzP5
         Jl135uYtWM3CeoTIgW2gyCvuUC/ItLamIZoR2ujK9iTNZVRphfL2j4MnSZQWL99sYX1z
         f47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rQ87HFGJygj9MSqYTR0hscBamCmFUciEElaDGRe1T6g=;
        b=DSIDS/HDm0Sfx56sFJA1T+Tau5RVemXSQtcN1STKW/bWs67LizQjH8rZCUkbDjBewZ
         /rUzm1tvTByI6rtaHPp8iBryaIPoWST2z1buHHEQm+LBpoAUo5B6SOTNSvc4Cve9Mup2
         vpr16RFk74H5W4aK7USkuWmmZd9NUHsEFQS9QvIFtQexZ1vjXQbCD2ADL6L5DJs4zzvc
         Kc+GnvF6Qj4dHW9pydTkYjdZsyqk04sPwv+REKKv43zbxIqhrUnnFAM0QSh77wlDA3nN
         Krw+EMURolsXHdbuC768036BLv1JYMb517gDDD0RSqiKMd5fJYbCXubGG1lnSISO1X2R
         RYEg==
X-Gm-Message-State: AOAM530fQwDg5pDYO8uoKwlvGOSronKkUdVfxMLSgCHMm92ZkPkn2Onf
        +R//NMNDWd2O3UI+ZlwTBl4=
X-Google-Smtp-Source: ABdhPJxgmF+oKFR+RHGddAwp4naUdZMipqdXW7I3YyOnLXIxb9wlVHfn+5EX364PwSGDxrdf5OZKYw==
X-Received: by 2002:a05:620a:14b8:: with SMTP id x24mr7287639qkj.475.1627592389953;
        Thu, 29 Jul 2021 13:59:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id j3sm2268529qka.96.2021.07.29.13.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 13:59:49 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 1/2] SUNRPC: Add srcaddr as a file in sysfs
Date:   Thu, 29 Jul 2021 16:59:46 -0400
Message-Id: <20210729205947.162599-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729205947.162599-1-Anna.Schumaker@Netapp.com>
References: <20210729205947.162599-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

I don't support changing it right now, but it could be useful
information for clients with multiple network cards.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/sysfs.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 64da3bfd28e6..2e7a53504974 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -100,6 +100,28 @@ static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
 	return ret + 1;
 }
 
+static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   char *buf)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	struct sockaddr_storage saddr;
+	struct sock_xprt *sock;
+	ssize_t ret = -1;
+
+	if (!xprt)
+		return 0;
+
+	sock = container_of(xprt, struct sock_xprt, xprt);
+	if (kernel_getsockname(sock->sock, (struct sockaddr *)&saddr) < 0)
+		goto out;
+
+	ret = sprintf(buf, "%pISc\n", &saddr);
+out:
+	xprt_put(xprt);
+	return ret + 1;
+}
+
 static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					char *buf)
@@ -376,6 +398,9 @@ static const void *rpc_sysfs_xprt_namespace(struct kobject *kobj)
 static struct kobj_attribute rpc_sysfs_xprt_dstaddr = __ATTR(dstaddr,
 	0644, rpc_sysfs_xprt_dstaddr_show, rpc_sysfs_xprt_dstaddr_store);
 
+static struct kobj_attribute rpc_sysfs_xprt_srcaddr = __ATTR(srcaddr,
+	0644, rpc_sysfs_xprt_srcaddr_show, NULL);
+
 static struct kobj_attribute rpc_sysfs_xprt_info = __ATTR(xprt_info,
 	0444, rpc_sysfs_xprt_info_show, NULL);
 
@@ -384,6 +409,7 @@ static struct kobj_attribute rpc_sysfs_xprt_change_state = __ATTR(xprt_state,
 
 static struct attribute *rpc_sysfs_xprt_attrs[] = {
 	&rpc_sysfs_xprt_dstaddr.attr,
+	&rpc_sysfs_xprt_srcaddr.attr,
 	&rpc_sysfs_xprt_info.attr,
 	&rpc_sysfs_xprt_change_state.attr,
 	NULL,
-- 
2.32.0

