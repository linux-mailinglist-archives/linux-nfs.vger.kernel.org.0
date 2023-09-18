Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9FC7A4EBE
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 18:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjIRQZx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 12:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjIRQZh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 12:25:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E47925AC0
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 09:22:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D664CC433BD;
        Mon, 18 Sep 2023 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045441;
        bh=R55ntVJtfkDGm/0y9Z3qEMOVfy5bp/uRB+n3N+bC5Zg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ixXEchfWn1Mq+ThHK16YFXR/5ak3yQwZ2o0xA683i2RKghUn/hvud8m271WvnV6/G
         YX9D3jTFM/ZJ9zIu3nxfD3HvrCF/wCgs6FdWFoJOXdXgGGgfVmRB0hn/LKxWOu+8XU
         68pXgR7BqgKHIezpo//Fzwz7om1cqnerC5qUiWLDbBqCPkB/omwVypULfiu6XnBOrm
         3jK906n3cF75ORl8TG+zJuuxCdp2k+71dYGXJf1VpGL4WuER/luOvuHhxI7Mr3ad89
         VOEjyTPjyZ2/PQCaopdovTk/q3LhTR5dxreWQBaLzUPwueaNCeee6irsNRIKeL3TTe
         L4UoAghAg67aA==
Subject: [PATCH v1 05/52] NFSD: Add nfsd4_encode_fattr4__true()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:57:19 -0400
Message-ID: <169504543984.133720.6869405794264080605.stgit@manet.1015granger.net>
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

Add an encoding helper that encodes a single boolean "true" value.
Attributes that always return "true" can use this helper.

In a subsequent patch, this helper will be called from a bitmask
loop, so it is given a standardized synopsis.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   55 ++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 85466b959c51..ba07e97c206b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2947,6 +2947,12 @@ struct nfsd4_fattr_args {
 	bool			contextsupport;
 };
 
+static __be32 nfsd4_encode_fattr4__true(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_bool(xdr, true);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3128,16 +3134,14 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_encode_hyper(p, args.stat.size);
 	}
 	if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
+		status = nfsd4_encode_fattr4__true(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_SYMLINK_SUPPORT) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
+		status = nfsd4_encode_fattr4__true(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_NAMED_ATTR) {
 		p = xdr_reserve_space(xdr, 4);
@@ -3225,10 +3229,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			ACL4_SUPPORT_ALLOW_ACL|ACL4_SUPPORT_DENY_ACL : 0);
 	}
 	if (bmval0 & FATTR4_WORD0_CANSETTIME) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
+		status = nfsd4_encode_fattr4__true(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_CASE_INSENSITIVE) {
 		p = xdr_reserve_space(xdr, 4);
@@ -3237,16 +3240,14 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		*p++ = cpu_to_be32(0);
 	}
 	if (bmval0 & FATTR4_WORD0_CASE_PRESERVING) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
+		status = nfsd4_encode_fattr4__true(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_CHOWN_RESTRICTED) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
+		status = nfsd4_encode_fattr4__true(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FILEHANDLE) {
 		p = xdr_reserve_space(xdr, args.fhp->fh_handle.fh_size + 4);
@@ -3285,10 +3286,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_HOMOGENEOUS) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
+		status = nfsd4_encode_fattr4__true(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_MAXFILESIZE) {
 		p = xdr_reserve_space(xdr, 8);
@@ -3327,10 +3327,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		*p++ = cpu_to_be32(args.stat.mode & S_IALLUGO);
 	}
 	if (bmval1 & FATTR4_WORD1_NO_TRUNC) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
+		status = nfsd4_encode_fattr4__true(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_NUMLINKS) {
 		p = xdr_reserve_space(xdr, 4);


