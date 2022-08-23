Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0B959EDDF
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Aug 2022 23:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiHWVAe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Aug 2022 17:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiHWVAb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Aug 2022 17:00:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324987963F
        for <linux-nfs@vger.kernel.org>; Tue, 23 Aug 2022 14:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E40D8B81F3B
        for <linux-nfs@vger.kernel.org>; Tue, 23 Aug 2022 21:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC05C433D6;
        Tue, 23 Aug 2022 21:00:27 +0000 (UTC)
Subject: [PATCH v1 4/7] lockd: Check for junk after RPC Call messages
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Aug 2022 17:00:26 -0400
Message-ID: <166128842661.2788.12824170997837980965.stgit@manet.1015granger.net>
In-Reply-To: <166128840714.2788.7887913547062461761.stgit@manet.1015granger.net>
References: <166128840714.2788.7887913547062461761.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The current RPC server code allows incoming RPC messages up to about
a megabyte in size. For TCP, this is based on the size value
contained in the RPC record marker.

Currently, lockd ignores anything in the message that is past the end
of the encoded RPC Call message. A very large RPC message can arrive
with just an NLM LOCK operation in it, and lockd ignores the rest of
the message until the next RPC fragment in the TCP stream.

That ignored data still consumes pages in the svc_rqst's page array,
however. The current arrangement is that each svc_rqst gets about
260 pages, assuming that all supported NLM operations will never
require more than a total of 260 pages to decode a Call message
and construct its corresponding Reply message.

A clever attacker can add garbage at the end of an RPC Call message.
At the least, it can result in a short or empty NLM result.

So, let's teach lockd to look for such shenanigans and reject any
Call where the incoming RPC frame has content remaining in the
receive buffer after lockd has decoded the Call arguments.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 59ef8a1f843f..80b3f1a006f6 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -694,9 +694,12 @@ module_exit(exit_nlm);
 static int nlmsvc_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *procp = rqstp->rq_procinfo;
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 
 	svcxdr_init_decode(rqstp);
-	if (!procp->pc_decode(rqstp, &rqstp->rq_arg_stream))
+	if (!procp->pc_decode(rqstp, xdr))
+		goto out_decode_err;
+	if (xdr_stream_remaining(xdr))
 		goto out_decode_err;
 
 	*statp = procp->pc_func(rqstp);


