Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88D40A799
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbhINHgq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241270AbhINHfr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:35:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC1C061764
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:34:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m21-20020a17090a859500b00197688449c4so2095123pjn.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0Cz5KszzKgz+rfafe6kJxucNkG4zz2R/wYYOusb/5g=;
        b=vJYKAwYhwUV5hhfFKNxFX40A7tFGg6R3plM+yV0OSmh/VU/IqBmwbz8zgHD1tHkEK4
         E1JD4YltDx4a3n4GSbOI0E3x++tTa+l+SIit1D9Da0hOUEa8EjrH/68hl09owts8ZSP7
         lpFgWoOwZs70Nh5hAPXb8CMgr30Z9pNyIMb0YXUoMiaxCQVE0eG3O++s30J7pfJeu5k3
         Iqw1eTvYDoaHw9ODD3FXUIcPhYShUrAtBJc1DDPDdwRsjTw6vr5De7ltVLGADuOeqFgQ
         q4vQAhJ8Up4ymIRMAKjHeyR0DbH3TBqW6isSVBLzY8tABPgSSy57qJbomc00Lngwzsfy
         Yb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0Cz5KszzKgz+rfafe6kJxucNkG4zz2R/wYYOusb/5g=;
        b=3pl+JenKwp3ZOBEob/QJ9sJVqJFkb9OuvvUHl7S/K0+Lha+47wbB9KokCSiY55Ylja
         p0MFagu0J9y0lsHWISHiwwQxo9QfM2o1FCtNkv7I/Q1wiCpPSDwhLBArE8wTcfw2GP5A
         sIQzjckYuLCKru0/Sxai9ubdu8qN4k3dxw/fpkybrRhYwDB0KwM3m8vmiD9dVkEqNhrx
         BZ6VFrTfqLwsMoWIOQBYr+fg4lInQigrNhJfRduxvn4CsS0TNrYUU2Ph+skP5T+60EQN
         iWFCGUkkNTdacd4xJjVRSTIEI8WuQVvV4Qslhmn9LXCKBnbMSdUOzb6ebdjhtr8JIS1O
         Er/A==
X-Gm-Message-State: AOAM530vs8kmX+lG1vkBxT/rI+e2ayvm/h+BM2IqwhShp3wIgwKq3kU3
        9EpKro2EX/tgC5VA7hw2pEJsEw==
X-Google-Smtp-Source: ABdhPJyCqvutogGUThraHLU+AXmQ0katkDnels28Nlq4T7R4apDU3w/FDhkLQaDwakizASQL3Uq/RQ==
X-Received: by 2002:a17:90a:2:: with SMTP id 2mr523792pja.77.1631604858840;
        Tue, 14 Sep 2021 00:34:18 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.34.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:34:18 -0700 (PDT)
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
Subject: [PATCH v3 12/76] adfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:34 +0800
Message-Id: <20210914072938.6440-13-songmuchun@bytedance.com>
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
 fs/adfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index bdbd26e571ed..e8bfc38239cd 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -220,7 +220,7 @@ static struct kmem_cache *adfs_inode_cachep;
 static struct inode *adfs_alloc_inode(struct super_block *sb)
 {
 	struct adfs_inode_info *ei;
-	ei = kmem_cache_alloc(adfs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, adfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
-- 
2.11.0

