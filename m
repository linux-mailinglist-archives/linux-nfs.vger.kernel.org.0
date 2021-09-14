Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D0240A812
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhINHmg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbhINHmA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:42:00 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394DFC06129D
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:38:30 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g184so11930805pgc.6
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5L3/NHaCGqFlXi1PgtyPXPldesWisd5M2MzkdPFswpU=;
        b=aawds+ZdgmQfgr4O19Bbjb1tnmHppDZeHQM28obpBAxc63f/d3ki+9vg8HMeNgCvZ9
         l1fv4U38sV9NVGlyrHRR/L3biZ3qMuBgMcBJ9/4d/3OdwQf3VnFrxWRGbbepAVI7sArV
         AfkHKSDuNhvgEgZEYICVo1qqRY2XolcCiBTM1eqKKDTjabKr7vU/Ew7prI441h+yxe0U
         psjwfhIeEXa1UIUGkoULi4SOGfFHhOQyRxNyt5yf1UEVjJttnJu7DoFDtotNJ2hUvFWV
         UUH2szXMKPJVLVV9cXPKc0GnOYjr5NDBAiQOCIjsR5oBilqlzVRdV4l0VMHkUaTBja1J
         3l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5L3/NHaCGqFlXi1PgtyPXPldesWisd5M2MzkdPFswpU=;
        b=PsB3OD49Ig+r5EWWzJntftTbTkVfZUpVFIrgLba+2/4SnbUO9imxxpsaeXF8Degqft
         Qdz9g6F+VLQS4wbH1YgLvqaCwtNaIeGlxeskNGTUI1/OVDn4gMxEZLQZLjGxR3wC0pk9
         ka+1IaSD5swWOye3ceTIG7Hpy9S2YODYbuss18eQeSHPBYLoHG92Dfm3rDvj/BtK5iBS
         HDgxRVp0ggi1uzvowR4hMstZ0hP3rHrZV1U7w0m0kGkPCBu8EHQPZbsJ7eP++ZXqqe7s
         N8Y+ptOqFOO/cFamy40APxaNu8GN9XK6waCBTaFnUz9em7C5s8YVhxa0+AhIp8Ttg8bS
         TrgA==
X-Gm-Message-State: AOAM532sU7gWFYKSwsNKj3ykndRtHFHrNhQUaQfVFdIHaIsKzGkYFE+k
        nDPrLBL9YIZ8bBH87X7T/iT8ndqT30fvUQ==
X-Google-Smtp-Source: ABdhPJy8+rOLc14+gnFDljhOryw2SP31lFSN5DwaxpCdBACFxg01n2dIXxGl5EEh/bqyueZ408ipGg==
X-Received: by 2002:a63:7454:: with SMTP id e20mr14244578pgn.136.1631605109791;
        Tue, 14 Sep 2021 00:38:29 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:38:29 -0700 (PDT)
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
Subject: [PATCH v3 46/76] orangefs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:08 +0800
Message-Id: <20210914072938.6440-47-songmuchun@bytedance.com>
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
 fs/orangefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 2f2e430461b2..1deb411ca5e8 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -106,7 +106,7 @@ static struct inode *orangefs_alloc_inode(struct super_block *sb)
 {
 	struct orangefs_inode_s *orangefs_inode;
 
-	orangefs_inode = kmem_cache_alloc(orangefs_inode_cache, GFP_KERNEL);
+	orangefs_inode = alloc_inode_sb(sb, orangefs_inode_cache, GFP_KERNEL);
 	if (!orangefs_inode)
 		return NULL;
 
-- 
2.11.0

