Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2D3CAD5A
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 21:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244123AbhGOT6M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 15:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344214AbhGOT4E (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Jul 2021 15:56:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4A6861424;
        Thu, 15 Jul 2021 19:52:37 +0000 (UTC)
Subject: [PATCH v2 6/7] NFS: Extract the xdr_init_encode/decode() calls from
 decode_compound
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 15 Jul 2021 15:52:37 -0400
Message-ID: <162637875713.728653.6438646228241933410.stgit@manet.1015granger.net>
In-Reply-To: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
References: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Move the xdr_init_encode() and xdr_init_decode() calls
into the dispatcher, just like the NFSD and lockd dispatchers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback_xdr.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index c1d08ab1fe22..bf0efec93da8 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -925,22 +925,15 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 {
 	struct cb_compound_hdr_arg hdr_arg = { 0 };
 	struct cb_compound_hdr_res hdr_res = { NULL };
-	struct xdr_stream xdr_in, xdr_out;
-	__be32 *p, status;
 	struct cb_process_state cps = {
 		.drc_status = 0,
 		.clp = NULL,
 		.net = SVC_NET(rqstp),
 	};
 	unsigned int nops = 0;
+	__be32 status;
 
-	xdr_init_decode(&xdr_in, &rqstp->rq_arg,
-			rqstp->rq_arg.head[0].iov_base, NULL);
-
-	p = (__be32*)((char *)rqstp->rq_res.head[0].iov_base + rqstp->rq_res.head[0].iov_len);
-	xdr_init_encode(&xdr_out, &rqstp->rq_res, p, NULL);
-
-	status = decode_compound_hdr_arg(&xdr_in, &hdr_arg);
+	status = decode_compound_hdr_arg(&rqstp->rq_arg_stream, &hdr_arg);
 	if (status == htonl(NFS4ERR_RESOURCE))
 		return rpc_garbage_args;
 
@@ -960,15 +953,15 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 	cps.minorversion = hdr_arg.minorversion;
 	hdr_res.taglen = hdr_arg.taglen;
 	hdr_res.tag = hdr_arg.tag;
-	if (encode_compound_hdr_res(&xdr_out, &hdr_res) != 0) {
+	if (encode_compound_hdr_res(&rqstp->rq_res_stream, &hdr_res) != 0) {
 		if (cps.clp)
 			nfs_put_client(cps.clp);
 		return rpc_system_err;
 	}
 	while (status == 0 && nops != hdr_arg.nops) {
-		status = process_op(nops, rqstp, &xdr_in,
-				    rqstp->rq_argp, &xdr_out, rqstp->rq_resp,
-				    &cps);
+		status = process_op(nops, rqstp, &rqstp->rq_arg_stream,
+				    rqstp->rq_argp, &rqstp->rq_res_stream,
+				    rqstp->rq_resp, &cps);
 		nops++;
 	}
 
@@ -996,6 +989,9 @@ nfs_callback_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *procp = rqstp->rq_procinfo;
 
+	svcxdr_init_decode(rqstp);
+	svcxdr_init_encode(rqstp);
+
 	*statp = procp->pc_func(rqstp);
 	return 1;
 }


