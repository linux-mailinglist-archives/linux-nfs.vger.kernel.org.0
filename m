Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE80D65B592
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjABRHo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbjABRHn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:07:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE05BC07
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:07:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BF8A6104A
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7226EC433EF
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679260;
        bh=OHI7TRP6rMXxItmY2Et8GmzZ5dWgzhR7EGu4B9SjHuI=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=SV742pACtWCBCxT4Yao3+gp6q2a7oEuY0JlOE8yJSIlZ6pX7UJRpIvYe4EKp0ZyRo
         ooEZmhVO5ec3vzc6ulp78RSuwtZIEI44jW9aOBfx1+9J1ET9O1URXRJxPrBGjW2ewh
         pYG3Z2JDIxxhXO+h39p7L0aYnf33Rvbuk/AxuCkPoeAdZfhmeR5/4YpIpL1HdD4CTp
         zQ+fPvVT/aJbWrq6+DkF6KVID2kbtGh5aiVGBnY5a7ORo3ek8omE8ZNz7AH6QiRZLD
         2eb5RQxW+4Gr6JemeF3v4cjSP2Z4qWLQY0/iknqB8Hf87qvdjIe83VlWnLBHG8F0cB
         ALhEzIrbxgFbw==
Subject: [PATCH v1 21/25] SUNRPC: Re-order construction of the first reply
 fields
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:07:39 -0500
Message-ID: <167267925935.112521.11777990967352048147.stgit@manet.1015granger.net>
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

Clean up: Group these together for legibility.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e4f8a177763e..e473c19b2f8d 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1248,19 +1248,15 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	__set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
 	__clear_bit(RQ_DROPME, &rqstp->rq_flags);
 
+	/* Construct the first words of the reply: */
 	svc_putu32(resv, rqstp->rq_xid);
+	svc_putnl(resv, RPC_REPLY);
+	reply_statp = resv->iov_base + resv->iov_len;
 
 	vers = svc_getnl(argv);
-
-	/* First words of reply: */
-	svc_putnl(resv, 1);		/* REPLY */
-
 	if (vers != 2)		/* RPC version number */
 		goto err_bad_rpc;
 
-	/* Save position in case we later decide to reject: */
-	reply_statp = resv->iov_base + resv->iov_len;
-
 	svc_putnl(resv, 0);		/* ACCEPT */
 
 	rqstp->rq_prog = prog = svc_getnl(argv);	/* program number */


