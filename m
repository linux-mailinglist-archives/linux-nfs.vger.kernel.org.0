Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD3A5B62A9
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiILVXN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiILVXM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:23:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DA2AC65
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 14:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E37C7B80D87
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A60C433D6
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:23:08 +0000 (UTC)
Subject: [PATCH v1 07/12] NFSD: Clean up WRITE arg decoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 17:23:07 -0400
Message-ID: <166301778775.89884.9482171937924136523.stgit@oracle-102.nfsv4.dev>
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

xdr_stream_subsegment() already returns a boolean value.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |    4 +---
 fs/nfsd/nfsxdr.c  |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 71e32cf28885..3308dd671ef0 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -571,10 +571,8 @@ nfs3svc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		args->count = max_blocksize;
 		args->len = max_blocksize;
 	}
-	if (!xdr_stream_subsegment(xdr, &args->payload, args->count))
-		return false;
 
-	return true;
+	return xdr_stream_subsegment(xdr, &args->payload, args->count);
 }
 
 bool
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index aba8520b4b8b..caf6355b18fa 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -338,10 +338,8 @@ nfssvc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	if (args->len > NFSSVC_MAXBLKSIZE_V2)
 		return false;
-	if (!xdr_stream_subsegment(xdr, &args->payload, args->len))
-		return false;
 
-	return true;
+	return xdr_stream_subsegment(xdr, &args->payload, args->len);
 }
 
 bool


