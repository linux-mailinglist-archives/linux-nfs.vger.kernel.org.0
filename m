Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F003A04D8
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhFHUBe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhFHUBd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:01:33 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F7AC061574
        for <linux-nfs@vger.kernel.org>; Tue,  8 Jun 2021 12:59:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z4so13223657qts.4
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijSZ1d7ATjjrKIOSInSDm6o0/HsEQun9JpMaNABtse0=;
        b=OcpJc+mFqeZDfS17LVKJNmMXVFKuMKD9vm031uUDAGEU1+ZmMmbwtWGSWWCEnHPbno
         DRpgFtOUCawpgEVsUyVHAYb0PgQ81CA1Nc0Not0SPiYL9QzUM5z7KHAbc0SiGlgilJeA
         xsyjIJF8XgLYoNrMb6pQCDf4HNAz9MSth92xAy82VSem5n2K8YWOeA/ARjotyf0di0lG
         vCyZSIg54+Me+PZXKNbwD9tK7znb+rRMepirWnyYIm8iLCwz7jE/18KA0iiEXjV61zZA
         Qm1aZXpE+17Mx37QJvqJB1I3F/bI5nvNVx8EB3pDL3qaiyw/Nyta92WIKA9Kpl4RlPqd
         LXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijSZ1d7ATjjrKIOSInSDm6o0/HsEQun9JpMaNABtse0=;
        b=La7OuigHGww//ZXkob+Hl9T5LLf7IicBw404cggFpfJbadZ83GsbsnVjogbvy6Oyol
         CzHjw6h3eKAIhpfZ1E/L2IZmJ4THZ5BFzcQ0e5/VzWxQRHEbiUi4cwQVVw3Wm0Q2OzpT
         dGm45M61Cw/jvdgzbvuqcgK4Og/SGbWZafGWfIPEqiJymIoDaQrl7n/hBErekKt7rPgt
         yUgAZk9qMBgaaQAXnJGPg4bxmq1jhsyE2XEfg61xF3Y1DXO6Y3dhqM2WJRo2wv1RJsTq
         LJVLGkF6BmanxM4Q+pq3ezixt+yWOykR2EYhXYRc049Ta/0YqAnLGWb+1Bn9cAGKYp0a
         UwJg==
X-Gm-Message-State: AOAM533UYniRU5lPR9m9MGbDhdL8pn48WpFyajGo6Ypq4KF5msOAwJQm
        r2MS7QOtOR23JhKkfsUXWKVR4At+q40=
X-Google-Smtp-Source: ABdhPJx3vY+tzsd+1mgA6VlOB9fwQXB6OQ3zjmeTN0ptw36yUj4BLhWDPuyXsAs5VpwKSmHnd8ThMg==
X-Received: by 2002:a05:622a:1046:: with SMTP id f6mr5721084qte.237.1623182379870;
        Tue, 08 Jun 2021 12:59:39 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id j127sm12952765qke.90.2021.06.08.12.59.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:59:39 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 11/13] sunrpc: provide transport info in the sysfs directory
Date:   Tue,  8 Jun 2021 15:59:20 -0400
Message-Id: <20210608195922.88655-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
References: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
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
index 402924bbd743..f770eb7301b5 100644
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
@@ -205,8 +226,12 @@ static const void *rpc_sysfs_xprt_namespace(struct kobject *kobj)
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

