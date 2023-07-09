Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9374C7F9
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jul 2023 22:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGIUFP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jul 2023 16:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGIUFO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jul 2023 16:05:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D19FE
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 13:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F92E60C20
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 20:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFFCC433C7;
        Sun,  9 Jul 2023 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688933113;
        bh=fou8AGJVg7txseqewnRn0AjTBVgDNvNRiu8TRqNRdGE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=f6poD2pOHsZfS7G83N4DG7cvKaNHC+YDY9smk8KyAG2XOVDPhknxpkMxyUIjGeF+p
         0qVP07AC3m6xEPs7N3R2+0J0H4Y9XSDtyyIMEe3z7LBO01oVWMpzkz5nz5cbgntMZR
         e958Y0B8jYu4qW76Xpl1kFFIvywTuPtCZSyuMhw1/Gf/XyLPa2wjpx4Mg7r/Mizgxp
         h1NhYkUy5QZr2X0VZL2Hu26xlxhWtP/w2G+rFdOiw2OE+VKh6OmUpto3ZhIdX6qyOK
         tcbIEKXWVTIbgsY1sD+S+G6XWADllB8TuYcGfuywyYBu/4pcHmrm5u/xm3ys0WigAy
         bCeJZex0qCE/w==
Subject: [PATCH RFC 3/4] SUNRPC: Use a per-transport receive bio_vec array
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date:   Sun, 09 Jul 2023 16:05:11 -0400
Message-ID: <168893311179.1949.11410720662404392708.stgit@manet.1015granger.net>
In-Reply-To: <168893265677.1949.1632048925203798962.stgit@manet.1015granger.net>
References: <168893265677.1949.1632048925203798962.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

TCP receives are serialized, so we need only one bio_vec array per
socket. This shrinks the size of struct svc_rqst by 4144 bytes on
x86_64.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h     |    1 -
 include/linux/sunrpc/svcsock.h |    2 ++
 net/sunrpc/svcsock.c           |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f8751118c122..36052188222d 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -224,7 +224,6 @@ struct svc_rqst {
 
 	struct folio_batch	rq_fbatch;
 	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
-	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
 
 	__be32			rq_xid;		/* transmission id */
 	u32			rq_prog;	/* program number */
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index a9bfeadf4cbe..4efae760f3cb 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -40,6 +40,8 @@ struct svc_sock {
 
 	struct completion	sk_handshake_done;
 
+	struct bio_vec		sk_recv_bvec[RPCSVC_MAXPAGES]
+						____cacheline_aligned;
 	struct bio_vec		sk_send_bvec[RPCSVC_MAXPAGES]
 						____cacheline_aligned;
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index ae7143f68343..6f672cb0b0b3 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -333,7 +333,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 {
 	struct svc_sock *svsk =
 		container_of(rqstp->rq_xprt, struct svc_sock, sk_xprt);
-	struct bio_vec *bvec = rqstp->rq_bvec;
+	struct bio_vec *bvec = svsk->sk_recv_bvec;
 	struct msghdr msg = { NULL };
 	unsigned int i;
 	ssize_t len;


