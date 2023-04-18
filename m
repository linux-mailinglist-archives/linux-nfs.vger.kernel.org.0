Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAE16E5763
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 04:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjDRCPc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Apr 2023 22:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDRCPb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Apr 2023 22:15:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC164198C
        for <linux-nfs@vger.kernel.org>; Mon, 17 Apr 2023 19:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88E2761001
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 02:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D95C433EF
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 02:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681784130;
        bh=74qQ/dF4HU7lvocEDz3TVqiMrSgxsgB+zW6ARn6mmFo=;
        h=Subject:From:To:Date:From;
        b=tsmGkZmOhkCXhpyJzbDs3fhghiRTl1p35+WkcJayhH9xdXyS6W1uER1mZ/KjeCol7
         O+VXmY+BLBKYqilthFDl85m1SNb2LjX1gTbJ5fUUazkmg9ZWyRHGCVz8hFyD/Owwxz
         TXC6tRfoqiW2/qC3Kcz5r5LJwts12KY/nYISboSuLP9Kudg5V++ReZaAr5F+CRlm3W
         hRb9bSs7q2m2KKPQcGm47L68RIqZuPX6k3xX9VfGINqfDekKI/CiLZlQLA0622HIo1
         BD0Nk5cW8AM4X6o+TKV9sykHJPWlKlO0VL2sOyxutuGXDw9FnNvVUyHetHmv4JeAvo
         XOG2BgfFx81/w==
Subject: [PATCH] SUNRPC: Clear rq_xid when receiving a new RPC Call
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 17 Apr 2023 22:15:28 -0400
Message-ID: <168178412883.8769.9296327350018086805.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

This is an eye-catcher for tracepoints that record the XID: it means
the svc_rqst has not received a full RPC Call with an XID yet.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index e3952b690f54..3b9708b39e35 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -701,6 +701,8 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 	arg->page_len = (pages-2)*PAGE_SIZE;
 	arg->len = (pages-1)*PAGE_SIZE;
 	arg->tail[0].iov_len = 0;
+
+	rqstp->rq_xid = xdr_zero;
 	return 0;
 }
 


