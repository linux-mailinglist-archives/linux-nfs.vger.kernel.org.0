Return-Path: <linux-nfs+bounces-21235-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFM9EoRg8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21235-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:23:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3BC47EC27
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3094E3025DE6
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4553A9612;
	Tue, 28 Apr 2026 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASO0YgSy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67483B19CE;
	Tue, 28 Apr 2026 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360328; cv=none; b=aF5UD88MDIeLkYth5owO+yan5lkWo2idWvT1a6ITG+xJJzXv96woZCT28EDfrQjASFgfB8DQXye+xWqbj4H4fJQCLyqK35yXiUpyOjiPWVB3bG8PATavdiDiu6PgYJLNpazNQNZsdTgiBbepUasJRCgqwG91nKroEWYeu0M+Crg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360328; c=relaxed/simple;
	bh=rXq7eUH4xSN0tI04G6bK80YWfcSKFJNz2w053/l/fqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q1vX6hWwtBi7zLahaC55FaanBnI05bq2dC5a1H3/DEBUTRpEwxKZPqJyrDORnDX7sqT0xNJPOuQKbNSBfyqK4b1NHOfaD114GAtHxAiC3OcP6TF4nMtbjohlpsvGwR1OsUvDuUoKellCwz3NV7oGvC+Sl5OwXrzSXHTDBAZH8jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASO0YgSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD807C2BCAF;
	Tue, 28 Apr 2026 07:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360328;
	bh=rXq7eUH4xSN0tI04G6bK80YWfcSKFJNz2w053/l/fqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ASO0YgSyJL40XBWMvfXv8z7uTwdHiuWfsxOZn5qEfLLpZbF+m1AFnUnNUve+cYcpV
	 x9PxcQg6DwfdH57N7+k291pBexroHsogjcoG3TVXpI7KiuMhXTJPDgqRnue14O9DZE
	 fvcNO3b6+ITnV34OAv0Mkz/CDpbichZZDd7ceNWABep0NBY3v4ZTzeic7I+KjlR6sx
	 /e+k5RS/K4Oziwflnwwy2dpaPYNfpM0T363kHKS/y0v9TnEukyhPuuTrRrB7GMkU1y
	 nx7lhf2oG/0g7eBlTx49SrJRLdiFbnyBoJfHwL+XNlX98NroWWERgImemK138PQmSw
	 p1xv36CRmDitw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:10:07 +0100
Subject: [PATCH v3 23/28] nfsd: allow encoding a filehandle into fattr4
 without a svc_fh
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-23-5a0780ba9def@kernel.org>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
In-Reply-To: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rXq7eUH4xSN0tI04G6bK80YWfcSKFJNz2w053/l/fqo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1TKHDE4x0NA7wLvnis546b39gYAs7fMc6R4
 meidxCSLcOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdUwAKCRAADmhBGVaC
 FfbVD/9MKOPMrwqS0Nc8GSqE5XPpHRZDPKH53MCEN0i2j3dD10Oyzy0zSr+agkWJHGjZNY6jjtt
 lyCNTfBIEpQHDIPD2p3J4z0YZBht/C/QFmlebR9PdLOHJ6vHcdsEOr96On9tYgkwaE2PGX6qwDj
 3r6x3xcALHlsacRByvG2uqq7Y+t1Cj0272+nGLR6sgrBzPqY/rs40IbVKG3xSJVT0NI/e4lF074
 9fH3pXCdIkTHPT/9kYNkaoaIpMOU2EyjfvMDvF2Ph9QO0AK2wnrTWhxyon+IlpasUa5grNVQkRC
 Metwb6GJlLe8mEwjkt1Dh4O6KDi6RoQAkjlJe7KBzGtiieycZqCJc7lTnNDXKsAa7NeNDpsVGKK
 exnR3PeAtfmlce7bO3oCBgoPtOitQQ+pC+mL2EilStor+7ml+vkjUbfg/zXvNctMY2xtr54n9Q/
 AZOfFFXxFRyigE2aSoX92B6Z/CrYXTiisBB31C/u3vMXZZNv105zHJFfTggKeU9dha/tXMvFx+b
 z0Vl0MPL2mkMKAlM5fCQywtd5eESPWXHXWGOboS6j32/zKl2eAHd2+/vRf1XnvAQmQZU/85EMIB
 2al8bYCvQdYgUQBdppV3vW1XohwEf7CV1P4695vMivJph+/rKSV2aUiX9I8CTByDeoAkffvc24a
 uJwc4DGkZjWoXZg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 4E3BC47EC27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21235-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The current fattr4 encoder requires a svc_fh in order to encode the
filehandle. This is not available in a CB_NOTIFY callback. Add a a new
"fhandle" field to struct nfsd4_fattr_args and copy the filehandle into
there from the svc_fh. CB_NOTIFY will populate it via other means.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f85581ebbd10..a9cdf7a3f8b3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2701,7 +2701,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 }
 
 static __be32 nfsd4_encode_nfs_fh4(struct xdr_stream *xdr,
-				   struct knfsd_fh *fh_handle)
+				   const struct knfsd_fh *fh_handle)
 {
 	return nfsd4_encode_opaque(xdr, fh_handle->fh_raw, fh_handle->fh_size);
 }
@@ -3144,6 +3144,7 @@ struct nfsd4_fattr_args {
 	struct svc_fh		*fhp;
 	struct svc_export	*exp;
 	struct dentry		*dentry;
+	struct knfsd_fh		fhandle;
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
@@ -3359,7 +3360,7 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 					     const struct nfsd4_fattr_args *args)
 {
-	return nfsd4_encode_nfs_fh4(xdr, &args->fhp->fh_handle);
+	return nfsd4_encode_nfs_fh4(xdr, &args->fhandle);
 }
 
 static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
@@ -3969,19 +3970,23 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (err)
 			goto out_nfserr;
 	}
-	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
-	    !fhp) {
-		tempfh = kmalloc_obj(struct svc_fh);
-		status = nfserr_jukebox;
-		if (!tempfh)
-			goto out;
-		fh_init(tempfh, NFS4_FHSIZE);
-		status = fh_compose(tempfh, exp, dentry, NULL);
-		if (status)
-			goto out;
-		args.fhp = tempfh;
-	} else
-		args.fhp = fhp;
+
+	args.fhp = fhp;
+	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID))) {
+		if (!args.fhp) {
+			tempfh = kmalloc_obj(struct svc_fh);
+			status = nfserr_jukebox;
+			if (!tempfh)
+				goto out;
+			fh_init(tempfh, NFS4_FHSIZE);
+			status = fh_compose(tempfh, exp, dentry, NULL);
+			if (status)
+				goto out;
+			args.fhp = tempfh;
+		}
+		if (args.fhp)
+			fh_copy_shallow(&args.fhandle, &args.fhp->fh_handle);
+	}
 
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);

-- 
2.54.0


