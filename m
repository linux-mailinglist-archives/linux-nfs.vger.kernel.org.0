Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840F737A518
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 12:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhEKKxs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 06:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhEKKxo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 06:53:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE93C06138A
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 03:52:36 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s22so15468580pgk.6
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 03:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NL60CwduwWyPJJzwINsmFcWyjAvC0A20QSD6WsxPODY=;
        b=OJw/5jAsOLZ3Uy7wKezj2tHz0wKrzoK0KxiKSuUqTZu3Th14oGo++0Q5g2ZwuuMBG0
         9mOQ3JAJeR4l8W4IxHBSvbOnXz8s3fy3MCgjimjUH6i706PaiZfBVWn5DrY273AYfSAI
         pwc9Woa+GovmT2AIp1/iSMFw6JSKRd+g+itDf76pZBxBka0Vc67I2p7DOX2pov7MDM6W
         iVK82IKji3+exFHjd7BCDPtjLw8R2P/ZDKN/MeV/QQoNCUXu5qQI7496pBpcHt3UBiIL
         /uOjnJUlWUrmPrPKG6i9+ieV0orbFpBHt9BLmD/q6IUtHjVaDV/O1MoF2dATJSnsMt29
         aXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NL60CwduwWyPJJzwINsmFcWyjAvC0A20QSD6WsxPODY=;
        b=NLiOBJbLhfmAi7V62TPmjRfcBxebewpj8m+9ZR/+IVTm3mkBCA2I6aHDT0YaTDEii5
         K9XKtv26yPKLt+SP6g2XJ3/OGMpBcEhWf29v7MDD71i7DRIdiBJz2ZFvTiwM3liB5kga
         fMSs/4ZEjuEaANvumYIASD1aD48S6NzgQl/tOI9GV68gEW1663+HNNppgIsPnG5WGdR5
         8HJZNsu5c21quFb5Z56Zy6qPmNz+q7q6ABPbMSUAmj24Iy2uCuDXLKnMmO/dLrGyzMYK
         HDCeMVaMR4b5minUTMO7WBkZp1IIk/nmT9YE76Y4zGn0XzMy4imMWXE/SjgcNP0kAi1x
         GAnA==
X-Gm-Message-State: AOAM530NlX8i3zyXIUwVIytBnG5+xvHD3jgKdKpjJRA5/nrRfORSJhRy
        lOzOSjDdw5k323YLWrHNyfavcA==
X-Google-Smtp-Source: ABdhPJxgWSmEtEI8VOcDf8wYmVXuR0IRBvYI5h/0m5KiK4ZRrYceGvZXI1rutj4/RpYSUEb9ZamaGw==
X-Received: by 2002:a63:e515:: with SMTP id r21mr29761202pgh.412.1620730356530;
        Tue, 11 May 2021 03:52:36 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.52.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:52:36 -0700 (PDT)
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
Subject: [PATCH 11/17] mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
Date:   Tue, 11 May 2021 18:46:41 +0800
Message-Id: <20210511104647.604-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The dentry will be added to its list_lru, so we should also allocate the
lru list. Replace kmem_cache_alloc() with kmem_cache_alloc_lru().

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

