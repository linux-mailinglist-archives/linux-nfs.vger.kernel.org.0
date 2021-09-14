Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C640A81F
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhINHn1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhINHms (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:42:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033E4C0612AB
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:39:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so2054209pjb.5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=by9NfbxzyA9OaU41O415kc2mnEvP01WDocZm+uGoCXI=;
        b=lDvvzY0uEA3X/+hq1dQH9zDz/ubjo0Dqpy4DFm8dgjth7TNPsAgsg7nkg7/yqzvUE1
         WqaLt5T+Soiuh5YENtaxfVOJsNK1dz9wvizCFZpKgtImRU3yCtYtTlqyr6jMw9iN7pUZ
         fcbXR/5eEZ2iyj28KJAddteqj3wGgAQ87gbMdap5r/uBLJqvwoX2GLTT/twasEGndVZO
         zRhg+pzuTp63xBaKB93cVBrd2qthIp4O68AQbutKy/WthW7fuhkauWwAUwnzXxCprZ0u
         hVvFagzNBb6FEOgL91BQx0mq1qH1a0XoBq0pG3yZ4Hz+HEPAPzhQTrMAxNivNB75M3Jf
         7lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=by9NfbxzyA9OaU41O415kc2mnEvP01WDocZm+uGoCXI=;
        b=hmNPb8gIGcjkEIxRsdrfYVijAP9NSm3d+t5irWYqZZ+pZ5uH7Ouzq+m2HzF1YUz6Y9
         6GJIOJIXyVr3ZbZXb18Pa66VyAmLk5ioGB6nH/xr517exllIFtqCCc9KedyInogwqa6N
         EpysNwZ/0cbCKlxH1tfX/x0IZFgoWJFKAsHcAsZFEYJTc1g8k3lAbwEB/SNg8X6nd9zz
         XXIAEuDtOoOteWltXM86x8rr7VJ1uFqYEOcgC/uGRm77Zw1HRjL0Nm+xBTXK8vOVtfQ2
         nZ5apm3CHy4DfJenev/QAi1YZd9uDPQLJ0wYo1nVsw2zJHrQV1jgD2jL6kEDhvHXuvy+
         vOXg==
X-Gm-Message-State: AOAM5304Cuvd5+M9eL+GDXgELFHtr0Xc/q3jcm1PgGPJiRfEjXXEUgci
        NUtWTkx/Cp8EtClr8lsTyC9Z5g==
X-Google-Smtp-Source: ABdhPJwWCz+YhluUHhHodW2PrbNo6vi+zerFmcFdV98Ijs8yYhsRbP2lKnBz3Rx4FUr7kVF3FNyXBQ==
X-Received: by 2002:a17:90a:12:: with SMTP id 18mr579942pja.104.1631605145552;
        Tue, 14 Sep 2021 00:39:05 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:05 -0700 (PDT)
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
Subject: [PATCH v3 51/76] reiserfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:13 +0800
Message-Id: <20210914072938.6440-52-songmuchun@bytedance.com>
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
 fs/reiserfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 58481f8d63d5..e7beba4dae09 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -639,7 +639,7 @@ static struct kmem_cache *reiserfs_inode_cachep;
 static struct inode *reiserfs_alloc_inode(struct super_block *sb)
 {
 	struct reiserfs_inode_info *ei;
-	ei = kmem_cache_alloc(reiserfs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, reiserfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	atomic_set(&ei->openers, 0);
-- 
2.11.0

