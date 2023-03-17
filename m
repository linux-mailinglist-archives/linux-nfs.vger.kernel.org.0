Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C236BE759
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 11:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCQK4Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQK4P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 06:56:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036B0E9198
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 03:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADA70B824C8
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 10:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B7BC433EF;
        Fri, 17 Mar 2023 10:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679050571;
        bh=8jTUc2Blu7ToKbEt318GFl8KR/RhiUz4jXQHAwQoXmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYTRYoz++gS0VN9WDLBh850sLRZVb4GkB/lzH6jR/SjzCWg+GGQU00WW8VPH1UDou
         DuEgUyE34uBCkkBSILyqROaXDvd2o9qAx3b8ZrnGa41XHhZ4ndUirrOt5w6dMgQhsn
         miw6G4YPPIVhSZOMTimI8dqdRmsr/Ee4ycDeeo594Z38QIvXQ0rUNn2LBqCmAt7Npk
         Wd5G0LJshag1TOjKpWzGTrV4DiOQ5UAMZEM5ZqR67/n75odnpIMO6BLP80vbfZGUOP
         spTXznLpESNpBYGHVYoqV3LsedEO0S7mX/3UWurGh3baaoLe1hqQQ2y4PHpE+bIfVl
         J2qg4G3XNaA4Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, dcritch@redhat.com, d.lesca@solinos.it
Subject: [PATCH 2/2] sunrpc: add bounds checking to svc_rqst_replace_page
Date:   Fri, 17 Mar 2023 06:56:08 -0400
Message-Id: <20230317105608.19393-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317105608.19393-1-jlayton@kernel.org>
References: <20230317105608.19393-1-jlayton@kernel.org>
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

There's no good way to handle this gracefully, but if rq_next_page ends
up pointing outside the array, we can at least crash the box before it
scribbles over too much else.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index fea7ce8fba14..864e62945647 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -845,6 +845,16 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
  */
 void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
 {
+	struct page **begin, **end;
+
+	/*
+	 * Bounds check: make sure rq_next_page points into the rq_respages
+	 * part of the array.
+	 */
+	begin = rqstp->rq_pages;
+	end = &rqstp->rq_pages[RPCSVC_MAXPAGES];
+	BUG_ON(rqstp->rq_next_page < begin || rqstp->rq_next_page > end);
+
 	if (*rqstp->rq_next_page) {
 		if (!pagevec_space(&rqstp->rq_pvec))
 			__pagevec_release(&rqstp->rq_pvec);
-- 
2.39.2

