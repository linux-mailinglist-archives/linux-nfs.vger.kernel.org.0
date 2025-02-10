Return-Path: <linux-nfs+bounces-10021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57483A2F48A
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 18:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0169D162F62
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104A424BD1C;
	Mon, 10 Feb 2025 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeHXhhT6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027925757
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207016; cv=none; b=U1VfpJ6X4Z4v//ABQHjyZlOJRPUe95ccY3pLr/7rcY2Fh/mTXayVxN3brGYfroqFFjwetKunI1ojD9zNZpAxy4IThUEH7P8AqDkf2g0aix3KaEFiC001mdDixsYjJVJ61iSIrpDmVzVR5knUKSdiCWJYTh+XSn714Xb/4wBmJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207016; c=relaxed/simple;
	bh=hSZPa4npKOaFvp+ZXKaYPUxtJYWTUC/5wYr37+ARTiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1G0qZQZpDQU/a/XQx2zqg1CEzI1/BZceuRpkFNuu9IgyR4WxVbtVCQXvLhe0y9lGFk9OI96EKsw/GEUpQgW62CRClM+Kcww7agWTFs5ZE2dnu+k9Jaty9afHgZTm3t2ozNBUSRHH/8xbRp/I4ulRuCohjL/rizC8X9d1sKt2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeHXhhT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A4DC4CED1;
	Mon, 10 Feb 2025 17:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739207015;
	bh=hSZPa4npKOaFvp+ZXKaYPUxtJYWTUC/5wYr37+ARTiQ=;
	h=From:To:Cc:Subject:Date:From;
	b=CeHXhhT6VgxN3+uVqUCtw264grMXjPLMjqslNkEzXBenJhN6MMYa6TMaOLdLPaPd1
	 lmfQ7ckS1vR0FwGir8yswVYj/tV8AdYAqz2cL9bGrGwaC33FFqHBxYY8pjRz2ExX6R
	 9CdhGh4c1utnnalkntqMvFAOebcuqCxSIgRFo4NaDTESx0Dn3gWGWEa8hItxhnFtNp
	 VRsSPqPiYzZi9psgGedspPsPWdmb/flIVLh8DESbztEQrMWKFxcEw+zJTjIwrv6Dj6
	 9eJ1HwKsgwjwRs5EiO23fXQYN7aui5CCw8EAuKClnm7ZGn02Sf75cndBCmfixG7jq5
	 T1bK50diONJng==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] NFSD: Fix callback decoder status codes
Date: Mon, 10 Feb 2025 12:03:32 -0500
Message-ID: <20250210170332.115051-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

fs/nfsd/nfs4callback.c implements a callback client. Thus its XDR
decoders are decoding replies, not calls.

NFS4ERR_BAD_XDR is an on-the-wire status code that reports that the
client sent a corrupted RPC /call/. It's not used as the internal
error code when a /reply/ can't be decoded, since that kind of
failure is never reported to the sender of that RPC message.

Instead, a reply decoder should return -EIO, as the reply decoders
in the NFS client do.

Fixes: 6487a13b5c6b ("NFSD: add support for CB_GETATTR callback")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

This is only compile-tested, but I'm thinking of throwing this on
the "for v6.15" pile.


diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 961b1defcb1a..ae4b7b6df47f 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -101,15 +101,15 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
 
 	if (bitmap[0] & FATTR4_WORD0_CHANGE)
 		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_change) < 0)
-			return -NFSERR_BAD_XDR;
+			return -EIO;
 	if (bitmap[0] & FATTR4_WORD0_SIZE)
 		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_fsize) < 0)
-			return -NFSERR_BAD_XDR;
+			return -EIO;
 	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
 		fattr4_time_deleg_access access;
 
 		if (!xdrgen_decode_fattr4_time_deleg_access(xdr, &access))
-			return -NFSERR_BAD_XDR;
+			return -EIO;
 		fattr->ncf_cb_atime.tv_sec = access.seconds;
 		fattr->ncf_cb_atime.tv_nsec = access.nseconds;
 
@@ -118,7 +118,7 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
 		fattr4_time_deleg_modify modify;
 
 		if (!xdrgen_decode_fattr4_time_deleg_modify(xdr, &modify))
-			return -NFSERR_BAD_XDR;
+			return -EIO;
 		fattr->ncf_cb_mtime.tv_sec = modify.seconds;
 		fattr->ncf_cb_mtime.tv_nsec = modify.nseconds;
 
@@ -682,15 +682,15 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
 	if (unlikely(status || cb->cb_status))
 		return status;
 	if (xdr_stream_decode_uint32_array(xdr, bitmap, 3) < 0)
-		return -NFSERR_BAD_XDR;
+		return -EIO;
 	if (xdr_stream_decode_u32(xdr, &attrlen) < 0)
-		return -NFSERR_BAD_XDR;
+		return -EIO;
 	maxlen = sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize);
 	if (bitmap[2] != 0)
 		maxlen += (sizeof(ncf->ncf_cb_mtime.tv_sec) +
 			   sizeof(ncf->ncf_cb_mtime.tv_nsec)) * 2;
 	if (attrlen > maxlen)
-		return -NFSERR_BAD_XDR;
+		return -EIO;
 	status = decode_cb_fattr4(xdr, bitmap, ncf);
 	return status;
 }
-- 
2.47.0


