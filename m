Return-Path: <linux-nfs+bounces-21098-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJvaK0Yf7GmpUgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21098-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:56:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA68464A8A
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B59D3017A0A
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 01:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAB726ED5D;
	Sat, 25 Apr 2026 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi95WQXp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407F248F64;
	Sat, 25 Apr 2026 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082039; cv=none; b=fBVyz7v/79Jn0ofapMDtKW+xjYy+s5OlQHLiG0tDw1QHrxgXCJP5F1K3V9GMwPfgxuULNI8QK3HiOVDUzw6u3UftEjOAsMhUzK8HcvJ8fGKZxxYnZKXFbbsO+n62vTZqArUShF0PFBfE+E2y/S6OqhzDTNEjR8DckjfZT/BAxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082039; c=relaxed/simple;
	bh=7qcGCalbO8KkpsIrewxDQbW3F+/q9MR1MUul4uvB6WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JmVDYEATpUosqmfwsGGAR5acqBVvjQqD1g+v/k6pXD8K63b94I5R026V55p/IkrWlohgwfANbl5kf5nnAO3JlRLOx1S4BzUN8X4F9SqIYtfKx5jggFtzmal4Be4sxmUdU7YbIdASZCZOnXuFfjCb9ARZmHqE5yYP8ziuCgSRehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi95WQXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C400C2BCB2;
	Sat, 25 Apr 2026 01:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082038;
	bh=7qcGCalbO8KkpsIrewxDQbW3F+/q9MR1MUul4uvB6WI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qi95WQXpNDyjFy0LmxKlrTgZYQSG6IZVyOSGR3pwU5+X2dq0sJrZu1yDrdNkrP7qB
	 qg+uy3te+g0wBp6ZJbxfv1lETETLS9en9LpqJR3FvgNEbp9H4XTYmJEPoMp0dR46tq
	 lnEnRr0ol+e4oEFKkzpoLJSplrPxMgL0oMqjZ0qp2C9kh8dvh1+L4h2gJGWtu/HNx0
	 3MS87r0r/0080EUT3t/YYala546EMl1AP+CjzU6IER3AQ6O+k5SKsfOBYjn2DQu2aV
	 5x7uRM+Puj9HbmNMgxp6ePEp/XUldAqcial4d4QygCZFtZOyE+MrxQWd4wtn8EtFbe
	 uS0veZmNzuWxQ==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 24 Apr 2026 21:53:16 -0400
Subject: [PATCH v11 14/15] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE
 and FATTR4_CASE_PRESERVING
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-case-sensitivity-v11-14-de5619beddaf@oracle.com>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
In-Reply-To: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4552;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Gb++2WXxq7tymC3lSBQQTwIgZZJUrL12YzUU9YIeoRg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6RFnJh5RPlhzv8zOFhfy+P+Bn3NqH2/9JE5
 hDuPI1TwTKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekQAKCRAzarMzb2Z/
 lw2REACbr6lCxWkqB+jzxg/IBfXv10fHbhPzMCvQlZWb+dbrracqFwJuhhC4/6M9Pc73JmJ1WOl
 OCdBLrEvpPKPy898FKaA6nLBZ46ziYNeqqDSHTuqIqPRcIjGwHL0izSHHMdO33POOb+BfEd9CSe
 pnnpsnPyqYu8vlwBv7gkReIWcmGankd0OQUO2oTwiMD0+WRaFi9jfWXIzq5WQOdEtJ4Xo+GIrIm
 D3fMAPC4n2QLSl1+G+Jatxv5D1iUDpToG3lcXHjHm3U+k+mB6P5jkV6Ol9W3F5izpMq6+iaCnhe
 1lq2f1fYB8Jjo1vasu6QJNkqZ2xfjbK0qKCz4pC1KFJEcwwBVUq4/vrK46uDY3JjDYNHof7b7tK
 +xSMFRgEdjWiaOWyJqZR3jmtruIYnAk6pkokurwbNrQs+EaUUWHS2XEqpvay+pJ9wDg/3PR2TQT
 07eR1o6ctS8a1O1KksJMqN97jRA2nr1VsilkcXKNTVvBfJt2Bn79yNGQtjbGnYCUbaSitdi1Y1n
 OZsUgGaT38ixBRL9MWX42O8Eg4mLPYwz0jOW4jTPWNEAHEwXn0Q1LuB3HtHSPLI/L1oGJf8Z+mn
 +c08lbwUV1Gb1Ve1dcq6zQhaj5EnGgmy8eWpnFZJfr2sv03K3T3nZTHWUgtdQ1Wk91fh7hnYdCY
 Vn18aYwYyULhRzg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: BFA68464A8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21098-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,nrubsig.org:email]

From: Chuck Lever <chuck.lever@oracle.com>

NFSD currently provides NFSv4 clients with hard-coded responses
indicating all exported filesystems are case-sensitive and
case-preserving. This is incorrect for case-insensitive filesystems
and ext4 directories with casefold enabled.

Query the underlying filesystem's actual case sensitivity via
nfsd_get_case_info() and return accurate values to clients. This
supports per-directory settings for filesystems that allow mixing
case-sensitive and case-insensitive directories within an export.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2a0946c630e1..68b23863dab1 100644
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
+	 * Filesystems with a Unicode encoding loaded (e.g. ext4, f2fs
+	 * with the casefold feature) expose case folding as a
+	 * per-directory attribute, so the per-file-system
+	 * case_insensitive and case_preserving values can legitimately
+	 * differ across objects that share the same fsid.  Report
+	 * FATTR4_HOMOGENEOUS = FALSE on such filesystems to keep that
+	 * variation consistent with RFC 8881 Section 5.8.2.16.
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
@@ -3968,6 +3997,26 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		args.fhp = tempfh;
 	} else
 		args.fhp = fhp;
+	if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
+			   FATTR4_WORD0_CASE_PRESERVING)) {
+		struct dentry *cd = dentry;
+
+		/*
+		 * On casefold-capable file systems the flag lives
+		 * on the directory, not on its entries. For a
+		 * non-directory object, name-comparison semantics
+		 * come from its parent. A directory (including the
+		 * export root, whose parent is outside the export)
+		 * is queried as-is so its own contents' lookup
+		 * behaviour is reported.
+		 */
+		if (!d_is_dir(dentry))
+			cd = dentry->d_parent;
+		status = nfsd_get_case_info(cd, &args.case_insensitive,
+					    &args.case_preserving);
+		if (status != nfs_ok)
+			goto out;
+	}
 
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);

-- 
2.53.0


