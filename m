Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BA240A775
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbhINHeY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbhINHeU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:34:20 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6475CC061574
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:33:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q22so11370047pfu.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWCb9mX5Tccbd9CST9przEKxw+x/XOfn2zfVE9J87jE=;
        b=gt93lYs0v6WgNM7WwrP6n5fC0cnWuhYjHWP5ts7TA1kWd1STI2P9UTp4wCFszZaY6P
         DN/+6d4qFvixYVGP/2yCdaPcxRIQRH8Ecy+RtUMRiTQVSfp3Et36RMJoZR1xY5uYiJ5k
         iSjuu8vqQxPjxQOBCFMFMCwR7CnjUTGY8CgeeEc6s1nhstrlQG/Y94OeeAro0vR8WnFz
         Yj0gns/NpEwYPxjKuWKEeRQStLOT6m3DoutxVOgqLtU60JHoAq5mco39Y0lDHVWYwgt1
         sHwPDxp+ast9TcqJP+owH12ttPCvkChcWwxVCaskkOLiZHhgoRAqYd+PKDjF7rrjxWRJ
         00tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWCb9mX5Tccbd9CST9przEKxw+x/XOfn2zfVE9J87jE=;
        b=qyfqRJGMEZ2lhJmRHZ205lHga0SoB9jqPsjHWgQBcKc4jKhhX5e/Ec2AJTj0XrAwo1
         d/3/MNsmlyBggTgRxfDuvIgySYyT5uigvxeztmzah4skgTBaanCy4nUwvj3k+9SE6geF
         761qUw64q6cWtB1lVIH545bh3lWwzx836zVYfplV25eBXVw+EAnQKejRtUalqgw8rWjv
         eM7jnPqFoUoNROS1HXvoYcpy0PmLAmXjx1dbwr8KbwLAWOLXKIE5n8Hw5fRnsxFTqOhT
         gG+yH/pUqQaKHCQHHkK8nvPq6PJs3PfYS4HJ3V4RFkXJlhlIzSqt10KOgUJGuuVMujbg
         SqEQ==
X-Gm-Message-State: AOAM530WinO5E7tQoUOFj2k3z2AAy0/J78px0v6tFkdg/Wl+0TZt746q
        K9crDnfbiaT2pN7zEC2zywMC6A==
X-Google-Smtp-Source: ABdhPJxskCh3uAqwW44HafdpZET2ZOfsNGGneakGYVgU3YZLmwPaFGYlMvKICArQQ4Dg52CAuCfOiQ==
X-Received: by 2002:a63:4344:: with SMTP id q65mr14370885pga.364.1631604782954;
        Tue, 14 Sep 2021 00:33:02 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.32.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:33:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 01/76] mm: list_lru: fix the return value of list_lru_count_one()
Date:   Tue, 14 Sep 2021 15:28:23 +0800
Message-Id: <20210914072938.6440-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit 2788cf0c401c ("memcg: reparent list_lrus and free kmemcg_id
on css offline"), ->nr_items can be negative during memory cgroup reparenting.
In this case, list_lru_count_one() returns an unusual and huge value, which
will surprise users. So let it returns zero when ->nr_items is negative.

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

