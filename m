Return-Path: <linux-nfs+bounces-8486-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933FA9EA112
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 22:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AC1165730
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 21:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0A21A7046;
	Mon,  9 Dec 2024 21:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDCKm370"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578319C54A;
	Mon,  9 Dec 2024 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778868; cv=none; b=cmrWk8Svu10Dsodc2tNMb5UTvXcQ/C1N/xwbCJ2Ghtuo6MVBKm6Rh9L3/HRHHLHQm27rIvFGSOANovK1YpimuBunx4fgG+qhPxWSXgCB/pFygYUMvJu1i+sBw2eDr+Nkh0EXWGRJup6Ln5hyYlYZs8ppNh0vrB1rwuJfzScIX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778868; c=relaxed/simple;
	bh=VEHOwStO+gCYUuq2M8p9wjztvUB56YWilUi6AG2I/f8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ilQTNWsZy3k0awsDPg6jzPOd6kXRSvj5NI+E0WGQBp4BDO0eX3IV4re4TgHen/PN7yIko/mOLwd8KSM7U2Be3LdTr/ta6keynMg2Vb4dnZupKFwS8O9kCEmQBjBbu8ofI9Z6ryuDbPBpAAjA8CuS9J8un4V+YNDUYaSM5BdxXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDCKm370; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C94C4CEE2;
	Mon,  9 Dec 2024 21:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733778867;
	bh=VEHOwStO+gCYUuq2M8p9wjztvUB56YWilUi6AG2I/f8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IDCKm3705RmAGHAtlm3HPX56Y4wGyMY07MwgDLsr+9ulGNmhYZujqblChXOA7VJS1
	 dr1SQNE84PmnZsIJAGoxHBZV7Fl1ChiXMOHYyvmajYUaewLoSnpk/yzBh+99snAXc8
	 QVikNsErrUQpFXAbtrKPAze6HkH+8kgoOMaURdcVeLh+3iAVng3RevrQquMr//wnzJ
	 48SynlcooGvtcO2qUk8S7dlIrV46KMc+qQcu9ChH3lZ/G3JW9NPpxwoDD6ZKu0rZXb
	 w93JtdgOENi++Q+JeNJfQ6m8LyJ7UzJDUwgSkoSziKrvOJt+sHN6EZHwlxm57aDZtT
	 og82S7+CpAfOQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 09 Dec 2024 16:14:02 -0500
Subject: [PATCH v5 10/10] nfsd: implement
 OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-delstid-v5-10-42308228f692@kernel.org>
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
In-Reply-To: <20241209-delstid-v5-0-42308228f692@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3288; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VEHOwStO+gCYUuq2M8p9wjztvUB56YWilUi6AG2I/f8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnV12lk9ogCkJbqZJMFHgnaOWaAVxC9Y8QixTFV
 CA5Lx+zw1WJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ1ddpQAKCRAADmhBGVaC
 FabhD/0akETMOmSpdewrRO7opexkUgUPGuMbPxBnNiiM7qYtxbci+I4kYOKozUPeMvargF88AWx
 2eP1fLMOkcPNpEQF/k+w2BkfNTUTzcstSIHE5+Kij3NNaiqkJVa9QwAXVmLg+N+8hdLS1Qw3z2+
 hdpvZhO8KY0dpPlVqRjZYkzrgw3sJQo5XDS9pzRsTuwX4DrCYIUyH+xgqP0h5bwepLZsDqaaPyK
 pRXoWPki6/1osnr3WJSLQp8j8CWvTrBh8DFrzQIYsi3UdHWsqneG/1OS1TGd+/Sw0lyjyZUQqeW
 bh/adNxZRL+E6O6DZaHTeTkFvUxYgfoG7ut9bPVuDmTSmDzJTr2qRY+d87R/bps8e0q9eAgV4tR
 fJMfrGkL4yIoAzDMhBLltYRrbphRASUhU+OF3Gi2VrmAMuiSlbfhix2pvGzsnIMQNtr+1WSz13V
 i1nhl6bwwMN3Mfu6jFHpj24IoFFi9X81M7gNXoiClmFTMGzez0JUiZWzHWQ8vku/GdmwHXdvuR+
 Enzc4OBZtw9TiHb8tIl+okbFXfjhSSFwy94bgNQ3KauHr1zHXgwjv8VqLX2oyvulDJsTBqfN0j+
 99fK0wpDj6ux1BEpEXx3pf5y58RtoEQ7y//zORN18mxv+CLnZzcpw3IOJC33FSViIFFENpdwNRv
 nwtn+nSj4eOWJkQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow clients to request getting a delegation xor an open stateid if a
delegation isn't available. This allows the client to avoid sending a
final CLOSE for the (useless) open stateid, when it is granted a
delegation.

If this flag is requested by the client and there isn't already a new
open stateid, discard the new open stateid before replying.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 24 +++++++++++++++++++++++-
 fs/nfsd/nfs4xdr.c   |  3 ++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a76e35f86021c5657e31e4fddf08cb5781f01e32..82d2aee484d9ee6604a8096227e0a958d58d3128 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6133,6 +6133,17 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
 	 */
 }
 
+/* Are we only returning a delegation stateid? */
+static bool open_xor_delegation(struct nfsd4_open *open)
+{
+	if (!(open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
+		return false;
+	/* Did we actually get a delegation? */
+	if (!deleg_is_read(open->op_delegate_type) && !deleg_is_write(open->op_delegate_type))
+		return false;
+	return true;
+}
+
 /**
  * nfsd4_process_open2 - finish open processing
  * @rqstp: the RPC transaction being executed
@@ -6230,6 +6241,17 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* OPEN succeeds even if we fail.
 	*/
 	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
+
+	/*
+	 * If there is an existing open stateid, it must be updated and
+	 * returned. Only respect WANT_OPEN_XOR_DELEGATION when a new
+	 * open stateid would have to be created.
+	 */
+	if (new_stp && open_xor_delegation(open)) {
+		memcpy(&open->op_stateid, &zero_stateid, sizeof(open->op_stateid));
+		open->op_rflags |= OPEN4_RESULT_NO_OPEN_STATEID;
+		release_open_stateid(stp);
+	}
 nodeleg:
 	status = nfs_ok;
 	trace_nfsd_open(&stp->st_stid.sc_stateid);
@@ -6246,7 +6268,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	/*
 	* To finish the open response, we just need to set the rflags.
 	*/
-	open->op_rflags = NFS4_OPEN_RESULT_LOCKTYPE_POSIX;
+	open->op_rflags |= NFS4_OPEN_RESULT_LOCKTYPE_POSIX;
 	if (nfsd4_has_session(&resp->cstate))
 		open->op_rflags |= NFS4_OPEN_RESULT_MAY_NOTIFY_LOCK;
 	else if (!(open->op_openowner->oo_flags & NFS4_OO_CONFIRMED))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ce93a31ac5cec75b0f944d288e796e7a73641572..2b6a64b4d2a3e3295b9f72e2993dd469945b6114 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3420,7 +3420,8 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
-					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS))
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS)	| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
 
 #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
 				 BIT(OPEN_ARGS_OPEN_CLAIM_PREVIOUS)	| \

-- 
2.47.1


