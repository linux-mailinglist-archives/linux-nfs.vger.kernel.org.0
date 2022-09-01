Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99D5A9F9E
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiIATKJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 15:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiIATKE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 15:10:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2971759C
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 12:10:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDCE0B828CE
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 19:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52553C433C1;
        Thu,  1 Sep 2022 19:10:00 +0000 (UTC)
Subject: [PATCH v3 2/6] SUNRPC: Fix svcxdr_init_encode's buflen calculation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Sep 2022 15:09:59 -0400
Message-ID: <166205939934.1435.10147129980334935811.stgit@manet.1015granger.net>
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

Commit 2825a7f90753 ("nfsd4: allow encoding across page boundaries")
added an explicit computation of the remaining length in the rq_res
XDR buffer.

The computation appears to suffer from an "off-by-one" bug. Because
buflen is too large by one page, XDR encoding can run off the end of
the send buffer by eventually trying to use the struct page address
in rq_page_end, which always contains NULL.

Fixes: bddfdbcddbe2 ("NFSD: Extract the svcxdr_init_encode() helper")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 5a830b66f059..0ca8a8ffb47e 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -587,7 +587,7 @@ static inline void svcxdr_init_encode(struct svc_rqst *rqstp)
 	xdr->end = resv->iov_base + PAGE_SIZE - rqstp->rq_auth_slack;
 	buf->len = resv->iov_len;
 	xdr->page_ptr = buf->pages - 1;
-	buf->buflen = PAGE_SIZE * (1 + rqstp->rq_page_end - buf->pages);
+	buf->buflen = PAGE_SIZE * (rqstp->rq_page_end - buf->pages);
 	buf->buflen -= rqstp->rq_auth_slack;
 	xdr->rqst = NULL;
 }


