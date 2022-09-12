Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BDF5B62AB
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiILVXY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiILVXX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:23:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48242AC65
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 14:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E5BEB80C9E
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25987C433D6
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:23:20 +0000 (UTC)
Subject: [PATCH v1 09/12] NFSD: Clean up nfs4svc_encode_compoundres()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 17:23:19 -0400
Message-ID: <166301779933.89884.4528707315025844737.stgit@oracle-102.nfsv4.dev>
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

In today's Linux NFS server implementation, the NFS dispatcher
initializes each XDR result stream, and the NFSv4 .pc_func and
.pc_encode methods all use xdr_stream-based encoding. This keeps
rq_res.len automatically updated. There is no longer a need for
the WARN_ON_ONCE() check in nfs4svc_encode_compoundres().

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 49afc0e5b04c..88ced20fec11 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5459,12 +5459,8 @@ bool
 nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-	struct xdr_buf *buf = xdr->buf;
 	__be32 *p;
 
-	WARN_ON_ONCE(buf->len != buf->head[0].iov_len + buf->page_len +
-				 buf->tail[0].iov_len);
-
 	/*
 	 * Send buffer space for the following items is reserved
 	 * at the top of nfsd4_proc_compound().


