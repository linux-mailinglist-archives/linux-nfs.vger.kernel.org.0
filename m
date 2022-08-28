Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8F55A3F2F
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Aug 2022 20:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiH1Sux (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Aug 2022 14:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiH1Suw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Aug 2022 14:50:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520DEDF7A
        for <linux-nfs@vger.kernel.org>; Sun, 28 Aug 2022 11:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F266BB8076E
        for <linux-nfs@vger.kernel.org>; Sun, 28 Aug 2022 18:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DE9C433C1;
        Sun, 28 Aug 2022 18:50:48 +0000 (UTC)
Subject: [PATCH v2 5/7] NFSD: Clean up WRITE arg decoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 28 Aug 2022 14:50:47 -0400
Message-ID: <166171264742.21449.12798598095676580927.stgit@manet.1015granger.net>
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

xdr_stream_subsegment() already returns a boolean value.

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


