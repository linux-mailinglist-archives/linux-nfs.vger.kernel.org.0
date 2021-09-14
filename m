Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304F640A7F5
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbhINHlD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241650AbhINHka (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:40:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF72C06122E
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:37:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t4so2004556plo.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z46CAf++vWNuCvheHpcgLnfLOzy9VY+omC7eSMsVmCI=;
        b=eQSaW7lNBdHi5KgQh+gECuNfuAwoGGyc50ZyaMiu4wpArjjQ8tBFBQsn9xlNelCQmv
         5OBK9Q/SXI6FRGMt9XGoScmrzTOb2U7PbWXM9NAETS4ja9/wswF+Gn/LrHnXAn0Z4fUL
         EWHBtDtcIIcLWoZGTmMyNdduKYiQQP2LBF0coVdVnNaTt3YM0pvs+TlXLvK4dSWJYMeV
         BkeFc6BO7cZz5FXVB8hX2fX6RalfjWZhAtKhpOvHLDnFm2pXBcSGbsISAn0sqIP/M1YZ
         /EZ+Z9xtEZqp4/704+ZMqJmj3XS8afiHk4EKSvX3WJfURXaHUhwVNgFktYnxkCSwOHv3
         wq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z46CAf++vWNuCvheHpcgLnfLOzy9VY+omC7eSMsVmCI=;
        b=FXpWBcM2HaMC1PzLJxu22RhIB+ESu/+I+2NXbhx/7mXfjbtvuDJJwijjV1qNwDSy89
         LMQ1Tfl8Q7ncSQrtmyFRRJ5rjSt9iDXzPWr1NkG7QloiBvr4SKUcSzRPtZTCXF6+/pvO
         N85+P8BuVtfB3RW70rZv1IMHb1jn1K4MBg5seL6kffNKh03zMCtSa6abDOHZLkYOEzrV
         STOiQOejoqcthdioakLsfEIeAUOZpJy7x1l/mqhwdJrCIYw3A2P/el9J7AukL0xnID5M
         SCZm4Ks5HmAKT7DNFalj/US53AhP6fCFzV8i1QUo0/cehujSoJAr2pHeTgu/Qohscu6a
         ouZg==
X-Gm-Message-State: AOAM531SEFIeWHsJ6+DmWMMiJVU37wW2Yj9Lf+9EP6j+kE8l92xb3I1j
        8JFmgzuyvV3yrz/wXltusVB/tg==
X-Google-Smtp-Source: ABdhPJwj8mp/hBHtqM8sVnXiQ7xQ8bihltPI4ouJRqOv/AopUxToiy3SFXDC76z/VupeU/zM/k58uw==
X-Received: by 2002:a17:90a:8817:: with SMTP id s23mr527246pjn.181.1631605046111;
        Tue, 14 Sep 2021 00:37:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:25 -0700 (PDT)
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
Subject: [PATCH v3 37/76] isofs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:59 +0800
Message-Id: <20210914072938.6440-38-songmuchun@bytedance.com>
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
 fs/isofs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 678e2c51b855..ea8fb73ae3e7 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -70,7 +70,7 @@ static struct kmem_cache *isofs_inode_cachep;
 static struct inode *isofs_alloc_inode(struct super_block *sb)
 {
 	struct iso_inode_info *ei;
-	ei = kmem_cache_alloc(isofs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, isofs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
-- 
2.11.0

