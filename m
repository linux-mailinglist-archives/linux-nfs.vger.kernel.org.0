Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78A372C721
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbjFLONq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbjFLONn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:13:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC0410F3
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 07:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01B6C629B3
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 14:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF12C4339B;
        Mon, 12 Jun 2023 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579220;
        bh=waX2R5tuAZ3ZTjZvQAgFXfBb0L6qNebDCJ0stUjJHd8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Li/a4xv0j97uEyaLISr3qclKjO5ac/NhQrqq3yFHJhSTnIryKAQjuHXrFQNYiVCOF
         tweCA4K+OUeE/rPWRvjiGnnXk8x9FDhuq+RDwTN7cC3QzaOeJJwU7a8yva30QZcBRg
         JXNptryPWzZ5ezPCVYxupkq2Q/l0zvIKWdDlrR7sLmkyRG6vpC7cCLowa1e1EfXqXG
         NRBVSea65knvcjHVm3YMazzrViHxV/R436jML2CJcIoOSJjFlVB9VrQRlSMgBErLDo
         99djMiuzU9hoh6eRWqnn/lujiJod/TpzVuO5CJX736pEXMkR8r81+D634DByPBcRNl
         +ijC6E71bJj8A==
Subject: [PATCH v1 2/7] NFSD: Add an nfsd4_encode_nfstime4() helper
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 12 Jun 2023 10:13:39 -0400
Message-ID: <168657921935.5674.16164163702846685356.stgit@manet.1015granger.net>
In-Reply-To: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
References: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: de-duplicate some common code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 41234fc3b905..f3be2a6055f2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2541,6 +2541,20 @@ static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
 	return p;
 }
 
+static __be32 nfsd4_encode_nfstime4(struct xdr_stream *xdr,
+				    struct timespec64 *tv)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 3);
+	if (!p)
+		return nfserr_resource;
+
+	p = xdr_encode_hyper(p, (s64)tv->tv_sec);
+	*p = cpu_to_be32(tv->tv_nsec);
+	return nfs_ok;
+}
+
 /*
  * ctime (in NFSv4, time_metadata) is not writeable, and the client
  * doesn't really care what resolution could theoretically be stored by
@@ -3348,11 +3362,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_encode_hyper(p, dummy64);
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_ACCESS) {
-		p = xdr_reserve_space(xdr, 12);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (s64)stat.atime.tv_sec);
-		*p++ = cpu_to_be32(stat.atime.tv_nsec);
+		status = nfsd4_encode_nfstime4(xdr, &stat.atime);
+		if (status)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_DELTA) {
 		p = xdr_reserve_space(xdr, 12);
@@ -3361,25 +3373,19 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = encode_time_delta(p, d_inode(dentry));
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_METADATA) {
-		p = xdr_reserve_space(xdr, 12);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (s64)stat.ctime.tv_sec);
-		*p++ = cpu_to_be32(stat.ctime.tv_nsec);
+		status = nfsd4_encode_nfstime4(xdr, &stat.ctime);
+		if (status)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_MODIFY) {
-		p = xdr_reserve_space(xdr, 12);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (s64)stat.mtime.tv_sec);
-		*p++ = cpu_to_be32(stat.mtime.tv_nsec);
+		status = nfsd4_encode_nfstime4(xdr, &stat.mtime);
+		if (status)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
-		p = xdr_reserve_space(xdr, 12);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
-		*p++ = cpu_to_be32(stat.btime.tv_nsec);
+		status = nfsd4_encode_nfstime4(xdr, &stat.btime);
+		if (status)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
 		u64 ino = stat.ino;


