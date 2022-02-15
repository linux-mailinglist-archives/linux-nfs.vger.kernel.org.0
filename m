Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09B64B7B0C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Feb 2022 00:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbiBOXL5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 18:11:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiBOXL5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 18:11:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F1413CE8
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 15:11:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F381861507
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 23:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3355AC340EB
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 23:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644966705;
        bh=JgCJYNhJMwTHRIJVMHEOfQtH3nNGTQ66/9NWsyN7KGE=;
        h=From:To:Subject:Date:From;
        b=Il1xzKd8uyfyFLmoaoYQZTF/e18MfN4J+F+Y5V0gb+9agf16+Vi2hU/cxOQOqYqWw
         ogqZYxpZpaRY/eGawBCH1JEEBnmLzsWoRTayNAA5jZhhu9IRa0z+kTJPHP38BTA8rO
         dgGdgZf0l1qaeXX672FqWipl0klrr91iorpnHwqnA51X0e91p8yKKttK2p2e3i7ehv
         zw+TC2Hpbmu+5FYjEHU62/n4KwjMMG/m/b+BUDl+8UTXg5TDtMeAuVShbgSlmavVTw
         oCiLsrnDBAOuPBwhdpI636gELoKDr784zf//mh7LD55YWVkoKIR3zt7+vaeWwBuzkJ
         IdVn6cA7vl7qQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Use of mapping_set_error() results in spurious errors
Date:   Tue, 15 Feb 2022 18:05:17 -0500
Message-Id: <20220215230518.24923-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
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

The use of mapping_set_error() in conjunction with calls to
filemap_check_errors() is problematic because every error gets reported
as either an EIO or an ENOSPC by filemap_check_errors() in functions
such as filemap_write_and_wait() or filemap_write_and_wait_range().
In almost all cases, we prefer to use the more nuanced wb errors.

Fixes: b8946d7bfb94 ("NFS: Revalidate the file mapping on all fatal writeback errors")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f88b0eb9b18e..74d258781205 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -316,7 +316,10 @@ static void nfs_mapping_set_error(struct page *page, int error)
 	struct address_space *mapping = page_file_mapping(page);
 
 	SetPageError(page);
-	mapping_set_error(mapping, error);
+	filemap_set_wb_err(mapping, error);
+	if (mapping->host)
+		errseq_set(&mapping->host->i_sb->s_wb_err,
+			   error == -ENOSPC ? -ENOSPC : -EIO);
 	nfs_set_pageerror(mapping);
 }
 
-- 
2.35.1

