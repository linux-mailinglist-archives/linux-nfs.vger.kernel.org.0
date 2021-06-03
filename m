Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C6739ADF0
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFCWXz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:23:55 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:34769 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhFCWXy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:23:54 -0400
Received: by mail-qt1-f179.google.com with SMTP id v4so5613626qtp.1
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhDyK3KDUDoYOICYsVAwK115keL37tYbWZgH4EftGJo=;
        b=sdKTuG6415V8zjSWGeTCO0hdjYb+wbRKmDlIHCQ4tsBms/Zv1S1LXk3SLRl+qZEdBC
         zjMh91YsIep3PhyCl9UYuyarFJ4iyrQ/Dcthxf8tbRGIqLKs8Ch8frleBK76giUtboKQ
         17ihE8ulU3vm08f82Cayun4AxbhSZZHlLzNJ/+BcPGFjEzdWQ9q0MkzwuTaLtB/Z4Yss
         5eiGsScaI10Ag3OfruzBlRs/ab+SGJJSYmCFw7NRHDrIfWa2zH4a6silkwH+BcTc9ibN
         ZN6gpuVY6+JoX0u6TYqW+YUtfHf7uiB/X88Xn0VkEjH1RcY9Jla5M6QuGwskgmzqbfCH
         AU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhDyK3KDUDoYOICYsVAwK115keL37tYbWZgH4EftGJo=;
        b=L7qRfa6/V2p57ZXStCK4ujxftnub0yqkHxrBg/xROkdKHdBEonRz8FEt14QVE8FSVz
         j+cRLesufWjiGLG34YubZZ4bk/+ozO0h3BLQokzwpHIvYPpkftQB2vHFrt4j5crbJnhd
         GvnxcC9fD/zFcP36p6fTPcoNU5KD/qI8svNnAT6q1V5DkHYfiHRTSYV75y1L+phb5jW1
         MHwh2je3/qqJXZSwFeAO7fTD2YrL1SDQBF1+aIO9+pfW9MVVbvO8Q+RsEdoK/P4m1IQt
         gB7CCaJkG7nT83Aw9MvlzSVQ32tjEu8hc1CQa/KNNuXYCIH8p5hFHHQmmc1SxbV9P1d3
         5shQ==
X-Gm-Message-State: AOAM533BoPskh7C5cBIeJ/weNwcOk3UA14H4ijhYCh/kccwjaOmsxgx0
        ShlOoR4YSnSFlv2PMWy+HZU=
X-Google-Smtp-Source: ABdhPJzo3hzR5isqDqCyt5Qj6m/nPT2rbWfyiYnemaWRLZlx2XLWdds2gn6unb6BCs6CgHjo0RTOFw==
X-Received: by 2002:ac8:75c3:: with SMTP id z3mr1733574qtq.308.1622758854919;
        Thu, 03 Jun 2021 15:20:54 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:54 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 11/13] sunrpc: provide transport info in the sysfs directory
Date:   Thu,  3 Jun 2021 18:20:37 -0400
Message-Id: <20210603222039.19182-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Allow to query transport's attributes. Currently showing following
fields of the rpc_xprt structure: state, last_used, cong, cwnd,
max_reqs, min_reqs, num_reqs, sizes of queues binding, sending,
pending, backlog.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/sysfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 4a14342e4d4e..23a3eb08b5b1 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -81,6 +81,27 @@ static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
 	return ret + 1;
 }
 
+static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					char *buf)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	ssize_t ret;
+
+	if (!xprt)
+		return 0;
+
+	ret = sprintf(buf, "last_used=%lu\ncur_cong=%lu\ncong_win=%lu\n"
+		       "max_num_slots=%u\nmin_num_slots=%u\nnum_reqs=%u\n"
+		       "binding_q_len=%u\nsending_q_len=%u\npending_q_len=%u\n"
+		       "backlog_q_len=%u\n", xprt->last_used, xprt->cong,
+		       xprt->cwnd, xprt->max_reqs, xprt->min_reqs,
+		       xprt->num_reqs, xprt->binding.qlen, xprt->sending.qlen,
+		       xprt->pending.qlen, xprt->backlog.qlen);
+	xprt_put(xprt);
+	return ret + 1;
+}
+
 static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
 					    struct kobj_attribute *attr,
 					    const char *buf, size_t count)
@@ -199,8 +220,12 @@ static const void *rpc_sysfs_xprt_namespace(struct kobject *kobj)
 static struct kobj_attribute rpc_sysfs_xprt_dstaddr = __ATTR(dstaddr,
 	0644, rpc_sysfs_xprt_dstaddr_show, rpc_sysfs_xprt_dstaddr_store);
 
+static struct kobj_attribute rpc_sysfs_xprt_info = __ATTR(xprt_info,
+	0444, rpc_sysfs_xprt_info_show, NULL);
+
 static struct attribute *rpc_sysfs_xprt_attrs[] = {
 	&rpc_sysfs_xprt_dstaddr.attr,
+	&rpc_sysfs_xprt_info.attr,
 	NULL,
 };
 
-- 
2.27.0

