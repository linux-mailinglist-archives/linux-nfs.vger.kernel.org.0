Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBB7573F88
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 00:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiGMWVk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 18:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGMWVj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 18:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15172A731
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 15:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 891F560F05
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 22:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44CBC34114
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 22:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657750897;
        bh=DR1AFiwUVk8DRBOGw7sdQE6dn/plxgKVPdjF5ohuf0A=;
        h=From:To:Subject:Date:From;
        b=Xfd0V9VI+HPmnbKxwkbY3yC8cdJldRUdhlc0tWoCzBttf39NbQVRneNC0+32LURRe
         XT3CwjznjkdEDcHei2xYwNSfB1VcAO32ZdB0l1Xo0sEasO1TxsIba+O9OwSyMCR/i+
         Z0f5Wl/FRkaSux4NQfTp8gJ9svWdB/7LMJcXNnUu1UM2HmQzeRHXOGL6rC4hFM0aJD
         bF/4V1UCUsLtbbW5R2fqTe9vFLq+lc4IvlQ4xDBIIJQ++GZYskSIUJnrZ15jMVnAYi
         zzCPcEjeIQnMg53rHpU/OvjxR9XOj4e9Td0aA5eCn3cmkQWAQCkG4+dGOWHffcExBX
         2smhuF+KRGLFw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4.1: Don't decrease the value of seq_nr_highest_sent
Date:   Wed, 13 Jul 2022 18:15:10 -0400
Message-Id: <20220713221511.1038552-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
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

When we're trying to figure out what the server may or may not have seen
in terms of request numbers, do not assume that requests with a larger
number were missed, just because we saw a reply to a request with a
smaller number.

Fixes: 3453d5708b33 ("NFSv4.1: Avoid false retries when RPC calls are interrupted")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bb0e84a46d61..628471d06947 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -784,10 +784,9 @@ static void nfs4_slot_sequence_record_sent(struct nfs4_slot *slot,
 	if ((s32)(seqnr - slot->seq_nr_highest_sent) > 0)
 		slot->seq_nr_highest_sent = seqnr;
 }
-static void nfs4_slot_sequence_acked(struct nfs4_slot *slot,
-		u32 seqnr)
+static void nfs4_slot_sequence_acked(struct nfs4_slot *slot, u32 seqnr)
 {
-	slot->seq_nr_highest_sent = seqnr;
+	nfs4_slot_sequence_record_sent(slot, seqnr);
 	slot->seq_nr_last_acked = seqnr;
 }
 
-- 
2.36.1

