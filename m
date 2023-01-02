Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFEE65B58B
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbjABRHV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbjABRG5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:06:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9026EA45F
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:06:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A2706104A
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2ECC433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679215;
        bh=IzScd/LMq0y2xqlV48xaUHiHepqmUge5YgaG2pkeVqs=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=PcYUosluHPOb5sxKrzm84RLs3LzDhE0vSlOp3ZhqB6Djo9IzLQyb1VvW4WktKho6e
         8/WQSF9or4ErSxZZq9BzQ5cgKl37Duq2yYB2dJbM/sJ27tP+4msle8MDGqDv+PFyac
         g1FCnWA0XFghz6LJLMbHyyl5OBLUNcKBlg477ecnTZ7aagUNedWQ82edXOoKG55RNl
         zaPOA4kCe6ZMHUv/TBJgEbo96UzBGB4TiZnnRS1D/I6bZlvFYFiZ4sFr6XfAG5tJlJ
         /j5O2VrJiRDSmq0xS6r8ikPqrbodRunGMpsCK47l+l+CAIrHnmxBxT0qlisb0Pqeen
         lfATS4m5caRug==
Subject: [PATCH v1 14/25] SUNRPC: Convert unwrap_integ_data() to use
 xdr_stream
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:06:54 -0500
Message-ID: <167267921434.112521.15582369756118768001.stgit@manet.1015granger.net>
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

Done as part of hardening the server-side RPC header decoding path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h        |    1 +
 net/sunrpc/auth_gss/svcauth_gss.c |   47 ++++++++++++++++++++++++-------------
 net/sunrpc/xdr.c                  |   15 ++++++++++++
 3 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 8b5c9d0cdcb5..accfe8d6e283 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -247,6 +247,7 @@ extern int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec,
 		size_t nbytes);
 extern void __xdr_commit_encode(struct xdr_stream *xdr);
 extern void xdr_truncate_encode(struct xdr_stream *xdr, size_t len);
+extern void xdr_truncate_decode(struct xdr_stream *xdr, size_t len);
 extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
 extern void xdr_write_pages(struct xdr_stream *xdr, struct page **pages,
 		unsigned int base, unsigned int len);
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 33fe307372d0..d049db997ab7 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -904,13 +904,14 @@ EXPORT_SYMBOL_GPL(svcauth_gss_register_pseudoflavor);
  *		proc_req_arg_t arg;
  *	};
  */
-static int
-svcauth_gss_unwrap_integ(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq,
-			 struct gss_ctx *ctx)
+static noinline_for_stack int
+svcauth_gss_unwrap_integ(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
 {
 	struct gss_svc_data *gsd = rqstp->rq_auth_data;
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
+	u32 len, offset, seq_num, maj_stat;
+	struct xdr_buf *buf = xdr->buf;
 	struct xdr_buf databody_integ;
-	u32 len, seq_num, maj_stat;
 	struct xdr_netobj checksum;
 
 	/* NFS READ normally uses splice to send data in-place. However
@@ -925,29 +926,43 @@ svcauth_gss_unwrap_integ(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq,
 	if (rqstp->rq_deferred)
 		return 0;
 
-	len = svc_getnl(&buf->head[0]);
-	if (len & 3)
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
 		goto unwrap_failed;
-	if (len > buf->len)
+	if (len & 3)
 		goto unwrap_failed;
-	if (xdr_buf_subsegment(buf, &databody_integ, 0, len))
+	offset = xdr_stream_pos(xdr);
+	if (xdr_buf_subsegment(buf, &databody_integ, offset, len))
 		goto unwrap_failed;
 
-	if (xdr_decode_word(buf, len, &checksum.len))
+	/*
+	 * The xdr_stream now points to the @seq_num field. The next
+	 * XDR data item is the @arg field, which contains the clear
+	 * text RPC program payload. The checksum, which follows the
+	 * @arg field, is located and decoded without updating the
+	 * xdr_stream.
+	 */
+
+	offset += len;
+	if (xdr_decode_word(buf, offset, &checksum.len))
 		goto unwrap_failed;
 	if (checksum.len > sizeof(gsd->gsd_scratch))
 		goto unwrap_failed;
 	checksum.data = gsd->gsd_scratch;
-	if (read_bytes_from_xdr_buf(buf, len + 4, checksum.data, checksum.len))
+	if (read_bytes_from_xdr_buf(buf, offset + XDR_UNIT, checksum.data,
+				    checksum.len))
 		goto unwrap_failed;
+
 	maj_stat = gss_verify_mic(ctx, &databody_integ, &checksum);
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_mic;
-	seq_num = svc_getnl(&buf->head[0]);
+
+	/* The received seqno is protected by the checksum. */
+	if (xdr_stream_decode_u32(xdr, &seq_num) < 0)
+		goto unwrap_failed;
 	if (seq_num != seq)
 		goto bad_seqno;
-	/* trim off the mic and padding at the end before returning */
-	xdr_buf_trim(buf, round_up_to_quad(checksum.len) + 4);
+
+	xdr_truncate_decode(xdr, XDR_UNIT + checksum.len);
 	return 0;
 
 unwrap_failed:
@@ -1652,11 +1667,11 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 			/* placeholders for length and seq. number: */
 			svc_putnl(resv, 0);
 			svc_putnl(resv, 0);
-			if (svcauth_gss_unwrap_integ(rqstp, &rqstp->rq_arg,
-						     gc->gc_seq, rsci->mechctx))
+			svcxdr_init_decode(rqstp);
+			if (svcauth_gss_unwrap_integ(rqstp, gc->gc_seq,
+						     rsci->mechctx))
 				goto garbage_args;
 			rqstp->rq_auth_slack = RPC_MAX_AUTH_SIZE;
-			svcxdr_init_decode(rqstp);
 			break;
 		case RPC_GSS_SVC_PRIVACY:
 			/* placeholders for length and seq. number: */
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 4845ba2113fd..c7e89921d511 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1192,6 +1192,21 @@ void xdr_truncate_encode(struct xdr_stream *xdr, size_t len)
 }
 EXPORT_SYMBOL(xdr_truncate_encode);
 
+/**
+ * xdr_truncate_decode - Truncate a decoding stream
+ * @xdr: pointer to struct xdr_stream
+ * @len: Number of bytes to remove
+ *
+ */
+void xdr_truncate_decode(struct xdr_stream *xdr, size_t len)
+{
+	unsigned int nbytes = xdr_align_size(len);
+
+	xdr->buf->len -= nbytes;
+	xdr->nwords -= XDR_QUADLEN(nbytes);
+}
+EXPORT_SYMBOL_GPL(xdr_truncate_decode);
+
 /**
  * xdr_restrict_buflen - decrease available buffer space
  * @xdr: pointer to xdr_stream


