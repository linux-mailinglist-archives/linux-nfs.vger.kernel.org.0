Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B1640A839
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhINHoy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbhINHoM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:44:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0A4C0613E5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f65so11340870pfb.10
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NFK8477UAn3zAKQ0vXm0lu+fwWsZH+uussXoYW7LsE4=;
        b=L2tXQ4abitca4ZpsuUEhDYaxwHxkohsNX4r8JUZZQMfvw7KBpwdpYy3hMa2VxOYtOY
         /tWe2XlXOVIPpAcphXR1WZg5UOXFqg3UHPRDwQcVJsodv5NthoXtQCHLnfzhBXgKMa2m
         QVEG+UgL5UHafDNVUK1v/2X5mkcpp/1us69k8wopwcZAfPE2E8CMtnfTuwa4uHps3Dfl
         F7l09aI91gOWOCcE1+tkPcfFpVoS+eH+k8cbXfk+zb0kBUhch6ofDcvZMyfDpmnoEH2b
         tx+8zfpUEScvl/2qvwweom0hZMUnnM8273fTlolF41JYbgc5UtvHFm6Qxxl4EC13OCig
         2bSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NFK8477UAn3zAKQ0vXm0lu+fwWsZH+uussXoYW7LsE4=;
        b=dVhaDkdTS8DAavgd0nNFnAEE+A6UGauXdXGPMlXwCjRem19sJcd3uzJmxCepOsufEF
         BVSZIZnVKcnxa9BYgHC73A9xa8SPj8SfcX50HH4gd0W1pVfGImBTTmNl+4HW0mfFYH9k
         KtNlkk7j9ZFzf+AI28lnmAXzdjJkU0ljtQLcKMJSZPiXqhkvqCGwJLFAuj+IDy+y0RoR
         b7v3+ugCZTs1FQbtz2EYlhpWwYTeP3Tqw9vGdrLqA/PhAfutGrcIPgR2JxQtXvdsvgdX
         Cd0ctpyA2W+xji7tVwga3rs/gpVA/qooa4X8zeuH1N3QOmpV7HYg/nafovraYCe4QhXn
         xtRg==
X-Gm-Message-State: AOAM530WlcCVsg92pLO7iynoT+yRSlToTpP0g/ll4EsEe32Q+fVIbBpw
        k3y3dfp/tH4FnRFQr5pGKPtbdQ==
X-Google-Smtp-Source: ABdhPJxJWNVuFEOyhzUxVwAwBroFpnzb1jddWkZTC7DYPKbbNMEwIFS2gGCQs+6W/z4hcToI8QOqAw==
X-Received: by 2002:a62:b515:0:b0:438:42ab:2742 with SMTP id y21-20020a62b515000000b0043842ab2742mr3383918pfe.77.1631605199954;
        Tue, 14 Sep 2021 00:39:59 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.39.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:59 -0700 (PDT)
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
Subject: [PATCH v3 59/76] xfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:21 +0800
Message-Id: <20210914072938.6440-60-songmuchun@bytedance.com>
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
 fs/xfs/xfs_icache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index f2210d927481..0a4f32c0044c 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -77,7 +77,7 @@ xfs_inode_alloc(
 	 * XXX: If this didn't occur in transactions, we could drop GFP_NOFAIL
 	 * and return NULL here on ENOMEM.
 	 */
-	ip = kmem_cache_alloc(xfs_inode_zone, GFP_KERNEL | __GFP_NOFAIL);
+	ip = alloc_inode_sb(mp->m_super, xfs_inode_zone, GFP_KERNEL | __GFP_NOFAIL);
 
 	if (inode_init_always(mp->m_super, VFS_I(ip))) {
 		kmem_cache_free(xfs_inode_zone, ip);
-- 
2.11.0

