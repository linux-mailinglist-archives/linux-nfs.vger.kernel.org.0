Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42DE37A4F6
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 12:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhEKKwa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhEKKw3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 06:52:29 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79CFC06174A
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 03:51:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 69so6019134plc.5
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 03:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fkv5wb+1+DGkoP3yZjv9oMKkFDk0tSiczNIe18RktTE=;
        b=qqcBn0jkVqV+KyeSBol7e4l5R1MpV3SwrDDEATmlvOxSVFKRCPBuK9jGUX9biY+jfO
         Z1oyy4lDOgQ+rT9wRD7JjUydOvramniAP+pJ0+/K8u/WtP1IEeJCisO0GbI8iaiCkVaE
         YJtymGVfa43s3ZgRj+N0RMBviHNacOv9TltFKxilWHLa899GoJ7PNjCXRfHUx8NLf5Z5
         JwoPOsOLMd6ErK09p3/ireKgcFFaqtPqJPK2B/rPiJ9vY7hnLhMK9QHyZgTeWlR4EjHa
         3qxntUlsNp0YDL6BGl2QE27Wl+oK4HQBuuXV12VJSJu8Q0rMM1I6o6vXbL2Oi1Cv3H0N
         ghUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fkv5wb+1+DGkoP3yZjv9oMKkFDk0tSiczNIe18RktTE=;
        b=ak4+hjKoFq5DBsuNJIS01G4uRt7/p/8AhKeNQNFo+25lJjVTV1YoxVmROEo4zF+H2P
         HS4bRno89kClH1RfwNrAqwpIaI2PPKnJ7lrFrmHySN/qS9x7q3lPUvEjYQ9KRM2jICeQ
         LlYz5nxJVcJXwemBcQKdC4WlB57LCBb/OiYuqxGIgYf0XxIRkWq04+lGRwoYqPu/dXiH
         XTjTVJQbsbunOVUAM7IfmDI8NUiCSBYJXdMa6rr5RBTpAw/jn6caSCL8GLXiogwkgxVe
         ZA/8FbixwUjR/rQK+Nuxd6bP1kM8tE8KY4I7nUExTMWdv701sxsMnBLGVSEAVF00Oauh
         AQAA==
X-Gm-Message-State: AOAM532FxGKdU4PVYdnQMzJb2tQAbQC50U8cBtj7088G/XPrJXe+zNC0
        d87MCgujQ42LrwwKiaG5LyL01w==
X-Google-Smtp-Source: ABdhPJxC3I9XtMaDwx6Dx0AYAHNd26ktO1L37i+djgUgk6WSl8Trt5/KWMOtA3o9dfGojcV7D/p7bw==
X-Received: by 2002:a17:90a:8902:: with SMTP id u2mr33066729pjn.143.1620730282400;
        Tue, 11 May 2021 03:51:22 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.51.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:51:22 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 01/17] mm: list_lru: fix list_lru_count_one() return value
Date:   Tue, 11 May 2021 18:46:31 +0800
Message-Id: <20210511104647.604-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit 2788cf0c401c ("memcg: reparent list_lrus and free kmemcg_id
on css offline"), the ->nr_items can be negative during memory cgroup
reparenting. In this case, list_lru_count_one() returns an unusual and
huge value. Ii can surprise users. So let it return zero when ->nr_items
is negative.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index cd58790d0fb3..4962d48d4410 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -176,13 +176,16 @@ unsigned long list_lru_count_one(struct list_lru *lru,
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
-	unsigned long count;
+	long count;
 
 	rcu_read_lock();
 	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
 	count = READ_ONCE(l->nr_items);
 	rcu_read_unlock();
 
+	if (unlikely(count < 0))
+		count = 0;
+
 	return count;
 }
 EXPORT_SYMBOL_GPL(list_lru_count_one);
-- 
2.11.0

