Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9D7A4BD5
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjIRPWq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbjIRPWp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:22:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DA02707
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:18:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C4FC43142;
        Mon, 18 Sep 2023 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045485;
        bh=kNaL5e8aaD0GTwAKDAPTJ9K7nCrPYuoVxT9Pmw/x1TI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ssgJi9DY6Ww5dFkndPBe2rE872DWybkcApuMPKEHgUOPkUMm5SX4Oyqjn+0MQsCBP
         fwSrtmXZQ/Grgwo9Riz2MniKT5NrK2p/ib+yNpzG+2u8rCIQx+YuoPmDs5EDfiVlh5
         aSWsT3VzBzfbhl3dWazVZr3DHGbJwNv6bihip5J5f9x/XCC28Zk+UmB1BiSO0Bz4+Z
         ove3RG7JMWCeFWsBiLq1kNTNrqrt++1YzVCrJZdUUAVy1w3UOWlylSmlAW83kGHo0x
         hmz62TFXIqSnpKTg1NgM5e1AIMD9Dk1zrgAW111aX4mHX5fTAfVo5dq0HcZQWJhMqd
         TRHUDSzJre00w==
Subject: [PATCH v1 12/52] NFSD: Add nfsd4_encode_fattr4_fsid()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:58:04 -0400
Message-ID: <169504548451.133720.15494194051885617338.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_FSID into a helper. In a subsequent
patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   58 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 601b3a0e61d4..b41bc1b0c12c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3030,6 +3030,39 @@ static __be32 nfsd4_encode_fattr4_size(struct xdr_stream *xdr,
 	return nfsd4_encode_uint64_t(xdr, args->stat.size);
 }
 
+static __be32 nfsd4_encode_fattr4_fsid(struct xdr_stream *xdr,
+				       const struct nfsd4_fattr_args *args)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 2 + XDR_UNIT * 2);
+	if (!p)
+		return nfserr_resource;
+
+	if (unlikely(args->exp->ex_fslocs.migrated)) {
+		p = xdr_encode_hyper(p, NFS4_REFERRAL_FSID_MAJOR);
+		xdr_encode_hyper(p, NFS4_REFERRAL_FSID_MINOR);
+		return nfs_ok;
+	}
+	switch (fsid_source(args->fhp)) {
+	case FSIDSOURCE_FSID:
+		p = xdr_encode_hyper(p, (u64)args->exp->ex_fsid);
+		xdr_encode_hyper(p, (u64)0);
+		break;
+	case FSIDSOURCE_DEV:
+		*p++ = xdr_zero;
+		*p++ = cpu_to_be32(MAJOR(args->stat.dev));
+		*p++ = xdr_zero;
+		*p   = cpu_to_be32(MINOR(args->stat.dev));
+		break;
+	case FSIDSOURCE_UUID:
+		xdr_encode_opaque_fixed(p, args->exp->ex_uuid, EX_UUID_LEN);
+		break;
+	}
+
+	return nfs_ok;
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3195,28 +3228,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FSID) {
-		p = xdr_reserve_space(xdr, 16);
-		if (!p)
-			goto out_resource;
-		if (exp->ex_fslocs.migrated) {
-			p = xdr_encode_hyper(p, NFS4_REFERRAL_FSID_MAJOR);
-			p = xdr_encode_hyper(p, NFS4_REFERRAL_FSID_MINOR);
-		} else switch (fsid_source(args.fhp)) {
-		case FSIDSOURCE_FSID:
-			p = xdr_encode_hyper(p, (u64)exp->ex_fsid);
-			p = xdr_encode_hyper(p, (u64)0);
-			break;
-		case FSIDSOURCE_DEV:
-			*p++ = cpu_to_be32(0);
-			*p++ = cpu_to_be32(MAJOR(args.stat.dev));
-			*p++ = cpu_to_be32(0);
-			*p++ = cpu_to_be32(MINOR(args.stat.dev));
-			break;
-		case FSIDSOURCE_UUID:
-			p = xdr_encode_opaque_fixed(p, exp->ex_uuid,
-								EX_UUID_LEN);
-			break;
-		}
+		status = nfsd4_encode_fattr4_fsid(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_UNIQUE_HANDLES) {
 		status = nfsd4_encode_fattr4__false(xdr, &args);


