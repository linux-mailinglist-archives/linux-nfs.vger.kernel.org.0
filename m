Return-Path: <linux-nfs+bounces-8477-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAD99EA0F8
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 22:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C09166A2A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 21:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB68219E97E;
	Mon,  9 Dec 2024 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DskQUNlN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDEA19E836;
	Mon,  9 Dec 2024 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778856; cv=none; b=shBTL9iYCeCscfY1vB8Xsd7MVZoErUGLX/X1OwKGyG79j+gYsPvNvhxim6oOF5co9ENW2mJAw+/sq8ShO6gKkfJ+T37acUL95rvLaaZgW/aF+uzDRLN0k7VTwy7rMMWODKYAfaxOhsRG3S9Rh4siUyTYBwsnA/liTZx5AbhmRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778856; c=relaxed/simple;
	bh=qRO220jVJDpFhT0mNgCOk0gbt3XROXVxU97ICxTeQCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AnbfnCcxwlCba3tKuYd/wo09J+t+0X7FtzLmM3bH+Dr6Ksmork2OCeCe2McrNNhRz6imzE6iZp6jM2yER7Sjd02EjUeufZBVnZ8Hh4Dkci8gxP+gFR5K8XpYYgHEdDaLG0mQxu7iLl6pPutjbjYZR2PmDpn8SrJEJ5tHYsGyG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DskQUNlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA04C4CEE0;
	Mon,  9 Dec 2024 21:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733778856;
	bh=qRO220jVJDpFhT0mNgCOk0gbt3XROXVxU97ICxTeQCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DskQUNlN1mh85QKNkc6veYrTVI5Ph6QfAFy9HgxTE5w+2xxuaK5Vg5+qcBe45K3kg
	 wWNY8IxBpllOWCVDFGpd/2/fFs7N7LQQ0T/4u26AlHsI/8MBMJJ5P595/hiMv+iejL
	 dqTHVRtSLOgr5Eh62AeFEp5gyv1gBGvAZ4+RVLUk9TziuOYYqpJyDJswy/BwBRxp0M
	 YfUeDJut1SZl1j+RDC4blQj0ZTQvFS7oV8GG7QV22hhAS4dVxdo+MR698F9wIeExYI
	 WsYdeogQb4KS1YR/OzSPoYHFkRkSgXRABB4FVOKS4Zhd4t38Ayis1sXtYHB0C4woM3
	 LZUlOhJS3Kufg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 09 Dec 2024 16:13:53 -0500
Subject: [PATCH v5 01/10] nfsd: fix handling of delegated change attr in
 CB_GETATTR
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-delstid-v5-1-42308228f692@kernel.org>
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
In-Reply-To: <20241209-delstid-v5-0-42308228f692@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3275; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qRO220jVJDpFhT0mNgCOk0gbt3XROXVxU97ICxTeQCs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnV12k69ReI8d+0F0XPYrnqoW/OJc2dTaG1nUrP
 kmxaevKRKWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ1ddpAAKCRAADmhBGVaC
 Fa2MEACPpDFkn4+h6Ba7N3BEU8kRdEr0TZd004E3F839c2Keu8BWc2t3tgwdjEs410pz9nKXld7
 BnWkFJu3iMOOyfDfrz3qEcvd5CW2K/8JS6JLX9zp9YwlPYM5UH2MM7cBvTObUJYFuNMQZI6isqd
 mc622dC0nnoWUkvimq3xuPFkklV/uBSASqdxfLQkPTOTcdbbn/aQEFTCugiWWgqbo3NPKTEDvtt
 h6+cv3AQeyUlCEA3f0aNLcn5iUCMNdobt6Enlnmid9Geo3dR2wnOdi3VMw+fPa5wtZqapeblrsM
 4ZBN+O2/+MSUsp++/HYPC1x7R1atUB+iv+Opy9X1zc6X3nZuIISxSfo5yAFcQeW+WFjp92+MoC/
 +OXb2rJ/JB4q3qy5sxABRiHa08FxtKN5WInDERsstPuvEG5XXm/67OHdeaI2Eh4KpHxUGQLFNXB
 7uBm2MEWnZyTFr3L5LFqckJVovU0hNezoCN4hyb20xFxwWWqjcCdPqAoq7ciN2/K4y7RVYGPOYs
 kQmvQi/cS8o4P50iNHSwSgtJeOuTGuq7bse2U63DgC+EwFz0A+XhBlUa8jzP6Ckf79sGvto6scc
 +KQC+14knTS3DowcYsUdUM775/8qmuoxg65h5moXX2LGYgNhGIpMB0N1Rxip4oyTm2QgmSd3NmM
 q6sNo0QtIPlKbAw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

RFC8881, section 10.4.3 has some specific guidance as to how the
delegated change attribute should be handled. We currently don't follow
that guidance properly.

In particular, when the file is modified, the server always reports the
initial change attribute + 1. Section 10.4.3 however indicates that it
should be incremented on every GETATTR request from other clients.

Only request the change attribute until the file has been modified. If
there is an outstanding delegation, then increment the cached change
attribute on every GETATTR.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c |  8 +++++---
 fs/nfsd/nfs4xdr.c      | 15 +++++++++------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 3877b53e429fd89899d7dc35086bee8bda6eed07..25acb8624b854f5d0d184efec660e1f72cad8885 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -361,12 +361,14 @@ static void
 encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
 			struct nfs4_cb_fattr *fattr)
 {
-	struct nfs4_delegation *dp =
-		container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
+	struct nfs4_delegation *dp = container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
 	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
+	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
 	u32 bmap[1];
 
-	bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
+	bmap[0] = FATTR4_WORD0_SIZE;
+	if (!ncf->ncf_file_modified)
+		bmap[0] |= FATTR4_WORD0_CHANGE;
 
 	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
 	encode_nfs_fh4(xdr, fh);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 53fac037611c05ff8ba2618f9e324a9cb54c3890..c8e8d3f0dff4bb5288186369aad821906e684db7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2919,6 +2919,7 @@ struct nfsd4_fattr_args {
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
+	u64			change_attr;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	void			*context;
 	int			contextlen;
@@ -3018,7 +3019,6 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 					 const struct nfsd4_fattr_args *args)
 {
 	const struct svc_export *exp = args->exp;
-	u64 c;
 
 	if (unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
 		u32 flush_time = convert_to_wallclock(exp->cd->flush_time);
@@ -3029,9 +3029,7 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 			return nfserr_resource;
 		return nfs_ok;
 	}
-
-	c = nfsd4_change_attribute(&args->stat);
-	return nfsd4_encode_changeid4(xdr, c);
+	return nfsd4_encode_changeid4(xdr, args->change_attr);
 }
 
 static __be32 nfsd4_encode_fattr4_size(struct xdr_stream *xdr,
@@ -3556,11 +3554,16 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	if (dp) {
 		struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
 
-		if (ncf->ncf_file_modified)
+		if (ncf->ncf_file_modified) {
+			++ncf->ncf_initial_cinfo;
 			args.stat.size = ncf->ncf_cur_fsize;
-
+		}
+		args.change_attr = ncf->ncf_initial_cinfo;
 		nfs4_put_stid(&dp->dl_stid);
+	} else {
+		args.change_attr = nfsd4_change_attribute(&args.stat);
 	}
+
 	if (err)
 		goto out_nfserr;
 

-- 
2.47.1


