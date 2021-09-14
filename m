Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C46140A77C
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbhINHen (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbhINHef (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:34:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D22C0613CF
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:33:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y17so11320808pfl.13
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vnv6075e5xDpDmjVmdi7yoSCEZdGGyfQtI+r26s3BY0=;
        b=MXKF76sadscNWBEDPyWQ6ydw7qu1qu4KQ08PzoC25+M2nyogxyvWh6Vo6e6fuT9KjJ
         EPHFNIl5glwAj56Ghs9GNUoPI5ErOuZk44qv75QztfuFwjeTeG1L4pSr8kFop1qlM185
         nk/1J905u3EnKNBvCR6k/ukz51CCK3AScv60qazmh0X2omMmZGLRYGVBjaHI6si1YQBK
         VUQfLSZXq0wr0J2vgQZzlelhA5p8DH2WQpGrCT5TqlNJuj0rsY5ZNP0OE4RjwPJZ51Ib
         uuB3dT4G7NTTtGEU2UY7ZoxlHFdq57sVDFnJ6bgKQPwrdgqyd+PSzTju40UnVnea5lLX
         aPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vnv6075e5xDpDmjVmdi7yoSCEZdGGyfQtI+r26s3BY0=;
        b=aPx5JvaD5sjM+D8mKF5tq2keSOHO9S0G5nx0JxZSoH8GEJOra5qJD/lTkC2BgzP2+k
         ENIxcQUAENaUASb95GOhRPyE/UpJAHXFphxhB8DY7pTpA5fqER+/mShxxH3w5PttRcUs
         8uGwMcU69iYo7iQ/cpav2+/vdTy3MGXDjs9E2GPH+vrNZGzwGcny7qx25HRjCnHaxtfL
         v6LpR914rCQKbTpczXENJ2IVZOCd8mwcy1Hqj4y5VmErM3pdYNdU7DDzg0HMi1NB/1bP
         VMx9w4lioRFLV4PitfLPx+9ntaQNyofnTQRf90fQUIdCQSMMZrPf0K1LKpnSX/QCB1l/
         Yfug==
X-Gm-Message-State: AOAM530MbcD2hSx6vgJR0Hkm9SsrKAzSyrtp9xrmqOZC3ivp8E1xaerl
        o++cOJXPTEbYfDyCMB3eO+kgEHqsTCISlg==
X-Google-Smtp-Source: ABdhPJyTYPgvYnhqECa/3pKjPwUP5/+kEmpd9Rxi8q+BV0aFN3ZhNlHMttkuLtRDk2VCixzj2EEC1Q==
X-Received: by 2002:a63:da49:: with SMTP id l9mr14246393pgj.277.1631604797007;
        Tue, 14 Sep 2021 00:33:17 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.33.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:33:16 -0700 (PDT)
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
Subject: [PATCH v3 03/76] mm: memcontrol: remove the kmem states
Date:   Tue, 14 Sep 2021 15:28:25 +0800
Message-Id: <20210914072938.6440-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now the kmem states is only used to indicate whether the kmem is
offline. Because css_alloc() could fail, then we didn't make the
kmem offline. In this case, we need the kmem state to mark this
so that memcg_free_kmem() can make the kmem offline.

However, we can set ->kmemcg_id to -1 to indicate the kmem is
offline. Actually, we can remove the kmem states to simplify the
code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 7 -------
 mm/memcontrol.c            | 9 +++------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3a0ce40090c6..7267cf9d1f3d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -180,12 +180,6 @@ struct mem_cgroup_thresholds {
 	struct mem_cgroup_threshold_ary *spare;
 };
 
-enum memcg_kmem_state {
-	KMEM_NONE,
-	KMEM_ALLOCATED,
-	KMEM_ONLINE,
-};
-
 #if defined(CONFIG_SMP)
 struct memcg_padding {
 	char x[0];
@@ -318,7 +312,6 @@ struct mem_cgroup {
 
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
-	enum memcg_kmem_state kmem_state;
 	struct obj_cgroup __rcu *objcg;
 	struct list_head objcg_list; /* list of inherited objcgs */
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e0d7ceb0db26..6844d8b511d8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3611,7 +3611,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 		return 0;
 
 	BUG_ON(memcg->kmemcg_id >= 0);
-	BUG_ON(memcg->kmem_state);
 
 	memcg_id = memcg_alloc_cache_id();
 	if (memcg_id < 0)
@@ -3628,7 +3627,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	static_branch_enable(&memcg_kmem_enabled_key);
 
 	memcg->kmemcg_id = memcg_id;
-	memcg->kmem_state = KMEM_ONLINE;
 
 	return 0;
 }
@@ -3638,11 +3636,9 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	struct mem_cgroup *parent;
 	int kmemcg_id;
 
-	if (memcg->kmem_state != KMEM_ONLINE)
+	if (cgroup_memory_nokmem)
 		return;
 
-	memcg->kmem_state = KMEM_ALLOCATED;
-
 	parent = parent_mem_cgroup(memcg);
 	if (!parent)
 		parent = root_mem_cgroup;
@@ -3656,12 +3652,13 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
+	memcg->kmemcg_id = -1;
 }
 
 static void memcg_free_kmem(struct mem_cgroup *memcg)
 {
 	/* css_alloc() failed, offlining didn't happen */
-	if (unlikely(memcg->kmem_state == KMEM_ONLINE))
+	if (unlikely(memcg->kmemcg_id != -1))
 		memcg_offline_kmem(memcg);
 }
 #else
-- 
2.11.0

