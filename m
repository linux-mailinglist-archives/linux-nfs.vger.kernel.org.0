Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5234361869
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 05:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbhDPDxJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 23:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbhDPDxI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 23:53:08 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF912C061756
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:44 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f19so9905366qka.8
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/e5NJBFFJg1ldGTdD9zc5Mr29MH3BLv/X8XsBP6gxuk=;
        b=AU+if+ARKkZg0oCtGBC21/+AfuyU0XEj8Q3XCFQI5Vz5+ffhJI7Y7YqnSvyyFhvRGO
         NfcSXDm+m77LyOyUry2Go2IdYHs9k3bP6gNUHtEnOtmgx6IXL8rMadPjQGlto5JXe3qC
         qbfvkIjmdjYmlm0u4vGWo4kcGXzzXUvPPFKdrPJDA416QydiC8T7FUlANfcTjnZHL1tv
         jifz73rUglLGTC5lqfdURKihU8Lr/KNFuIQvTWA9P1HWkX4DKKmNTPBNAthLhOTllw9a
         /K5g7PNgASLri+ppf3rYrknUbT+E9rlqemueZCtIBp95dvswlMwfMOd3DkaKpI11NPE1
         xAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/e5NJBFFJg1ldGTdD9zc5Mr29MH3BLv/X8XsBP6gxuk=;
        b=eeJvipkLKEqUmIyEHuTZiS3NUXMZdCs78umM+vTyY/1ywxu3o2YFddvGznVOVYhN+N
         oN3nXgMseQqEeKwSVv8B0S8Vu40/6BpjiOemAHxky3dFFgpHSCu0sLsRMCulYX4vL/n8
         BqrXN11YUUJyHzgJgWX+69DBUlYEJoJQn4B5/qHXWE7zRDxu3QvPB7W7/O8DRRYIGH7F
         9o4Qq2l+hJryso/aPGh+6CdO6W0hW0HpPXSXSIqbvPsXFZ0zVZAud6LaWuUnmrSPPnON
         HWj4q4SN1j3/TuRwb7HOLWdsNDEvAJV+Ite5vXXQMTTIj41EBU2VHJp2qGu8UMr/y7EX
         vEPg==
X-Gm-Message-State: AOAM532TMbmDv3yzsgl4hBB/2zqsVSPKY+cOELpA+bIEnNtvxmAGZ2rz
        1XC3nRIiYkobJ2HxjOyKkohmUh/me9I=
X-Google-Smtp-Source: ABdhPJzmTUcKq5CUzZj7pi5Nh7AHHd49hO2jQkPfqpPoXqgzHZODBBHl4adpD0k0gOAbyhee08HBZQ==
X-Received: by 2002:a37:9bd1:: with SMTP id d200mr6519885qke.91.1618545163982;
        Thu, 15 Apr 2021 20:52:43 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id x82sm3500913qkb.0.2021.04.15.20.52.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 20:52:43 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 13/13] sunrpc: provide multipath info in the sysfs directory
Date:   Thu, 15 Apr 2021 23:52:26 -0400
Message-Id: <20210416035226.53588-14-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
References: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
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
index e7a728da8e9c..b6a2484cf067 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -54,6 +54,19 @@ rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
 	return xprt_get(x->xprt);
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
@@ -122,6 +135,24 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
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
@@ -230,6 +261,14 @@ static struct attribute *rpc_sysfs_xprt_attrs[] = {
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
@@ -238,6 +277,7 @@ static struct kobj_type rpc_sysfs_client_type = {
 
 static struct kobj_type rpc_sysfs_xprt_switch_type = {
 	.release = rpc_sysfs_xprt_switch_release,
+	.default_attrs = rpc_sysfs_xprt_switch_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_switch_namespace,
 };
-- 
2.27.0

