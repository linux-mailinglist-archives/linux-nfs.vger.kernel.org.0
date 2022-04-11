Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E0D4FC6E1
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Apr 2022 23:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350070AbiDKVm4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Apr 2022 17:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350226AbiDKVmz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Apr 2022 17:42:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60563338AB
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 14:40:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D958B818C8
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 21:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5793DC385A5;
        Mon, 11 Apr 2022 21:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649713237;
        bh=PILKzRTE62PeTeUucmUsBc8qA03ZD1GzTYPrd7eYXrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uf5lrpvd3qqafA+rPcR0G1R9A9A5ojV95TAMkwGayhfpeRXeZ3XeFn4mKAe9bJql0
         0/LQVAbPPDdIPF3kT4bje013Tyrv+/4NXOXC+c4SVfUq/M2EAFxdYZQOdt6kVcWHth
         JtIXNL+cEFwhHzvKykiQTCFI1dCo2FktfpHiO5eVrD38FsW9TPMaMdcE/O6u/KPfpH
         xGOdus9E/gm9DXRcJ4TS0cWH9Fb7HgrnyNlDLvLn7jjRhzi8XcdlCI2HZb38n3Wbz8
         +tF4Lu93kNlxloopGOMC9Ar+8nDFrNFEl9x7GdtSC8Ojaqp9voqSWYv36lQUYDqllR
         hzggL2zaFPVVQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH v2 5/5] NFS: Don't report errors from nfs_pageio_complete() more than once
Date:   Mon, 11 Apr 2022 17:33:46 -0400
Message-Id: <20220411213346.762302-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411213346.762302-5-trondmy@kernel.org>
References: <20220411213346.762302-1-trondmy@kernel.org>
 <20220411213346.762302-2-trondmy@kernel.org>
 <20220411213346.762302-3-trondmy@kernel.org>
 <20220411213346.762302-4-trondmy@kernel.org>
 <20220411213346.762302-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 9d3ac6edc901..0fe101e4e3db 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -677,11 +677,7 @@ static int nfs_writepage_locked(struct page *page,
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
@@ -739,9 +735,6 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 
 	if (err < 0)
 		goto out_err;
-	err = pgio.pg_error;
-	if (nfs_error_is_fatal(err))
-		goto out_err;
 	return 0;
 out_err:
 	return err;
-- 
2.35.1

