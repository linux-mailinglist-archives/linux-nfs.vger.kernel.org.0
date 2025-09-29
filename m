Return-Path: <linux-nfs+bounces-14781-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B015BAA0F4
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 18:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171813C7ACE
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15273306480;
	Mon, 29 Sep 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0o39YJe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6831F5827
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164823; cv=none; b=G0+fT4yfy433CuzBmcTJ8+9zp/tOu+eMNpqaq5fNZ1HhBH+iCrxf4UUi3fglUWuFqf6lYgPIzzUWbUVt+UhxLfcmXEgsrdVC+mECsDWYIBTJmuinaESs/Yvdm13+Y9fS9pQM3e54vdS6+xM4nnO6lke1g+kpNrABfy9/Qxr7iwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164823; c=relaxed/simple;
	bh=ghZY/9CFg1195LQuZepQG4yfiaFfjMw4Fas7M3HHFOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o67zxfmGX+qTI0gjcpTK05MSHo+FchDzR4x85S1rB30+dhNixi6deGEnB4Gnjq1yKbkIhIvU6HJA+hm1NsbtyZ2aGZhfMpfnAknffAEdgG87JirKIErSqoCSNblrJoAiymPvZ3y/6o+5yRzJQLynDG1+xJVQ8SvGtbo+S9mWvhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0o39YJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA192C4CEF4;
	Mon, 29 Sep 2025 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759164823;
	bh=ghZY/9CFg1195LQuZepQG4yfiaFfjMw4Fas7M3HHFOo=;
	h=From:To:Cc:Subject:Date:From;
	b=C0o39YJeMEJHnKmtwGYpXdHOLWePj/Xa5L9iAjEDukes9I38IKrWPRtQir5wiJVcc
	 LB6gAhSlZfjP2rXHZnExNsvANuYUKb/vhBVh2b8GJUcBFrXOMVDe3vqEd54aHxCdug
	 8DMXXnCKfzEHPIpmcfNVvUN1qyvsVhm4RYjltpvi0wd6RUU86rcyKGV1Or+pPOVX9r
	 EZTmSBU/CxfgZqCYz9O0FAyXKtBRa83+2GuxLcqx6KxnCmEk7Hg4c18A42PlmKMgQ/
	 moDDkicQlgMxFK5/SNRakOLxpMYw7gXuS5BDEAMzc7JrUtzdDv11uBKXQA9gWF1ZDN
	 /b+j6hWPo4BSw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Robert Morris <rtm@csail.mit.edu>
Subject: [PATCH v2] NFSD: Define actions for the new time_deleg FATTR4 attributes
Date: Mon, 29 Sep 2025 12:53:40 -0400
Message-ID: <20250929165340.9493-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFSv4 clients won't send legitimate GETATTR requests for these new
attributes because they are intended to be used only with CB_GETATTR
and SETATTR. But NFSD has to do something besides crashing if it
ever sees a GETATTR request that queries these attributes.

RFC 8881 Section 18.7.3 states:

> The server MUST return a value for each attribute that the client
> requests if the attribute is supported by the server for the
> target file system. If the server does not support a particular
> attribute on the target file system, then it MUST NOT return the
> attribute value and MUST NOT set the attribute bit in the result
> bitmap. The server MUST return an error if it supports an
> attribute on the target but cannot obtain its value. In that case,
> no attribute values will be returned.

Further, RFC 9754 Section 5 states:

> These new attributes are invalid to be used with GETATTR, VERIFY,
> and NVERIFY, and they can only be used with CB_GETATTR and SETATTR
> by a client holding an appropriate delegation.

Thus there does not appear to be a specific server response mandated
by specification. Taking the guidance that querying these attributes
via GETATTR is "invalid", NFSD will return nfserr_inval, failing the
request entirely.

Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-nfs/7819419cf0cb50d8130dc6b747765d2b8febc88a.camel@kernel.org/T/#t
Fixes: 51c0d4f7e317 ("nfsd: add support for FATTR4_OPEN_ARGUMENTS")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f4a5e102b63a..e0eb4221cee6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2939,6 +2939,12 @@ struct nfsd4_fattr_args {
 typedef __be32(*nfsd4_enc_attr)(struct xdr_stream *xdr,
 				const struct nfsd4_fattr_args *args);
 
+static __be32 nfsd4_encode_fattr4__inval(struct xdr_stream *xdr,
+					 const struct nfsd4_fattr_args *args)
+{
+	return nfserr_inval;
+}
+
 static __be32 nfsd4_encode_fattr4__noop(struct xdr_stream *xdr,
 					const struct nfsd4_fattr_args *args)
 {
@@ -3560,6 +3566,8 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 
 	[FATTR4_MODE_UMASK]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_XATTR_SUPPORT]		= nfsd4_encode_fattr4_xattr_support,
+	[FATTR4_TIME_DELEG_ACCESS]	= nfsd4_encode_fattr4__inval,
+	[FATTR4_TIME_DELEG_MODIFY]	= nfsd4_encode_fattr4__inval,
 	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
 };
 
-- 
2.51.0


