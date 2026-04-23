Return-Path: <linux-nfs+bounces-21041-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEcuOHsc6mntuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21041-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:19:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3420452BC6
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 454AD303B281
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9043F20FF;
	Thu, 23 Apr 2026 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaYE/SnQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE93F0A90;
	Thu, 23 Apr 2026 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949981; cv=none; b=s2OTt95sXRGCGYSTd0hLPbPO+CUsqA4XZLrvw1riOzLVFdctzQBhmni1nZl5hc91ilYnyoccr3mHdh1rO1OO3+iHShc9gXGZ9BOOVERUcEQIxuSUwFnFTeveBWIwfz2fXAFOynjStUm1MqKF6RHTeXvnNUqRH24FcuOUBfbaxlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949981; c=relaxed/simple;
	bh=XYKt46mg6wMVV2YdJGZU1apyeQ0MXeEOOUK+OVQco70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PeUa2/iG/p9uCV8PtehpuLSAYP0a9WyvFVeu5Gf/JZR/8sDsB0v2XN360rSp8GjqTQZKYd/LN36MaW7Z5VwTcVhEp0FJ23EsK24wZPdyI7MUtx9rWzyHgVh10LNreR8RBm8YVhtIejTlZbBCaAdwEPtSiVk0IxbBxmbkaDz4GsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaYE/SnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48483C2BCB3;
	Thu, 23 Apr 2026 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949981;
	bh=XYKt46mg6wMVV2YdJGZU1apyeQ0MXeEOOUK+OVQco70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JaYE/SnQVrEr92eGos5xu+rxKnYB29JOGxvTWLOW1s8/0pkDpc/NDjL6YenlsD1UX
	 eHtXvOkGvvUY70x9iSx5tdDAD46V14R1J3yE6Cl67tvoW7BkGGfsP3gX1aHI6j8u8F
	 2wCG3dL6AJd9cNlnrojPiq+yf0RiFQqXeENNOZRZVqchN0PgAagYrcrDs+Kli5SN70
	 FOGzI0MZoHx9utRo0PcvcCOwYvLnkXClk5EfZ00GJ/AbDnQfP9YUdIJgBOvI7w8BqR
	 IzJ06vmiyD90lWmlKydA/mr2NNtbgZd4Guj+j9XGwHh3GzzLGmatVAnLpG/t8FCBG5
	 WVJsMO7xH30mQ==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:19 -0400
Subject: [PATCH v10 16/17] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE
 and FATTR4_CASE_PRESERVING
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-16-c385d674a6cf@oracle.com>
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2833;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=QFOGuYFmcxqWyXGZEGt68U1bhDPXmPPrCdAEtt84t6g=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq0SERDMzl/Ku6k/coKNHnWTaSTkehoUKGr1
 XmcqZPciViJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 l+ycD/0XgnwZjb+9LZ1rFtZ/uYLu7XNGKoWGsTX0pGthYq7Ri4V7/KNMz7dap+QXhykptCfRODB
 VXFszVhCfmFBjn32+ec5ZMA65+iem2nVL18lFNplLt84eYxQlVQ4kUioFiyDG8JZslt5cNfV7r5
 o/8ILCI9Ea7ga6nEEXUUiXkugmzKgDPiK56FVzu8gLZA53SIBoiILFyQMskPQ2LmTTGFDwtoQun
 J/qM4Q4WErc5UybzBqcVlWxD8lYBlpMqmFiSpaHFFWk30HYuANc2srzAY049/esIHMLWRlZDXJe
 wHswH9Qo0VyHxY1jtAw2o6Lt+gPrX9DaSE5xac6hlhc+0e10IvKCsymoUKbK808tRIRDiIPtfgU
 VL3Vv5rpzV821SHU5m8iF8PwxYyg3OVvCSfaZ7ntMLtLz+I2AArRCXRUPeutyc2OWuYFZG/KUdv
 SjpeeLJ/IBjZjwyMKdGYxdGlVUaXoXjcmCxB/4dD30XTIVpP1nM0V3jHKhL1usNCeJE3Y00RvLb
 IzoPwqVA4F0ETMqlhXoC+FcuVuG1jFzQiL1fa/9U3GqfuDXA6E2haY4V3H3kf4anCk+xZ896xZ4
 TmS6hzQD9y91jQbH19KpUVc+UXRiSK8OwnDtePopyx6OsNf8SwMTYN5qbCQvD0KbYOqEt10yfjI
 b/LfLZXA5r/lbRA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21041-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_TWELVE(0.00)[32];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D3420452BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

NFSD currently provides NFSv4 clients with hard-coded responses
indicating all exported filesystems are case-sensitive and
case-preserving. This is incorrect for case-insensitive filesystems
and ext4 directories with casefold enabled.

Query the underlying filesystem's actual case sensitivity via
nfsd_get_case_info() and return accurate values to clients. This
supports per-directory settings for filesystems that allow mixing
case-sensitive and case-insensitive directories within an export.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2a0946c630e1..961cd59756fb 100644
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
@@ -3356,6 +3358,18 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
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
 static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 					     const struct nfsd4_fattr_args *args)
 {
@@ -3748,8 +3762,8 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
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
@@ -3968,6 +3982,13 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		args.fhp = tempfh;
 	} else
 		args.fhp = fhp;
+	if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
+			   FATTR4_WORD0_CASE_PRESERVING)) {
+		status = nfsd_get_case_info(dentry, &args.case_insensitive,
+					    &args.case_preserving);
+		if (status != nfs_ok)
+			goto out;
+	}
 
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);

-- 
2.53.0


