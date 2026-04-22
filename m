Return-Path: <linux-nfs+bounces-21014-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADUFFtxa6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21014-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:33:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CEE44BB2F
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23B3F302B730
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA4B346AE3;
	Wed, 22 Apr 2026 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvp+IDK6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4232C924;
	Wed, 22 Apr 2026 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900655; cv=none; b=kjItZ4xNqAxnV9+/TBKxV7cFSTQ7Yuq6c92Fk3+TG6uJrmiWjMe040xuA+7eOkIl3DaA4Yyq+QlN69OJNBFZX8/uKgVGr+6ilxRYLFXl+kbM1ahCeH1xxkq3zxPiN8cgxlMzCTVkWXVLpg8btykzSeJLbpPeiy4o6Gb/hlho/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900655; c=relaxed/simple;
	bh=XYKt46mg6wMVV2YdJGZU1apyeQ0MXeEOOUK+OVQco70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fOovFjfvVfdsphkx+wt0GqCFBiM8x28H3U9bvHuZJfZR5W55hk+VNwYxh8thQ/8hz2oEtr3P/fQZmIK0n6myfcUNeZXZIJX8dKjey3K9H1DN/4Kr8STpvoyNWGPALzfRhXFLr943NVisLXF8Gna4WbIHxnsxy8A9exOHQ0I0EUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvp+IDK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44931C2BCB6;
	Wed, 22 Apr 2026 23:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900655;
	bh=XYKt46mg6wMVV2YdJGZU1apyeQ0MXeEOOUK+OVQco70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lvp+IDK6TNvywIDdBKgvL/3FBZyiOSND1UZwuwpepvtodHyNQ22Rpk34z7o+XwD7e
	 fyilqzrwnSbby6n2hr7O3DctbkWKbzKvx2k0Xn65i9v0RzGxrhCR2ROLUZV6VOxxmx
	 KNNKvWsE7LuO14q556uqABaadKIo4VEx/tsqrj4Owh6T6kaqswuw+HCPI621rlyOdt
	 MtY/vdVGGzIwA0sR15y2Q4DJ1eibVovJKqQk/stPCh84oaddY17YdjxkD6OHLRwHBb
	 MaPRYrwaUyP+tSbkRuC774MSHfqcv8QJZzIidu8JZbHFb0OeXwZBfwSGMszKafe2i+
	 nFzpNjy2PD0rA==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 22 Apr 2026 19:30:10 -0400
Subject: [PATCH v9 16/17] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and
 FATTR4_CASE_PRESERVING
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-case-sensitivity-v9-16-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
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
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoGx7DVo78KMprpZqfGCN5WzT9tzWxff4Hog
 q9AnM+6V8KJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBgAKCRAzarMzb2Z/
 l36hD/0YyDllkoj3d155OKOQkF8QDlniZ5TxDzwN6u+gE1KDVIzqv9ACdZy4wbiVIyVZyldA6km
 mCWAACkKLFXvSOQwqeJqP5qCLohqRwSGMsFVMYCrDQ/l/ezJvzoeMi4ccEBQHv2vmAnFtaj+C4s
 y4wPiimVK2pyzH4Xc5A074f52x8ee3Zd5ws0eaoanY6qy88+VNUX9NhzY/Iog51+pC9HP3hKLLw
 azL6f1cOlWoVH4VSKU/WZK21p4+wJqS01TJNQqGXHRmkwNBj+qrxbRt8buy6qx7nuKEadblDPmm
 l+CXpMHexXB8w4HsTVM67NDtYC2ZefsnZP0nZJrtnUKraOVYqkhjp9CIkLlcUQkKFEfcKYO07pm
 tS94Cd6hYeMQQvM8uX7PgV3jWcnwhduqI2IoE0kqmQTwX6wEPYRkRgycoWP712C26vOeDh6l+ye
 909L40ArKd+qqRci1v5oQbNFWe3POYlJuTBPGEDBvVlRjNZ86AHdmQkRZ8+qLD5I6RhX45GT8qY
 FxpoFcBhefi2WYTfaL+ifCsXqCj4GlmwKD2d0yTpPTinJuMcF58kZ1n0RZDrCaGkDQ0acTBKtNo
 FCvwH05g9FPfui96PcgqM1strXBurb+2eDW1SWExz4UehYB10IK+49ihwvOlag8/A0ZsBtwHf+C
 +8qaVJ+Ww3Ta4/g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21014-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[32];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51CEE44BB2F
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


