Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737C037A4F9
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 12:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhEKKwk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 06:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhEKKwg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 06:52:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39D1C061574
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 03:51:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h16so3016113pfk.0
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lGjb9XHs9HEa3yuCIWtdN6OV6aUJlazGyEylQig/2qw=;
        b=1ZlSDkHHElJFkZnuHviAqONLGrsrF74n1N3r4603t2OcT6B8Zghjytatk5NUDWAMrc
         CWYBWR0DHY/FIT0z1qEOKkn3++hfRLeyeSa1exRX29IrunIVc2fcFbuABH9vof0rUXHF
         /D0FIOJckKHayu9vDAtiALygRnnhdSdfAQzTMup39o1wwGXCYbLgZkaitBjY1w7Uu2A3
         Iwa73mJ/dlsPt/kwINQkxilRF3wFpWP+ZtWK1/44M7xGUcE9f9IuZbNNkoAJ0sZEnS+C
         wEfyogG2RhX8rGy/uRAUaZV5pvFsMsHZmUiC44od1xt/PD4GPgUcvi14//naVQmHZgD7
         YrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lGjb9XHs9HEa3yuCIWtdN6OV6aUJlazGyEylQig/2qw=;
        b=HOKRKyhHSMOSwE2a/d6VPI5YMdH3srImLlpeI4+QezYYbk0urChvlUodFD1+Ss4o+t
         goeJujiljBGY6vSBc6hk2PpXxSVXMM0jYEOLiwBa3RB+ePvhmGPjgnni1hhBCLwH3F4O
         E7WSrinH32rDu0QvZncA1Cqw4k3oiNWxDslACqkQJEgexJG+Sotyg2lh6Jj3U8+1v4fn
         uhWsaDZEhQIFMmmtefFjUlNnZP8F4tYDOE2rm1Ch8rH2LHrol1zqH4ZlFQ1AHUTQL/o4
         zLSPZSrnphopQkfKtRttyrHUWAi4d6yxmwiW2FEhPsM2JNkDH2fBWy3fyTNLooJxyXb4
         cyqw==
X-Gm-Message-State: AOAM533INIAxSv0slzWpEW0o81C3lsQ26RBdyzGusMdsThv3auNTeo/P
        MgliSSuebsl9GLUa5a7GquwMGg==
X-Google-Smtp-Source: ABdhPJwrs5wlHj9JR4nN7o9mNIe/lOSuXtHDeccVzlqFnpwhk46tI6wfm+22UPitRWq14ew6ukG+hg==
X-Received: by 2002:a65:5088:: with SMTP id r8mr29061106pgp.12.1620730289556;
        Tue, 11 May 2021 03:51:29 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:51:29 -0700 (PDT)
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
Subject: [PATCH 02/17] mm: memcontrol: remove kmemcg_id reparenting
Date:   Tue, 11 May 2021 18:46:32 +0800
Message-Id: <20210511104647.604-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since slab objects and kmem pages are charged to object cgroup instead
of memory cgroup, memcg_reparent_objcgs() will reparent this cgroup and
all its descendants to the parent cgroup. This already makes further
list_lru_add()'s add elements to the parent's list. So we do not need
to change kmemcg_id of an offline cgroup to its parent's id. It is just
waste CPU cycles. Just remove those redundant code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64ada9e650a5..21e12312509c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3485,8 +3485,7 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
-	struct cgroup_subsys_state *css;
-	struct mem_cgroup *parent, *child;
+	struct mem_cgroup *parent;
 	int kmemcg_id;
 
 	if (memcg->kmem_state != KMEM_ONLINE)
@@ -3503,22 +3502,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
 
-	/*
-	 * Change kmemcg_id of this cgroup and all its descendants to the
-	 * parent's id, and then move all entries from this cgroup's list_lrus
-	 * to ones of the parent. After we have finished, all list_lrus
-	 * corresponding to this cgroup are guaranteed to remain empty. The
-	 * ordering is imposed by list_lru_node->lock taken by
-	 * memcg_drain_all_list_lrus().
-	 */
-	rcu_read_lock(); /* can be called from css_free w/o cgroup_mutex */
-	css_for_each_descendant_pre(css, &memcg->css) {
-		child = mem_cgroup_from_css(css);
-		BUG_ON(child->kmemcg_id != kmemcg_id);
-		child->kmemcg_id = parent->kmemcg_id;
-	}
-	rcu_read_unlock();
-
+	/* memcg_reparent_objcgs() must be called before this. */
 	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
-- 
2.11.0

