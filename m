Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96DE65B58C
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbjABRHW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbjABRHE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:07:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C50A18B
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:07:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B9DB6104A
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1505C433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679222;
        bh=ft3xYt5CPrge5r/Kb0E9Mg/pxWba4FyrViavuip2mWM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=D1BYOhbFX/qYEDB2msNuuxBbkxGEuBXXOOXm503skk+fl3QLWzeQwTuw6a0U1HvQ6
         tposOP8sWqrWZZRCH9j5GWJIGim4zmv2GyZs71ZzTeiG2XVbQ5TVy1NVAAcvWrJGnI
         XHbEiu6tVj5+AG/qFikS8rIDbYqYfvm/E6s0smc1T1Gq/5/5p7TLvcQPs9NJXvpryC
         J/NyXZFuPpoL7GkBkwMYZi8FESLZ3smXEZZrnpfigPREfg2l+FCMQP+Udlq/drDi3D
         P+vgA99mvwlv6eC49i0jeSObvHun3G2K+vUo1CILRbYX1EYCVPkpBs5BeLFN51HYaq
         0f6XxxiRP/wlg==
Subject: [PATCH v1 15/25] SUNRPC: Rename automatic variables in
 unwrap_priv_data()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:07:00 -0500
Message-ID: <167267922080.112521.9799655371429506640.stgit@manet.1015granger.net>
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

Clean up: To help orient readers, name the stack variables to match
the XDR field names.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   38 ++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index d049db997ab7..8f91768d0be0 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -993,16 +993,28 @@ fix_priv_head(struct xdr_buf *buf, int pad)
 	}
 }
 
+/*
+ * RFC 2203, Section 5.3.2.3
+ *
+ *	struct rpc_gss_priv_data {
+ *		opaque databody_priv<>
+ *	};
+ *
+ *	struct rpc_gss_data_t {
+ *		unsigned int seq_num;
+ *		proc_req_arg_t arg;
+ *	};
+ */
 static int
-unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gss_ctx *ctx)
+svcauth_gss_unwrap_priv(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq,
+			struct gss_ctx *ctx)
 {
-	u32 priv_len, maj_stat;
+	u32 len, seq_num, maj_stat;
 	int pad, remaining_len, offset;
-	u32 rseqno;
 
 	__clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
-	priv_len = svc_getnl(&buf->head[0]);
+	len = svc_getnl(&buf->head[0]);
 	if (rqstp->rq_deferred) {
 		/* Already decrypted last time through! The sequence number
 		 * check at out_seq is unnecessary but harmless: */
@@ -1012,14 +1024,14 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	 * request to the end, where head[0].iov_len is just the bytes
 	 * not yet read from the head, so these two values are different: */
 	remaining_len = total_buf_len(buf);
-	if (priv_len > remaining_len)
+	if (len > remaining_len)
 		goto unwrap_failed;
-	pad = remaining_len - priv_len;
+	pad = remaining_len - len;
 	buf->len -= pad;
 	fix_priv_head(buf, pad);
 
-	maj_stat = gss_unwrap(ctx, 0, priv_len, buf);
-	pad = priv_len - buf->len;
+	maj_stat = gss_unwrap(ctx, 0, len, buf);
+	pad = len - buf->len;
 	/* The upper layers assume the buffer is aligned on 4-byte boundaries.
 	 * In the krb5p case, at least, the data ends up offset, so we need to
 	 * move it around. */
@@ -1035,8 +1047,8 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_unwrap;
 out_seq:
-	rseqno = svc_getnl(&buf->head[0]);
-	if (rseqno != seq)
+	seq_num = svc_getnl(&buf->head[0]);
+	if (seq_num != seq)
 		goto bad_seqno;
 	return 0;
 
@@ -1044,7 +1056,7 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	trace_rpcgss_svc_unwrap_failed(rqstp);
 	return -EINVAL;
 bad_seqno:
-	trace_rpcgss_svc_seqno_bad(rqstp, seq, rseqno);
+	trace_rpcgss_svc_seqno_bad(rqstp, seq, seq_num);
 	return -EINVAL;
 bad_unwrap:
 	trace_rpcgss_svc_unwrap(rqstp, maj_stat);
@@ -1677,8 +1689,8 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 			/* placeholders for length and seq. number: */
 			svc_putnl(resv, 0);
 			svc_putnl(resv, 0);
-			if (unwrap_priv_data(rqstp, &rqstp->rq_arg,
-					gc->gc_seq, rsci->mechctx))
+			if (svcauth_gss_unwrap_priv(rqstp, &rqstp->rq_arg,
+						    gc->gc_seq, rsci->mechctx))
 				goto garbage_args;
 			rqstp->rq_auth_slack = RPC_MAX_AUTH_SIZE * 2;
 			svcxdr_init_decode(rqstp);


