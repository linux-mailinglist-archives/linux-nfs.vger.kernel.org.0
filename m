Return-Path: <linux-nfs+bounces-21360-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAejLegI9mk3RwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21360-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:23:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 483304B26E4
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08023300E5ED
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 14:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A887233E367;
	Sat,  2 May 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rywUvWSA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E8F2820AC;
	Sat,  2 May 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731756; cv=none; b=XzdSHwUFkH9w7SLD/gwuVCa/CtCUD38EsHrVxb/tau/u8p3DauUbg1knh9TmCKhsyHh1BZmrjenWC8SsNfUhl2/m5/jUQOQze28q+I3xBU7DnqnJa/olsOpwLmT0VxyYQwuAtvCc3IiZODv6K+X7d2lmNs/cY9hjCBPXA1O/ThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731756; c=relaxed/simple;
	bh=IBYLppDmEpk49AW+aDaK+jyoS+KenxvVpd0xkXYb9e4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPtkBGjcjYm4mIZNw8D6fElitQTY2ROaQ2mAU6FxDzZ5oKIfrh7o9Mf9tKRTcNy6BwCwaXszSbHd7F/PYJZnuzmHdK9ZGh7AqTZeHgGxb+Q6J2Bu3X2oQe+LyDvqVGpQY9wBOIUMx/ngg7ECBBiPK/UjmbwrWhbHZt69e0dlxVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rywUvWSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BBDC2BCC4;
	Sat,  2 May 2026 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777731756;
	bh=IBYLppDmEpk49AW+aDaK+jyoS+KenxvVpd0xkXYb9e4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rywUvWSA3KU3kEM5YOrF4I92KWz+dtWkTT8uoGD9VBQtax69DobSaFypVCqYj1aWm
	 q0RvEnE4pakgtcGecOU3GyFbRQONukv06+5evNASwdKplvek+qRIW0iHlCxKC6qCaT
	 Ck8nik9bwdptwSMqQaqiUBozSQOuYujV2llca98tNPEQdDhJIWyenOiDzPOzNl37cN
	 /E238E6IxpZ2JqOwZ77kiVDE+VrxB8HTsiaXpTkXrAmjBRJ7i0XIBjm1s/tA6X1ikR
	 E44bksEOKBURrMDtY/VH4SR5MtShX63LW/4sJGBD4ds63MM5Ne0aCzv6rkyynC9HSc
	 1f7g1N/oSOu5g==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 02 May 2026 10:20:59 -0400
Subject: [PATCH v13 14/15] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE
 and FATTR4_CASE_PRESERVING
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-case-sensitivity-v13-14-aa853140311f@oracle.com>
References: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
In-Reply-To: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, 
 linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
 almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
 adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, 
 pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
 trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, 
 hansg@kernel.org, senozhatsky@chromium.org, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4936;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=ezCClrtcetCYnq60ZMthhQBIKalbwZM7UJGTvsJx60Q=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghRZHXDWrBOKBPiYd9/A/2qNYBxWjYNc1mUa
 Mba+1U/o6KJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUQAKCRAzarMzb2Z/
 l+pHD/9szCzlJ7xx0AGJZxYiKgNGx1GH4rZVoB9AGHCULctRjTS8Sr4J1/C26ripNZiaFeAruqe
 LRq0b1NedgTGLdDZTJZBWn1H3uMrSgVmicsLzCeWICFj3A/idmRcKKuhppN4Dmv1BRRoi+5QQEC
 +RIOJI1FwsXEcwMsh5h5KUz5vmqhybBVsL74+Qe3RvP8UEVC7bcmdJAjmULRjMS5By4nt4LfvyP
 CXib4VMqDBHdIX3JMUfFsQPzIOMRQGQLFPj1A5JE8UXlTbZBo0M2B2mPerQ3p7BrN6oBgkL1uba
 WkuyvGK7RLu9wASejqw9shamCX94tmP4cKSsASn4HTVPkq4Qb57V31hw0amtYul/gILYiQT6Ufp
 4TBAiBeWBWKxK2KvSL+nFV0KfiNlvrgwA4u46Bm1KVsPgDx6EqEwcoj+qU/yFBwokxQIXAqg0Gy
 hHMl3cxIinx69VXAfXl5Rz24kCYb6QVkavxWT0uFPqGXL72vJKG82Bs7eCHX1d5EFN56wL3HR5U
 YlUi9sWmqjYOq1Kw4a0SgQb/TPJRKhCE5GFNGR5LT7YwbAAc3O7QK4kOKxtDbsuSDarbBR45EVT
 3wELlC8ube+lyksLB+oU0QrbEayaPuxvUeXhC1p27b2YbwlyXiziuELrpS68z4c5N3JGc582u3N
 Ix2Tqk2gVUEX/+A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 483304B26E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21360-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nrubsig.org:email,oracle.com:mid,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

NFSD currently provides NFSv4 clients with hard-coded responses
indicating all exported filesystems are case-sensitive and
case-preserving. This is incorrect for case-insensitive filesystems
and ext4 directories with casefold enabled.

Query the underlying filesystem's actual case sensitivity via
nfsd_get_case_info() and return accurate values to clients. This
supports per-directory settings for filesystems that allow mixing
case-sensitive and case-insensitive directories within an export.

The helper queries the parent dentry for non-directory filehandles
because case-folding is a per-directory property. That resolution
has the same corner cases here as for NFSv3 PATHCONF: single-file
exports query an unexported parent, disconnected dentries report
defaults until reconnected, and hardlinked files track whichever
alias the dcache currently holds.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2a0946c630e1..d77304692e11 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3158,6 +3158,8 @@ struct nfsd4_fattr_args {
 	u32			rdattr_err;
 	bool			contextsupport;
 	bool			ignore_crossmnt;
+	bool			case_insensitive;
+	bool			case_preserving;
 };
 
 typedef __be32(*nfsd4_enc_attr)(struct xdr_stream *xdr,
@@ -3356,6 +3358,33 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_encode_fattr4_case_insensitive(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_bool(xdr, args->case_insensitive);
+}
+
+static __be32 nfsd4_encode_fattr4_case_preserving(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_bool(xdr, args->case_preserving);
+}
+
+static __be32 nfsd4_encode_fattr4_homogeneous(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+	/*
+	 * Casefold-capable filesystems (e.g. ext4 or f2fs with the
+	 * casefold feature) attach a Unicode encoding at mount time
+	 * but apply case folding per directory.  The per-file-system
+	 * case_insensitive and case_preserving values can therefore
+	 * legitimately differ across objects that share the same fsid.
+	 * Report FATTR4_HOMOGENEOUS = FALSE on such filesystems to
+	 * keep that variation consistent with RFC 8881 Section 5.8.2.16.
+	 */
+	return nfsd4_encode_bool(xdr, !sb_has_encoding(args->dentry->d_sb));
+}
+
 static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 					     const struct nfsd4_fattr_args *args)
 {
@@ -3748,8 +3777,8 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_ACLSUPPORT]		= nfsd4_encode_fattr4_aclsupport,
 	[FATTR4_ARCHIVE]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_CANSETTIME]		= nfsd4_encode_fattr4__true,
-	[FATTR4_CASE_INSENSITIVE]	= nfsd4_encode_fattr4__false,
-	[FATTR4_CASE_PRESERVING]	= nfsd4_encode_fattr4__true,
+	[FATTR4_CASE_INSENSITIVE]	= nfsd4_encode_fattr4_case_insensitive,
+	[FATTR4_CASE_PRESERVING]	= nfsd4_encode_fattr4_case_preserving,
 	[FATTR4_CHOWN_RESTRICTED]	= nfsd4_encode_fattr4__true,
 	[FATTR4_FILEHANDLE]		= nfsd4_encode_fattr4_filehandle,
 	[FATTR4_FILEID]			= nfsd4_encode_fattr4_fileid,
@@ -3758,7 +3787,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_FILES_TOTAL]		= nfsd4_encode_fattr4_files_total,
 	[FATTR4_FS_LOCATIONS]		= nfsd4_encode_fattr4_fs_locations,
 	[FATTR4_HIDDEN]			= nfsd4_encode_fattr4__noop,
-	[FATTR4_HOMOGENEOUS]		= nfsd4_encode_fattr4__true,
+	[FATTR4_HOMOGENEOUS]		= nfsd4_encode_fattr4_homogeneous,
 	[FATTR4_MAXFILESIZE]		= nfsd4_encode_fattr4_maxfilesize,
 	[FATTR4_MAXLINK]		= nfsd4_encode_fattr4_maxlink,
 	[FATTR4_MAXNAME]		= nfsd4_encode_fattr4_maxname,
@@ -3968,6 +3997,23 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		args.fhp = tempfh;
 	} else
 		args.fhp = fhp;
+	if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
+			   FATTR4_WORD0_CASE_PRESERVING)) {
+		err = nfsd_get_case_info(dentry, &args.case_insensitive,
+					 &args.case_preserving);
+		/*
+		 * SUPPORTED_ATTRS unconditionally advertises both
+		 * bits, and the Linux client treats an absent
+		 * CASE_PRESERVING in a GETATTR reply as false. When
+		 * the filesystem does not expose case state,
+		 * nfsd_get_case_info() fills POSIX defaults
+		 * (case-sensitive, case-preserving) and returns
+		 * -EOPNOTSUPP; encode those defaults so the reply
+		 * agrees with what the server claims to support.
+		 */
+		if (err && err != -EOPNOTSUPP)
+			goto out_nfserr;
+	}
 
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);

-- 
2.53.0


