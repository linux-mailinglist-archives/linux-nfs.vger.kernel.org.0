Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38DD592115
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Aug 2022 17:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbiHNPdj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Aug 2022 11:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbiHNPcz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Aug 2022 11:32:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520AF1C126
        for <linux-nfs@vger.kernel.org>; Sun, 14 Aug 2022 08:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F5260C92
        for <linux-nfs@vger.kernel.org>; Sun, 14 Aug 2022 15:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB86FC433D7
        for <linux-nfs@vger.kernel.org>; Sun, 14 Aug 2022 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660491004;
        bh=2ZyMXhcyuCglRjPOIv9tqvYcIlF8WL9ZOUD2U3JeOLc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HGQXgtvARELXhfwJxag3nslqZeNX73J5cOUBNPtSKiyhpdOpTf7s7XAqwaJ22Gm6B
         qW5lyiA188LJIQGJXb37yqcZR48ve6c1V/vSxTOs5oOg/v1XkzNe2ppw5AReGT96Lk
         VTYVuxFMqGOOlmpSpvMdgABlQ2NLc3kC4Cu5u6sUCTOAch0LvynV6PxuHfpoWgv1Xy
         xlqFe9DxSdai1i90uTLvyPgwSiUovvCFKHU71EopEf7PVs6EAqyedJJr5YY6phV8+S
         z2wEfEh9kNlHSPiYVbUOzsiSZsb/KG8Nr6dQqa7eLbe5KAVp4siijRednMfaUPMQXW
         rKyzX0kp/MJJw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: Remove a bogus flag setting in pnfs_write_done_resend_to_mds
Date:   Sun, 14 Aug 2022 11:23:16 -0400
Message-Id: <20220814152317.30985-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220814152317.30985-1-trondmy@kernel.org>
References: <20220814152317.30985-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Since pnfs_write_done_resend_to_mds() does not actually call
end_page_writeback() on the pages that are being redirected to the
metadata server, callers of fsync() do not see the I/O as complete until
the writeback to the MDS finishes. We therefore do not need to set
NFS_CONTEXT_RESEND_WRITES, since there is nothing to redrive.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 41a9b6b58fb9..2613b7e36eb9 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2817,7 +2817,6 @@ int pnfs_write_done_resend_to_mds(struct nfs_pgio_header *hdr)
 	/* Resend all requests through the MDS */
 	nfs_pageio_init_write(&pgio, hdr->inode, FLUSH_STABLE, true,
 			      hdr->completion_ops);
-	set_bit(NFS_CONTEXT_RESEND_WRITES, &hdr->args.context->flags);
 	return nfs_pageio_resend(&pgio, hdr);
 }
 EXPORT_SYMBOL_GPL(pnfs_write_done_resend_to_mds);
-- 
2.37.1

