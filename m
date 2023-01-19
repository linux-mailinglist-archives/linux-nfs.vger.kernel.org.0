Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF6674BD1
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jan 2023 06:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjATFKr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Jan 2023 00:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjATFJm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Jan 2023 00:09:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EB6AD02
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 20:57:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C6C5B82745
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D93C433F0;
        Thu, 19 Jan 2023 21:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164417;
        bh=DQlO/1BB5dJCEHvIRqz0h/0FLGl9QaRIdYVSKIm5FDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjqnzWvAgvYzmw3Jf81e8dkGus6p2KGF+npoFrIug1Ier3FB5+BpBmfPtjvk5QTnz
         yFzaPqx5hEa5sZwIsBSrwIYA7M6DgOyqeowyQ1xiZatHIKiDtAIMMcyn4IYh/mOyZO
         LYuvu3X7S5cNtT4nrpqx8vlp/MFcHB6l5bAiDmwE15pqT6jw35BxpdiX5xh1ozp2SD
         06+lgAS0DQq4eRITJDCDLnH17IF0wTWdODFrvHdqB3b1nw6r538pJJqskvDVMD65+a
         UmDZQmUzF35wgduszxOhzosmFPgpedpgbzzO7SWsvL7vGCiy5cdjsPOyDyBou3X3zq
         a36xaSfwvBibw==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 01/18] NFS: Fix for xfstests generic/208
Date:   Thu, 19 Jan 2023 16:33:34 -0500
Message-Id: <20230119213351.443388-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119213351.443388-1-trondmy@kernel.org>
References: <20230119213351.443388-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the same page and data is being used for multiple requests,
then ignore that when the request indicates we're reading from the start
of the page.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 16be6dae524f..369e4553399a 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -920,6 +920,9 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *desc,
 		req = nfs_list_entry(head->next);
 		nfs_list_move_request(req, &hdr->pages);
 
+		if (req->wb_pgbase == 0)
+			last_page = NULL;
+
 		if (!last_page || last_page != req->wb_page) {
 			pageused++;
 			if (pageused > pagecount)
-- 
2.39.0

