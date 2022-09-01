Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE8A5A9FA0
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 21:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiIATKP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 15:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiIATKL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 15:10:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E31925EAA
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 12:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3816BB825DC
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 19:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA410C433C1;
        Thu,  1 Sep 2022 19:10:06 +0000 (UTC)
Subject: [PATCH v3 3/6] NFSD: Protect against send buffer overflow in NFSv2
 READDIR
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Sep 2022 15:10:05 -0400
Message-ID: <166205940565.1435.7170548905174362083.stgit@manet.1015granger.net>
In-Reply-To: <166204973526.1435.6068003336048840051.stgit@manet.1015granger.net>
References: <166204973526.1435.6068003336048840051.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

Restore the previous limit on the @count argument to prevent a
buffer overflow attack.

Fixes: 53b1119a6e50 ("NFSD: Fix READDIR buffer overflow")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 7381972f1677..ddb1902c0a18 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -567,12 +567,11 @@ static void nfsd_init_dirlist_pages(struct svc_rqst *rqstp,
 	struct xdr_buf *buf = &resp->dirlist;
 	struct xdr_stream *xdr = &resp->xdr;
 
-	count = clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
-
 	memset(buf, 0, sizeof(*buf));
 
 	/* Reserve room for the NULL ptr & eof flag (-2 words) */
-	buf->buflen = count - XDR_UNIT * 2;
+	buf->buflen = clamp(count, (u32)(XDR_UNIT * 2), (u32)PAGE_SIZE);
+	buf->buflen -= XDR_UNIT * 2;
 	buf->pages = rqstp->rq_next_page;
 	rqstp->rq_next_page++;
 


