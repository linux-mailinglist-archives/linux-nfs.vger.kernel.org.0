Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB7040A791
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbhINHf5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbhINHfc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:35:32 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BCFC0613EF
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:34:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j16so11354748pfc.2
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Een1sDBPrj2tYW3UgVidRn2hFKpvInjKsC4lnzv+r+s=;
        b=hwfQHv4YyZFuK8uRdecl6UJ4ZCLL+YxGBmSPzJfSBj+cNX0RGj/vjS2huquwqR2eff
         894MlelcvOoW2PXCHkdchBqg5JUCefoMMCAC8MR03VHs8yMafrYb0TeXP+3K5mV5REeD
         482qt36XpQMzllbc+46p7H8rLB98khauGSLxtRet0z3aIid/fOJpRD2DoUCzkst0ZBMc
         vjfu9UiPtpxcX1uhiLA8iY7YU9A2PEZZDB/g2RyO4gZf2oilHmwW/8eePABd1A05Gqkx
         OUBnQfpEhAiz43za7C+MvI08abWGRBjPx6qmSW/y3/Nx6pphrhq6xFOnko1qnD0RVtXv
         aVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Een1sDBPrj2tYW3UgVidRn2hFKpvInjKsC4lnzv+r+s=;
        b=fRrzJe89Mzqdb8hl2CNk6XovvffswQVY+fNdtyJLUYY7lvGUgToGd5lyasS3Zagl+E
         M54YJCBet4dQL4mMBcH2LVJWwVxpWK2BwKajH5ztlh0/2q1sdqruNg0YcycRk9bdsMzD
         Ovyf7EOjyJHgaklXxAqalwhvO2hZDYbqWNy5vm+9L2V4ByuBPOmW208deCSx6rjgrogB
         vmvxYxv6F1y3dOqInGJfaAdiw0UWOcfCUKjyXy1bIjQgMlDLCcODQXvlRugCKLzLJx40
         FZUpEqRcsMPoLbe5WPeoXQ6LK+yLvUVJkDZqZMscTN3GDGeYO3/CBA5d1oU36UdtASPY
         8ufQ==
X-Gm-Message-State: AOAM533dMnwIYcp/jMMmixDjNen7pkHqDv3IKYgIeiXCgUNGYsGNJcFe
        RujG2UJuMvH0t0OIHylUFBtqbQ==
X-Google-Smtp-Source: ABdhPJxDuPlbC/nA4zUe4ijemmnEj10CilEPVZjnz1hnHeZ7fxNYn8sSJwcyYn/0tT/kQd/l8F/T9g==
X-Received: by 2002:a63:8f53:: with SMTP id r19mr14599042pgn.84.1631604843947;
        Tue, 14 Sep 2021 00:34:03 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.33.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:34:03 -0700 (PDT)
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
Subject: [PATCH v3 10/76] dax: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:32 +0800
Message-Id: <20210914072938.6440-11-songmuchun@bytedance.com>
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
 drivers/dax/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index fc89e91beea7..288c0b85bb77 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -447,7 +447,7 @@ static struct inode *dax_alloc_inode(struct super_block *sb)
 	struct dax_device *dax_dev;
 	struct inode *inode;
 
-	dax_dev = kmem_cache_alloc(dax_cache, GFP_KERNEL);
+	dax_dev = alloc_inode_sb(sb, dax_cache, GFP_KERNEL);
 	if (!dax_dev)
 		return NULL;
 
-- 
2.11.0

