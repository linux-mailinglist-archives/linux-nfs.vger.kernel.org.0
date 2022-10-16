Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6A66000DC
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Oct 2022 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJPPrH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Oct 2022 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJPPrF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Oct 2022 11:47:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D572C657
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 08:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03BCB60C05
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 15:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D119C433D6
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 15:47:03 +0000 (UTC)
Subject: [PATCH 1 2/3] NFSD: Finish converting the NFSv2 GETACL result encoder
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 16 Oct 2022 11:47:02 -0400
Message-ID: <166593522241.1710.1607659813797998942.stgit@klimt.1015granger.net>
In-Reply-To: <166593521604.1710.10648202421284171508.stgit@klimt.1015granger.net>
References: <166593521604.1710.10648202421284171508.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
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

The xdr_stream conversion inadvertently left some code that set the
page_len of the send buffer. The XDR stream encoders should handle
this automatically now.

This oversight adds garbage past the end of the Reply message.
Clients typically ignore the garbage, but NFSD does not need to send
it, as it leaks stale memory contents onto the wire.

Fixes: f8cba47344f7 ("NFSD: Update the NFSv2 GETACL result encoder to use struct xdr_stream")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs2acl.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 9edd3c1a30fb..87f224cd30a8 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -246,7 +246,6 @@ nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
 	struct dentry *dentry = resp->fh.fh_dentry;
 	struct inode *inode;
-	int w;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
 		return false;
@@ -260,15 +259,6 @@ nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	if (xdr_stream_encode_u32(xdr, resp->mask) < 0)
 		return false;
 
-	rqstp->rq_res.page_len = w = nfsacl_size(
-		(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
-		(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
-	while (w > 0) {
-		if (!*(rqstp->rq_next_page++))
-			return true;
-		w -= PAGE_SIZE;
-	}
-
 	if (!nfs_stream_encode_acl(xdr, inode, resp->acl_access,
 				   resp->mask & NFS_ACL, 0))
 		return false;


