Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E68527205
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiENOdR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiENOdQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:33:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7FC1C134
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAA49B808BC
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31860C34115;
        Sat, 14 May 2022 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652538791;
        bh=sWSQWQV6+C6Wk5/V/IJldIJ/fI3yA92GS7TVuJK9QJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wclx6NRkeywopOtiNTWr1ydnkjKoh/r5ZVZEd5DucY8bvpwHjln7JTgYSWGISPEO1
         HM0nJv0K6dJSTMwj6ELl7I7FVwgmkpa7NX0V9wmuisegFTgF5TfTXlv9R6BPpkzWdq
         iQISpJPmATFiG175+4uAqK91dcPO9kyDO25JVsiNPSGLWYE16LItYP1jrPyI9yyZ6X
         Cq2BcV4/xW3LEG5ITEBmwv8PAYyLebmMdxZu6Qsj0Uqi3nFfcwkeh04qObtj6V0gT8
         Ll3oIF7yBOU5l4oWS3lLgB0IO8hFVBtnIzTHZdqLfq/1QYhN38HYyTg5U5IrzGCBcH
         hUGlXnc8x8xRw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/5] NFS: Do not report EINTR/ERESTARTSYS as mapping errors
Date:   Sat, 14 May 2022 10:27:00 -0400
Message-Id: <20220514142704.4149-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514142704.4149-1-trondmy@kernel.org>
References: <20220514142704.4149-1-trondmy@kernel.org>
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

If the attempt to flush data was interrupted due to a local signal, then
just requeue the writes back for I/O.

Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with generic one")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index a8eb348947a6..ce4cc4222422 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1441,7 +1441,7 @@ static void nfs_async_write_error(struct list_head *head, int error)
 	while (!list_empty(head)) {
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
-		if (nfs_error_is_fatal(error))
+		if (nfs_error_is_fatal_on_server(error))
 			nfs_write_error(req, error);
 		else
 			nfs_redirty_request(req);
-- 
2.36.1

