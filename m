Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0BC40A7E3
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbhINHj7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241723AbhINHjT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:39:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64945C0613AA
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:36:41 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oc9so8235575pjb.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vhKSYO+w5+4UqN2xprDDrSRBUlSs7Rk18R8p/1ECvE=;
        b=PVmqXYProQrcarodCcC4uggaknivjAPZiqZ6CuwNwesKmZMr9vBBg8yL9oIo6lcW97
         HVjprM/kYvwD+OUEGw2/BuVl1KywqBrEUtLgMCy26VGtzMOHgN4hPNCRl2i98AUnV8pm
         sNN6qYjhFVWO+KD4E7M3V8Infq2cPZjyXQl2Rf4poYTBSp7BIj6i3Ge1qgdpIb5G5inS
         E3Dks7TcvHY1+Wh16+c4m9H1dsXomllFPzajPoUQMJNpjGLT/Q1Bq740Sqvu43ltveth
         6lwek+7KgpEoFymETX3BjWvPUiHZ4SEYNb0g0pTHotd6nG+R08tGFZ6vTkUDAt++QB+x
         y7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vhKSYO+w5+4UqN2xprDDrSRBUlSs7Rk18R8p/1ECvE=;
        b=JHex5vyGcnBYYTSrN0OQTEQXO0mYPNfAQTpw/mdQGvLEpbB7nQbajpYZ8ce9/dSBju
         NBRgeZkVwrs8x+jFe8dp0wFo4CexWfYO4m7Rlpz/RqsUdRvxQw768SIoRCTdIEc1caG4
         U4T+P835mmCe+1R2yv9q/PU8qVv3F9GMEdyLmFbxjC2EXotffPyvUsaeXmZTla27bZhy
         /BQ5FJJFMk+f/ti3T2EIC3SabynqprOQcXmabUmbD1TpMEGnnlIcpn1zdL4VQbBxVl3B
         ZFeEslKLCummlTnWuqKaVtcOcp82RwSkEH5uAZA4msfqzIQdMCcM2A8ig0x0cOXJQk9R
         HinA==
X-Gm-Message-State: AOAM5322ceGlNAr+KpQSKzCL2PW2zi5ctzjtf9S88w++WXe7SGCPRaNY
        1AhYbyYDbkxSGNW5YA/0t+yeMA==
X-Google-Smtp-Source: ABdhPJxZRW9q9YfVoKHGbbYCVmcBarXPBCCzFRBWTZUPztDMhMBmHBtSYhMDCAEx/F313PGE17/HoQ==
X-Received: by 2002:a17:903:2c2:b029:101:9c88:d928 with SMTP id s2-20020a17090302c2b02901019c88d928mr13898475plk.62.1631605000969;
        Tue, 14 Sep 2021 00:36:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.36.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:36:40 -0700 (PDT)
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
Subject: [PATCH v3 31/76] gfs2: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:53 +0800
Message-Id: <20210914072938.6440-32-songmuchun@bytedance.com>
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
 fs/gfs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 6e00d15ef0a8..2778d4349b66 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1427,7 +1427,7 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
 {
 	struct gfs2_inode *ip;
 
-	ip = kmem_cache_alloc(gfs2_inode_cachep, GFP_KERNEL);
+	ip = alloc_inode_sb(sb, gfs2_inode_cachep, GFP_KERNEL);
 	if (!ip)
 		return NULL;
 	ip->i_flags = 0;
-- 
2.11.0

