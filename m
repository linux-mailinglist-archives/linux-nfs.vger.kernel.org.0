Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF257A4BD1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbjIRPWW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbjIRPWU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:22:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9449226BA
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:20:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF54C116A0;
        Mon, 18 Sep 2023 13:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045504;
        bh=XvaHvfQJlyRNh/aVDspmx5wQA7m0ZtMKN0EboRwQ8Fc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uA8Qt7uK2STwN2BRcBpK6KysAHLLQLkI3jDMqr3v9POktG7RzJRe2cb6w67zcS0QU
         LVwqcHZFVqFL7E9WqRBef/PTEVMWCsmHg/TvAF3SWF8yruy+kgWCNG+JzDkqu8qiTi
         FapFmH0gjPyTlTDQH0I6thAVNR8yBDm7oWXZeoUf3w+5nWZZnX5W4KKbx7uWwGr16j
         gTOU4kSit5VtzV1TbttO605S9RpAvZ0gSCsdaMCgmthybRRkIhQ3j4GJvm51GAtuPW
         JSSgMwLMYnCrGkrowHHU7b/4XWrf6WRY4muGCZwTxcrJJujwQVzcEtdlmjO6hsTj7I
         tB7+7JvMvNEGQ==
Subject: [PATCH v1 15/52] NFSD: Add nfsd4_encode_fattr4_aclsupport()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:58:23 -0400
Message-ID: <169504550370.133720.16652934537928090407.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Refactor the encoder for FATTR4_ACLSUPPORT into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c67b5d942390..6604763bd96c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3077,6 +3077,17 @@ static __be32 nfsd4_encode_fattr4_rdattr_error(struct xdr_stream *xdr,
 	return nfsd4_encode_uint32_t(xdr, args->rdattr_err);
 }
 
+static __be32 nfsd4_encode_fattr4_aclsupport(struct xdr_stream *xdr,
+					     const struct nfsd4_fattr_args *args)
+{
+	u32 mask;
+
+	mask = 0;
+	if (IS_POSIXACL(d_inode(args->dentry)))
+		mask = ACL4_SUPPORT_ALLOW_ACL | ACL4_SUPPORT_DENY_ACL;
+	return nfsd4_encode_uint32_t(xdr, mask);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3291,11 +3302,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 out_acl:
 	if (bmval0 & FATTR4_WORD0_ACLSUPPORT) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(IS_POSIXACL(dentry->d_inode) ?
-			ACL4_SUPPORT_ALLOW_ACL|ACL4_SUPPORT_DENY_ACL : 0);
+		status = nfsd4_encode_fattr4_aclsupport(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_CANSETTIME) {
 		status = nfsd4_encode_fattr4__true(xdr, &args);


