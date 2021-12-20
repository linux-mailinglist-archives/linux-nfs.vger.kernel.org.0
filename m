Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB747A66A
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 09:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbhLTI6b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 03:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhLTI6a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 03:58:30 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665BFC06173E
        for <linux-nfs@vger.kernel.org>; Mon, 20 Dec 2021 00:58:30 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id g2so6228688pgo.9
        for <linux-nfs@vger.kernel.org>; Mon, 20 Dec 2021 00:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=8TvIWV4OcYjjwOFikHz5icX5EPwoGVd0G0cgNnPZ3OwEVCd1pU0l0TJ8kMAJsPK9RM
         PRN4azkexQwIGxX7faj/qui7DqF2/6qbwIrig1emlHBmVHQtiuJgzZaDIoVdcE/hIYRa
         f/oN6byDYFY09mwkdmC+7+ld0PrHoNv7SsfBSloklfRKOZyVer4Py+Otclx/EreCtJG/
         b3mcLGEd2YVWGbstIdlB20L0l9MilJgHwRkTvvvTYy6fKkULljGQNO7/4W7UzWrTBCu4
         jGyczyontU6bv3EgHxp9f9K3KxkB978FR87aHBY1Hv3kkxaFJcrHa0C/5zZlyAU28jXI
         BB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=KwL0SYFTk7cgePRqx1E5pkMn8bEQjkobJyYNiO8Ww0qRgMlgtI7YAoPBCQVZiKIdnT
         KzY12ZYAM0FZyHL2bgcQPd24Jb4ifGluZYQgWT94ljoU8UFLosE7eDqSk3OaWaj4yuN9
         sP6nsWuearng6BVGp8hZLOWE+ilv7QXMP5pqfPGPIXLH0Fbz26iZw6XnqBICa0x9I9gJ
         afjYN/wPV1lZ1AIygNpysYJSCEQ8NwW7moqBYhbSNwROR8GFvdPWVFibTLswKKalpxtv
         9AO31flcP0cYMgTsx5pMRhVahzp1RaGvE063SAuonzd9BIMQQUtNiVjaeoGPVVqtu0IC
         3gWQ==
X-Gm-Message-State: AOAM532jxD+iyqdjUF9BOABKEwLa0jXT++qyvEao/mZEgruO3mNRUnqu
        LJdSmqSZp6DcSiUKXio7VR9IzA==
X-Google-Smtp-Source: ABdhPJwgD7F+t3CwkzWdwKXbO2malMfQYkfyNPYoSA3kA4cX5MYf5gaBUpJ0WwXdbwxNoKoRJzJXUg==
X-Received: by 2002:a63:951b:: with SMTP id p27mr14121588pgd.524.1639990709993;
        Mon, 20 Dec 2021 00:58:29 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:58:29 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 07/16] mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
Date:   Mon, 20 Dec 2021 16:56:40 +0800
Message-Id: <20211220085649.8196-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Like inode cache, the dentry will also be added to its memcg list_lru.
So replace kmem_cache_alloc() with kmem_cache_alloc_lru() to allocate
dentry.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/dcache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cf871a81f4fd..36d4806d7284 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1741,7 +1741,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	char *dname;
 	int err;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL);
+	dentry = kmem_cache_alloc_lru(dentry_cache, &sb->s_dentry_lru,
+				      GFP_KERNEL);
 	if (!dentry)
 		return NULL;
 
-- 
2.11.0

