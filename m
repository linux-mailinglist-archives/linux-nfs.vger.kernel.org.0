Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474CA65B58A
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbjABRHA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbjABRGu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:06:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B0A64DB
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:06:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE0BB60018
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35BEC433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679209;
        bh=dv543Dm686lFX77LDp0TFK/tfOPsFuv9CFqys/DdcZE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=oZxYvzA8y6I4FRxlpQRvE/dxRgk2wjOUgyDGU7bZ6gCgsER/jHd9ykec+wO4fYCut
         Gi+GTpFF0P40zheH8N05qK/nu7K8ZFmhqeMdyk0SCbRrHgpB422WzD6Tyn96f/rVsm
         qVXfJm4l2B305iVxySdUC/Eb/F82vYOnzJKePILMOTE4xQ9ptDPaWUkLdf6aCDMcA3
         QsvsvbqTJ2OHPTA+TESRLsztwZZq6Bszjf74jKWfEMY5u12vFS4Zh+FeA/REilZFmE
         jGNsrQUgE9km0/EAWRBosZX8t3TqpCjhkfFxpLyZ3WZP0CLpFiw8/71cTXNwz/wg96
         LhPSPuab8dqDg==
Subject: [PATCH v1 13/25] SUNRPC: Rename automatic variables in
 unwrap_integ_data()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:06:47 -0500
Message-ID: <167267920790.112521.11075870107567104552.stgit@manet.1015granger.net>
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

For readability, I'm also going to rename the unwrap and wrap
functions in a consistent manner, starting with unwrap_integ_data().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   57 +++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 0f9700c86f62..33fe307372d0 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -891,18 +891,27 @@ svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name)
 }
 EXPORT_SYMBOL_GPL(svcauth_gss_register_pseudoflavor);
 
-/* It would be nice if this bit of code could be shared with the client.
- * Obstacles:
- *	The client shouldn't malloc(), would have to pass in own memory.
- *	The server uses base of head iovec as read pointer, while the
- *	client uses separate pointer. */
+/*
+ * RFC 2203, Section 5.3.2.2
+ *
+ *	struct rpc_gss_integ_data {
+ *		opaque databody_integ<>;
+ *		opaque checksum<>;
+ *	};
+ *
+ *	struct rpc_gss_data_t {
+ *		unsigned int seq_num;
+ *		proc_req_arg_t arg;
+ *	};
+ */
 static int
-unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gss_ctx *ctx)
+svcauth_gss_unwrap_integ(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq,
+			 struct gss_ctx *ctx)
 {
 	struct gss_svc_data *gsd = rqstp->rq_auth_data;
-	u32 integ_len, rseqno, maj_stat;
-	struct xdr_netobj mic;
-	struct xdr_buf integ_buf;
+	struct xdr_buf databody_integ;
+	u32 len, seq_num, maj_stat;
+	struct xdr_netobj checksum;
 
 	/* NFS READ normally uses splice to send data in-place. However
 	 * the data in cache can change after the reply's MIC is computed
@@ -916,36 +925,36 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct g
 	if (rqstp->rq_deferred)
 		return 0;
 
-	integ_len = svc_getnl(&buf->head[0]);
-	if (integ_len & 3)
+	len = svc_getnl(&buf->head[0]);
+	if (len & 3)
 		goto unwrap_failed;
-	if (integ_len > buf->len)
+	if (len > buf->len)
 		goto unwrap_failed;
-	if (xdr_buf_subsegment(buf, &integ_buf, 0, integ_len))
+	if (xdr_buf_subsegment(buf, &databody_integ, 0, len))
 		goto unwrap_failed;
 
-	if (xdr_decode_word(buf, integ_len, &mic.len))
+	if (xdr_decode_word(buf, len, &checksum.len))
 		goto unwrap_failed;
-	if (mic.len > sizeof(gsd->gsd_scratch))
+	if (checksum.len > sizeof(gsd->gsd_scratch))
 		goto unwrap_failed;
-	mic.data = gsd->gsd_scratch;
-	if (read_bytes_from_xdr_buf(buf, integ_len + 4, mic.data, mic.len))
+	checksum.data = gsd->gsd_scratch;
+	if (read_bytes_from_xdr_buf(buf, len + 4, checksum.data, checksum.len))
 		goto unwrap_failed;
-	maj_stat = gss_verify_mic(ctx, &integ_buf, &mic);
+	maj_stat = gss_verify_mic(ctx, &databody_integ, &checksum);
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_mic;
-	rseqno = svc_getnl(&buf->head[0]);
-	if (rseqno != seq)
+	seq_num = svc_getnl(&buf->head[0]);
+	if (seq_num != seq)
 		goto bad_seqno;
 	/* trim off the mic and padding at the end before returning */
-	xdr_buf_trim(buf, round_up_to_quad(mic.len) + 4);
+	xdr_buf_trim(buf, round_up_to_quad(checksum.len) + 4);
 	return 0;
 
 unwrap_failed:
 	trace_rpcgss_svc_unwrap_failed(rqstp);
 	return -EINVAL;
 bad_seqno:
-	trace_rpcgss_svc_seqno_bad(rqstp, seq, rseqno);
+	trace_rpcgss_svc_seqno_bad(rqstp, seq, seq_num);
 	return -EINVAL;
 bad_mic:
 	trace_rpcgss_svc_mic(rqstp, maj_stat);
@@ -1643,8 +1652,8 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 			/* placeholders for length and seq. number: */
 			svc_putnl(resv, 0);
 			svc_putnl(resv, 0);
-			if (unwrap_integ_data(rqstp, &rqstp->rq_arg,
-					gc->gc_seq, rsci->mechctx))
+			if (svcauth_gss_unwrap_integ(rqstp, &rqstp->rq_arg,
+						     gc->gc_seq, rsci->mechctx))
 				goto garbage_args;
 			rqstp->rq_auth_slack = RPC_MAX_AUTH_SIZE;
 			svcxdr_init_decode(rqstp);


