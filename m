Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B39757E580
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 19:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiGVRZl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 13:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbiGVRZf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 13:25:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627B674DDA
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 10:25:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E841B8296E
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 17:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D116C341C7;
        Fri, 22 Jul 2022 17:25:30 +0000 (UTC)
Subject: [PATCH 1/4] SUNRPC: Fail faster on bad verifier
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 13:25:29 -0400
Message-ID: <165851072945.361126.5868156674844369539.stgit@morisot.1015granger.net>
In-Reply-To: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
References: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A bad verifier is not a garbage argument, it's an authentication
failure. Retrying it doesn't make the problem go away, and delays
upper layer recovery steps.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index b6781ada3aa8..a97d4e06cae3 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2650,7 +2650,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 
 out_verifier:
 	trace_rpc_bad_verifier(task);
-	goto out_garbage;
+	goto out_err;
 
 out_msg_denied:
 	error = -EACCES;


