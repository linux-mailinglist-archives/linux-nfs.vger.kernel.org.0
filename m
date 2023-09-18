Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DD47A4C14
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjIRP0J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjIRP0I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:26:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95D310E4
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:24:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8538C116A1;
        Mon, 18 Sep 2023 13:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045492;
        bh=4bX28rcLfTjwMKcweUPIz9tfBG6eDRYjCDjZfyqCq/U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ddPkljgvAQfgdKGJuja+8Jm5rUK90RcNb4VMy3kZKUEicnL9eoKc9WlzNTa4NY5Ur
         bAKo8RuFT+WldHVtysDkZZdu1Y9LZpnHP7UPTHNKFqIBPsXd1i0ehg5fMT5TklDZR8
         zqglvtl+c0b6ronGcEjHJtTUjwAMCSqA4g0DNVxbCl0BEE1mU+FFFS743Z8XmfRPLy
         ONg5inEICDo86qF4lFdFJIZ3ZQO5NUUTqcRj+KwYyDBZy5eNAW1+Mr44TSZ5ieuV2l
         md2ke0v61FL1LEkoPTcz01ptQyyyCFoxWTyfYl+uFcJ/cmRpYRnoo6BrwZ4DG/X6i/
         vmy5JUtsqMEzg==
Subject: [PATCH v1 13/52] NFSD: Add nfsd4_encode_fattr4_lease_time()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:58:10 -0400
Message-ID: <169504549092.133720.11655987019526283395.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_LEASE_TIME into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   16 +++++++++++-----
 fs/nfsd/xdr4.h    |    2 ++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b41bc1b0c12c..15a07f7d9b38 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3063,6 +3063,14 @@ static __be32 nfsd4_encode_fattr4_fsid(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_encode_fattr4_lease_time(struct xdr_stream *xdr,
+					     const struct nfsd4_fattr_args *args)
+{
+	struct nfsd_net *nn = net_generic(SVC_NET(args->rqstp), nfsd_net_id);
+
+	return nfsd4_encode_nfs_lease4(xdr, nn->nfsd4_lease);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3094,7 +3102,6 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		.mnt	= exp->ex_path.mnt,
 		.dentry	= dentry,
 	};
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 	BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
 	BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
@@ -3238,10 +3245,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_LEASE_TIME) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(nn->nfsd4_lease);
+		status = nfsd4_encode_fattr4_lease_time(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_RDATTR_ERROR) {
 		p = xdr_reserve_space(xdr, 4);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index d6059b0549f5..488ecdacc4c6 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -90,6 +90,8 @@ nfsd4_encode_uint32_t(struct xdr_stream *xdr, u32 val)
 	return nfs_ok;
 }
 
+#define nfsd4_encode_nfs_lease4(x, v)	nfsd4_encode_uint32_t(x, v)
+
 /**
  * nfsd4_encode_uint64_t - Encode an XDR uint64_t type result
  * @xdr: target XDR stream


