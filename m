Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E925D5A3F2D
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Aug 2022 20:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiH1Sul (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Aug 2022 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiH1Suj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Aug 2022 14:50:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A025B7EB
        for <linux-nfs@vger.kernel.org>; Sun, 28 Aug 2022 11:50:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D2F0B80B87
        for <linux-nfs@vger.kernel.org>; Sun, 28 Aug 2022 18:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5574C433C1;
        Sun, 28 Aug 2022 18:50:35 +0000 (UTC)
Subject: [PATCH v2 3/7] NFSD: Protect against READDIR send buffer overflow
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 28 Aug 2022 14:50:34 -0400
Message-ID: <166171263459.21449.18044553311121354704.stgit@manet.1015granger.net>
In-Reply-To: <166171174172.21449.5036120183381273656.stgit@manet.1015granger.net>
References: <166171174172.21449.5036120183381273656.stgit@manet.1015granger.net>
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

For many years, NFSD has conserved the number of pages held by
each nfsd thread by combining the RPC receive and send buffers
into a single array of pages. The dividing line between the
receive and send buffer is pointed to by svc_rqst::rq_respages.

Thus the send buffer shrinks when the received RPC record
containing the RPC Call is large.

nfsd3_init_dirlist_pages() needs to account for the space in the
svc_rqst::rq_pages array already consumed by the RPC receive buffer.
Otherwise READDIR reply encoding can wander off the end of the page
array.

Thanks to Aleksi Illikainen and Kari Hulkko for discovering this
issue.

Reported-by: Ben Ronallo <Benjamin.Ronallo@synopsys.com>
Fixes: f5dcccd647da ("NFSD: Update the NFSv2 READDIR entry encoder to use struct xdr_stream")
Fixes: 7f87fc2d34d4 ("NFSD: Update NFSv3 READDIR entry encoders to use struct xdr_stream")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    5 ++---
 fs/nfsd/nfsproc.c  |    5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index a41cca619338..fab87e9e0b20 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -564,12 +564,11 @@ static void nfsd3_init_dirlist_pages(struct svc_rqst *rqstp,
 	struct xdr_buf *buf = &resp->dirlist;
 	struct xdr_stream *xdr = &resp->xdr;
 
-	count = clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
-
 	memset(buf, 0, sizeof(*buf));
 
 	/* Reserve room for the NULL ptr & eof flag (-2 words) */
-	buf->buflen = count - XDR_UNIT * 2;
+	buf->buflen = clamp(count, (u32)(XDR_UNIT * 2), rqstp->rq_res.buflen);
+	buf->buflen -= XDR_UNIT * 2;
 	buf->pages = rqstp->rq_next_page;
 	rqstp->rq_next_page += (buf->buflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 7381972f1677..23c273cb68a9 100644
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
+	buf->buflen = clamp(count, (u32)(XDR_UNIT * 2), rqstp->rq_res.buflen);
+	buf->buflen -= XDR_UNIT * 2;
 	buf->pages = rqstp->rq_next_page;
 	rqstp->rq_next_page++;
 


