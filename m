Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAF15882F4
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Aug 2022 22:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiHBUIz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Aug 2022 16:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiHBUIy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Aug 2022 16:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8DE52455
        for <linux-nfs@vger.kernel.org>; Tue,  2 Aug 2022 13:08:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AB7660C09
        for <linux-nfs@vger.kernel.org>; Tue,  2 Aug 2022 20:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F6AC433C1
        for <linux-nfs@vger.kernel.org>; Tue,  2 Aug 2022 20:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659470933;
        bh=5NZeClx66lRhjbDzzIfLH6xR3fUOsG4zg6SLjZGjMcE=;
        h=From:To:Subject:Date:From;
        b=P3WHEo0QLMIRcm00vo7Erary8bzPPr6EC1gFIur7+wPN+L+ZLQeZDAnEDiyUjnRFb
         tgg2hI/MEOZGrYFMNZc7mIhzYAvqV3BI0f0Kp1Ob4rNbMgJbxaXcofWrnR+O4+ObII
         QR1zvkqMCFGG8deS4kd86+nHJ71FuphnMIQKSj4LEZCkMO55xKRwb8Gh4QVG2WuIPV
         SRLkcUvGX2fxuZTPG2em83mOn+3+xN3AIMp4Assvc5KXvBcJF9N/6X159ulzIWBLLu
         QzomL0IPhwsrurJ2oKmFzy0OlY27TCWwSoMjqOPvOiBJEsK0ckgwrM0ga2DGFesUdz
         zn+BGF5+q/n7g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: nfs_async_write_reschedule_io must not recurse into the writeback code
Date:   Tue,  2 Aug 2022 16:04:44 -0400
Message-Id: <20220802200444.381597-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

It is not safe to call filemap_fdatawrite_range() from
nfs_async_write_reschedule_io(), since we're often calling from a page
reclaim context. Just let fsync() redrive the writeback for us.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 16d166bc4099..4adf2b488da1 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1444,8 +1444,6 @@ static void nfs_async_write_error(struct list_head *head, int error)
 static void nfs_async_write_reschedule_io(struct nfs_pgio_header *hdr)
 {
 	nfs_async_write_error(&hdr->pages, 0);
-	filemap_fdatawrite_range(hdr->inode->i_mapping, hdr->args.offset,
-			hdr->args.offset + hdr->args.count - 1);
 }
 
 static const struct nfs_pgio_completion_ops nfs_async_write_completion_ops = {
-- 
2.37.1

