Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DAB40A866
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbhINHqg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbhINHpf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:45:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C296C06115B
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso1445642pjh.5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=JhAlTvU3RWk3oRDa2aTY8JKMFt9Ez7Qvhwau43LIZwVt3n/yJ2Ir8tLfT7NZ0H6X12
         BDxLL+Oux2/7MjK3Lk+uIMdVrHQuYow40eQBrr/gTXkfEwB7Uc1quD/ffiKvxxblMBvm
         xEsvUkz22/wDzy0vSKKxw6k8g7pGDQtRTRrQNErOmdxF+ohBQk1K0XBFi5DnQYBH2r/W
         IWr5m2jyR7dnpVY7TDJbByTDRTtN51tcAQmDTCpmEb3lkUzPTJT8DNyN5RjuxCE9V1RT
         qXCa7mzgwY58hyW6b0OW7M80G8cYfjWnRViBLfe9PQZFD5CmWIplOlDoNwplM8r58hcM
         25UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=mIDCAoKgrHkUhi7egTH4g45P+mBPzMzUUemTG9wD5L+hGBBcIMpY8kC4wNHtW+pie/
         2owZoLKtET0aMms10p4E8PPMAZR2yxOCOLOnUFv2Oc0DBsHkE2Q/9LGdvYprma4sT0uq
         95YQ/ZBCt0H7/49Glgy8d3E/74297jEXScvkuw5FS2tXDOI+xYR+4lTc/8ZC8Nl2lz+D
         /JXApBteSO4PdjQC9DSRu+cCmkeV5BZQSASzOOinoJNjjCr1hoWFRCg4wUpR09fZw2Xv
         vwJ7lQaGTOr1UWmjTDsE1fkt8RjeWn8z3tOOeoRObB765fWLbVcUmCncbdsiM1tzTs1c
         me5Q==
X-Gm-Message-State: AOAM531SHwYz7TnPTHPTRbZNLHjfQsRaj1UglxKzQHH/cthBj1+/Cmpi
        IcedcrsxiiSWBppnEE7Je4IpkA==
X-Google-Smtp-Source: ABdhPJyAUjo4UZB4NIB2ZL+LCFQmoGF92sZYCgPBvTgn0UV2XRJw/w5a6fkyBczWBG3bB61VQWmbxw==
X-Received: by 2002:a17:90a:9a2:: with SMTP id 31mr588698pjo.58.1631605257891;
        Tue, 14 Sep 2021 00:40:57 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:40:57 -0700 (PDT)
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
Subject: [PATCH v3 67/76] mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
Date:   Tue, 14 Sep 2021 15:29:29 +0800
Message-Id: <20210914072938.6440-68-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
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

