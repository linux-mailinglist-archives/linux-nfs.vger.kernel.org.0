Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D0791BB7
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 18:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjIDQle (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Sep 2023 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbjIDQld (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Sep 2023 12:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ECC1B7
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 09:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89327616F6
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 16:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA72C433C9;
        Mon,  4 Sep 2023 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693845689;
        bh=dVm3cA6S4iZBPGlrLFzon4H1c/bWA6gMkAgxXB18xLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WnFESd7nOCvdfqB3AY90PHFlTmYXzBjHdRYAxbe6Y1AlXNuEmA8E+cDbllYaKaLwG
         eJze7VesheXOKSW0No/ED/M9A18q/of62OXeqjSTVtj7LYOpM7oQvW9R1IJjKFCwSY
         zEuHhJPIFRycjwaTmScx1GnNu3phq2OHfoG0/6X+L63fvClfaPpxFlNXpEnsfGtrAE
         SpR1RywVQR23RA74YK9X2/F6qZPZ7gE1S/VotCRLOxp8TG9+isAlWbb6QBlvhY7/1s
         q6YRAX1tiYpzpW09BJehxGV4HBzDfSg34Pq7FB60USHb0LIjkcHZmRShsrBQVJ8yru
         HSUGhK++x7DYA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/5] NFS: Fix O_DIRECT locking issues
Date:   Mon,  4 Sep 2023 12:34:38 -0400
Message-ID: <20230904163441.11950-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904163441.11950-2-trondmy@kernel.org>
References: <20230904163441.11950-1-trondmy@kernel.org>
 <20230904163441.11950-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The dreq fields are protected by the dreq->lock.

Fixes: 0703dc52ef0b ("NFS: Fix error handling for O_DIRECT write scheduling")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index ee88f0a6e7b8..e8a1645857dd 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -553,7 +553,7 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 		/* Bump the transmission count */
 		req->wb_nio++;
 		if (!nfs_pageio_add_request(&desc, req)) {
-			spin_lock(&cinfo.inode->i_lock);
+			spin_lock(&dreq->lock);
 			if (dreq->error < 0) {
 				desc.pg_error = dreq->error;
 			} else if (desc.pg_error != -EAGAIN) {
@@ -563,7 +563,7 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 				dreq->error = desc.pg_error;
 			} else
 				dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
-			spin_unlock(&cinfo.inode->i_lock);
+			spin_unlock(&dreq->lock);
 			break;
 		}
 		nfs_release_request(req);
@@ -871,9 +871,9 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 
 			/* If the error is soft, defer remaining requests */
 			nfs_init_cinfo_from_dreq(&cinfo, dreq);
-			spin_lock(&cinfo.inode->i_lock);
+			spin_lock(&dreq->lock);
 			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
-			spin_unlock(&cinfo.inode->i_lock);
+			spin_unlock(&dreq->lock);
 			nfs_unlock_request(req);
 			nfs_mark_request_commit(req, NULL, &cinfo, 0);
 			desc.pg_error = 0;
-- 
2.41.0

