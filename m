Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A8140A7A2
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbhINHh1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241006AbhINHgw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:36:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6E1C0613EF
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:34:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so2046112pjb.5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pedf9du0q8x1qAsaM5V3taJv2nQf7Bhn4Zyu6Rs8BOA=;
        b=UmoEkfxCRPhIo5HEYCOvUTLwt2JiJ7GS6xmqjTUFzuAs0PIbDbopH2NDmuJyFjtvSA
         6Qocu6XCUru0ObSWp/NjROFSqLvbK1De3Fo1USBVt+p+GeyE7puX/aMKapXy+mPilRpn
         1AjHYrsyrr3J41uOox3PqjFfRqMWjfKb6impQOYoGwyJbValrlYJajenPS7+RYtemLIl
         GUO+IphKhrxtkIgZFF31nY2xO8r1RCKRr4NdnKa3tynWEIgt/k5x0ZJKfQ0ag50EUOwM
         tkrQAQyCR7aEmJqihD3I5zpip1PyBFUDFZkQWNKp6X/8XrHpgktM6ZkSnpzrvth72bFz
         4W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pedf9du0q8x1qAsaM5V3taJv2nQf7Bhn4Zyu6Rs8BOA=;
        b=sPgW7JHCkA8wxYxui7ip3d1oqeRzY1H7AkENV7Up05F7F/nZ1UNh47xSui3yDVbOla
         Xdl69uCPXIw4QMnyjHb/7K859N1Dktz1yvqn2EpdLii2ZtSeoY7GYs5I6Bvl+hQjT+E3
         iT0iFHCxZYj/7IAAftV+2N4IGoNGUI8JIsw2Z7xCDsEtmEbrAi5P3yYqTPQiV0YWhkuL
         Tn3S1NNF4IxfwExr7jC+ZDhZ3+gPfWdOQ2LTe6O/9oz3vsq+wSbR2wLSbTSwkx1rpOAJ
         e2OVqDjKuDzweQ597clV0CQ4v2JW2xM0dUhOEdx5fxNXQZE1+gCkhdz14BGQiInp+1ix
         uC5w==
X-Gm-Message-State: AOAM532Kx+cLxaG9l6XkCplEIIIMjgFmMuPKz3b261v735NsiiZpQSou
        junEoG7Suw56RrIIrYXDuLuFLA==
X-Google-Smtp-Source: ABdhPJyrhuxUeqV+K1cl2xp3aIj58oY9WlBf65ST7PoGj30D+6kcbs/jZTrC/qRoOUA6+U41V1WqrQ==
X-Received: by 2002:a17:90b:4901:: with SMTP id kr1mr574557pjb.80.1631604883756;
        Tue, 14 Sep 2021 00:34:43 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.34.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:34:43 -0700 (PDT)
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
Subject: [PATCH v3 15/76] befs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:37 +0800
Message-Id: <20210914072938.6440-16-songmuchun@bytedance.com>
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
 fs/befs/linuxvfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index c1ba13d19024..b4b3567ac655 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -277,7 +277,7 @@ befs_alloc_inode(struct super_block *sb)
 {
 	struct befs_inode_info *bi;
 
-	bi = kmem_cache_alloc(befs_inode_cachep, GFP_KERNEL);
+	bi = alloc_inode_sb(sb, befs_inode_cachep, GFP_KERNEL);
 	if (!bi)
 		return NULL;
 	return &bi->vfs_inode;
-- 
2.11.0

