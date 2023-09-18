Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE187A4EB8
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjIRQZh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 12:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIRQZd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 12:25:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914872547C
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 09:22:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035F5C433BA;
        Mon, 18 Sep 2023 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045428;
        bh=ivYlbbAmiVVZYNkuHJx1W3/ofNUn2OJQ7vClkjK6ed4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MNUvVqK5CT7jzFctXirM01STWlsprXNaXTwz2HollLyjpnN5spA0OVyV22qs9rIDt
         BVKre+k/EFm9sdE+BshdjnUqcycAj6cWhUPSSHGcZtnvT5nfztef2RHVS8kQcrNqHK
         k1ASifW03pu+dP2F7GqZKspNyOsbPOa2qLIzj1gNjdzmi5hFfMJXjh885uZFyvtdAx
         XvG+mme5Qdve3QvoLlppRYVCfbClXL9c+rcWE/xHuT7G9HglQmUzy18PFF6P12dBB4
         7jA7JYQcyxuJ5ucHUwcvfak+vlZ9nqGphmIjc4qeP3Lh31+ZCpGYS7uDQp6/kZwukw
         Wyp9UgIUo9ONQ==
Subject: [PATCH v1 03/52] NFSD: Clean up nfsd4_encode_setattr()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:57:07 -0400
Message-ID: <169504542705.133720.14718638463977967182.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

De-duplicate the encoding of bitmap4 results in
nfsd4_encode_setattr().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 84df0f36c15b..8715a43a70c4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4427,34 +4427,25 @@ nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return nfsd4_do_encode_secinfo(xdr, secinfo->sin_exp);
 }
 
-/*
- * The SETATTR encode routine is special -- it always encodes a bitmap,
- * regardless of the error status.
- */
 static __be32
 nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 		     union nfsd4_op_u *u)
 {
 	struct nfsd4_setattr *setattr = &u->setattr;
-	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
+	__be32 status;
 
-	p = xdr_reserve_space(xdr, 16);
-	if (!p)
-		return nfserr_resource;
-	if (nfserr) {
-		*p++ = cpu_to_be32(3);
-		*p++ = cpu_to_be32(0);
-		*p++ = cpu_to_be32(0);
-		*p++ = cpu_to_be32(0);
-	}
-	else {
-		*p++ = cpu_to_be32(3);
-		*p++ = cpu_to_be32(setattr->sa_bmval[0]);
-		*p++ = cpu_to_be32(setattr->sa_bmval[1]);
-		*p++ = cpu_to_be32(setattr->sa_bmval[2]);
+	switch (nfserr) {
+	case nfs_ok:
+		/* attrsset */
+		status = nfsd4_encode_bitmap4(resp->xdr, setattr->sa_bmval[0],
+					      setattr->sa_bmval[1],
+					      setattr->sa_bmval[2]);
+		break;
+	default:
+		/* attrsset */
+		status = nfsd4_encode_bitmap4(resp->xdr, 0, 0, 0);
 	}
-	return nfserr;
+	return status != nfs_ok ? status : nfserr;
 }
 
 static __be32


