Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ADE40A83D
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhINHo4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbhINHo1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:44:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624C0C0613BC
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f21so5372459plb.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQiPvHV1kAW82zxCaMhaRncf1tI904Mp4fT7Z6DcW/g=;
        b=HTv0QCf28It9lU5pPVCMk5Xm3hHYstEaSOTILsVpTo12lCQwSniOySljOVzbZVR9rr
         ukAUHRYlJqyxd0bEmiWI8CYpqY4qrlyXBf3ybtfSESmP+DtrGooyzYW8lwUjuF3D/V2E
         a8Oxbi7yBv86BCkEUBuA5+PozfOGuFx/hUhKn9FDJ/Mrmsy68cqip0am4ExgAdWXIwI4
         Ts7MfPOFQHx2KG/R9fAjbqroVLOTokfOOrVHVJ8ln1TA5o0IZ+wQMbVWiu6p50QkRDBp
         H/KFDsQIhgqyxELj+CHfimxExE2Wlpn6wBjldIVlxq4If3Rw9ueYE76WeQi1ZaLBsf7G
         ep9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQiPvHV1kAW82zxCaMhaRncf1tI904Mp4fT7Z6DcW/g=;
        b=FC6WIrbiMiT0TJ68jwdJ80TqjYVl6yUzo9WFvJBosKikakNvWTEapIoYPkwLJNzwew
         Wxtf28fIjYmfLmCfuD/loalkTkpl20Ek0hxXZ60PczsaZbtw2UtJgLiSb2pC4NU7wXjZ
         PTuOzwGXtil6GFymrGwMrAFXpqAMtQ1Ojuc6sKCpM7jxnhFPHRuENmp6CnQt1wXNiVwr
         oWCW1yFYXGv7yKYG1kDMy8lDty6ft3SIIHn/dBYDVfdmGLpdJpBNz80XN2Rt7gSiCQc0
         NkQPVWGMXNBOM8KkxFCJkKY3fA+oW2SL3HLokTH4P/eyTVygjoT3zVrpypRQ4bhBLrTJ
         dy2Q==
X-Gm-Message-State: AOAM531AcFLbNYIY41N1z0fdIrM6/AN8iwr8BS8Q06+CEhBW4tfOSKOF
        HtCW7Ai6A+TgVx+avPRQrycsEQ==
X-Google-Smtp-Source: ABdhPJzgOQ2EfmZzsSiVVu+EtjPWBaYq/0SkGw4dtdh/XidcLQ/yLTjOZYpVmaEit+KKYkhbLW+5MQ==
X-Received: by 2002:a17:90b:4901:: with SMTP id kr1mr596641pjb.80.1631605216971;
        Tue, 14 Sep 2021 00:40:16 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:40:16 -0700 (PDT)
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
Subject: [PATCH v3 61/76] ipc: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:23 +0800
Message-Id: <20210914072938.6440-62-songmuchun@bytedance.com>
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
 ipc/mqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5becca9be867..7c08eb3c258d 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -486,7 +486,7 @@ static struct inode *mqueue_alloc_inode(struct super_block *sb)
 {
 	struct mqueue_inode_info *ei;
 
-	ei = kmem_cache_alloc(mqueue_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, mqueue_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
-- 
2.11.0

