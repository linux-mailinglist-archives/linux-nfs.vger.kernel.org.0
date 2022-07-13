Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D09573F89
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 00:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbiGMWVm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 18:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGMWVl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 18:21:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8A2A731
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 15:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C84B4B82089
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 22:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F34FC3411E
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 22:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657750898;
        bh=mODro8g6cxVPv/00s6JgCXR4NU0V8jyQjeBRaE7/0mc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gSl8tod2PQJHz+Bk/UFrbuLL4skGT3NR+tpnVgTl9j2sn4P9AA/1SmOvMG5b+58Mf
         EnLwy/qppSRuPOKIZItO+9P7k1NXhTVIonvGBW/WIibKcdVZJ8JvqVmNJiB2euDr2+
         Ah1guo8b8sSWPUEcK2C9wiWrznhjy3CjQs10De1+sz967Q9awWyPxMLTwvnxblW+l9
         2hCSo0lmYvOPAwERtCNM3rYGsB2TWB3H2Ql60n6y0CqvmrEIWc1jAez5UbHnVgIDMX
         Oz/5o5wYjxUHa1/hhOTfpm8bRptMzVx5BIUDDfqhSXZ2Dcl7Q9l7J6tP4yHYvGCq7j
         lfWpUEx7YzOpg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4.1: Handle NFS4ERR_DELAY replies to OP_SEQUENCE correctly
Date:   Wed, 13 Jul 2022 18:15:11 -0400
Message-Id: <20220713221511.1038552-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713221511.1038552-1-trondmy@kernel.org>
References: <20220713221511.1038552-1-trondmy@kernel.org>
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

Don't assume that the NFS4ERR_DELAY means that the server is processing
this slot id.

Fixes: 3453d5708b33 ("NFSv4.1: Avoid false retries when RPC calls are interrupted")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 628471d06947..4e0dcc19ca71 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -853,7 +853,6 @@ static int nfs41_sequence_process(struct rpc_task *task,
 			__func__,
 			slot->slot_nr,
 			slot->seq_nr);
-		nfs4_slot_sequence_acked(slot, slot->seq_nr);
 		goto out_retry;
 	case -NFS4ERR_RETRY_UNCACHED_REP:
 	case -NFS4ERR_SEQ_FALSE_RETRY:
-- 
2.36.1

