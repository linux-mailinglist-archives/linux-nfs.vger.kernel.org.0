Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EA65B62A8
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiILVXH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiILVXG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:23:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CAF4055B
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 14:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16B08B80C9E
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA06C433D7
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:23:02 +0000 (UTC)
Subject: [PATCH v1 06/12] NFSD: Use xdr_inline_decode() to decode NFSv3
 symlinks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 17:23:02 -0400
Message-ID: <166301778198.89884.1973943063854884679.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
References: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
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

Replace the check for buffer over/underflow with a helper that is
commonly used for this purpose. The helper also sets xdr->nwords
correctly after successfully linearizing the symlink argument into
the stream's scratch buffer.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 0293b8d65f10..71e32cf28885 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -616,8 +616,6 @@ nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_symlinkargs *args = rqstp->rq_argp;
 	struct kvec *head = rqstp->rq_arg.head;
-	struct kvec *tail = rqstp->rq_arg.tail;
-	size_t remaining;
 
 	if (!svcxdr_decode_diropargs3(xdr, &args->ffh, &args->fname, &args->flen))
 		return false;
@@ -626,16 +624,10 @@ nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (xdr_stream_decode_u32(xdr, &args->tlen) < 0)
 		return false;
 
-	/* request sanity */
-	remaining = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
-	remaining -= xdr_stream_pos(xdr);
-	if (remaining < xdr_align_size(args->tlen))
-		return false;
-
-	args->first.iov_base = xdr->p;
+	/* symlink_data */
 	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
-
-	return true;
+	args->first.iov_base = xdr_inline_decode(xdr, args->tlen);
+	return args->first.iov_base != NULL;
 }
 
 bool


