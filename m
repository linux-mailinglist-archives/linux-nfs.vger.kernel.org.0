Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58B140A831
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhINHov (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240956AbhINHln (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:41:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587BBC06178C
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:38:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id n30so8651535pfq.5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4KSe7AjEWCOQhYQ4BKRxMdYZ3ES9HItolt5HRTGpI0=;
        b=xzje0lYjgtiYHB/0iy5+pQyezpDMVsZnP2cxTJfS1TYBvIaCpk7rc+/+B6Z/Zxx6WW
         8S0zvXD3c824X/qZyTd8IWPWU9M2jSXSysb3dbB6jDqSkEt+zYiV0VD4Mdtru/cROuke
         5b+6ZQKuaJyFa9sfYE4SePn+eF6sswksdq/g4FLZsLQJUA3ZFj1EGXpxLbtchmZbaLG4
         LR2jcADw4D0AjIpv+pnz93RAxWRGa+W4LUe2JYF7NfA51Ht1R50bhEPZlfbgI5m6/fsQ
         KBH4+cpE4O3pnNQpDc8mnlskadIdSSb5c65P8flpkapQUwG+6ZQRbEt7JhRqT5s55lKH
         qnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4KSe7AjEWCOQhYQ4BKRxMdYZ3ES9HItolt5HRTGpI0=;
        b=sOBv5nLfSlkQqjdYzCSREeKKyfgqOC+ZynNf5lTZNmoSEH5BKFeoGB/p3U7pPUQYcY
         jHK8dSgTZQLM1azuPjkgbGG/AvNafIEYTjrzReYFpYCra0+8aOWJBlCbyMyD2XVYoXKP
         Ve6b9nupqhnal1rMT67TNKrFRq3Th5ERjJ9f1bMwwyw1zJdXmCAyj8zyfBtFQ/Jbryrq
         lTw7ehx2hk7pUo2C3/yKLiaUmKdi6qDGqb2p2A/r0TJ3K+6r0IG/TCLS7P0wklmUA2cG
         do3XlXD4mqcoMdJZOhqTlSq2iyboljDlF6eUv2vLCdbe68e7H+HeSfx7Ni7V739rTxY7
         GklA==
X-Gm-Message-State: AOAM533u/TRKUZQZCdvHDC/0tJyHiU37yeIOGba9ndMoLbTJZpkYKoVw
        eijiH7+D1iwWRSpNWpbc4Lu/ew==
X-Google-Smtp-Source: ABdhPJxryW6NCxFQfOwl0VgErjFN4YVibym7a89eiIqVNquSMjlh33A61h3eZANYF0n3jL0KiGKDtw==
X-Received: by 2002:a62:870e:0:b0:416:4820:a208 with SMTP id i14-20020a62870e000000b004164820a208mr3430714pfe.0.1631605100936;
        Tue, 14 Sep 2021 00:38:20 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:38:20 -0700 (PDT)
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
Subject: [PATCH v3 45/76] openpromfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:07 +0800
Message-Id: <20210914072938.6440-46-songmuchun@bytedance.com>
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
 fs/openpromfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index f825176ff4ed..f0b7f4d51a17 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -335,7 +335,7 @@ static struct inode *openprom_alloc_inode(struct super_block *sb)
 {
 	struct op_inode_info *oi;
 
-	oi = kmem_cache_alloc(op_inode_cachep, GFP_KERNEL);
+	oi = alloc_inode_sb(sb, op_inode_cachep, GFP_KERNEL);
 	if (!oi)
 		return NULL;
 
-- 
2.11.0

