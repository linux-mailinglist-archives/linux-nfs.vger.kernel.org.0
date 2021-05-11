Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7E37A4FD
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 12:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhEKKwo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 06:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhEKKwo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 06:52:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815C8C06175F
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 03:51:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a11so10629564plh.3
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 03:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4jDxCt8n77REyDHgYZFiAH9QsICwT/CfRTyFliAVkY=;
        b=06zHA1gUi1VqCeLYroahSAhcX58diigPj7gDH0kP9dNSgiSEAsd+8hjKAzQO//KZEB
         50DRgwgI3IiAnTdaaw7RhOawjEaFaTST5LC9244nJUIqTKJg1nsw6h2f/zBKPFaEagVY
         2Vw9KfZzxnd7N5d134QldOvuGpsFAs4FEaTTW693QPW/tizv+01rT786DHV91kz9pgPE
         Dhbh5eFkF75RBi6OiGIonOEHInDCkbXiyZy2c4mR8lfQc4R6R1jGSTbnv7vQ5z7Plarq
         BxWufxvjbl9CYmSBI5ct6TEk7D28bj49BaRszr3VF5gVU00IFSAXWh3+gDY+0omlR7UK
         8mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4jDxCt8n77REyDHgYZFiAH9QsICwT/CfRTyFliAVkY=;
        b=YinjTDZC+wARnAYChUBVLIxHbzjaZUum0d5Owb3Ei1qi0Pmrp2gTTxcqyLoXOp+ROK
         jQDRxOzp+bsTO4OsGK9yhlCqgCCxY0onNEkjEzbOpYx/EIhafSA04/nMB9r8vgRh+V/w
         KJWLENleO4cPlMk5HN9P4U2zo6HzSxQwH4n+OIsLM5oQYSUnDlInhajJRDyzU8v9Zjof
         yhRWzLG/rH+qpAfBDEbprWvaDNbox+hfZJ8a1gCdxlLfzHYkNu3fH5KEfwsHsk1zsJic
         a8dg13JAbAd37gTdBCgkYp+552y5XHM50EePMY8ibOw4oTwDWoUlOFmVmuo7dybRL0QL
         cZwg==
X-Gm-Message-State: AOAM533VO0nYLqdwbouMqA+LwkcTV+zPmpfCwwt6INe7MvAjidLt4h5/
        j42M1RubiwbamLLCIbFDt/rxpA==
X-Google-Smtp-Source: ABdhPJz2S/+FDBdfIoJEY/9ohxgiE1dl2S6saMFngV85buTbmhClfdJI96FIYTAx6lhNks4IMYV45Q==
X-Received: by 2002:a17:902:9685:b029:ef:70fd:a5a2 with SMTP id n5-20020a1709029685b02900ef70fda5a2mr180626plp.20.1620730297052;
        Tue, 11 May 2021 03:51:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.51.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:51:36 -0700 (PDT)
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
Subject: [PATCH 03/17] mm: memcontrol: remove the kmem states
Date:   Tue, 11 May 2021 18:46:33 +0800
Message-Id: <20210511104647.604-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now the kmem states is only used to indicate whether the kmem is
offlined. But we can use ->kmemcg_id to do the same thing. So
remove the kmem states to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  7 -------
 mm/memcontrol.c            | 10 ++--------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c193be760709..6350c563c7b8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -182,12 +182,6 @@ struct mem_cgroup_thresholds {
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
@@ -320,7 +314,6 @@ struct mem_cgroup {
 
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
-	enum memcg_kmem_state kmem_state;
 	struct obj_cgroup __rcu *objcg;
 	struct list_head objcg_list; /* list of inherited objcgs */
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 21e12312509c..e161a319982a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3461,7 +3461,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 		return 0;
 
 	BUG_ON(memcg->kmemcg_id >= 0);
-	BUG_ON(memcg->kmem_state);
 
 	memcg_id = memcg_alloc_cache_id();
 	if (memcg_id < 0)
@@ -3478,7 +3477,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	static_branch_enable(&memcg_kmem_enabled_key);
 
 	memcg->kmemcg_id = memcg_id;
-	memcg->kmem_state = KMEM_ONLINE;
 
 	return 0;
 }
@@ -3488,11 +3486,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	struct mem_cgroup *parent;
 	int kmemcg_id;
 
-	if (memcg->kmem_state != KMEM_ONLINE)
-		return;
-
-	memcg->kmem_state = KMEM_ALLOCATED;
-
 	parent = parent_mem_cgroup(memcg);
 	if (!parent)
 		parent = root_mem_cgroup;
@@ -3506,12 +3499,13 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
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

