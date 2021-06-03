Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7812939ADEE
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFCWXz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:23:55 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:38892 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhFCWXy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:23:54 -0400
Received: by mail-qk1-f173.google.com with SMTP id q10so7555798qkc.5
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZNTq8kaQciFIu2qyp+QrzOJCjHD/h+z7mn7Ab0d6O4=;
        b=YVML9+HlOWr1PmCplnNqQeOmgINbJlQnC+s3frV7R2IDscFnKImnx5z3lbjr9fu5pN
         FJNPVTyX4asZGKdo1yW9Uv+jU58ER1404VYMCj0VBKtL/e0jBdKGoKJcaa7Lu6jORt3s
         HX5YV+EyCOHGl8odX8lEgv/swgcg7qir7lH4jBuvzhoDXxJKnwCUadAhwEercJAYOqDX
         qkl9AuD0qgA9S93BtpX+0jfoaDfKHYwoziC56dMB6Hu0crlHFDe2qMDWhG3lFAKpLihV
         ybh2PepOhGjHiLOanDeYAh2/7eDpUcEpPLUwFQO8sUuF48lPyE+WY3QqmklbGghAeTS+
         vgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZNTq8kaQciFIu2qyp+QrzOJCjHD/h+z7mn7Ab0d6O4=;
        b=ItxaL6hDzbYlwwLNuPuiCL0dMf5UzxDp14OjJCSrQUHtgI2tlMu0wu3l6NasfNMiHI
         LmCgbHILhdkmQeQuRZP0huBbdrjNeu7Rq9jGISV2UugCrCKKrGbUVo9NQNyplB5zlWpU
         qSXTWKUgXgFE3EmfbJKzI9xEcXYUNQ9N1Qwfoih2b5wZsUtillzG5FkcE8NWi99v+/zx
         47StveoC+khLhGeVXbmyV2AZ/+Ud4jWg9nySk58w63YYBgh+cmP1QzXUzdZ7Gp2aeYGl
         zP2HR9tigpGkNmaIO9IlI325Ycuf0SCbljI00GYDfSq5mUFYBk0Dchr2snpGX7ZjPjb1
         J8cQ==
X-Gm-Message-State: AOAM530vzqb7M3MKmEc9aQgKswnbU+l9PhDhKdrRxiV0jt3yJY2tRST1
        mUQ6Y4teHCsTEUueoFlLHsM=
X-Google-Smtp-Source: ABdhPJzs6mUILWU1jKaLE3fFBgOe66GjrAcGJ04scNpyPppvXA0Y+7mpLJWp1La364zQnD9sZzkI5g==
X-Received: by 2002:a05:620a:e12:: with SMTP id y18mr1521595qkm.106.1622758857149;
        Thu, 03 Jun 2021 15:20:57 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:56 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 13/13] sunrpc: provide showing transport's state info in the sysfs directory
Date:   Thu,  3 Jun 2021 18:20:39 -0400
Message-Id: <20210603222039.19182-14-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In preparation of being able to change the xprt's state, add a way
to show currect state of the transport.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/sysfs.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 819134f28a4c..ec06c9257c07 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -111,6 +111,49 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 	return ret + 1;
 }
 
+static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	ssize_t ret;
+	int locked, connected, connecting, close_wait, bound, binding,
+	    closing, congested, cwnd_wait, write_space;
+
+	if (!xprt)
+		return 0;
+
+	if (!xprt->state) {
+		ret = sprintf(buf, "state=CLOSED\n");
+	} else {
+		locked = test_bit(XPRT_LOCKED, &xprt->state);
+		connected = test_bit(XPRT_CONNECTED, &xprt->state);
+		connecting = test_bit(XPRT_CONNECTING, &xprt->state);
+		close_wait = test_bit(XPRT_CLOSE_WAIT, &xprt->state);
+		bound = test_bit(XPRT_BOUND, &xprt->state);
+		binding = test_bit(XPRT_BINDING, &xprt->state);
+		closing = test_bit(XPRT_CLOSING, &xprt->state);
+		congested = test_bit(XPRT_CONGESTED, &xprt->state);
+		cwnd_wait = test_bit(XPRT_CWND_WAIT, &xprt->state);
+		write_space = test_bit(XPRT_WRITE_SPACE, &xprt->state);
+
+		ret = sprintf(buf, "state=%s %s %s %s %s %s %s %s %s %s\n",
+			      locked ? "LOCKED" : "",
+			      connected ? "CONNECTED" : "",
+			      connecting ? "CONNECTING" : "",
+			      close_wait ? "CLOSE_WAIT" : "",
+			      bound ? "BOUND" : "",
+			      binding ? "BOUNDING" : "",
+			      closing ? "CLOSING" : "",
+			      congested ? "CONGESTED" : "",
+			      cwnd_wait ? "CWND_WAIT" : "",
+			      write_space ? "WRITE_SPACE" : "");
+	}
+
+	xprt_put(xprt);
+	return ret + 1;
+}
+
 static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
 					       struct kobj_attribute *attr,
 					       char *buf)
@@ -249,9 +292,13 @@ static struct kobj_attribute rpc_sysfs_xprt_dstaddr = __ATTR(dstaddr,
 static struct kobj_attribute rpc_sysfs_xprt_info = __ATTR(xprt_info,
 	0444, rpc_sysfs_xprt_info_show, NULL);
 
+static struct kobj_attribute rpc_sysfs_xprt_change_state = __ATTR(xprt_state,
+	0644, rpc_sysfs_xprt_state_show, NULL);
+
 static struct attribute *rpc_sysfs_xprt_attrs[] = {
 	&rpc_sysfs_xprt_dstaddr.attr,
 	&rpc_sysfs_xprt_info.attr,
+	&rpc_sysfs_xprt_change_state.attr,
 	NULL,
 };
 
-- 
2.27.0

