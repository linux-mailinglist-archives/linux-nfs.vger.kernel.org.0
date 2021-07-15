Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6B63CAD5B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 21:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244242AbhGOT6T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 15:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344227AbhGOT4E (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Jul 2021 15:56:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2745613C0;
        Thu, 15 Jul 2021 19:52:43 +0000 (UTC)
Subject: [PATCH v2 7/7] NFS: Clean up the synopsis of callback process_op()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 15 Jul 2021 15:52:43 -0400
Message-ID: <162637876320.728653.16177467182002924598.stgit@manet.1015granger.net>
In-Reply-To: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
References: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
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
index bf0efec93da8..4c48d85f6517 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -863,17 +863,16 @@ preprocess_nfs4_op(unsigned int op_nr, struct callback_op **op)
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
 
@@ -903,9 +902,11 @@ static __be32 process_op(int nop, struct svc_rqst *rqstp,
 
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
 
@@ -914,7 +915,7 @@ static __be32 process_op(int nop, struct svc_rqst *rqstp,
 	if (unlikely(res))
 		return res;
 	if (op->encode_res != NULL && status == 0)
-		status = op->encode_res(rqstp, xdr_out, resp);
+		status = op->encode_res(rqstp, xdr_out, rqstp->rq_resp);
 	return status;
 }
 
@@ -959,9 +960,7 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 		return rpc_system_err;
 	}
 	while (status == 0 && nops != hdr_arg.nops) {
-		status = process_op(nops, rqstp, &rqstp->rq_arg_stream,
-				    rqstp->rq_argp, &rqstp->rq_res_stream,
-				    rqstp->rq_resp, &cps);
+		status = process_op(nops, rqstp, &cps);
 		nops++;
 	}
 


