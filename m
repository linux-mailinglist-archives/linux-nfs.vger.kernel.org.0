Return-Path: <linux-nfs+bounces-7167-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D08799D76B
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 21:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E09284281
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 19:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AD41D0F4A;
	Mon, 14 Oct 2024 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTIq/IoE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00C1D0E13;
	Mon, 14 Oct 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934037; cv=none; b=bTOLCIIOJnt0rwUUFFK/H59iFZdmxmx1efP+WYfJ0xgXpU+EtzQQIanZLa2HFjiC+8xje8feolV0yTnPCMstgtgSys+iXb+HQFdMwKQuLSg0YgxKPVIQEdk4q4JtGo/CuZbILph5d3a5LG8/AZ9Jw05mmHXmlYAWKKVE/0FlVPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934037; c=relaxed/simple;
	bh=Gdnp7ZUMKG+dC9gQ7nB03xLfgBQs3H/eiGZRPxyxlv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4RBI55lL06mk2TmegsgXtjICs62uy4DBz0oyIYtfP8pwFKiASwY9TQBX5/5xJnyrmX8yDtv9w2ep/IwUzuiPvJaFpY9XWY0Nwn5zz2gHm/v+wCCoAbBK0643d1gb6PJd0QKzECVHdT1MlS4DuCMzsn23LRgkLCLF8nZTWRjzmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTIq/IoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6354BC4CED8;
	Mon, 14 Oct 2024 19:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728934037;
	bh=Gdnp7ZUMKG+dC9gQ7nB03xLfgBQs3H/eiGZRPxyxlv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TTIq/IoEOfpGVGAhxjYhnt/e0+XUG2hTf/W8bfbo45pMyLMQNr8AI+MlVFeandNqB
	 yJw49gUBMvh9NndwlOex8xMRM4HNhhwYIemUX/uN5bBCZDDd9omoN4SpzWYv+pf3Gx
	 XE0jUw2K4jmvPeF/t+haYYY/8Xj83T1ejlS8HOQ5LJ5hQ+cgKAVAi21QEFXYPtL1CD
	 6G9hl+vOIvkoWryAwWRsPSkef1s9lOR9g9Fcu1J/u4zpN/LL0RSUykv8WMa2PpF8DD
	 F0e9mdwPYx7ElFZd789Anj6mR8/aIoP4Bv7NSsMEZtFpZp+SkfngL5rQKpDgIMBsJg
	 bDZGe3PD0DlUQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Oct 2024 15:26:54 -0400
Subject: [PATCH 6/6] nfsd: handle delegated timestamps in SETATTR
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-delstid-v1-6-7ce8a2f4dd24@kernel.org>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
In-Reply-To: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Thomas Haynes <loghyr@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3234; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Gdnp7ZUMKG+dC9gQ7nB03xLfgBQs3H/eiGZRPxyxlv4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDXCMQ4YW+hawOR/CRBgN2k9D36HKXUIq+R0DC
 O99kx6ZQeWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw1wjAAKCRAADmhBGVaC
 FehQD/48f6JodKWRZeE0lWv60hXAxmFYc2SwOnxvCTMXMrxp7ui0xA2VFks7xGAVTo8s/HvR2ZM
 iGYZL968DJKvX6pugCOINBu8SodvQH0eh0Ky0n1X/irJOQ23wiCEX7kHWrPlfb/gr4LmoA3z449
 3TnRlJG1vSG7w3xLIN+AVJOeJeObV2fAVEBUZ+H3snxrD+WgLxXxG/81hJ0qZ7415xUjRJDLVLz
 NmtijqhHIukAeZvASJ8MakkQfS6vqwAFLEOLft/7MFRgC1PNQXJMNE31HSvlgK/GxYmunGHKNUU
 mThfGdORC4GUcymIwocvcCWBdLrmkmi77Xu/t/JcHED4XW0raYrt32JyN/ryWrjyaZaaDkUol6E
 tXX5ZKNx+8sfrX+PWJbTCiAjQKXBAzItkHqdQAzQaOFtAt21JF8Scy8cTlMKaoNfWIXkNnKAZXD
 JnkxDC4PRDhbZ8yW1702R82BnnxMkT0HxU7ZXRPs2UbsscNkKdq9EwEV85LNK2Sw6BAdvrT3Gur
 NQlg+IOtuJ4kSZYu5QTON4118A56yRAEl0JZNow9BMTOyLQzffwQ8S3SQlf3X9VW5c6QvyOqSbC
 BQdX1+e+KSJ0ghisUV6rBZ+vXdFVRu4U8ymeRiIYNl3SYzWiKgFuogENlJkoJB04uv+g63MEcGa
 nGrDaQm/3GMhtwQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow SETATTR to handle delegated timestamps. This patch assumes that
only the delegation holder has the ability to set the timestamps in this
way, so we allow this only if the SETATTR stateid refers to a
*_ATTRS_DELEG delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 26 +++++++++++++++++++++++---
 fs/nfsd/nfs4xdr.c  | 20 ++++++++++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index fcce1f2e5454b0f3c4aa4b85fb4a4e24b2dee932..320c4f79662e65848dc824885566d48e696fe97c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1133,18 +1133,38 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
-				WR_STATE, NULL, NULL);
+				WR_STATE, NULL, &st);
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
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 0e9f59f6be015bfa37893973f38fec880ff4c0b1..857b39fcdb772585601f760705564968bb0d554c 100644
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

-- 
2.47.0


