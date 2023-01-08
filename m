Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A172661695
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjAHQ27 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjAHQ26 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:28:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7D13889
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:28:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0543860CA4
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535C9C433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195336;
        bh=c1iwYkCYWC3wYFX2GnKwRh0H8M8adsjY4fr/5BRHK0c=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=K0w5Wja4Hz3qzdH1LVhxJ7ik73NLrJOrUFGOup2x6N+34sIb3tzo+DxZkuojCwlxx
         HzvJ6cIZuu2xwduf6LOgW7RJuOPrbaigebH/Kzh9JLbBUXaC9Csr/TzrUJTU7cP8WB
         8D+beoSw00/4srN1VbqqzyDYrKbUXtm+jy+xbNYcWzBVmOjt3qGTzMbwbnTBz5E8Tr
         DjaZ2kkedfX5Rxs2THy1hBd5QduLa6dtlJd8WC3SZgN7Kq/LX0D7mFpZjQLNo/UWA0
         cgA3BuE8167OYZku+19DTMUgN6GRTYSzbsvnLE4aKl32LjfesHar/BQdhsWz80STIr
         KmXhjqvzklR+g==
Subject: [PATCH v1 05/27] SUNRPC: Convert svcauth_gss_wrap_integ() to use
 xdr_stream()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:28:55 -0500
Message-ID: <167319533537.7490.14676041298155635311.stgit@bazille.1015granger.net>
In-Reply-To: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Done as part of hardening the server-side RPC header decoding path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 6aefe24953fa..3715ff842ca1 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1778,40 +1778,39 @@ svcauth_gss_prepare_to_wrap(struct xdr_buf *resbuf, struct gss_svc_data *gsd)
 static int svcauth_gss_wrap_integ(struct svc_rqst *rqstp)
 {
 	struct gss_svc_data *gsd = rqstp->rq_auth_data;
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct rpc_gss_wire_cred *gc = &gsd->clcred;
-	struct xdr_buf *buf = &rqstp->rq_res;
+	struct xdr_buf *buf = xdr->buf;
 	struct xdr_buf databody_integ;
 	struct xdr_netobj checksum;
 	u32 offset, len, maj_stat;
-	struct kvec *resv;
 	__be32 *p;
 
 	p = svcauth_gss_prepare_to_wrap(buf, gsd);
 	if (p == NULL)
 		goto out;
+
 	offset = (u8 *)(p + 1) - (u8 *)buf->head[0].iov_base;
 	len = buf->len - offset;
-	if (len & 3)
-		goto out;
-	*p++ = htonl(len);
-	*p++ = htonl(gc->gc_seq);
 	if (xdr_buf_subsegment(buf, &databody_integ, offset, len))
 		goto wrap_failed;
+	/* Buffer space for these has already been reserved in
+	 * svcauth_gss_accept(). */
+	*p++ = cpu_to_be32(len);
+	*p = cpu_to_be32(gc->gc_seq);
 
 	checksum.data = gsd->gsd_scratch;
 	maj_stat = gss_get_mic(gsd->rsci->mechctx, &databody_integ, &checksum);
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_mic;
-	svc_putnl(resv, checksum.len);
-	memset(checksum.data + checksum.len, 0,
-	       round_up_to_quad(checksum.len) - checksum.len);
-	resv->iov_len += XDR_QUADLEN(checksum.len) << 2;
-	/* not strictly required: */
-	buf->len += XDR_QUADLEN(checksum.len) << 2;
-	if (resv->iov_len > PAGE_SIZE)
+
+	if (xdr_stream_encode_opaque(xdr, checksum.data, checksum.len) < 0)
 		goto wrap_failed;
+	xdr_commit_encode(xdr);
+
 out:
 	return 0;
+
 bad_mic:
 	trace_rpcgss_svc_get_mic(rqstp, maj_stat);
 wrap_failed:


