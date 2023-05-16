Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269D27050A6
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjEPO0j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjEPO0i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 10:26:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E4768C
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 07:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99B4D63896
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 14:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CF9C433EF;
        Tue, 16 May 2023 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684247177;
        bh=lnqnmTBaVzJVt9DGdx6wfQxDNOI7MKFalB8LZMqtFuE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kKwtvRMr0Pe1wdbdLYYGxRDfoW70ei7ehcTgdi4xd4gJK+ppc/+ZNax8xs+14yMuK
         vG1HWRyOCHsYGUnByUCVWY3c9DHwZG65YDbbNWZhY5LEMC17560U9sm9BFAwW06n+s
         Szv1qe54g2XcpeT/OYpbQkKRqEWX/8NeuciQ8siAyu3P6zEPZ+oAL7cEE7V3PrzFE0
         qwk/7G3YIj+JVppnUgMSONcIfr+AJYif7YIMo097/z0anMd1kSlnsk96gDa4vM6wb0
         JuPRBs8a8o5+amIuQhs/Z3E/5GaMP75wFfDnFc6nBOEvfyWAqVj+oHCWYkr5xX4yuT
         CqjZwLHcmYVJQ==
Subject: [PATCH 2/2] NFSD: Replace encode_cinfo()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Tue, 16 May 2023 10:26:15 -0400
Message-ID: <168424717577.9951.14248504218559938502.stgit@manet.1015granger.net>
In-Reply-To: <168424716929.9951.1129941008353547304.stgit@manet.1015granger.net>
References: <168424716929.9951.1129941008353547304.stgit@manet.1015granger.net>
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

De-duplicate "reserve_space; encode_cinfo".

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   72 ++++++++++++++++++-----------------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1488ce978f7c..c5c6873b938d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2566,12 +2566,16 @@ static __be32 *encode_time_delta(__be32 *p, struct inode *inode)
 	return p;
 }
 
-static __be32 *encode_cinfo(__be32 *p, struct nfsd4_change_info *c)
+static __be32
+nfsd4_encode_change_info4(struct xdr_stream *xdr, struct nfsd4_change_info *c)
 {
-	*p++ = cpu_to_be32(c->atomic);
-	p = xdr_encode_hyper(p, c->before_change);
-	p = xdr_encode_hyper(p, c->after_change);
-	return p;
+	if (xdr_stream_encode_bool(xdr, c->atomic) < 0)
+		return nfserr_resource;
+	if (xdr_stream_encode_u64(xdr, c->before_change) < 0)
+		return nfserr_resource;
+	if (xdr_stream_encode_u64(xdr, c->after_change) < 0)
+		return nfserr_resource;
+	return nfs_ok;
 }
 
 /* Encode as an array of strings the string given with components
@@ -3786,12 +3790,10 @@ nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_create *create = &u->create;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, 20);
-	if (!p)
-		return nfserr_resource;
-	encode_cinfo(p, &create->cr_cinfo);
+	nfserr = nfsd4_encode_change_info4(xdr, &create->cr_cinfo);
+	if (nfserr)
+		return nfserr;
 	return nfsd4_encode_bitmap(xdr, create->cr_bmval[0],
 			create->cr_bmval[1], create->cr_bmval[2]);
 }
@@ -3909,13 +3911,8 @@ nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_link *link = &u->link;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, 20);
-	if (!p)
-		return nfserr_resource;
-	p = encode_cinfo(p, &link->li_cinfo);
-	return 0;
+	return nfsd4_encode_change_info4(xdr, &link->li_cinfo);
 }
 
 
@@ -3930,11 +3927,11 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 	nfserr = nfsd4_encode_stateid(xdr, &open->op_stateid);
 	if (nfserr)
 		return nfserr;
-	p = xdr_reserve_space(xdr, 24);
-	if (!p)
+	nfserr = nfsd4_encode_change_info4(xdr, &open->op_cinfo);
+	if (nfserr)
+		return nfserr;
+	if (xdr_stream_encode_u32(xdr, open->op_rflags) < 0)
 		return nfserr_resource;
-	p = encode_cinfo(p, &open->op_cinfo);
-	*p++ = cpu_to_be32(open->op_rflags);
 
 	nfserr = nfsd4_encode_bitmap(xdr, open->op_bmval[0], open->op_bmval[1],
 					open->op_bmval[2]);
@@ -4310,13 +4307,8 @@ nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_remove *remove = &u->remove;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, 20);
-	if (!p)
-		return nfserr_resource;
-	p = encode_cinfo(p, &remove->rm_cinfo);
-	return 0;
+	return nfsd4_encode_change_info4(xdr, &remove->rm_cinfo);
 }
 
 static __be32
@@ -4325,14 +4317,11 @@ nfsd4_encode_rename(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_rename *rename = &u->rename;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, 40);
-	if (!p)
-		return nfserr_resource;
-	p = encode_cinfo(p, &rename->rn_sinfo);
-	p = encode_cinfo(p, &rename->rn_tinfo);
-	return 0;
+	nfserr = nfsd4_encode_change_info4(xdr, &rename->rn_sinfo);
+	if (nfserr)
+		return nfserr;
+	return nfsd4_encode_change_info4(xdr, &rename->rn_tinfo);
 }
 
 static __be32
@@ -5102,15 +5091,8 @@ nfsd4_encode_setxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_setxattr *setxattr = &u->setxattr;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
-
-	p = xdr_reserve_space(xdr, 20);
-	if (!p)
-		return nfserr_resource;
 
-	encode_cinfo(p, &setxattr->setxa_cinfo);
-
-	return 0;
+	return nfsd4_encode_change_info4(xdr, &setxattr->setxa_cinfo);
 }
 
 /*
@@ -5256,14 +5238,8 @@ nfsd4_encode_removexattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_removexattr *removexattr = &u->removexattr;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, 20);
-	if (!p)
-		return nfserr_resource;
-
-	p = encode_cinfo(p, &removexattr->rmxa_cinfo);
-	return 0;
+	return nfsd4_encode_change_info4(xdr, &removexattr->rmxa_cinfo);
 }
 
 typedef __be32(*nfsd4_enc)(struct nfsd4_compoundres *, __be32, union nfsd4_op_u *u);


