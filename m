Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C21C392756
	for <lists+linux-nfs@lfdr.de>; Thu, 27 May 2021 08:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhE0GZ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 May 2021 02:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbhE0GZz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 May 2021 02:25:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA382C061763
        for <linux-nfs@vger.kernel.org>; Wed, 26 May 2021 23:24:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x18so2847766pfi.9
        for <linux-nfs@vger.kernel.org>; Wed, 26 May 2021 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7xcEWYskDBGu/bK3eKJT7YkQNy1YoQQPMH2C2+EMstk=;
        b=Q6/3D8pP+YPIY9c5gcugaTZWMDQovoBE/dn87+UA9E08IM6mZBijQrgLYo4IpMpwaM
         xdy8cDIDZRsXcysP+1i5noZsePA/87hpIsdudzFRoSVmyo6s86mwl+K+May6cNCegfkI
         Iy6GQGsUUytBgDnzvk2ByMnQBqgCshQLnunSjNfLLuZ7SJbQ8bSvTGmABFaPDY/N0l+j
         KxGtMcsR8YMEwc/ruSFE3PO+Jc0zJUDvz/FWuNZVCubkBKePUU4aNwu/7S/tQLDCiC5P
         u7OexXHYaa4olTIx7NkV5gtaPpWNlgCqKaTaK9gWuuWGhCsffUOgvT4jEgZxQ1DBUGzC
         cWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7xcEWYskDBGu/bK3eKJT7YkQNy1YoQQPMH2C2+EMstk=;
        b=oNhFC0Q4jG0I+I6kFCpsluLuDJrFys2UGfw7ZeIB8HtgDEikTZI2Dd/bNTJsrLoxu6
         vEmMVjVZFiJdKD5HBJU06pZDHTzBRUeCNeGz9uScC0/4Eo6RHJGQ2mTvimgSWP6ejFzX
         1u6BSAvdj9/hT9JwDATf8A9tXpx8OSQNeNBcTt30DT4ibGjsVxjOxcw6qRkYLzs/Xbw4
         25k1phtV5ht1WvNVv3XMhlV9oMV9fbgUCjnzwg/PFDh/AfvAaOSaT/v7X11QQGY+0CNP
         hH/cLytbiCrfwafvJ/J+udg1r2a9sEdykoLYLhvyXT5RBj3wcgncq0SDZ/vUYZk/uGpZ
         Jrlg==
X-Gm-Message-State: AOAM531OJqrTVECg6Nw9QUCYuVLtOKPZ63IIWS2jlr/brk4vi2ak4KJc
        ebtQL91zgUFywbDnekFkNv5Vug==
X-Google-Smtp-Source: ABdhPJzrZBmPL3AYKSHKsLxo8L8abN9IDlFQW8JyPdoRceqGeMwyxDBF0enNTeguNaomtOhemc8nEw==
X-Received: by 2002:a63:4d52:: with SMTP id n18mr2233081pgl.147.1622096661406;
        Wed, 26 May 2021 23:24:21 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.24.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:24:21 -0700 (PDT)
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
Subject: [PATCH v2 01/21] mm: list_lru: fix list_lru_count_one() return value
Date:   Thu, 27 May 2021 14:21:28 +0800
Message-Id: <20210527062148.9361-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit 2788cf0c401c ("memcg: reparent list_lrus and free kmemcg_id
on css offline"), the ->nr_items can be negative during memory cgroup
reparenting. In this case, list_lru_count_one() returns an unusual and
huge value. It can surprise users. So let it return zero when ->nr_items
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

