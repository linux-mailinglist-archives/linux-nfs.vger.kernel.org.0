Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D39A40A7C4
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbhINHiX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241508AbhINHh4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:37:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF03C0617A8
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:35:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so8233284pjv.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1yuy+HZCggD2Ix0ajnpDnDAqsy20DBm7xFEbRuBADBk=;
        b=a6sOSaXIPiqPpssIICXEj+A9I0pXX8WW+n0AIX6Qer+S9FzZnNc9/lAKHNJIbqfd98
         te5EgnNysJZ/Gr6Tl5XFrvMeKYuVVkXPgxcD7EXX/ZtO9AacuwK6B3gaY7QjTRoBLup3
         kwIW63M3ksbtxYT1MvuDNjMjSgPzg8tvmhyN1KG7nGpYatsmj+g1dYMFdWG82EMn72vn
         pqDbRVLzkzkXknyq3PP5/ajZ0ZIJ1NX4vV/xHPZdUSrDtQ1vSWWjL8oNX/vDZp/V+sLU
         mditTKgDXUyj39galecQGgd99rKihY8WLCH9Cj4wGtEc8H8d2b1RmTQ80YDr7kfpKZk4
         NPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1yuy+HZCggD2Ix0ajnpDnDAqsy20DBm7xFEbRuBADBk=;
        b=2rfZsi/wOUZ4Ybv1KQNcLSZ0UrmZaO1MESxnFXJ0mmxmNJJo8V1x/qdgNwbWR+lccI
         OqjPftn0vTlEvJ4WOLZUgcSDGoF1AZT60vl3Z6ixHUnORDVIZjbOGhiDQ6HcqG45+BXL
         lkbcFfu0U3yID5LI34x/s4GQmg3aHZHMziUKgdwlM76ExUfMrI2LAfNZHmSYyD93SXfb
         NL3uPDSdK+cmbrcpput1a5IpNHm+vmkVCR5qGzJkYOcruGMjwh4Q2291i/C/dgli09hg
         sxTDfJmG1i75dF2xeMtpRoFY292Jzo9gljzygvQyHD9j00tYbcp7K0x7cpOqASVSOETq
         Lxaw==
X-Gm-Message-State: AOAM533YzEHle/xVbieSSShEcEZe9+gxOSZSD1xzadEVym8wu+YQl4hW
        XbC7tn4xOu1TPYlM0gWOi5cBsQ==
X-Google-Smtp-Source: ABdhPJws7JltmeMv6QYknpPOWEOB65IqgYWjDjVwL8ZJqUCVuwi0tAesPsTpFFDsYdx1IaTXzoHG9Q==
X-Received: by 2002:a17:90b:4c8a:: with SMTP id my10mr538516pjb.220.1631604940104;
        Tue, 14 Sep 2021 00:35:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.35.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:39 -0700 (PDT)
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
Subject: [PATCH v3 23/76] efs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:45 +0800
Message-Id: <20210914072938.6440-24-songmuchun@bytedance.com>
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
 fs/efs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/efs/super.c b/fs/efs/super.c
index 62b155b9366b..b287f47c165b 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -69,7 +69,7 @@ static struct kmem_cache * efs_inode_cachep;
 static struct inode *efs_alloc_inode(struct super_block *sb)
 {
 	struct efs_inode_info *ei;
-	ei = kmem_cache_alloc(efs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, efs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
-- 
2.11.0

