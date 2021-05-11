Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9164637A503
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 12:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhEKKw7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 06:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhEKKw6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 06:52:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B054BC06175F
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 03:51:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p17so10612662plf.12
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 03:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKsKB4GYgRd6f8D/mWUIDZKZ0++0gc+VH9lM9TpP6RU=;
        b=VVp+A4ZecBFGFSRbIs1i2QqI6JPeI905+XDW/+4NUVYBpfJKdo2mbnRAZqBaYDT4fj
         4z4sAgYuQMO2Gzd88guaqjzr7QsSzWk0M6u3aSFhwuIAnhT5BWQL/0cgKQPTOI5FsaUz
         /gzItuJCZ+WqT7RPthjOskKDSNBtyhJ8fagVIok9ix6HJrCNF0IioVjIH4hIUBZQtzQP
         +jY9uc0H9L0xxB0RWb1XZatZrdQmzbCtqEVPUBVor82Q9kSw1DprU++yxJg4Ht9CyskU
         T1sCsNzpcnN61qhYTe6qncS6dSI8vpgLFlRmEJ5qpeRyJ1pQjYp/3sFEKP5R1+o1JB57
         mjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKsKB4GYgRd6f8D/mWUIDZKZ0++0gc+VH9lM9TpP6RU=;
        b=gLRJeeSbOFWZjd6mbHLcRWdB9xtn05PD8m0w5ln5I/v02+pgl7SKb1qpKTL7vEqnLV
         J91GovXHABm15KfCCjT+aJxYHED73LJ6v7fDasKOsv0jHn/oYcmk3ptA84rxKqg3liEN
         bXUSr8jNufBbAlb/2p0k9nl37dfJIsr3ekiGrjjzt208ncZAFuX5N7Pd6XszUhuAhSyd
         03m9TefyfwcTA+SmjpTs6JxEbLrp1iZbmyLzFVSWFOOtW4gyAELCabkY1Wd7JV3uagQc
         00NnduMPJk/rrYX0CL+pxN0FBCzpF5aUw/kwvAbmTqI0CNtdAOkZjxCS+L2ycY6Nx/DA
         527Q==
X-Gm-Message-State: AOAM531UkmIxYNX5L/3OgOwzec8twm1pUNKEJ9lxAzIQzc6fQjGSJMUE
        90xgZCmqAbc3nA6kkGVe5lN0cA==
X-Google-Smtp-Source: ABdhPJydRosyrrbHMxbhHLsJ0w0mphTejG9nrk4d+o8QXBnZoaP/o2HTRqwJkBfCPH2wNNO8V3cQCg==
X-Received: by 2002:a17:902:e8cb:b029:ee:f963:4fd8 with SMTP id v11-20020a170902e8cbb02900eef9634fd8mr28864251plg.40.1620730312287;
        Tue, 11 May 2021 03:51:52 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.51.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:51:51 -0700 (PDT)
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
Subject: [PATCH 05/17] mm: list_lru: remove holding lru node lock
Date:   Tue, 11 May 2021 18:46:35 +0800
Message-Id: <20210511104647.604-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit e5bc3af7734f ("rcu: Consolidate PREEMPT and !PREEMPT
synchronize_rcu()"), the critical section of spinlock can serve
as RCU read-side critical section. So we can remove redundant
locking from memcg_update_list_lru_node().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 4962d48d4410..e86d4d055d3c 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -403,18 +403,9 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 
 	memcpy(&new->lru, &old->lru, old_size * sizeof(void *));
 
-	/*
-	 * The locking below allows readers that hold nlru->lock avoid taking
-	 * rcu_read_lock (see list_lru_from_memcg_idx).
-	 *
-	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
-	 * we have to use IRQ-safe primitives here to avoid deadlock.
-	 */
-	spin_lock_irq(&nlru->lock);
 	rcu_assign_pointer(nlru->memcg_lrus, new);
-	spin_unlock_irq(&nlru->lock);
-
 	kvfree_rcu(old, rcu);
+
 	return 0;
 }
 
-- 
2.11.0

