Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D6F4FAAA0
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Apr 2022 22:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiDIUJn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Apr 2022 16:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiDIUJn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Apr 2022 16:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884B7154499
        for <linux-nfs@vger.kernel.org>; Sat,  9 Apr 2022 13:07:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2318D60C35
        for <linux-nfs@vger.kernel.org>; Sat,  9 Apr 2022 20:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDF5C385A0;
        Sat,  9 Apr 2022 20:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649534853;
        bh=XDyu0lsurJEAhJLJoQZYLGFV2g+T+Pe+yv9mizVz8CE=;
        h=From:To:Cc:Subject:Date:From;
        b=cAzYzd381HzbY6BWVzNtISKpawAHG90kHUx3iGBREFq1Lg8MlV2el/8l2Xqu0Oz6F
         rmSCoHPl4N/4LDO8Sa//mKDI3ab4nY9Xs2f13cHSyOmxfHWXHxNAxy48ICV450HNdf
         Tz50LMb5QPGpLR4hPsfThJa64SshuKgw5AXemMhcSuwGuqhpwQvLtf622xTGAVS4Dg
         xKgplaRFE7Q0I65xj8lFLOZEGZnb22rAQm0ejWRUdgi5/cZ5M/RxtjE/mOtNaxR6CT
         OMzwAez5aFaPQouujGA6tQNcEiCYZyTSK1QUpuKQTfNGCS00XJm5G9PFo036z3VTzy
         iushapIT4jMZA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH 1/2] NFS: Do not report EINTR/ERESTARTSYS as mapping errors
Date:   Sat,  9 Apr 2022 16:01:07 -0400
Message-Id: <20220409200108.94208-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
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

If the attempt to flush data was interrupted due to a local signal, then
just requeue the writes back for I/O.

Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with generic one")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index e864ac836237..9d3ac6edc901 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1436,7 +1436,7 @@ static void nfs_async_write_error(struct list_head *head, int error)
 	while (!list_empty(head)) {
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
-		if (nfs_error_is_fatal(error))
+		if (nfs_error_is_fatal_on_server(error))
 			nfs_write_error(req, error);
 		else
 			nfs_redirty_request(req);
-- 
2.35.1

