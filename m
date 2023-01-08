Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187506616B6
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbjAHQb0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbjAHQbO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:31:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539EC1E1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:31:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E66F860C58
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA4AC433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195472;
        bh=1Okx2EaUPDqe8bGyg9i0ooG9E8JUu6bNXgvChRG7idU=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=dox6VNg/u9wGnUBklBoO7WzzVfiYfNJgbg6FAL0vlW0VDKARP25qgWUqANHCsArSk
         FoiZEnVGs391ACZwxNpJUGja4LinMFbFLuDTVQjGg4/HOplE56e8qncJog2rMdFRO0
         p3pmg96XY3i9cRA4ouo1fhbociHniPqGiW2SPWNIFpCQe7JRPZKa9WaKzmd5IDQUBd
         CGgs6I60iwiy/CdJvAT/6FEEZq8Shp67ffrNV8m8tuFVE7OnFaCeYMYq2ANlc7iZy8
         PzUc7OomC3ISKZE5pVl9ocpdZe9L33zaGlc0H3sFzqULQZkeXwg7ckyZAiOBla+3KE
         EupAZUcGsrtUA==
Subject: [PATCH v1 27/27] SUNRPC: Go back to using gsd->body_start
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:31:11 -0500
Message-ID: <167319547140.7490.10549776139860828344.stgit@bazille.1015granger.net>
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

Now that svcauth_gss_prepare_to_wrap() no longer computes the
location of RPC header fields in the response buffer,
svcauth_gss_accept() can save the location of the databody
rather than the location of the verifier.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   78 +++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 333873abb7d9..419d5ad6311c 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -71,9 +71,7 @@
 struct gss_svc_data {
 	/* decoded gss client cred: */
 	struct rpc_gss_wire_cred	clcred;
-	/* save a pointer to the beginning of the encoded verifier,
-	 * for use in encryption/checksumming in svcauth_gss_release: */
-	__be32				*verf_start;
+	u32				gsd_databody_offset;
 	struct rsc			*rsci;
 
 	/* for temporary results */
@@ -1595,7 +1593,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 	if (!svcdata)
 		goto auth_err;
 	rqstp->rq_auth_data = svcdata;
-	svcdata->verf_start = NULL;
+	svcdata->gsd_databody_offset = 0;
 	svcdata->rsci = NULL;
 	gc = &svcdata->clcred;
 
@@ -1647,11 +1645,11 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 		goto complete;
 	case RPC_GSS_PROC_DATA:
 		rqstp->rq_auth_stat = rpcsec_gsserr_ctxproblem;
-		svcdata->verf_start = xdr_reserve_space(&rqstp->rq_res_stream, 0);
 		if (!svcauth_gss_encode_verf(rqstp, rsci->mechctx, gc->gc_seq))
 			goto auth_err;
 		if (!svcxdr_set_accept_stat(rqstp))
 			goto auth_err;
+		svcdata->gsd_databody_offset = xdr_stream_pos(&rqstp->rq_res_stream);
 		rqstp->rq_cred = rsci->cred;
 		get_group_info(rsci->cred.cr_group_info);
 		rqstp->rq_auth_stat = rpc_autherr_badcred;
@@ -1705,30 +1703,24 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 	return ret;
 }
 
-static __be32 *
+static u32
 svcauth_gss_prepare_to_wrap(struct svc_rqst *rqstp, struct gss_svc_data *gsd)
 {
-	__be32 *p;
-	u32 verf_len;
+	u32 offset;
 
-	p = gsd->verf_start;
-	gsd->verf_start = NULL;
+	/* Release can be called twice, but we only wrap once. */
+	offset = gsd->gsd_databody_offset;
+	gsd->gsd_databody_offset = 0;
 
 	/* AUTH_ERROR replies are not wrapped. */
 	if (rqstp->rq_auth_stat != rpc_auth_ok)
-		return NULL;
-
-	/* Skip the verifier: */
-	p += 1;
-	verf_len = ntohl(*p++);
-	p += XDR_QUADLEN(verf_len);
+		return 0;
 
 	/* Also don't wrap if the accept_stat is nonzero: */
 	if (*rqstp->rq_accept_statp != rpc_success)
-		return NULL;
+		return 0;
 
-	p++;
-	return p;
+	return offset;
 }
 
 /*
@@ -1756,21 +1748,21 @@ static int svcauth_gss_wrap_integ(struct svc_rqst *rqstp)
 	struct xdr_buf *buf = xdr->buf;
 	struct xdr_buf databody_integ;
 	struct xdr_netobj checksum;
-	u32 offset, len, maj_stat;
-	__be32 *p;
+	u32 offset, maj_stat;
 
-	p = svcauth_gss_prepare_to_wrap(rqstp, gsd);
-	if (p == NULL)
+	offset = svcauth_gss_prepare_to_wrap(rqstp, gsd);
+	if (!offset)
 		goto out;
 
-	offset = (u8 *)(p + 1) - (u8 *)buf->head[0].iov_base;
-	len = buf->len - offset;
-	if (xdr_buf_subsegment(buf, &databody_integ, offset, len))
+	if (xdr_buf_subsegment(buf, &databody_integ, offset + XDR_UNIT,
+			       buf->len - offset - XDR_UNIT))
 		goto wrap_failed;
 	/* Buffer space for these has already been reserved in
 	 * svcauth_gss_accept(). */
-	*p++ = cpu_to_be32(len);
-	*p = cpu_to_be32(gc->gc_seq);
+	if (xdr_encode_word(buf, offset, databody_integ.len))
+		goto wrap_failed;
+	if (xdr_encode_word(buf, offset + XDR_UNIT, gc->gc_seq))
+		goto wrap_failed;
 
 	checksum.data = gsd->gsd_scratch;
 	maj_stat = gss_get_mic(gsd->rsci->mechctx, &databody_integ, &checksum);
@@ -1817,17 +1809,19 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 	struct kvec *head = buf->head;
 	struct kvec *tail = buf->tail;
 	u32 offset, pad, maj_stat;
-	__be32 *p, *lenp;
+	__be32 *p;
 
-	p = svcauth_gss_prepare_to_wrap(rqstp, gsd);
-	if (p == NULL)
+	offset = svcauth_gss_prepare_to_wrap(rqstp, gsd);
+	if (!offset)
 		return 0;
 
-	lenp = p++;
-	offset = (u8 *)p - (u8 *)head->iov_base;
-	/* Buffer space for this field has already been reserved
-	 * in svcauth_gss_accept(). */
-	*p = cpu_to_be32(gc->gc_seq);
+	/*
+	 * Buffer space for this field has already been reserved
+	 * in svcauth_gss_accept(). Note that the GSS sequence
+	 * number is encrypted along with the RPC reply payload.
+	 */
+	if (xdr_encode_word(buf, offset + XDR_UNIT, gc->gc_seq))
+		goto wrap_failed;
 
 	/*
 	 * If there is currently tail data, make sure there is
@@ -1863,12 +1857,15 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 		tail->iov_len = 0;
 	}
 
-	maj_stat = gss_wrap(gsd->rsci->mechctx, offset, buf, buf->pages);
+	maj_stat = gss_wrap(gsd->rsci->mechctx, offset + XDR_UNIT, buf,
+			    buf->pages);
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_wrap;
 
-	*lenp = cpu_to_be32(buf->len - offset);
-	pad = xdr_pad_size(buf->len - offset);
+	/* Wrapping can change the size of databody_priv. */
+	if (xdr_encode_word(buf, offset, buf->len - offset - XDR_UNIT))
+		goto wrap_failed;
+	pad = xdr_pad_size(buf->len - offset - XDR_UNIT);
 	p = (__be32 *)(tail->iov_base + tail->iov_len);
 	memset(p, 0, pad);
 	tail->iov_len += pad;
@@ -1908,9 +1905,6 @@ svcauth_gss_release(struct svc_rqst *rqstp)
 	gc = &gsd->clcred;
 	if (gc->gc_proc != RPC_GSS_PROC_DATA)
 		goto out;
-	/* Release can be called twice, but we only wrap once. */
-	if (gsd->verf_start == NULL)
-		goto out;
 
 	switch (gc->gc_svc) {
 	case RPC_GSS_SVC_NONE:


