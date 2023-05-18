Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE18708722
	for <lists+linux-nfs@lfdr.de>; Thu, 18 May 2023 19:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjERRqG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 May 2023 13:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjERRqA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 May 2023 13:46:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DCF10EF
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 10:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06CAA65151
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 17:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176EDC433EF;
        Thu, 18 May 2023 17:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684431951;
        bh=NVWxOt6L9hNhW548s723r+uCh1QTojidjmChOQNlhwo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qLct4iaZlIVvdaoySmz1z1N32dqEX5nHoRH4gLJXkG1/zkKOq+sOja5cg3xyqvFFo
         PBmySo7CwPFxSIM8r636HeOb5cIPeOukecgRqPVRJzCSE7h/AEvjbISWXin8c8cQIp
         yAIqiVId5Uw7lsvq3aJ70YKz6fErAwYp3AM7kCyh1iTRwWBCxb0XUcU6MRRSbPk/vq
         e9uIUpjw5mTJnWE6vo0nU6MEDaAGitYSExdhN9Hd9KW8LoZQmgFId79Y3BLE8p1tNs
         UBvZ4TdWQz0Wrc+/Q9l3iF+msNlrsQVijd/ici8a4iK4QapDwIYZoeP0wVIoxHA+rg
         JuuWqc2fItXgw==
Subject: [PATCH v1 3/6] NFSD: Update rq_next_page between COMPOUND operations
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, dhowells@redhat.com, jlayton@redhat.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Thu, 18 May 2023 13:45:50 -0400
Message-ID: <168443195015.516083.14011811574141137830.stgit@klimt.1015granger.net>
In-Reply-To: <168443154055.516083.746756240848084451.stgit@klimt.1015granger.net>
References: <168443154055.516083.746756240848084451.stgit@klimt.1015granger.net>
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

A GETATTR with a large result can advance xdr->page_ptr without
updating rq_next_page. If a splice READ follows that GETATTR in the
COMPOUND, nfsd_splice_actor can start splicing at the wrong page.

I've also seen READLINK and READDIR leave rq_next_page in an
unmodified state.

There are potentially a myriad of combinations like this, so play it
safe: move the rq_next_page update to nfsd4_encode_operation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 0368e0902146..23dd09c4b2cd 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5439,6 +5439,12 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 release:
 	if (opdesc && opdesc->op_release)
 		opdesc->op_release(&op->u);
+
+	/*
+	 * Account for pages consumed while encoding this operation.
+	 * The xdr_stream primitives don't manage rq_next_page.
+	 */
+	rqstp->rq_next_page = xdr->page_ptr + 1;
 }
 
 /* 
@@ -5507,9 +5513,6 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	p = resp->statusp;
 
 	*p++ = resp->cstate.status;
-
-	rqstp->rq_next_page = xdr->page_ptr + 1;
-
 	*p++ = htonl(resp->taglen);
 	memcpy(p, resp->tag, resp->taglen);
 	p += XDR_QUADLEN(resp->taglen);


