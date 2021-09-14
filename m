Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AA840A83B
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbhINHoz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbhINHoX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:44:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB3EC0613F0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n18so7596049plp.7
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/aIacaGRl4jhBPpI0aSZA83SmaoB2Q+2BniQczTSm4Y=;
        b=z9V5WdfVIIrCNM2nU/e7FWwd3XXc5qagKbdfa4nAywZIklfQzr+kCWhq5Ml9/KP4fh
         44yNvJZ4EQi//ByTnyJI+UOx4onioXRoFiV+wyCmDpKNyY0ZvWLEbLG5nV163dD1pQ56
         GrJ2tBrS7pzzmwdMVGsxzh9d2plp37ASRhZeaWYg+PtkfQco44Xq6o5+cw5yvC6qT3Qh
         Ii2dFhezFcls6g6Y1qyyGWee//Al+TQ95MJ0Y/Gc7am0T2/tmsc3/w2jtnZlAllC2f4A
         zAdmWD23Y8/p14LNMGW82Ib+ndNV2pIPtpLA6OD9NWKvo8z9EcEsh8Tqm34DeVpRiU77
         aMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/aIacaGRl4jhBPpI0aSZA83SmaoB2Q+2BniQczTSm4Y=;
        b=Go0MVTdt/qqlyfVPsjlS9GwUexjN/B7WyhZxhr9fhBK01wDsr41pOtAcXSRGfwbFD7
         Vc2FiCfagYisMIN0/7D7CFMQo2r6EmaTB8uZ+afcX8fbAlSMmZa2txUE16/yTY/kxdL1
         fwOjlwodYyaK8pKmjQ9GPkjH6kwk6JTNe0iuMOIIfIpvNjVzDuAmF/nQsYopiqj8ZDe4
         W6LoPGnQOvB2JTMpvj1guZu4hFO7CG3ALSsG1yewvp6ZhbSlp4BwpfSMJoUm/fYqiFs7
         NNU3L2NQEQKsSFHSPt4oQRbf31bKjF6WQf8ZnBAfkI9GhmbUzKZhodjmXBYhkM/gzHsZ
         mcRw==
X-Gm-Message-State: AOAM533edbnXfy05NFqqWJidXiV0s4q/WaEbEQD45VK9as2o9cY63wjC
        DQSjciH1tuJqJlBHasAFDt1jSg==
X-Google-Smtp-Source: ABdhPJzrMAx9NpkE69qozFAUf/hOGRSECWuNnEuPGrBhS7rF0c3hmMSUBNoa1rH26YZI+VB2dRQ1Ww==
X-Received: by 2002:a17:902:dac6:b0:138:85a7:ef80 with SMTP id q6-20020a170902dac600b0013885a7ef80mr13798289plx.45.1631605209487;
        Tue, 14 Sep 2021 00:40:09 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:40:09 -0700 (PDT)
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
Subject: [PATCH v3 60/76] zonefs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:22 +0800
Message-Id: <20210914072938.6440-61-songmuchun@bytedance.com>
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
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index ddc346a9df9b..19bebbc2ccdf 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1137,7 +1137,7 @@ static struct inode *zonefs_alloc_inode(struct super_block *sb)
 {
 	struct zonefs_inode_info *zi;
 
-	zi = kmem_cache_alloc(zonefs_inode_cachep, GFP_KERNEL);
+	zi = alloc_inode_sb(sb, zonefs_inode_cachep, GFP_KERNEL);
 	if (!zi)
 		return NULL;
 
-- 
2.11.0

