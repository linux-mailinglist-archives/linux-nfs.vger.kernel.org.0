Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0433965B585
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbjABRG3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbjABRG1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:06:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F346BC0D
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:06:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF7FFB80D0A
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56946C433EF
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679183;
        bh=4I6/LBKefzd86tix22TnthzStWhxiIrUvURUVo3jCqM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Hfzpor84qj00pNe6wItEQ1EVR+JY81XfB9SMtXvwZDoRT892hoXobx6csPppZrx0M
         py3MNCAii8dHLMGWpLzL2GZ4UWdLdvxWovOk2KnUZrS9Y1UxCTgvVAhKtfa09wrB+h
         OYEMenqC0QIKRW3YC9MotPVDMBX6tSExdU4AddX2/22v/WAJgStufVt4moYltLYmcr
         dxAZM4rRkAqPTGyuudhNQV/nuRzbldK4YnBW/rWlDkBEZ6KOwYlWjfBFWQ0OvGGNzs
         UXbMTG8TZzJK2wDWKe8TEAxxG3+VOW09ICmF320u59IUerPZcV3iULZyfrBEkKgHsP
         uXNiwcUx4OepQ==
Subject: [PATCH v1 09/25] SUNRPC: Remove gss_read_common_verf()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:06:22 -0500
Message-ID: <167267918226.112521.11833238713971258862.stgit@manet.1015granger.net>
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

gss_read_common_verf() is now just a wrapper for dup_netobj(), thus
it can be replaced with direct calls to dup_netobj().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index ba32c05f0258..5da4a3d48a7d 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1090,18 +1090,6 @@ gss_write_init_verf(struct cache_detail *cd, struct svc_rqst *rqstp,
 	return rc;
 }
 
-static inline int
-gss_read_common_verf(struct rpc_gss_wire_cred *gc,
-		     struct kvec *argv, __be32 *authp,
-		     struct xdr_netobj *in_handle)
-{
-	if (dup_netobj(in_handle, &gc->gc_ctx))
-		return SVC_CLOSE;
-	*authp = rpc_autherr_badverf;
-
-	return 0;
-}
-
 static inline int
 gss_read_verf(struct rpc_gss_wire_cred *gc,
 	      struct kvec *argv, __be32 *authp,
@@ -1109,12 +1097,9 @@ gss_read_verf(struct rpc_gss_wire_cred *gc,
 	      struct xdr_netobj *in_token)
 {
 	struct xdr_netobj tmpobj;
-	int res;
-
-	res = gss_read_common_verf(gc, argv, authp, in_handle);
-	if (res)
-		return res;
 
+	if (dup_netobj(in_handle, &gc->gc_ctx))
+		return SVC_CLOSE;
 	if (svc_safe_getnetobj(argv, &tmpobj)) {
 		kfree(in_handle->data);
 		return SVC_DENIED;
@@ -1151,12 +1136,11 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 {
 	struct kvec *argv = &rqstp->rq_arg.head[0];
 	unsigned int length, pgto_offs, pgfrom_offs;
-	int pages, i, res, pgto, pgfrom;
 	size_t inlen, to_offs, from_offs;
+	int pages, i, pgto, pgfrom;
 
-	res = gss_read_common_verf(gc, argv, &rqstp->rq_auth_stat, in_handle);
-	if (res)
-		return res;
+	if (dup_netobj(in_handle, &gc->gc_ctx))
+		return SVC_CLOSE;
 
 	inlen = svc_getnl(argv);
 	if (inlen > (argv->iov_len + rqstp->rq_arg.page_len)) {


