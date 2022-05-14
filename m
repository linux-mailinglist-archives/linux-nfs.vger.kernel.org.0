Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53268527209
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiENOdT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiENOdQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:33:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE371CFCB
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17EEFB80907
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712D2C34115;
        Sat, 14 May 2022 14:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652538793;
        bh=2uypRLy68/oN/fKavebGwOtAoHFFpgu9SH9UJYQ3NR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Njjq1zSbS3PwpRFT1MNAHT90BB7ps+4HLakzK1dF1hefyb9YE9FH6PgyQHe6XjqwX
         /TsdoZSBrfzgHZm5kLFF9DkJS7frP4Al6Rh1z3n0bwsxtNB44OwkKxhqQ399cU4ySp
         yFASVeeN/tSeB4ukCe6hF8/mPDPXAjqNS/YUQ47lb7aouzuXifgBLrxHj5qqId5PF4
         gjDV3ZPpjG1rT5xRxHax1+bmEO+Dn4Fbnr98GlTkTRpYICe/SLOdjyqhh2HPTJ7BSu
         BYrrGjtbRcAJ0efOKSZdKJrpmv3ulHF9uMu9S+p8MBWWqdKj6mkoLJ9jh/HOWphztz
         e8jRoR9ugiIbQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 5/5] NFS: Don't report errors from nfs_pageio_complete() more than once
Date:   Sat, 14 May 2022 10:27:04 -0400
Message-Id: <20220514142704.4149-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514142704.4149-5-trondmy@kernel.org>
References: <20220514142704.4149-1-trondmy@kernel.org>
 <20220514142704.4149-2-trondmy@kernel.org>
 <20220514142704.4149-3-trondmy@kernel.org>
 <20220514142704.4149-4-trondmy@kernel.org>
 <20220514142704.4149-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Since errors from nfs_pageio_complete() are already being reported
through nfs_async_write_error(), we should not be returning them to the
callers of do_writepages() as well. They will end up being reported
through the generic mechanism instead.

Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with generic one")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index ce4cc4222422..2f41659e232e 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -675,11 +675,7 @@ static int nfs_writepage_locked(struct page *page,
 	err = nfs_do_writepage(page, wbc, &pgio);
 	pgio.pg_error = 0;
 	nfs_pageio_complete(&pgio);
-	if (err < 0)
-		return err;
-	if (nfs_error_is_fatal(pgio.pg_error))
-		return pgio.pg_error;
-	return 0;
+	return err;
 }
 
 int nfs_writepage(struct page *page, struct writeback_control *wbc)
@@ -744,9 +740,6 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 
 	if (err < 0)
 		goto out_err;
-	err = pgio.pg_error;
-	if (nfs_error_is_fatal(err))
-		goto out_err;
 	return 0;
 out_err:
 	return err;
-- 
2.36.1

