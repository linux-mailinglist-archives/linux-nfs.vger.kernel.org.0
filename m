Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B140A7AC
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbhINHhk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbhINHhL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:37:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B41DC0613A3
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:34:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so1463194pjr.1
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ngaq8HeXVg0bDvfdB7FNpFgH1Z9L4n9AUAaT+A4ybEY=;
        b=TxlM/LNag+9j+pHHnzYxUIcqTnlG8CAktsmrXO0thXlgjt/0xKpEydfDbhVIhyLlSb
         8yaYLg0UVhsiS0IwI3D60wScJOYPe1zGXz1U4suUJ+i/6kRKVhMTFdS8ckWexTA4EE8h
         QEQyxDPXEneT65b4sX+iNOkGENj27L7Kwcfw3Y/ZG6i4O76WdoUR05MkcXlpMHaATepI
         4bx70VoM3TP7FMg4DKmNTasIjpr6AutJjLhrZtyNJyGSIDlLVAovGaPfa/HNI2TpR4Ae
         bQbYTzgj4IThGaUi5gXbrxK+V+eg2xuZdXHAOCxucXaqXGVpbLtTzUvJmXX4EK4DfMmn
         xE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ngaq8HeXVg0bDvfdB7FNpFgH1Z9L4n9AUAaT+A4ybEY=;
        b=xRORYR/jSip3K/2rz9In4zcXQIqysGjgl1gDFpdkjwLz4wDQrhdI1y/asoOEXk6OHT
         XP3OAbazUKewWT3i8xccSDmfkSqW/YUZO9GkMYTf9pX90I2vaGh1myoBpzVtUqmTjtV4
         Z8yYiQF7dOg0oDwR/B6aaMS041soaE7r6Ez8SW81mwTWACnq4WV3BC8Fkwv2TK8qXhyr
         zCIohT391Kp2o0bBPlY/3S8a296liUYelV7/99GIM0oNHwebUVGxSgkiLJJvwdvRCpl/
         lcRQqVbZfikk/uvdOC7stnGmWn3sNPiHyFGSiwXoBMGHhUvIdDkH7HIfx9zVktpHN0I7
         PVTA==
X-Gm-Message-State: AOAM532Bo9EBug64KsWtXAthDPCd3mpak/V2Dk0/D5RZf98i6MWXVFVV
        Xzz+oT800GnXu9Z8gNyRWmJmPQ==
X-Google-Smtp-Source: ABdhPJyCiB4o0BV2SmG7F/g3um9IpNXO0UQAa8xTk2H4jdGoOJfauoZeyXj54vI3CCV0Vr4LlpBBNA==
X-Received: by 2002:a17:90a:bd08:: with SMTP id y8mr523956pjr.123.1631604898107;
        Tue, 14 Sep 2021 00:34:58 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.34.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:34:57 -0700 (PDT)
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
Subject: [PATCH v3 17/76] block: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:39 +0800
Message-Id: <20210914072938.6440-18-songmuchun@bytedance.com>
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
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 45df6cbccf12..1630458b3e98 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -799,7 +799,7 @@ static struct kmem_cache * bdev_cachep __read_mostly;
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
 {
-	struct bdev_inode *ei = kmem_cache_alloc(bdev_cachep, GFP_KERNEL);
+	struct bdev_inode *ei = alloc_inode_sb(sb, bdev_cachep, GFP_KERNEL);
 
 	if (!ei)
 		return NULL;
-- 
2.11.0

