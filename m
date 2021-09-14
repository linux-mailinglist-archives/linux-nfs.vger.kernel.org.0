Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49CF40A84A
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhINHpG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237950AbhINHoo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:44:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F3CC0613BF
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id n30so8656446pfq.5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzMpd2icHKDgVZh/IHRZAX4AuKL56PFsFqQ9a9tRdLM=;
        b=CU4bfhcQLvN5AHq3ebwvRClEL0E5KxzWHts0ZIvKkNBaQrTiIrNNOlVntjRB7muYwm
         Z3uL7AgyvuoShFx68rOd+Pj1uG/EiAeLfh6d4LbnixdAr//2M3cRXNvGvH3OL4tUWFnN
         m0n46F6LAsYd675kx2lQFhuECvqIW1otJNRsfkPcYDaXCcvNKHyQ88x5Xmu9UjHrW+CN
         5hxVUEg7E7+iQjjOrrmPpNtjPY/+Hg3vutmVZOMLFT39MwSP+TwZd24vYzo9+OIXHH1w
         KsbDFFT7SQVaHX08av/hPnnHGdB2RJJPysf/Pqf/CUAUx/F6q8XP0ft5TlIn3sB/HsDN
         kmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzMpd2icHKDgVZh/IHRZAX4AuKL56PFsFqQ9a9tRdLM=;
        b=yaFTqXlNy8aIV/WStmWYq5onE7R7saO76yjAPO5jnLTDjfUw95U5oPI0hBfvDvesBC
         1ZX+aabRQrLQUD7khQqpKHamzx0drCqrIMpBMNejjXoIGmFluSb9VnigLPyJ8ABRPByc
         UFMt/sMB6Hl+JSsuy6y1LqZ+cd+IusEjJ0+f2At174M25qTPlrjMAst1WK1qUhasUTPg
         18M7QxZNMQ0N+eFvuliMsG33KS7U/Y59sAbFHnAwwKFdkaN4d4C19SzhB81W+URARVkC
         RXdgujehZJH5HE3x8YPY0GqFmW7GdNoNrjo364fiO/xZWlJN3HZiDBHaaADet1V5x9BB
         rPPg==
X-Gm-Message-State: AOAM532dL6+HB+oP05UKFCnwD68Ey9ne9u/4cVWt8vx0no/Fhx+et8p7
        qxSwqvIpc7Un+xspgU6dSemq3A==
X-Google-Smtp-Source: ABdhPJyMNoiU0Jst3lZMbRSWOcK0XGszzmqSKadnFf8sWdj6xUiFiP28gaSKoLEjwgjodGoOC0DppA==
X-Received: by 2002:a62:64d3:0:b0:43d:ba3:1e2c with SMTP id y202-20020a6264d3000000b0043d0ba31e2cmr3457416pfb.5.1631605230405;
        Tue, 14 Sep 2021 00:40:30 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:40:30 -0700 (PDT)
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
Subject: [PATCH v3 63/76] net: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:25 +0800
Message-Id: <20210914072938.6440-64-songmuchun@bytedance.com>
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
 net/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index 7f64a6eccf63..cee567ccd99c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -300,7 +300,7 @@ static struct inode *sock_alloc_inode(struct super_block *sb)
 {
 	struct socket_alloc *ei;
 
-	ei = kmem_cache_alloc(sock_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, sock_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	init_waitqueue_head(&ei->socket.wq.wait);
-- 
2.11.0

