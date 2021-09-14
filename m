Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1123140A7B8
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbhINHiM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbhINHhi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:37:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBCEC06179A
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:35:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso1444687pji.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yn4GjbGKOalkp7KyXghKb9kUqc+WdE7xPBBNtSw49kg=;
        b=npB+pVn/vbn0eNYwtlSthJv7NBkOrOYMdLVzNAnEHX0BsO73iZoa66jGaFaG5addC0
         cgJiTpm3Pv92k7hEjsZ05n4vWim9yUjZaflyMTHnB+SIxMH42+iuoY6FtWyfDm6T6uZM
         /SvJYTj0xZW4myvwa7ToEcgOpprF6LR7VMWYknvR26p0Qu6ZqxtY5e15cZta8W3aeblP
         Pu8Gyt1UcMCae2DKj9uC8co129TdSbpSUsUFBHsAv3ASerGOo92IyrNVp7P5ai0EDton
         KJkkOJDmM35KKrYqDrF7k790Srij5c5bn1mgnYI3eLrodF7RbhmMbZFUPZCbau4exCN+
         lHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yn4GjbGKOalkp7KyXghKb9kUqc+WdE7xPBBNtSw49kg=;
        b=7B58te3NxoZvVHbzO4qSbb2g2u9pP5TR9tJ+VflEpuVLuFFYSiK+n++dj8gDJM0hut
         7YlPEXSQs1IlSYdIaT5bE1rmgkmN5JYFE0rKxDeMfViY9Fi+oATbVrbwEoEY9JPZBX/K
         8toxbfikG/MWr+2Za3yxebEqWBPos3VQFlwkm6Pp9I9kaxTOKnSSRnIwImR+9VYpPjaG
         iULF2uc0U/g4z7wDMyK+isPvJpTc5BUzIkrwq1j2/F6uRL7SJdY7WfCq7w88cHDyHwHl
         PxzTkRMlIODISj8zzySXkrpBYWEKrOOu/llLSMCtzxwqjZMe2DQiBv2//UL+EZoZ6zdB
         5jSw==
X-Gm-Message-State: AOAM5301/WkrSFeeHyg4oSsjQ+D92KqKvGJSxupKS+8SeKsgysCcfVHD
        UfA9MSghoGWiiCezLN2jWnZdbQ==
X-Google-Smtp-Source: ABdhPJxy4IufRBKzjD8wBmIhR6AaKyadsNj889rMyLOVXLMf+K5MDbdlRVSNpKLlmHyPRl+ICj25uQ==
X-Received: by 2002:a17:90b:1bcf:: with SMTP id oa15mr479092pjb.58.1631604926427;
        Tue, 14 Sep 2021 00:35:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.35.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:26 -0700 (PDT)
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
Subject: [PATCH v3 21/76] coda: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:43 +0800
Message-Id: <20210914072938.6440-22-songmuchun@bytedance.com>
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
 fs/coda/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index d9f1bd7153df..2185328b65c7 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -43,7 +43,7 @@ static struct kmem_cache * coda_inode_cachep;
 static struct inode *coda_alloc_inode(struct super_block *sb)
 {
 	struct coda_inode_info *ei;
-	ei = kmem_cache_alloc(coda_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, coda_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	memset(&ei->c_fid, 0, sizeof(struct CodaFid));
-- 
2.11.0

