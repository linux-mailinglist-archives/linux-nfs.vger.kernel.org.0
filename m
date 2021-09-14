Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADBB40A7FA
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbhINHlJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241686AbhINHkj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:40:39 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06549C0613E0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:37:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e16so11350487pfc.6
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0tJ4LzCSiQNWlTK3v6ATr4GS5677vmJWHcgwSa7aCbg=;
        b=BXZkZbQfSd1qtezLFpJh8Hmqcad9Ntv+OyGHQ29vR2Mj6M0LFVrUWDUMYfLmUU1wvO
         KWuQ8ulc8fpG60BPuOQeoPfs95CDTRkTh+aLrQjk+MJc3jkMebS8bljQ+TSSe0y6PqdK
         x5Yswt2zN3uzOZGhos42+wGlhg6FW2DHfSg6AjX62Pu5bA8sxFovzAL/LtJgUzty/t8c
         oJN96DiB54fPw0Y4g6eMyj5qWFtsAdk+gFst6u+A8uJPIwc2t1uehq+0q3jdSKrmslsy
         W1snw7T7V6i0r923NINiMMN7+ZpI04pY9bAqgW2uYmxX9FF5jt8UqgPG70r5lQss7LmJ
         D/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0tJ4LzCSiQNWlTK3v6ATr4GS5677vmJWHcgwSa7aCbg=;
        b=HgMwzlhdGoGYnOC4OuuV1PxOSRiPlZGvqTaf2wcgjF7pUe6oOT5zUcCnUhgDzQhz6L
         IA06Zd2215chhQrMWzlJWdhYkdQT6cfvrMYwy8lf3B8n8noAKDGOrTv9IE/9PKDRaCgB
         OeAeZdYvKimXCRaIQZuZH35MAns/zmDNisWcvSfMGc7SVRbz3//RHkWNsDg8vaHhEWKe
         V+R20tJoqMIj8PPBhoWwBzz4iAfcVpp2EFCa+IIncE8wEmkUcRnxShIfQdL5E9Ir17Pd
         85p/MlMhXXdslkYV6b22v9pjunN/2TmXEut3ji4qRtRVBMVzs5+PhFieWEmVqQI0pmPl
         WDgg==
X-Gm-Message-State: AOAM532fOsC5ujfwn+8bF9nVJdoT2XnHJy8krRZZwVBKE8jl5rEw9hL4
        JUVkqhSvEKJrxDlr6RFlobhwzw==
X-Google-Smtp-Source: ABdhPJxKZ/dodBMrWu+ghMW0cf3Yf3jYjylcfThuGwO/YNFccWKegglZTgb34Bk4MJukfITA4YrVew==
X-Received: by 2002:a05:6a00:a10:b0:412:448c:89c7 with SMTP id p16-20020a056a000a1000b00412448c89c7mr3397757pfh.83.1631605053581;
        Tue, 14 Sep 2021 00:37:33 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:32 -0700 (PDT)
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
Subject: [PATCH v3 38/76] jffs2: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:00 +0800
Message-Id: <20210914072938.6440-39-songmuchun@bytedance.com>
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
 fs/jffs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 81ca58c10b72..7ea37f49f1e1 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -39,7 +39,7 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
 {
 	struct jffs2_inode_info *f;
 
-	f = kmem_cache_alloc(jffs2_inode_cachep, GFP_KERNEL);
+	f = alloc_inode_sb(sb, jffs2_inode_cachep, GFP_KERNEL);
 	if (!f)
 		return NULL;
 	return &f->vfs_inode;
-- 
2.11.0

