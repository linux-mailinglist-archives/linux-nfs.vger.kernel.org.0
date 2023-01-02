Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C492065B588
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjABRG6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjABRGk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:06:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB8A64DB
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:06:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EAA8B80D0A
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D3CC433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679196;
        bh=oNvIRYSmK6h7DkDH/5Q2L/nNl9hgz+bBW6Slphwcur0=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=T89mE82QkZPZhDC1GFTp5wlIhnbKf7xNt5PeQ74ZAFFFwaNAdXTrHQyrlIARnFxGa
         Ik9a3leuYE7Vips7r9AqPV4oJCDc619QqjfKwb5V3hLx7+xjF2nzyZj/BbGrUjw7RO
         lDkH+/8rFps8HsKbPqdTvO4q1tSijQfxrlIrW3y14gtiMuj4h4TKCYSSoGcrx+BJMS
         foVJ1/tXjzaMpOH9ZmAjUxAWFm2oG/Rd2uhl2KQ2Bq0zuN1JJkwGiWdapfPiTYqQtC
         JU2qPclcnawy2MIXKUP7iTVUAKpgG41fo94JMbfz8ZAiwxdtST3S6INJRv80Jli0uT
         lY41Te8UnR+2Q==
Subject: [PATCH v1 11/25] SUNRPC: Convert server-side GSS upcall helpers to
 use xdr_stream
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:06:35 -0500
Message-ID: <167267919508.112521.13882641909589080174.stgit@manet.1015granger.net>
In-Reply-To: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
References: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

The entire RPC_GSS_PROC_INIT path is converted over to xdr_stream
for decoding the Call credential and verifier.

Done as part of hardening the server-side RPC header decoding path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   87 +++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 29 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 5b03a97e32b7..8e8dec664a89 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1112,39 +1112,43 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 			       struct xdr_netobj *in_handle,
 			       struct gssp_in_token *in_token)
 {
-	struct kvec *argv = &rqstp->rq_arg.head[0];
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	unsigned int length, pgto_offs, pgfrom_offs;
-	size_t inlen, to_offs, from_offs;
 	int pages, i, pgto, pgfrom;
+	size_t to_offs, from_offs;
+	u32 inlen;
 
 	if (dup_netobj(in_handle, &gc->gc_ctx))
 		return SVC_CLOSE;
 
-	inlen = svc_getnl(argv);
-	if (inlen > (argv->iov_len + rqstp->rq_arg.page_len)) {
-		kfree(in_handle->data);
-		return SVC_DENIED;
-	}
+	/*
+	 *  RFC 2203 Section 5.2.2
+	 *
+	 *	struct rpc_gss_init_arg {
+	 *		opaque gss_token<>;
+	 *	};
+	 */
+	if (xdr_stream_decode_u32(xdr, &inlen) < 0)
+		goto out_denied_free;
+	if (inlen > xdr_stream_remaining(xdr))
+		goto out_denied_free;
 
 	pages = DIV_ROUND_UP(inlen, PAGE_SIZE);
 	in_token->pages = kcalloc(pages, sizeof(struct page *), GFP_KERNEL);
-	if (!in_token->pages) {
-		kfree(in_handle->data);
-		return SVC_DENIED;
-	}
+	if (!in_token->pages)
+		goto out_denied_free;
 	in_token->page_base = 0;
 	in_token->page_len = inlen;
 	for (i = 0; i < pages; i++) {
 		in_token->pages[i] = alloc_page(GFP_KERNEL);
 		if (!in_token->pages[i]) {
-			kfree(in_handle->data);
 			gss_free_in_token_pages(in_token);
-			return SVC_DENIED;
+			goto out_denied_free;
 		}
 	}
 
-	length = min_t(unsigned int, inlen, argv->iov_len);
-	memcpy(page_address(in_token->pages[0]), argv->iov_base, length);
+	length = min_t(unsigned int, inlen, (char *)xdr->end - (char *)xdr->p);
+	memcpy(page_address(in_token->pages[0]), xdr->p, length);
 	inlen -= length;
 
 	to_offs = length;
@@ -1167,6 +1171,10 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 		inlen -= length;
 	}
 	return 0;
+
+out_denied_free:
+	kfree(in_handle->data);
+	return SVC_DENIED;
 }
 
 static inline int
@@ -1196,27 +1204,45 @@ gss_write_resv(struct kvec *resv, size_t size_limit,
  * the upcall results are available, write the verifier and result.
  * Otherwise, drop the request pending an answer to the upcall.
  */
-static int svcauth_gss_legacy_init(struct svc_rqst *rqstp,
-				   struct rpc_gss_wire_cred *gc)
+static int
+svcauth_gss_legacy_init(struct svc_rqst *rqstp,
+			struct rpc_gss_wire_cred *gc)
 {
-	struct kvec *argv = &rqstp->rq_arg.head[0];
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct kvec *resv = &rqstp->rq_res.head[0];
 	struct rsi *rsip, rsikey;
-	struct xdr_netobj tmpobj;
+	__be32 *p;
+	u32 len;
 	int ret;
 	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
 	memset(&rsikey, 0, sizeof(rsikey));
 	if (dup_netobj(&rsikey.in_handle, &gc->gc_ctx))
 		return SVC_CLOSE;
-	if (svc_safe_getnetobj(argv, &tmpobj)) {
+
+	/*
+	 *  RFC 2203 Section 5.2.2
+	 *
+	 *	struct rpc_gss_init_arg {
+	 *		opaque gss_token<>;
+	 *	};
+	 */
+	if (xdr_stream_decode_u32(xdr, &len) < 0) {
+		kfree(rsikey.in_handle.data);
+		return SVC_DENIED;
+	}
+	p = xdr_inline_decode(xdr, len);
+	if (!p) {
 		kfree(rsikey.in_handle.data);
 		return SVC_DENIED;
 	}
-	if (dup_netobj(&rsikey.in_token, &tmpobj)) {
+	rsikey.in_token.data = kmalloc(len, GFP_KERNEL);
+	if (ZERO_OR_NULL_PTR(rsikey.in_token.data)) {
 		kfree(rsikey.in_handle.data);
 		return SVC_CLOSE;
 	}
+	memcpy(rsikey.in_token.data, p, len);
+	rsikey.in_token.len = len;
 
 	/* Perform upcall, or find upcall result: */
 	rsip = rsi_lookup(sn->rsi_cache, &rsikey);
@@ -1237,7 +1263,6 @@ static int svcauth_gss_legacy_init(struct svc_rqst *rqstp,
 			   rsip->major_status, rsip->minor_status))
 		goto out;
 
-	svcxdr_init_decode(rqstp);
 	ret = SVC_COMPLETE;
 out:
 	cache_put(&rsip->h, sn->rsi_cache);
@@ -1366,7 +1391,6 @@ static int svcauth_gss_proxy_init(struct svc_rqst *rqstp,
 			   ud.major_status, ud.minor_status))
 		goto out;
 
-	svcxdr_init_decode(rqstp);
 	ret = SVC_COMPLETE;
 out:
 	gss_free_in_token_pages(&ud.in_token);
@@ -1404,14 +1428,19 @@ static bool use_gss_proxy(struct net *net)
 static noinline_for_stack int
 svcauth_gss_proc_init(struct svc_rqst *rqstp, struct rpc_gss_wire_cred *gc)
 {
-	struct kvec *argv = rqstp->rq_arg.head;
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
+	u32 flavor, len;
+	void *body;
 
-	if (argv->iov_len < 2 * 4)
-		return SVC_DENIED;
-	if (svc_getnl(argv) != RPC_AUTH_NULL)
-		return SVC_DENIED;
-	if (svc_getnl(argv) != 0)
+	svcxdr_init_decode(rqstp);
+
+	/* Call's verf field: */
+	if (xdr_stream_decode_opaque_auth(xdr, &flavor, &body, &len) < 0)
+		return SVC_GARBAGE;
+	if (flavor != RPC_AUTH_NULL || len != 0) {
+		rqstp->rq_auth_stat = rpc_autherr_badverf;
 		return SVC_DENIED;
+	}
 
 	if (gc->gc_proc == RPC_GSS_PROC_INIT && gc->gc_ctx.len != 0) {
 		rqstp->rq_auth_stat = rpc_autherr_badcred;


