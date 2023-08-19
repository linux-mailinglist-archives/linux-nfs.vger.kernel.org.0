Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00E6781B6A
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Aug 2023 02:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjHTAJ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Aug 2023 20:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjHTAJo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Aug 2023 20:09:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4191B4A00EA
        for <linux-nfs@vger.kernel.org>; Sat, 19 Aug 2023 12:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D022F60B3F
        for <linux-nfs@vger.kernel.org>; Sat, 19 Aug 2023 19:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59F7C433C8;
        Sat, 19 Aug 2023 19:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692474161;
        bh=7zGditNX7Nj9VUZRBIyNKnaE8BS/nTNg6AKoFQEbADc=;
        h=From:To:Cc:Subject:Date:From;
        b=Pi4iM0zE/vwvHVg7/7UjK8SmCDBn/DuyeUN1AX84aYDDOas+HeFgrXTmnTJyvU6Es
         BB42pXXVll4eu3ET5AtUpWJ7746KGcIeChDSeQu2sezK7xMYrevjxSAMnnQnMbXUdA
         2eXpzsJHYRFY0c62PtlfJBt/ImikeVPpY7zjJCLV6DK81CDelAL93iqLzsevqTk8VL
         7yahQvauaKjI/Lass9tmt6FiESUOJ6/b+8GfYi1IU+9hzgZNhfzWsADsjwMJpamCol
         Ul2nxZA+47emCt01Ozb7IPPcAL+zYRjnaFX2TP7WruFnuwmMFinUhAGHrhBJKE1OLz
         EmqpyWX1Axl7w==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFS: Fix a potential data corruption
Date:   Sat, 19 Aug 2023 15:36:14 -0400
Message-ID: <20230819193614.704107-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
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

We must ensure that the subrequests are joined back into the head before
we can retransmit a request. If the head was not on the commit lists,
because the server wrote it synchronously, we still need to add it back
to the retransmission list.
Add a call that mirrors the effect of nfs_cancel_remove_inode() for
O_DIRECT.

Fixes: ed5d588fe47f ("NFS: Try to join page groups before an O_DIRECT retransmission")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
v2 - when adding the header back, we need to bump the refcount twice

 fs/nfs/direct.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index aaffaaa336cc..47d892a1d363 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -472,13 +472,31 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	return result;
 }
 
+static void nfs_direct_add_page_head(struct list_head *list,
+				     struct nfs_page *req)
+{
+	struct nfs_page *head = req->wb_head;
+
+	if (!list_empty(&head->wb_list) || !nfs_lock_request(head))
+		return;
+	if (!list_empty(&head->wb_list)) {
+		nfs_unlock_request(head);
+		return;
+	}
+	list_add(&head->wb_list, list);
+	kref_get(&head->wb_kref);
+	kref_get(&head->wb_kref);
+}
+
 static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 {
 	struct nfs_page *req, *subreq;
 
 	list_for_each_entry(req, list, wb_list) {
-		if (req->wb_head != req)
+		if (req->wb_head != req) {
+			nfs_direct_add_page_head(&req->wb_list, req);
 			continue;
+		}
 		subreq = req->wb_this_page;
 		if (subreq == req)
 			continue;
-- 
2.41.0

