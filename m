Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BCD70A167
	for <lists+linux-nfs@lfdr.de>; Fri, 19 May 2023 23:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjESVRm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 May 2023 17:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjESVRm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 May 2023 17:17:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C87BC
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 14:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 264DC65A94
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 21:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D5CC433EF;
        Fri, 19 May 2023 21:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684531060;
        bh=R/vsGa5niqnZgVwu5aJ6saZhFWPo59AqHcVWH51bmKw=;
        h=From:To:Cc:Subject:Date:From;
        b=V38r1Mefcan9WTVrdx5JIp4aiSDktCkUUWm4vL4vhVy+C7WeW6GIoHxo2gbLSbXII
         9ZVPkV+WVCnqIARRQ54PlNulvXqHwyKgz/pH1uBSoVTpx2jj/nGCKu/VN25JIvGpnn
         M1VL+aw+xTNg9FqNnDQqPr1QNg2tj8UcKvSxMDymAsyyM9LqPV7yP/m0SWtogVZlhE
         BPu0oZszdYW8NYUE0DoK9wBXeGAWm6oRazPD6QDqJpDP1kSH3EWw/S9DkIoj4Sjw/Q
         F0TPc3idmJWaf5GtGVkhtD3gu7ebPBZqEKEBQEB/i6jBsocJkX5Tx7+gh/xfmnO2i/
         6RwXiZBCCPDEQ==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH] NFSv4.2: Fix a potential double free with READ_PLUS
Date:   Fri, 19 May 2023 17:17:36 -0400
Message-Id: <20230519211736.246568-1-anna@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

kfree()-ing the scratch page isn't enough, we also need to set the pointer
back to NULL to avoid a double-free in the case of a resend.

Fixes: fbd2a05f29a9 (NFSv4.2: Rework scratch handling for READ_PLUS)
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4proc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 18f25ff4bff7..d3665390c4cb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5437,10 +5437,18 @@ static bool nfs4_read_plus_not_supported(struct rpc_task *task,
 	return false;
 }
 
-static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
+static inline void nfs4_read_plus_scratch_free(struct nfs_pgio_header *hdr)
 {
-	if (hdr->res.scratch)
+	if (hdr->res.scratch) {
 		kfree(hdr->res.scratch);
+		hdr->res.scratch = NULL;
+	}
+}
+
+static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
+{
+	nfs4_read_plus_scratch_free(hdr);
+
 	if (!nfs4_sequence_done(task, &hdr->res.seq_res))
 		return -EAGAIN;
 	if (nfs4_read_stateid_changed(task, &hdr->args))
-- 
2.40.1

