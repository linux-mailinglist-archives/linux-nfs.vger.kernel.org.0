Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BC540A7ED
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbhINHkb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241475AbhINHkO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:40:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DDDC0613AE
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:37:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y17so11329646pfl.13
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0G9QgPg+hfzr8x+8Bx7OvscmO6lHALpSRI/OEyBuHk=;
        b=uATwrDbNiKHs9A7JcSMurQYgFjrqGaAO75qRq8TzmBt1Rpc2g67hGH2yRdHL4jZi4G
         hYnWKMCzOyhKim3DowkY0wtEoLF2nGbkmHrkrR5ZCNto7iZ31dVwTvv3/hGqSgD1On4O
         B0ZV5zdqMy/vIb9hXB4LxN/ZT7qcw3bhzAzXJa9xvIP26Fs0Z8oDVn2uERxib8SKqySV
         l1eNsBvpM1/48WN2d9Cvc6KA5W9rebm12c3l7Gp188hSoC4uzgVZJ5ENUmKoNfO2XC8w
         o29ubWCMaEQEPnOXZEBR+pzVqP9EuZu3b4YQRgUAbJYR7Twx1UOwT1Z04DCXTFSjcOzW
         KviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0G9QgPg+hfzr8x+8Bx7OvscmO6lHALpSRI/OEyBuHk=;
        b=4MJxnx1pMvJ0p/lrKVAaFPDiQp+E9QwP7ZIjxr5sbtnWVudDjRPuewyqhkHpDY2JLd
         Oi2JHSIuP8/AKq6wtinVV34aBMl0cXeP5UurlxnQbTkFJ1fpoN9Xpieiu++zmaQBkDZt
         UZSEx2KYugXSFhkmzEDEoFh5lLEA94oMWCyURkcMN4xC12HiDe5wWihzpoiZOouerMZH
         90f873eju6glMraIgtU+7m3tkuov47lI25TorhmcPKn61lHINB/TEuEIlDV+J/RQ7Rb9
         oZfbpJlZljp6XwnTZmeoSEz6HnwVESR1Ffb9R7T66Y5VbnT7skqGsH7pSJ5t+pL7q3gp
         O0nw==
X-Gm-Message-State: AOAM532sBPpgFkFctBpOaWe5zWoKRF58WczHrK9ogB+bLIK+O9YJf92P
        OanNjRD4RplKZI5yKhjqp3/voA==
X-Google-Smtp-Source: ABdhPJxFZacq7xaIgBaomiZ8xQ8HnyQqJjq+FaOSbVOzDFUzBUGypQEmmhDAS0VvitHHAR9ty4tO1Q==
X-Received: by 2002:a05:6a00:2a2:b0:43d:ea13:9c06 with SMTP id q2-20020a056a0002a200b0043dea139c06mr3386511pfs.37.1631605023758;
        Tue, 14 Sep 2021 00:37:03 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.36.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:03 -0700 (PDT)
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
Subject: [PATCH v3 34/76] hostfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:56 +0800
Message-Id: <20210914072938.6440-35-songmuchun@bytedance.com>
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
 fs/hostfs/hostfs_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index d5c9d886cd9f..2123d2bed55b 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -222,7 +222,7 @@ static struct inode *hostfs_alloc_inode(struct super_block *sb)
 {
 	struct hostfs_inode_info *hi;
 
-	hi = kmem_cache_alloc(hostfs_inode_cache, GFP_KERNEL_ACCOUNT);
+	hi = alloc_inode_sb(sb, hostfs_inode_cache, GFP_KERNEL_ACCOUNT);
 	if (hi == NULL)
 		return NULL;
 	hi->fd = -1;
-- 
2.11.0

