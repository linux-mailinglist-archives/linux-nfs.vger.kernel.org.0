Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D29485454
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 15:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbiAEOYu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 09:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240664AbiAEOYu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jan 2022 09:24:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D00C061761;
        Wed,  5 Jan 2022 06:24:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 155006172B;
        Wed,  5 Jan 2022 14:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1621AC36AED;
        Wed,  5 Jan 2022 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641392688;
        bh=zbohierx/v2+fnHVBIipG8jrrQNNf42+E6VUmMwoVQw=;
        h=From:To:Cc:Subject:Date:From;
        b=Eorxsjoc6mpI84PryKmvWiTC1qRSmx12PPhlxCdwfUEdXXDp4JMiutRoRPptbFX5f
         iRhX8F1df+MFUtOFn7z8okR+t5Kce7CndOyLB0RgaPlfxaUGIkMNvYUPvXqVJpTSuO
         8om5iSzUt3gDC19kHRGAH+JeKYSHSJqnTZwZEUhVQHXhmODrWm2Je5vpxv/Cx2VrEo
         0HmocZPHi3qvNt13/MkYucaYMpA0hylQdmAkoSbP6R8/W9jtI1YNuhzFNEOLgCS03w
         c/JZD6JBWWo/O0RuiNXNEY+YOfUWiwj6OONnfoOu+jzakx16OQPmLlMzuoarNSqpUA
         dnHSKyHe45/4Q==
From:   trondmy@kernel.org
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH] RDMA: null pointer in __ib_umem_release causes kernel panic
Date:   Wed,  5 Jan 2022 09:18:41 -0500
Message-Id: <20220105141841.411197-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When doing RPC/RDMA, we're seeing a kernel panic when __ib_umem_release()
iterates over the scatter gather list and hits NULL pages.

It turns out that commit 79fbd3e1241c ended up changing the iteration
from being over only the mapped entries to being over the original list
size.

Fixes: 79fbd3e1241c ("RDMA: Use the sg_table directly and remove the opencoded version from umem")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 drivers/infiniband/core/umem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 86d479772fbc..59304bae13ca 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -55,7 +55,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
 		ib_dma_unmap_sgtable_attrs(dev, &umem->sgt_append.sgt,
 					   DMA_BIDIRECTIONAL, 0);
 
-	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i)
+	for_each_sgtable_dma_sg(&umem->sgt_append.sgt, sg, i)
 		unpin_user_page_range_dirty_lock(sg_page(sg),
 			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
 
-- 
2.33.1

