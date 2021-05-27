Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4602B392777
	for <lists+linux-nfs@lfdr.de>; Thu, 27 May 2021 08:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhE0G1b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 May 2021 02:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbhE0G1J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 May 2021 02:27:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D272C061761
        for <linux-nfs@vger.kernel.org>; Wed, 26 May 2021 23:25:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so1752657pjb.4
        for <linux-nfs@vger.kernel.org>; Wed, 26 May 2021 23:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=jgeKoWpk2GjyMfypyzxlbbnac3TWTwOgzJt96jJqAvQI95liqLVhJNfUx8EOTKfhGF
         4JR0WlMdklz4TbN/7KMayxK4+sRAHemy4e3o6vpu33f0sRKCaHXUkHVByGhkconcpC5P
         LVZbgz7ILWTP2+tCT7TKnGNrFHgNmlEnja61hYro+SvTwKieHVACeLNmwwsV0asUCd0M
         HSoxbz9PvDa2LP22/s6Zhv7I3z8MYyKLC/z1+kvna2RnFttogyHW5fjMhYEC3T41dxS1
         gsv1Z2Um5suWkCM0QPtsCPBSJ6VDZasnKWJg78xlOePEKtoJTMvVLbpln17g+eDbIZY6
         lgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=YdpwPNDzed3WTa9GQThf2Tw1xupp3iY/eNFv/sa+mx0vgh/K7+eGQDMLYH3xD20Wus
         CpBZA0OLo+flacsQoY6aJjQEyAsE4EZTqYj9QsRbyrcBrPAhMe8uXAyOElM0NDUCwcrw
         lhGdKRjklvt0xS3XjP/zGTo8FpJMbn/1QkGWcRx3y4ixPEeRZ3pZnMtrbTEXG2sYB4X+
         kgbvZVd2TP95AlHfnv80sI3qqYtHfGQRjWbnizEujc4bTzoQfL90y3I7w4+s9CmtMo2I
         fz3KaXJwigxA1AL0oYPR2vhkJ2upY7hXb5mjbgr+a1AaoYzR6SggjoZeTmjCp9GugU5Y
         U/aA==
X-Gm-Message-State: AOAM533428Taj9tpvqqhKoeyXCe4G/mg7qOxwVnnMbm4Cmw78/Ae7O1o
        IRR259rCrZBqgrjY3kpl3b47Rw==
X-Google-Smtp-Source: ABdhPJxcGuF5DQLh4LjJiXw5aeyBoGXy1Hjz00Eh2PAxD5BdIel1s/tP58hZR4Q7aTL9uSZUuaTZsQ==
X-Received: by 2002:a17:90a:df0c:: with SMTP id gp12mr366298pjb.80.1622096736011;
        Wed, 26 May 2021 23:25:36 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.25.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:25:35 -0700 (PDT)
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
Subject: [PATCH v2 11/21] mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
Date:   Thu, 27 May 2021 14:21:38 +0800
Message-Id: <20210527062148.9361-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
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

