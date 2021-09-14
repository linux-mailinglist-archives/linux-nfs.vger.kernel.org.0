Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D53340A7DD
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbhINHjf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241411AbhINHiz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:38:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B53C06139F
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:36:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j1so8234429pjv.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpuZrN7lVo6ohiZi0x9Y9gco3KIsT7Yu4UJF7LQ+Src=;
        b=XK2YVgvEnC8eo561Zj8YudwmEx/4PDfdTQ9dKb5DvB/DKuFgYUzpUolHYO2djH6KgZ
         KL90gWeOPaKl3X/lVfC0rvtEfSKcHaA5BE7Wo6UQTiVU2LjC+Q8/7cMn32P7aGUZcrc8
         Cok0BiIp8dMuTRs4sWjgZFzbpsy5A0ucWr7qqASyrwnGf34usBwod+EVjMfjwvnLcq7F
         GzJUHULfkk0hRQKS93PSPZ2YP8Kj/+mlP/1TgoUpnjC/QOOLKyRA5diUxnfn5ru/s2p9
         sM8rW3p38fz3zEqC4WE4lL4gXhfChJPS+h17cCngl+uXsVn8tDH0LtenenRAe5DMCMnL
         e3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpuZrN7lVo6ohiZi0x9Y9gco3KIsT7Yu4UJF7LQ+Src=;
        b=j/rreBnd2o7IxZ0agf6j30tn2pZEERVvd3WMVkz5NNZZAzcCHwAcvoraQrLYLEg+BP
         LkPaU7D9LG2+uSj0R8lZFiaMFlZUvEfIM3IQVBYav9aCuuBuXQYFm/1J/lKqlLWvR9Yy
         mdoo9Gkzl+bTFfmxVH0F4lEjFcMpksROditzkfEaQs4xctYeRDKLnQ7zaS9vG57679Kg
         2/4LUSJ5dnFqT1bQirzRLyqwaVS+dAJ+RFNUFwJHbv885cq74Pqjm1PF13FgyhWUbRrk
         pwRba0RnwEvoCWubgLC4A2D5qCT696UqOUiflUkfTQ9wCGHBWYkd5Z4dDpAOUucrtGdt
         6pgA==
X-Gm-Message-State: AOAM532xKTw8L4n3aGNpshjwpFlOz5Pkcizq55x90e+NbSwlOzsVB1cE
        b7nVEp//go88gfdCHmeg3ak8nQ==
X-Google-Smtp-Source: ABdhPJw0ASs2RIdhxbbR2O/YDK5qRhA5nrg4Z8m8PgOz0RuFsVoSPDmc2jQVl8bkdrait64wdD0EGg==
X-Received: by 2002:a17:90b:250e:: with SMTP id ns14mr573022pjb.84.1631604986552;
        Tue, 14 Sep 2021 00:36:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.36.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:36:26 -0700 (PDT)
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
Subject: [PATCH v3 29/76] freevxfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:51 +0800
Message-Id: <20210914072938.6440-30-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The inode allocation is supposed to use alloc_inode_sb(), so convert
kmem_cache_alloc() to alloc_inode_sb().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/freevxfs/vxfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index 578a5062706e..22eed5a73ac2 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -124,7 +124,7 @@ static struct inode *vxfs_alloc_inode(struct super_block *sb)
 {
 	struct vxfs_inode_info *vi;
 
-	vi = kmem_cache_alloc(vxfs_inode_cachep, GFP_KERNEL);
+	vi = alloc_inode_sb(sb, vxfs_inode_cachep, GFP_KERNEL);
 	if (!vi)
 		return NULL;
 	inode_init_once(&vi->vfs_inode);
-- 
2.11.0

