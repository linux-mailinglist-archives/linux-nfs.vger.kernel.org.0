Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831AF40A7CF
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbhINHi5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbhINHib (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:38:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1208BC0613E9
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:36:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso1492490pjj.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cmjjxAarEFgJ80kKiRRnCFdLqqijm/ZOZ3kz8PWEXM4=;
        b=uTrXKSnUgf/D1pPSszp9Jli4gPAIsZjFM3ymwHw0oD5rlNZgodHU1a0onalEQE/BnQ
         Tq3WMOBDjMAw00HLB8jMEtfbkzY9tzNQcDgABUEqHnxrKEB+eZV8mDTA8irJbX9Ldxry
         +EFr86Viasjl9SwUW3DuBJpw3T8Ak57aRafmujH19brt9CXaLZSmAdpkwZifbT2UHfkO
         WtpX3wnh1/ArkU3gzfhnyY+pWmd2YNY2q9VHvf34UEKyEp0e8XPvXQGyAzIaLMVxCFE0
         ugyuii9Xmh8v3fZf38yaYFzUCitTtFF47+fhdQf3sE5E8OrIS+kTSSqqeBaMg7hb8c3v
         w/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cmjjxAarEFgJ80kKiRRnCFdLqqijm/ZOZ3kz8PWEXM4=;
        b=VQo3XccLX9k44gL4BSdYwcbeRqzccL9vTYIHoNX2YdvDU0cjssrARczewzQ7CT/LP0
         YDTtcgWPX9C9Hxmi6XksxJ/02TOubxrFxAx+feZUyC7O4TKKUSpYaJp7jWdbS6s2InYZ
         oeNInHRo2wLmFj6OO+Yr0VDBqAJRUiWI2MWSsivGhSQkyiihvTwHTjMdhQ6/c1r8+TGb
         f1JBfYaotWjBxqhabWx3NbCoAOK63GTtsR60VxVPvva7L0iu98EtP3bFMUd/1daGyGB1
         E58D0Yhci3QPVK8Q6HMT1g8U6rj6DbfMcJFBMILaUsCMirNGxUSRa8ws2aH6GJ+qP6ZH
         6ong==
X-Gm-Message-State: AOAM532isO4w5WofR81gz4IaKknLX9y+Sdx1KmRBM4EjO+E1CKFfCWp2
        kBobdCP+RY0+Zlcmd1Vu1l/rzg==
X-Google-Smtp-Source: ABdhPJwbNn2n3qZtjVQMtbnAhg4/a/OijUviLF+d8q6+0lbEHs1AYMqKbKdwzQfo2+1abSfqmXKt8A==
X-Received: by 2002:a17:90a:4ce3:: with SMTP id k90mr517998pjh.237.1631604971297;
        Tue, 14 Sep 2021 00:36:11 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.36.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:36:11 -0700 (PDT)
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
Subject: [PATCH v3 27/76] ext4: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:49 +0800
Message-Id: <20210914072938.6440-28-songmuchun@bytedance.com>
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
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0775950ee84e..71982851063b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1284,7 +1284,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 {
 	struct ext4_inode_info *ei;
 
-	ei = kmem_cache_alloc(ext4_inode_cachep, GFP_NOFS);
+	ei = alloc_inode_sb(sb, ext4_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
 
-- 
2.11.0

