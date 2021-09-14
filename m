Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BC540A819
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhINHnF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhINHm3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:42:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03E5C0619F6
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:38:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso2061233pjq.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lHAYrFVB3RupwivCJS+aERvoyQvRbyNrf4+TX1u/TIc=;
        b=dLa8zy+WFMum3slpu1hEamUL6WRBtZ2Mf8Xczm6b6ik9Lbn2bq+2CyXLI11zGlHD/b
         T0eOAqG8HIOqkPOPCdnATP8WQgVa/Tqanrkrt0b9DYB3Be859skSNP3LAKqljBYfz3or
         unMHOSaKJQ1tzFBGL6w0IBMawqgu/Ozsm/roPZrZ/ynSGGv1f/MHA95SBzKacryL1F9r
         80lU8GdHzLN/yd2Yg1725qYCBtSRW7XkzlU3NMkSBEDB6SfljOHTDMpXH2KlRACjciBf
         9Lw3cXONutEJawugdkQHx9FJbf7Jp6JjBD5e5FxmdqbH8KYbaWUhzDyFji+ZZqCxCTpw
         8+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHAYrFVB3RupwivCJS+aERvoyQvRbyNrf4+TX1u/TIc=;
        b=DZmpCMpwKLwAdWoCInP2OiHXVu/cvJBc0EGZy/AKwC+bJlM79oCoREfQqUv2t3wrhU
         pUHlgXdOQSAdeV8mwagMvP/d9ec1DcdBbb6/KV16VsqzXHFgqdu7RPUtEQaLXFDL4BUD
         VaGXPZlky6L8grRu3f25EVXV61bLKkKADiAzJkWU8lKstjNRKAcTL2MteFzuAPwe+Zur
         jQ3BWCEN8Ij8PxCIE4AnO3/XRm9mACyF2i/ECN+McDXpa2yKhZt6y+/NljMBhL+i6ijq
         QVbabvU1SVeJd/Y65RGEW6rO1FWuX+/z2k6brYrFd8iMfynByU3vupisTm8ktru/xNW7
         O/IA==
X-Gm-Message-State: AOAM532rh34PaM4OvLwf5Fjt1BYk8nHnoDERsuAS86w9970nwKrzXqOa
        kK6L3WLEjGl4ZiHINLmgu8BcPg==
X-Google-Smtp-Source: ABdhPJyZ1gNoJwBwjSapufsGc0K+8Vsg5NtnDUWiyf6tHPBRFeHWboDHp+Gdig8QAOL5Yo1gLndiSQ==
X-Received: by 2002:a17:90b:250e:: with SMTP id ns14mr582898pjb.84.1631605132200;
        Tue, 14 Sep 2021 00:38:52 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:38:51 -0700 (PDT)
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
Subject: [PATCH v3 49/76] qnx4: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:11 +0800
Message-Id: <20210914072938.6440-50-songmuchun@bytedance.com>
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
 fs/qnx4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 3fb7fc819b4f..a635bb6615e9 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -338,7 +338,7 @@ static struct kmem_cache *qnx4_inode_cachep;
 static struct inode *qnx4_alloc_inode(struct super_block *sb)
 {
 	struct qnx4_inode_info *ei;
-	ei = kmem_cache_alloc(qnx4_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, qnx4_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
-- 
2.11.0

