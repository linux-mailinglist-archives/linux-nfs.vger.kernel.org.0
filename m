Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A853AE55
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jun 2022 22:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiFAUrl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jun 2022 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiFAUrX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jun 2022 16:47:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD801F4295
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 13:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06058B81BBA
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 20:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E418C385A5
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 20:39:48 +0000 (UTC)
Subject: [PATCH] SUNRPC: Trap RDMA segment overflows
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 01 Jun 2022 16:39:47 -0400
Message-ID: <165411598744.1142.6464520583131673765.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Prevent svc_rdma_build_writes() from walking off the end of a Write
chunk's segment array. Caught with KASAN.

The test that this fix replaces is invalid, and might have been left
over from an earlier prototype of the PCL work.

Fixes: 7a1cbfa18059 ("svcrdma: Use parsed chunk lists to construct RDMA Writes")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 5f0155fdefc7..11cf7c646644 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -478,10 +478,10 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 		unsigned int write_len;
 		u64 offset;
 
-		seg = &info->wi_chunk->ch_segments[info->wi_seg_no];
-		if (!seg)
+		if (info->wi_seg_no >= info->wi_chunk->ch_segcount)
 			goto out_overflow;
 
+		seg = &info->wi_chunk->ch_segments[info->wi_seg_no];
 		write_len = min(remaining, seg->rs_length - info->wi_seg_off);
 		if (!write_len)
 			goto out_overflow;


