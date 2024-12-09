Return-Path: <linux-nfs+bounces-8485-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731299EA110
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 22:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31AF164FEE
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 21:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5177A1A3BDE;
	Mon,  9 Dec 2024 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORJ1BZml"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD2F1A3BC0;
	Mon,  9 Dec 2024 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778867; cv=none; b=TDSMKJl6cl4IovN1ue+Lh0sVmjXK7m4iCTHbrdpACr4BNhlw+xrE3J2rWkXLGQD4D9n1RPFHitq5dp8QCSSmy4Dg7OV1xX2h0QWeMduT/cSLJZy0/dThu7/BRDxwyfaI7X8XPhTuD68oEwSYZxQKaKNz23EQrIKO3JPm9nn6Qhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778867; c=relaxed/simple;
	bh=9NJX85GvEHx3pviPGV6znyL1sYiMugX+xws57Sc8Y6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQMgMsicOadmz72zZhULJxCpMUtECkqwyn5p6Eud68okZ039xqwoZkYh6ewZRgdCLqcOGjnO9hi6AZDK9mb0B2imx65j2ue5GqPbqabBOX9XEaJ7NZmm5AAHoczDrFXX00gZJ6Q3G7wjQ9C1/57kntjHr8t/ISQKnIP7DxXK3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORJ1BZml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86078C4CEE1;
	Mon,  9 Dec 2024 21:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733778866;
	bh=9NJX85GvEHx3pviPGV6znyL1sYiMugX+xws57Sc8Y6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ORJ1BZmliSs5CZ7Ob/RLZAHsTaW7rdsdQ6zPXo4yChNf2SbCNLF/cXDcBIVAo5mhD
	 z7ugMqGBJxxDn3JQvZdL/koxo3XJwsjp7sn0+RNfRmz4P2Gi3hWC6YSRTmBTPMg7Zd
	 5zPcIxVb/v7lKy8o3sFApt9442j2hQNE8ynN41PdpHoGesOA+sxWhudKryxg3CnDPF
	 VsffYDr8UipL3yQqnklHXrmE5hSnUpAGHwBUQlnr9epY2SY25ygpzep+k7DYfTLALq
	 nhNaC50jo4rk6KB3NuKZbgTClsVaC5XbjHBpxCIphT0T+rwFDLb31Za73hFqsJLAov
	 Qi1YXwe32UJYA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 09 Dec 2024 16:14:01 -0500
Subject: [PATCH v5 09/10] nfsd: handle delegated timestamps in SETATTR
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-delstid-v5-9-42308228f692@kernel.org>
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
In-Reply-To: <20241209-delstid-v5-0-42308228f692@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4513; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9NJX85GvEHx3pviPGV6znyL1sYiMugX+xws57Sc8Y6k=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnV12lfVqz00RZH6/V7ywker8cJwTZE0Nm/wpBT
 WjnTmZLPomJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ1ddpQAKCRAADmhBGVaC
 FV3lD/9jigxpb6CXnv0+V/iQzXFYgI6ThtyE4LAYzVMeQjIo4dHzushIs6FIykK+sYUuoLDq8cT
 2S8ZyKC6z29Tgfu4WwkRRQzyZqBmVU+ktxO/LSwLeCtzdcBLl+ntkYYF4Pb+ePL+rBtOZk3+f3y
 /q94u/HELjlLuLF8p8WdhwP+eYlviuyJDkB/i+Ro0itJ8UJmdSCU9Xx8lUxe7Ubwjubo1hu1GL1
 DP/fgnvU/2xrFAYC5gqUn9vmNWqDlwfJwqAkXt4SaJF/mLHb1/Tz/C6QA8uhpabSEmILhvTFBVp
 +yZAuDwiTZUvz+1bKEFUTK5TPLPJgBdzVGV5ktW1bSP540X2l0ZgDCy9icIww3WVG7apgoFeLvt
 TNGJGCaailzitpWoPM31JRS1t3hSiaA8Jj3/xBc9B9JoMFIV0VZ8wHqgWjJWlO9rkpQ1hgR+EPE
 Ooinbz2SSch1TbLZNI68pkOye+n/01zL2el1ec41WNbCm2MH96Vq/vt5KDWqTXOaOHst/K4DOO4
 z7IQdEAh/ENeLYl8s1RvkYSvO3SODlHbgb4LjBeTWoJ7edjeRQMIcjNpopO2tbXSHn7tmMw9Wa+
 q/1fBZWJb7txsNwB1hNtsDlMCLWRN138Ai1gDg3BNKpr4TWGcQEasJCEWK5We06wJfwo9WWZw4W
 1XaBkLK9qNyVVGA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow SETATTR to handle delegated timestamps. This patch assumes that
only the delegation holder has the ability to set the timestamps in this
way, so we allow this only if the SETATTR stateid refers to a
*_ATTRS_DELEG delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  | 31 ++++++++++++++++++++++++++++---
 fs/nfsd/nfs4state.c |  2 +-
 fs/nfsd/nfs4xdr.c   | 20 ++++++++++++++++++++
 fs/nfsd/nfsd.h      |  5 ++++-
 4 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f8a10f90bc7a4b288c20d2733c85f331cc0a8dba..fea171ffed623818c61886b786339b0b73f1053d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1135,18 +1135,43 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		.na_iattr	= &setattr->sa_iattr,
 		.na_seclabel	= &setattr->sa_label,
 	};
+	bool save_no_wcc, deleg_attrs;
+	struct nfs4_stid *st = NULL;
 	struct inode *inode;
 	__be32 status = nfs_ok;
-	bool save_no_wcc;
 	int err;
 
-	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
+	deleg_attrs = setattr->sa_bmval[2] & (FATTR4_WORD2_TIME_DELEG_ACCESS |
+					      FATTR4_WORD2_TIME_DELEG_MODIFY);
+
+	if (deleg_attrs || (setattr->sa_iattr.ia_valid & ATTR_SIZE)) {
+		int flags = WR_STATE;
+
+		if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS)
+			flags |= RD_STATE;
+
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
-				WR_STATE, NULL, NULL);
+				flags, NULL, &st);
 		if (status)
 			return status;
 	}
+
+	if (deleg_attrs) {
+		status = nfserr_bad_stateid;
+		if (st->sc_type & SC_TYPE_DELEG) {
+			struct nfs4_delegation *dp = delegstateid(st);
+
+			/* Only for *_ATTRS_DELEG flavors */
+			if (deleg_attrs_deleg(dp->dl_type))
+				status = nfs_ok;
+		}
+	}
+	if (st)
+		nfs4_put_stid(st);
+	if (status)
+		return status;
+
 	err = fh_want_write(&cstate->current_fh);
 	if (err)
 		return nfserrno(err);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c882eeba7830b0249ccd74654f81e63b12a30f14..a76e35f86021c5657e31e4fddf08cb5781f01e32 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5486,7 +5486,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 static inline __be32
 nfs4_check_delegmode(struct nfs4_delegation *dp, int flags)
 {
-	if ((flags & WR_STATE) && deleg_is_read(dp->dl_type))
+	if (!(flags & RD_STATE) && deleg_is_read(dp->dl_type))
 		return nfserr_openmode;
 	else
 		return nfs_ok;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 0561c99b5def2eccf679bf3ea0e5b1a57d5d8374..ce93a31ac5cec75b0f944d288e796e7a73641572 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -521,6 +521,26 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		*umask = mask & S_IRWXUGO;
 		iattr->ia_valid |= ATTR_MODE;
 	}
+	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
+		fattr4_time_deleg_access access;
+
+		if (!xdrgen_decode_fattr4_time_deleg_access(argp->xdr, &access))
+			return nfserr_bad_xdr;
+		iattr->ia_atime.tv_sec = access.seconds;
+		iattr->ia_atime.tv_nsec = access.nseconds;
+		iattr->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET | ATTR_DELEG;
+	}
+	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
+		fattr4_time_deleg_modify modify;
+
+		if (!xdrgen_decode_fattr4_time_deleg_modify(argp->xdr, &modify))
+			return nfserr_bad_xdr;
+		iattr->ia_mtime.tv_sec = modify.seconds;
+		iattr->ia_mtime.tv_nsec = modify.nseconds;
+		iattr->ia_ctime.tv_sec = modify.seconds;
+		iattr->ia_ctime.tv_nsec = modify.seconds;
+		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
+	}
 
 	/* request sanity: did attrlist4 contain the expected number of words? */
 	if (attrlist4_count != xdr_stream_pos(argp->xdr) - starting_pos)
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 004415651295891b3440f52a4c986e3a668a48cb..f007699aa397fe39042d80ccd568db4654d19dd5 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -531,7 +531,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
 #endif
 #define NFSD_WRITEABLE_ATTRS_WORD2 \
 	(FATTR4_WORD2_MODE_UMASK \
-	| MAYBE_FATTR4_WORD2_SECURITY_LABEL)
+	| MAYBE_FATTR4_WORD2_SECURITY_LABEL \
+	| FATTR4_WORD2_TIME_DELEG_ACCESS \
+	| FATTR4_WORD2_TIME_DELEG_MODIFY \
+	)
 
 #define NFSD_SUPPATTR_EXCLCREAT_WORD0 \
 	NFSD_WRITEABLE_ATTRS_WORD0

-- 
2.47.1


