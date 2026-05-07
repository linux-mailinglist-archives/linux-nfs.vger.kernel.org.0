Return-Path: <linux-nfs+bounces-21431-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNvKOo1U/GlOOAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21431-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 10:59:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB4B4E565E
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 10:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDE22303A926
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09733BBA07;
	Thu,  7 May 2026 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgVF/ZHe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF637E31A;
	Thu,  7 May 2026 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144109; cv=none; b=EiicO8ASxt2gmew5ueIdZARyJ57hGCuh+BXQdQUIjPeJhZlQ2lUIfToKg4vsyVBejG0DQivPsr67N4BenfikiAnNMSDbYocDK/u9BLVHXDMjP8/KFEvEfSs9PkZZ8tfMkT9cVcDQ9lDfTXLu12Y4iowPHdfTFiDG/pKvvrMU70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144109; c=relaxed/simple;
	bh=yLWlWt9V9Y5GGjXgBQKVgu1PJw/giK9+7A2pF5f40rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkC5Sc9jL43VBmgG+DT8fJ4oAWgdIpPHd8UhMjmuQ3gV6kOWyjgvICw1Y1YzOADzJEewv7ayiFUvYYUENIUL7BQd0XVXt3VUmIr12YKXbou3FeXK5mY+yXAXCAK/YazVMyFRynm5aMjymPxQ5F+v3PfZsQLAh5sdx1NqhMhWb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgVF/ZHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98526C2BCB2;
	Thu,  7 May 2026 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778144107;
	bh=yLWlWt9V9Y5GGjXgBQKVgu1PJw/giK9+7A2pF5f40rk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DgVF/ZHeV+kuGyAWmVI6pYtPDmHwEyTaC/1dkxbE09rooY6ON3S2YqhNJLhtxWNnz
	 v4h9eHHEh1I7/1MjNDRzoD4ccip6pzQVvi1+cmgeHr7IYO8gxVFD7qVsnPab/61e0X
	 rgSkMMzi1DI7pbs8qwMaxriGsvPphFCHwPupLVRY7K3dK+1cCHgF4WHykAVQKz4xov
	 40LtclGOjQS5ak28bdxbgnOYfMSw4mw92Lur47qX/ILVjgdp5K74SDxwDTljYYeafN
	 AFb9ah+FgVebRtSJxqTs4qEGY8DXAVgLlwoMCbCQLMUkDHTZA51BamoHhYVwGKsmhu
	 S+NvMcusUwFdA==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 07 May 2026 04:53:07 -0400
Subject: [PATCH v14 14/15] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE
 and FATTR4_CASE_PRESERVING
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-case-sensitivity-v14-14-e62cc8200435@oracle.com>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4953;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=5/2C2emITzAWN8Je7PbhdbbMkvvYBrugawZoWYBZ60w=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp/FL2KxHLyffiYrb1ic3za8sMFG9zo+OQsbJdi
 jfmUL/mPIeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafxS9gAKCRAzarMzb2Z/
 lz07D/9TSIMf0tbC8Ba0i9jMTBBDddV4dk65yZI5JIWciCRrg55cmdAQkhiDKOxajwU1ZK0BotD
 lzvs7dV+QxIMJvWR04Ay3u+Mq2qcPSsQ4vHXujHGry/kEHA6CPonitmONSH43kcRwRRYqTNRTbZ
 6mv3sSJ96W7D9vhL8a/hD12W4e7E9RZOMPaWrFbGhDcbfkJJ5Q13jzAcBaZDDoXfdL/1NHAECkH
 uccSYYejdB+5kISMwCSj8ukXz3RaVVFLz4p0pfoqNE8G0ORDw3IDOx6nwRJ37AsMrDqhOlCQXJ7
 Eci/NYR+2TKzfQHjefMFLsv3/kHnBl9jx0Xvnb2Dz7zCI79nICBygT35nhOqtjyjUx00Hifpcva
 GdTSLyBIv4FjfmV4h3SaUlgiHqBAYsbgod9GI9bRIe8vbHJi8JZB010Q2F0wjZf4ejE9Rxxr+PC
 ofIze9YCs5xFjwevnHTtV5gpbSnATGp0pSCoWgHgd48lpFJ65qNU94+yNAlkKh/C5BQsf2aHuhC
 CdPPgm73p31m7P5HTwbm0CyWX2RLqt0gd7tkYWZnoWDUQgOCC6gLkkDiPqN4cKVilEQanENN/zJ
 XBoN7lMKZ5Z9nCMMkF8KF8MV86Fq+xHRB8XI0wwuyw4HjkA/oiO6YVW4hwBwp19twoId72SkRlF
 EAWeEuxYnFD5Uhw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 8BB4B4E565E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21431-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nrubsig.org:email,oracle.com:email,oracle.com:mid]
X-Rspamd-Action: no action

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
index 2a0946c630e1..319007b79d49 100644
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
+		 * Per RFC 8881 Section 18.7.3, an attribute advertised
+		 * in SUPPORTED_ATTRS must come back with a value or the
+		 * GETATTR must fail. nfsd_get_case_info() fills POSIX
+		 * defaults and returns -EOPNOTSUPP when the underlying
+		 * filesystem does not expose case state; encode those
+		 * defaults so the reply agrees with what SUPPORTED_ATTRS
+		 * advertises. Other errors fail the operation as the
+		 * spec requires.
+		 */
+		if (err && err != -EOPNOTSUPP)
+			goto out_nfserr;
+	}
 
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);

-- 
2.53.0


