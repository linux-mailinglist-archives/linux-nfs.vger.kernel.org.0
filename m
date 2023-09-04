Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACBE791BBB
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 18:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbjIDQmB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Sep 2023 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbjIDQli (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Sep 2023 12:41:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047121B7
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 09:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 308FACE0F1B
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 16:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473DDC433CB;
        Mon,  4 Sep 2023 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693845691;
        bh=6HBgG2zdnGPv6DyVxNzy21wZ3ZmR0Yp1Zd+W+7xooGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPY4eQfx1RqxzRvv5BQgtZMkSkhyKSQeT6NxExnjwM9WjX2ObcI1+hinJAQxdVCOg
         7jY9OcREW4lCkYs6Dbe1JB0rx9AGNvGsdYZ7tBtvDGMTDKMIduBv0IHry15e4KwI+8
         OFd2O/eneF+y1KQr2IFZfopsRQrNqypnPd9mO/hOq3xQnOArYNCnNZA41cUpUstSDh
         FHeRxIVFyXVBvkTsWdiVPnX6d/Km2B6IZOMGxUhjIXRqX07A/DX/lytfbEWjCqndKp
         MMS9RKb7P2vTH9o+gOvAEd17Hvc9PoLEqhCnf7VGmUCVZMbLPDqo6GDAPBHq0hUrgF
         S9oVn1WxCUO8A==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 5/5] NFS: More fixes for nfs_direct_write_reschedule_io()
Date:   Mon,  4 Sep 2023 12:34:41 -0400
Message-ID: <20230904163441.11950-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904163441.11950-5-trondmy@kernel.org>
References: <20230904163441.11950-1-trondmy@kernel.org>
 <20230904163441.11950-2-trondmy@kernel.org>
 <20230904163441.11950-3-trondmy@kernel.org>
 <20230904163441.11950-4-trondmy@kernel.org>
 <20230904163441.11950-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that all requests are put back onto the commit list so that they
can be rescheduled.

Fixes: 4daaeba93822 ("NFS: Fix nfs_direct_write_reschedule_io()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 3391c8b97da5..f6c74f424691 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -780,18 +780,23 @@ static void nfs_write_sync_pgio_error(struct list_head *head, int error)
 static void nfs_direct_write_reschedule_io(struct nfs_pgio_header *hdr)
 {
 	struct nfs_direct_req *dreq = hdr->dreq;
+	struct nfs_page *req;
+	struct nfs_commit_info cinfo;
 
 	trace_nfs_direct_write_reschedule_io(dreq);
 
+	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	spin_lock(&dreq->lock);
-	if (dreq->error == 0) {
+	if (dreq->error == 0)
 		dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
-		/* fake unstable write to let common nfs resend pages */
-		hdr->verf.committed = NFS_UNSTABLE;
-		hdr->good_bytes = hdr->args.offset + hdr->args.count -
-			hdr->io_start;
-	}
+	set_bit(NFS_IOHDR_REDO, &hdr->flags);
 	spin_unlock(&dreq->lock);
+	while (!list_empty(&hdr->pages)) {
+		req = nfs_list_entry(hdr->pages.next);
+		nfs_list_remove_request(req);
+		nfs_unlock_request(req);
+		nfs_mark_request_commit(req, NULL, &cinfo, 0);
+	}
 }
 
 static const struct nfs_pgio_completion_ops nfs_direct_write_completion_ops = {
-- 
2.41.0

