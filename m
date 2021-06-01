Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3840C397C44
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 00:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhFAWLc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 18:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbhFAWLc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 18:11:32 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06343C06175F
        for <linux-nfs@vger.kernel.org>; Tue,  1 Jun 2021 15:09:49 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l7so434446qtk.5
        for <linux-nfs@vger.kernel.org>; Tue, 01 Jun 2021 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYOLduTOB4Yz5DdHQZyKNrbsjDXIwBU7fxUTP5BtzUk=;
        b=uSlsz+l9jiXgzy8f4Jkb7hD2w8B2+8ruHv4gqYR1x8hFS34kXD32fnAZmPjx10oHBb
         VBhv5ulD79Ws8q6H2hZH80WpgZfsWQGTJZh0ZmvSqzxQsPNYK2qdowEKODi6QrqTcJL7
         KupACfkHtg7iWRpFiznrVqTEO6Tp6ph6Kts3JVUtSfMeuQkgcbS0OMebWkc/YYsMKVMw
         ux35gr/15X47oooA24Z1t6M1pbOWHybDlYaikVYRZQPgW7FhxgpehCNrcw+n+4uzi8PN
         8luFan1HioWkbKin4q8hQ2HN6pmzIYPetw0tTEYWMxYI1elaJg7Mp9u20Q80coRSSBGj
         oP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYOLduTOB4Yz5DdHQZyKNrbsjDXIwBU7fxUTP5BtzUk=;
        b=gzFkzug3JjS9UsIKqqbH/fRw6EH40asEAJf64x4g6Qei7th3TE0Zjb2CubdkXKvQlM
         FNumhKAX+KuJvc2lWyWMEZ7HffRcgRckY43lEHZYMZlEsGcsLUJix0g/F8nPvFuMhkoN
         J9iZpAht4xi9gotWo3/Z5q9B2GSNEA8LY2YSRJSPuQ9WnEoIqeLS63CG2XoO7bBZYNsP
         8HKcql1YoVqZZIbtDYeHEzOh4HoMTxRFhH9NLfZRLtp4e56zx8nztylTMhDpjny8zG4P
         +odrjCXKgVKywX+Glg377LYZfLvnDdTpSHE04AsV1hkjUnilzMHguRv9RrZ0P9Ycdzjn
         Vi+Q==
X-Gm-Message-State: AOAM532F6Y7v+8N1qCZQS9MRZBad77JtZvlQAzgOeWWY3SrOsaIWYqxr
        LiWnAcUAZQGzy/WZqY0fwoKjqeSIdu8=
X-Google-Smtp-Source: ABdhPJynfh0vPxv0ZKiz98wEZS3tlJC2rAL2NyDVg98ZEeXHrEUpP04qFZfmG6O7GmUWbus+oWviEw==
X-Received: by 2002:ac8:1188:: with SMTP id d8mr21364621qtj.218.1622585388162;
        Tue, 01 Jun 2021 15:09:48 -0700 (PDT)
Received: from kolga-mac-1.lan (50-124-240-218.alma.mi.frontiernet.net. [50.124.240.218])
        by smtp.gmail.com with ESMTPSA id q13sm12419789qkn.10.2021.06.01.15.09.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 15:09:47 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 11/13] sunrpc: provide transport info in the sysfs directory
Date:   Tue,  1 Jun 2021 18:09:13 -0400
Message-Id: <20210601220915.18975-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
References: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
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
index f330148433c8..dc97c16e4ff6 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -82,6 +82,27 @@ static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
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
@@ -200,8 +221,12 @@ static const void *rpc_sysfs_xprt_namespace(struct kobject *kobj)
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

