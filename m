Return-Path: <linux-nfs+bounces-22617-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fD3mHnk8MWrJegUAu9opvQ
	(envelope-from <linux-nfs+bounces-22617-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:07:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B25368F1B8
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:07:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M7URsVot;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22617-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22617-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29A5E3056F91
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E661946AEDD;
	Tue, 16 Jun 2026 11:59:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F54611EE;
	Tue, 16 Jun 2026 11:59:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611176; cv=none; b=HOh8tGhE8fDoECXUFmRvq8WJp9xGoQ0d2KMSfx3936Z3ND4L1V4XnfdKBALxqt6tvynW/xjpsE7izj+KxX5hIE+rJMyR29KyxWIh4RrFIbHKjlH/91N8tx5JsOzPLe35k7wrmsbYBWKqJLxVtlKlw3DR3ceSf+FDNEtZyB9y9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611176; c=relaxed/simple;
	bh=LU2xmqizOX/kJ1A2Fv+RuFBTbu839RLpSWdSRR2hsNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GM/uMA3rvpHKKK1TXNsvohUlzYLM9UtILK/K7/KdoIlBAiNpEmey/orNwz2iqsF8jDYlzx3P2wZ+OBL8MA+Aq+6fGFWSi8hDpN1C8+wsrmNQn2GHDTlhtKeEWV/mQmT7Of58XhAOTOZXAIN+oq3iz6Gsa0SB2GyJQttwbuvucsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7URsVot; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1151F00A3A;
	Tue, 16 Jun 2026 11:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611175;
	bh=4JAUyHCHPPu/JbmAepwRvvsAs9BUq0bCUZUd4jfYYB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=M7URsVotaJTKCQfStrcx6gXfcQGfrZMirXS5GASm+y11AD1Y0iAgb1JomE10+C/Ie
	 itEULmI4TdL+AAVVy0pRgt6KBMFPRD3OxH8JDjBlcMrr+zMX4PZX0dJ4yQFzi2TwyR
	 bRRk2f5ZSThVS7ihh5Q/oL6AP5BkWR0D3gg2i/MOdfh863BWmC7fH8JuezAN7fF1Ng
	 JALYni70kbcKq8k9eGrfBCZT9f98oW/bNh244vh42H0hK1YKHFL5gYWJEuBZxWhX53
	 psmHx4uG4DzY1yehZ74e3G4boEzcFYF475UunR+7172TYy6FxBffjEzoRNvyXjfKLD
	 GrmkR9U72WZfQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:58:58 -0400
Subject: [PATCH v7 15/20] nfsd: allow encoding a filehandle into fattr4
 without a svc_fh
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-15-6cbc7eac0ade@kernel.org>
References: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
In-Reply-To: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7513; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LU2xmqizOX/kJ1A2Fv+RuFBTbu839RLpSWdSRR2hsNY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqH5ZpXlIaYWc1ndzdQ3NGpSU+7o6h31AnwN
 EsZrFXSmy6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6hwAKCRAADmhBGVaC
 FUFUEADUSvyq9CE7/hnAS1lH13rSD2onpq/gAJkO9UbDkaHd7BRDokuwt9WjAdTZi0KN+FjUrcg
 q8Vx15reyOITnBl2wuLZNc3SyI/CkDC4h2VW4vjYh8enxQ9lRJ+SdB9s3aHW9fPLwUvlhqImjRh
 bSac4S1iPxzWJsN4mKFoO/6rxS9umBlQGvNgudoqU8qFoXEeb+4rvCyw7KlWIcwwZLZ1TVrXOE+
 uMxcaRm65tuASrpTHpWd1hHXTH2K9yKP7vWe2qCp2mWuTU4nh9NBKkhVeeVnKmqSjKk1furWaMi
 qC0wYNVOlmCkZ6KNJtBcyZBs9WBVDpET21U9hjCJbgeTpO5NqL4fKIbVGvrPPuzpLTRAtkFFXeS
 MP4ZtS5jFa0VMS8OoeN9nPoyJ2sMdjy3XJHWu+QJOK9m9sBxSjgQNVeO614iH9jOX1rf8kE88vw
 1YorP6uXB7f7qJNWct6TaeaCjeRBetc2c3uhp7tz+qgpB5p/hOWVLizRlp30vsRTviJfzJEsLbn
 fEEL2iZ+CFocGezyi/jcYmRkJew+SgaQBHeFP1DrrRfuTkAR/0jC4cSJECoY15jiK7J109GaUJU
 TGtZYpldF9PiBvAD4rqOjevvCFVBBt9Yp3oH1YF1teZ5xMVTWlvQe2JmdG0oL7OTF7Hw5gAMryl
 G0qcVTgUM9Qu6AQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22617-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B25368F1B8

The current fattr4 encoder requires a svc_fh in order to encode the
filehandle. This is not available in a CB_NOTIFY callback. Add a new
"fhandle" field to struct nfsd4_fattr_args and copy the filehandle into
there from the svc_fh. CB_NOTIFY will populate it via other means.

A filehandle composed this way may still need a MAC appended on signed
exports, so generalize fh_append_mac() to operate on a bare knfsd_fh
(plus its maximum size and net) rather than a svc_fh.

The FSID attribute shares the same attrmask gate as the filehandle, so
do the same for it: add fsid_source_fh() which takes a bare knfsd_fh and
its svc_export, and have the FSID encoder use args->fhandle and
args->exp. fsid_source() becomes a wrapper for the v2/v3 callers. The
now-unused svc_fh pointer is dropped from struct nfsd4_fattr_args.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 37 ++++++++++++++++++++-----------------
 fs/nfsd/nfsfh.c   | 30 ++++++++++++++++++------------
 fs/nfsd/nfsfh.h   |  3 +++
 3 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 90c265ce3846..48de0922c6dd 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2719,7 +2719,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 }
 
 static __be32 nfsd4_encode_nfs_fh4(struct xdr_stream *xdr,
-				   struct knfsd_fh *fh_handle)
+				   const struct knfsd_fh *fh_handle)
 {
 	return nfsd4_encode_opaque(xdr, fh_handle->fh_raw, fh_handle->fh_size);
 }
@@ -3159,9 +3159,9 @@ nfsd4_encode_bitmap4(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
 
 struct nfsd4_fattr_args {
 	struct svc_rqst		*rqstp;
-	struct svc_fh		*fhp;
 	struct svc_export	*exp;
 	struct dentry		*dentry;
+	struct knfsd_fh		fhandle;
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
@@ -3309,7 +3309,7 @@ static __be32 nfsd4_encode_fattr4_fsid(struct xdr_stream *xdr,
 		xdr_encode_hyper(p, NFS4_REFERRAL_FSID_MINOR);
 		return nfs_ok;
 	}
-	switch (fsid_source(args->fhp)) {
+	switch (fsid_source_fh(&args->fhandle, args->exp)) {
 	case FSIDSOURCE_FSID:
 		p = xdr_encode_hyper(p, (u64)args->exp->ex_fsid);
 		xdr_encode_hyper(p, (u64)0);
@@ -3406,7 +3406,7 @@ static __be32 nfsd4_encode_fattr4_homogeneous(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 					     const struct nfsd4_fattr_args *args)
 {
-	return nfsd4_encode_nfs_fh4(xdr, &args->fhp->fh_handle);
+	return nfsd4_encode_nfs_fh4(xdr, &args->fhandle);
 }
 
 static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
@@ -4019,19 +4019,22 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
+	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID))) {
+		if (!fhp) {
+			tempfh = kmalloc_obj(struct svc_fh);
+			status = nfserr_jukebox;
+			if (!tempfh)
+				goto out;
+			fh_init(tempfh, NFS4_FHSIZE);
+			status = fh_compose(tempfh, exp, dentry, NULL);
+			if (status)
+				goto out;
+			fhp = tempfh;
+		}
+		fh_copy_shallow(&args.fhandle, &fhp->fh_handle);
+	}
+
 	if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
 			   FATTR4_WORD0_CASE_PRESERVING)) {
 		/*
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ab53de1c280d..8b1a95e1d058 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -142,16 +142,15 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
 /* Size of a file handle MAC, in 4-octet words */
 #define FH_MAC_WORDS (sizeof(__le64) / 4)
 
-static bool fh_append_mac(struct svc_fh *fhp, struct net *net)
+bool fh_append_mac(struct knfsd_fh *fh, int fh_maxsize, struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	struct knfsd_fh *fh = &fhp->fh_handle;
 	siphash_key_t *fh_key = nn->fh_key;
 	__le64 hash;
 
 	if (!fh_key)
 		goto out_no_key;
-	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize)
+	if (fh->fh_size + sizeof(hash) > fh_maxsize)
 		goto out_no_space;
 
 	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
@@ -165,7 +164,7 @@ static bool fh_append_mac(struct svc_fh *fhp, struct net *net)
 
 out_no_space:
 	pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %zu would be greater than fh_maxsize %d.\n",
-			    fh->fh_size + sizeof(hash), fhp->fh_maxsize);
+			    fh->fh_size + sizeof(hash), fh_maxsize);
 	return false;
 }
 
@@ -564,7 +563,8 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		fhp->fh_handle.fh_size += maxsize * 4;
 
 		if (exp->ex_flags & NFSEXP_SIGN_FH)
-			if (!fh_append_mac(fhp, exp->cd->net))
+			if (!fh_append_mac(&fhp->fh_handle, fhp->fh_maxsize,
+					   exp->cd->net))
 				fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
 	} else {
 		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
@@ -894,19 +894,20 @@ char * SVCFH_fmt(struct svc_fh *fhp)
 	return buf;
 }
 
-enum fsid_source fsid_source(const struct svc_fh *fhp)
+enum fsid_source fsid_source_fh(const struct knfsd_fh *fh,
+				struct svc_export *exp)
 {
-	if (fhp->fh_handle.fh_version != 1)
+	if (fh->fh_version != 1)
 		return FSIDSOURCE_DEV;
-	switch(fhp->fh_handle.fh_fsid_type) {
+	switch (fh->fh_fsid_type) {
 	case FSID_DEV:
 	case FSID_ENCODE_DEV:
 	case FSID_MAJOR_MINOR:
-		if (exp_sb(fhp->fh_export)->s_type->fs_flags & FS_REQUIRES_DEV)
+		if (exp_sb(exp)->s_type->fs_flags & FS_REQUIRES_DEV)
 			return FSIDSOURCE_DEV;
 		break;
 	case FSID_NUM:
-		if (fhp->fh_export->ex_flags & NFSEXP_FSID)
+		if (exp->ex_flags & NFSEXP_FSID)
 			return FSIDSOURCE_FSID;
 		break;
 	default:
@@ -915,13 +916,18 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
 	/* either a UUID type filehandle, or the filehandle doesn't
 	 * match the export.
 	 */
-	if (fhp->fh_export->ex_flags & NFSEXP_FSID)
+	if (exp->ex_flags & NFSEXP_FSID)
 		return FSIDSOURCE_FSID;
-	if (fhp->fh_export->ex_uuid)
+	if (exp->ex_uuid)
 		return FSIDSOURCE_UUID;
 	return FSIDSOURCE_DEV;
 }
 
+enum fsid_source fsid_source(const struct svc_fh *fhp)
+{
+	return fsid_source_fh(&fhp->fh_handle, fhp->fh_export);
+}
+
 /**
  * nfsd4_change_attribute - Generate an NFSv4 change_attribute value
  * @stat: inode attributes
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5ef7191f8ad8..cdeb5eea65a8 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -131,6 +131,8 @@ enum fsid_source {
 	FSIDSOURCE_FSID,
 	FSIDSOURCE_UUID,
 };
+extern enum fsid_source fsid_source_fh(const struct knfsd_fh *fh,
+				       struct svc_export *exp);
 extern enum fsid_source fsid_source(const struct svc_fh *fhp);
 
 
@@ -226,6 +228,7 @@ __be32	fh_getattr(const struct svc_fh *fhp, struct kstat *stat);
 __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
 __be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
+bool	fh_append_mac(struct knfsd_fh *fh, int fh_maxsize, struct net *net);
 
 static __inline__ struct svc_fh *
 fh_copy(struct svc_fh *dst, const struct svc_fh *src)

-- 
2.54.0


