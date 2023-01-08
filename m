Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9DC6616B2
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbjAHQbU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbjAHQau (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:30:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF10DEBE
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:30:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D34360CF3
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FF8C433F0
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195447;
        bh=HMfqoBN2jjsgLZC0cOfkE8Ao3mxgv26yjkwXo5i9NOs=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=RbTB+nz7n41LxdtNgZG3ppoS4oZ3hcBnpp0YdGbvrOXrW70/rX9EmhSyn1KwOThPj
         ahVW5lqdrru1PySgbc4dbzG/LoqkmkJdGcXPJNFRuvPpIB/LFfFjtMYkoa7XQNdL7y
         PRJpyooCYXEYYkaHkzC8HHWsQd0mKdP0xqmKnn/DLHNVaGBSsZJfJl36ykYRaDsgRl
         fEmhisM1cB03P2iBdlRXPfHJemU5Zsz0cn+Oc/jJLYOMvp/1zB6Cm9exfj/Qzu3tiz
         NAto0MIvI+OdPe94S50kQ7kMXFdBt5ApZx+Rlq4SQJBFp+RLMHJIX3T2D3KaSiRhmS
         /nMlcN7ICHIsA==
Subject: [PATCH v1 23/27] SUNRPC: Final clean-up of svc_process_common()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:30:46 -0500
Message-ID: <167319544675.7490.2458325017024377410.stgit@bazille.1015granger.net>
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

The @resv parameter is no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index bcca1553c75a..bb58915622ca 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1225,7 +1225,7 @@ EXPORT_SYMBOL_GPL(svc_generic_init_request);
  * Common routine for processing the RPC request.
  */
 static int
-svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
+svc_process_common(struct svc_rqst *rqstp)
 {
 	struct xdr_stream	*xdr = &rqstp->rq_res_stream;
 	struct svc_program	*progp;
@@ -1455,7 +1455,7 @@ svc_process(struct svc_rqst *rqstp)
 	if (unlikely(*p != rpc_call))
 		goto out_baddir;
 
-	if (!svc_process_common(rqstp, resv))
+	if (!svc_process_common(rqstp))
 		goto out_drop;
 	return svc_send(rqstp);
 
@@ -1478,7 +1478,6 @@ int
 bc_svc_process(struct svc_serv *serv, struct rpc_rqst *req,
 	       struct svc_rqst *rqstp)
 {
-	struct kvec	*resv = &rqstp->rq_res.head[0];
 	struct rpc_task *task;
 	int proc_error;
 	int error;
@@ -1509,22 +1508,21 @@ bc_svc_process(struct svc_serv *serv, struct rpc_rqst *req,
 		rqstp->rq_arg.len = rqstp->rq_arg.head[0].iov_len +
 			rqstp->rq_arg.page_len;
 
-	/* reset result send buffer "put" position */
-	resv->iov_len = 0;
-
-	svcxdr_init_decode(rqstp);
+	/* Reset the response buffer */
+	rqstp->rq_res.head[0].iov_len = 0;
 
 	/*
 	 * Skip the XID and calldir fields because they've already
 	 * been processed by the caller.
 	 */
+	svcxdr_init_decode(rqstp);
 	if (!xdr_inline_decode(&rqstp->rq_arg_stream, XDR_UNIT * 2)) {
 		error = -EINVAL;
 		goto out;
 	}
 
 	/* Parse and execute the bc call */
-	proc_error = svc_process_common(rqstp, resv);
+	proc_error = svc_process_common(rqstp);
 
 	atomic_dec(&req->rq_xprt->bc_slot_count);
 	if (!proc_error) {


