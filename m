Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF9140A7AD
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbhINHhl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241071AbhINHhM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:37:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5BBC061788
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:35:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id n30so8643347pfq.5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NEq7kq9SMuUgC1IARLEvXImMtR13fBngVunARmKnk64=;
        b=jdEgYeufa0xbSpy6pjyVs9HuLGulGqxzZuIYgEqVO2w4wlElT/nX2QSJGpfUXrmti3
         ZB6EAatU3qFhGYvzY1BqWJIhxP7gTNlcabnbgUTn6I/EUwBBE6AjKZ/yeiZaSeVYJWQW
         PmXXJibSqLnbKfyKCxabpe3LV/Ya76OwPAy/zNF9K10LwjeBZr2jX+hRflJ+hSxXWVap
         DXrHNLKRe3vSam6AK1REtimYudoSqEYzpT5uA9+luOEN+y5aQFtwE7bw2GEKZn5MEAbg
         bA63vq1JfLcpxDtbwKD5httYxYPc6iH7S6Jkec/s2K2MA7AJNtDpBBmVvRqdaeyNZK8A
         ta0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEq7kq9SMuUgC1IARLEvXImMtR13fBngVunARmKnk64=;
        b=GHKbFo8iZMUjvHy3+KAmSlhqKtTH+7FOS7zsZO2kZg0Fh66vrjL2MS9NOC2n621G1S
         MsraMs+38xcYy0lHV2yMMrgfF+pJ6D5RnUyDLEBD/VYAyQhpKvNX7lR46vvIEd/y2z7v
         zCe9mmWI4CBX1UTRwKIkgvADwSPUdT0+9oUiC3Vsp04+5C1RuQXVEBkV85CjUgJ1nPPJ
         zl9NQjAr2S+y2cS7uKY80a0BtfprgkCsq9ascwv7PidAZ0YclC3/JaeecWo0+rkvGmVp
         QzWOI+KnTj9xTsQlVXZ3ZFXyIfRHnNdz/QOsYEWOXQKlWfChRIQAEs/qU8o/3ebquQpM
         YcRQ==
X-Gm-Message-State: AOAM530CfcM8nuw5kHFGwsjvnNHVVJA7amMjcrCmoc+yg5krzduVgQbm
        g3pgwDf+8319Ir9eMAa+WKFVPuneIokIMA==
X-Google-Smtp-Source: ABdhPJxOJCHtnx+WYbnA/IFmqdKOE7ty3oRk48gVLvlyEJf6F0MqheJB8RWJqz+q7QxmFlxo83mpug==
X-Received: by 2002:a63:7454:: with SMTP id e20mr14236260pgn.136.1631604905477;
        Tue, 14 Sep 2021 00:35:05 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.34.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:05 -0700 (PDT)
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
Subject: [PATCH v3 18/76] btrfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:40 +0800
Message-Id: <20210914072938.6440-19-songmuchun@bytedance.com>
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
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 487533c35ddb..f98fbe2ff212 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9072,7 +9072,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	struct btrfs_inode *ei;
 	struct inode *inode;
 
-	ei = kmem_cache_alloc(btrfs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, btrfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 
-- 
2.11.0

