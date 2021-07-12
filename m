Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8623C5E9E
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 16:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhGLOzu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 10:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235268AbhGLOzr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Jul 2021 10:55:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB11E6120A
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jul 2021 14:52:58 +0000 (UTC)
Subject: [PATCH RFC 7/7] NFS: Clean up the synopsis of callback process_op()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Jul 2021 10:52:58 -0400
Message-ID: <162610157805.2466.12384910841009517253.stgit@klimt.1015granger.net>
In-Reply-To: <162610122257.2466.7452891285800059767.stgit@klimt.1015granger.net>
References: <162610122257.2466.7452891285800059767.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The xdr_stream and rq_arg and rq_res are already accessible via the
@rqstp parameter.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback_xdr.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 19bbe8fc6cc2..6958ff1c2c29 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -854,17 +854,16 @@ preprocess_nfs4_op(unsigned int op_nr, struct callback_op **op)
 }
 
 static __be32 process_op(int nop, struct svc_rqst *rqstp,
-		struct xdr_stream *xdr_in, void *argp,
-		struct xdr_stream *xdr_out, void *resp,
-		struct cb_process_state *cps)
+			 struct cb_process_state *cps)
 {
+	struct xdr_stream *xdr_out = &rqstp->rq_res_stream;
 	struct callback_op *op = &callback_ops[0];
 	unsigned int op_nr;
 	__be32 status;
 	long maxlen;
 	__be32 res;
 
-	status = decode_op_hdr(xdr_in, &op_nr);
+	status = decode_op_hdr(&rqstp->rq_arg_stream, &op_nr);
 	if (unlikely(status))
 		return status;
 
@@ -894,9 +893,11 @@ static __be32 process_op(int nop, struct svc_rqst *rqstp,
 
 	maxlen = xdr_out->end - xdr_out->p;
 	if (maxlen > 0 && maxlen < PAGE_SIZE) {
-		status = op->decode_args(rqstp, xdr_in, argp);
+		status = op->decode_args(rqstp, &rqstp->rq_arg_stream,
+					 rqstp->rq_argp);
 		if (likely(status == 0))
-			status = op->process_op(argp, resp, cps);
+			status = op->process_op(rqstp->rq_argp, rqstp->rq_resp,
+						cps);
 	} else
 		status = htonl(NFS4ERR_RESOURCE);
 
@@ -905,7 +906,7 @@ static __be32 process_op(int nop, struct svc_rqst *rqstp,
 	if (unlikely(res))
 		return res;
 	if (op->encode_res != NULL && status == 0)
-		status = op->encode_res(rqstp, xdr_out, resp);
+		status = op->encode_res(rqstp, xdr_out, rqstp->rq_resp);
 	return status;
 }
 
@@ -950,9 +951,7 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 		return rpc_system_err;
 	}
 	while (status == 0 && nops != hdr_arg.nops) {
-		status = process_op(nops, rqstp, &rqstp->rq_arg_stream,
-				    rqstp->rq_argp,&rqstp->rq_res_stream,
-				    rqstp->rq_resp, &cps);
+		status = process_op(nops, rqstp, &cps);
 		nops++;
 	}
 


