Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8470540A826
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhINHno (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhINHnI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:43:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EDCC06179A
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:39:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m21-20020a17090a859500b00197688449c4so2104092pjn.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHRI7i94nkkwALVkJUru65wTIGyTMAu5yxZLJ0urhMs=;
        b=WLFvf0yPGpxYDITgQsoRZISgK1oizMjzYNnbCPzbiVPdq7IswUpVIxTsw4DygWSs9y
         uw8VmNGrWvIgI1Z7O3sQslX3re3c0eiPxnRwtt+F2g3PKev2n5MSnVJTBE6y6AVbRPhv
         HzPzwHvAFcd4LTE2VwMAwljMc6uRFXkEiPsKrbPs3qly5ey42l/L1BPTOMSoA9ZEM91E
         MNCZL1crssjdApZjU/gh2xl53+6G92GXfk9+7Hs7m2k2minNnGwgqa2qNEYOjSirX6c+
         csOZuB+w+r8rsjzG9WceNzCiTuYhYzZNTfrqjf5pdPzN4S39bm8v8pt5NGC+UsJ407lT
         qmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHRI7i94nkkwALVkJUru65wTIGyTMAu5yxZLJ0urhMs=;
        b=29OtquX8ZmeAw7fgVu1OeLg0rH4MNRJjRVcWsFixPI4BDpaNWctckn3CxZgkU77wzp
         FBOrhmtAx9JraWKZdMkOwR2U+X/AqKmcfiETs4cKJvovxYAIyirvbf/HG5gzcRChFLJr
         pqgDJs6P0ZpB0tmGYKUZp0f9TS7aPEcy1FS3R9bnl7ymvCFPoI8HnyTZXOL+345G0biU
         hEaBRc6m/MGgwiA9mNgNRwYv0g+ildyyaMDnOolpJu3/ava3lylrLTBq/JoFeWLQjFeL
         6B90FQdnqy19FFuCR2m6BNt0Wr/fahg0wd2LskOzi/NvrAz4hn03AaEPaQixkHsWaJQU
         d5vA==
X-Gm-Message-State: AOAM530eaBM+WVL/r+78kdnIjCQd/OyCH60N9EZW4B163f9toW8lMDLA
        mK4j9x9iXZ2tUo5odce0GMHyMg==
X-Google-Smtp-Source: ABdhPJy/HLUtiT+SQqdbf+XTfxJE1/QsuKyIRhd9fdS50+avblVckJ4d5s8cFJbFgkEZEIkF661tLw==
X-Received: by 2002:a17:90a:d516:: with SMTP id t22mr566682pju.208.1631605159109;
        Tue, 14 Sep 2021 00:39:19 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.39.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:18 -0700 (PDT)
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
Subject: [PATCH v3 53/76] squashfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:15 +0800
Message-Id: <20210914072938.6440-54-songmuchun@bytedance.com>
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
 fs/squashfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 60d6951915f4..e51625e93b00 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -550,7 +550,7 @@ static void __exit exit_squashfs_fs(void)
 static struct inode *squashfs_alloc_inode(struct super_block *sb)
 {
 	struct squashfs_inode_info *ei =
-		kmem_cache_alloc(squashfs_inode_cachep, GFP_KERNEL);
+		alloc_inode_sb(sb, squashfs_inode_cachep, GFP_KERNEL);
 
 	return ei ? &ei->vfs_inode : NULL;
 }
-- 
2.11.0

