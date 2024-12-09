Return-Path: <linux-nfs+bounces-8482-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9D29EA107
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 22:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BEB282F13
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 21:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFA71A08C5;
	Mon,  9 Dec 2024 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGVdm4Jl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390391A08AF;
	Mon,  9 Dec 2024 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778863; cv=none; b=KfeZ4ZTqeKgir2eOv8OZwMePTSSynm+fuJDPUWpd36fj/jr/Q/HYiT1lLLiJh+7axd4tB2uYhEu8FDmXCjA0XOzSoltTqh+9gaMm6bYoh/CT4QBLGH67JLEclJkv80dCX/gy6LnwENct51N0tQTyYm1bKGDQZTAwYWu/1KT7mfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778863; c=relaxed/simple;
	bh=9WoUPZjHr8bK84+akahdLMLMXcoDDgjY9wWCKOM+HkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HiWdxGKrDLNvr9OXD9CFG4eHUmvKdciA+oQYIyRxAKiBpqe2Hjab5cd2ZpFlHx4aikP7iTmiq4+NGva3vpP5925TQT/WTuXXV4ubu57EeILsq7SPBtIZgvE0xY8SJNFI8k+++sQEjkJ1qRPHfVz+xkmOGm+V6lDfd/c4xs1zesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGVdm4Jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B12C4CEE4;
	Mon,  9 Dec 2024 21:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733778862;
	bh=9WoUPZjHr8bK84+akahdLMLMXcoDDgjY9wWCKOM+HkQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WGVdm4JlgZKwyrWIJtTh4T87O5x7SeMpbVTkF5QXHeP7UaF6hJJeGeae8+axUx/hE
	 0+BEYYwPNUDkfdSuqvzz9jatfilqBW/ntC1XA9cIOmWpTJNqQHBiBIwH2tFXSt6gra
	 /Vs51vIBRYRnFg2M0F1vnhsd6YTlo4SQCSWpJOA0f43ku7qvvLZW0zuHm+Ngcoq0k/
	 VJYR0rExhIaqj2LyfSbOM4hRlII0GZfNw4527P4RYUw7g4Ya5fhAN5caCrCQt0ycyQ
	 tImtJYoU1zLQl/acJMl7Ty3RuhotxHF6cS2A2CSq3pNpauIyn2bXdhrELftZdJUCGM
	 OY/t1ptI1MWiA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 09 Dec 2024 16:13:58 -0500
Subject: [PATCH v5 06/10] nfsd: add support for FATTR4_OPEN_ARGUMENTS
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-delstid-v5-6-42308228f692@kernel.org>
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
In-Reply-To: <20241209-delstid-v5-0-42308228f692@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3826; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9WoUPZjHr8bK84+akahdLMLMXcoDDgjY9wWCKOM+HkQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnV12lqKSDRdIiTE1ufOsYdle1KCEQAxu9zlT3v
 3HLsSEXd9+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ1ddpQAKCRAADmhBGVaC
 FdB/EACwVd+VXDypvgUJ7QQO15F0DNal7mIHMf8+1p16ZFS+9PnQqKZ23MeA+X9R3UaxUgfO6Fg
 tcEprOXFlkejEo/HZiWUvkpZ9RZgTH19zBraZ+aG0u7hgdcoVzaqkFcWQ0amFL+y5KLt3N+cS8Y
 NPcvRzOzWeENic3ZUvseztcRCSfZ6C8uem6FijAX21NtfSUBsJbqtKl8wg74l5PaQ6kAldbNVIY
 ESvS82TlJsFoRNBSLFoBtlORXw2PPF92QN4udBPp/jq+c0dbUvIqLbO17fJFTfTHzu8WCKW4ze5
 1ytGgSyD8iriy0S4Ysn2ceI/AYwQXzrcKQn0qbWjaKxKbHgK9rvD+ICpT6H2e4DouJeT2EJz1Ly
 4Jj1Z4+zQOZ/uVmFJWPpX8UU5VA+sSGk4rUohh8K4ntb2CkQP0FrsyF+qhAe1/ZKHC3l856nDHo
 Q3OzuMVAI3XCvnODl/8qkFK0HWtayfwTF3gJr1Lw7SjrgVgSpc4y0Z9EuT236sFJp7X64u76fEM
 ogkGP6b68CpwnOA/Fo+qOhjUB5FBYeP0uWIVVPztk2alC5GsDZhwB08fRGXg4LWoQE431C7jOhF
 8PrArZmQlJbniWvXPxEzUmIYrPPD/czXwhQuFeS5Q0uqpLzabm1cpuoJ29uSW/ee1QPml5Kjq4C
 If1wa2cab7QqMLQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add support for FATTR4_OPEN_ARGUMENTS. This a new mechanism for the
client to discover what OPEN features the server supports.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  3 ++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8c48da421a07bf460ace6eddc140ed5fedffd408..3006406aac8332e27ca9310288c724954f804e75 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -55,6 +55,7 @@
 #include "netns.h"
 #include "pnfs.h"
 #include "filecache.h"
+#include "nfs4xdr_gen.h"
 
 #include "trace.h"
 
@@ -3387,6 +3388,54 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 	return nfsd4_encode_bool(xdr, err == 0);
 }
 
+#define NFSD_OA_SHARE_ACCESS	(BIT(OPEN_ARGS_SHARE_ACCESS_READ)	| \
+				 BIT(OPEN_ARGS_SHARE_ACCESS_WRITE)	| \
+				 BIT(OPEN_ARGS_SHARE_ACCESS_BOTH))
+
+#define NFSD_OA_SHARE_DENY	(BIT(OPEN_ARGS_SHARE_DENY_NONE)		| \
+				 BIT(OPEN_ARGS_SHARE_DENY_READ)		| \
+				 BIT(OPEN_ARGS_SHARE_DENY_WRITE)	| \
+				 BIT(OPEN_ARGS_SHARE_DENY_BOTH))
+
+#define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL))
+
+#define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_PREVIOUS)	| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR)	| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV)| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_FH)		| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH)	| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH))
+
+#define NFSD_OA_CREATE_MODE	(BIT(OPEN_ARGS_CREATEMODE_UNCHECKED4)	| \
+				 BIT(OPEN_ARGS_CREATE_MODE_GUARDED)	| \
+				 BIT(OPEN_ARGS_CREATEMODE_EXCLUSIVE4)	| \
+				 BIT(OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1))
+
+static uint32_t oa_share_access = NFSD_OA_SHARE_ACCESS;
+static uint32_t oa_share_deny = NFSD_OA_SHARE_DENY;
+static uint32_t oa_share_access_want = NFSD_OA_SHARE_ACCESS_WANT;
+static uint32_t oa_open_claim = NFSD_OA_OPEN_CLAIM;
+static uint32_t oa_create_mode = NFSD_OA_CREATE_MODE;
+
+static const struct open_arguments4 nfsd_open_arguments = {
+	.oa_share_access = { .count = 1, .element = &oa_share_access },
+	.oa_share_deny = { .count = 1, .element = &oa_share_deny },
+	.oa_share_access_want = { .count = 1, .element = &oa_share_access_want },
+	.oa_open_claim = { .count = 1, .element = &oa_open_claim },
+	.oa_create_mode = { .count = 1, .element = &oa_create_mode },
+};
+
+static __be32 nfsd4_encode_fattr4_open_arguments(struct xdr_stream *xdr,
+						 const struct nfsd4_fattr_args *args)
+{
+	if (!xdrgen_encode_fattr4_open_arguments(xdr, &nfsd_open_arguments))
+		return nfserr_resource;
+	return nfs_ok;
+}
+
 static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_SUPPORTED_ATTRS]	= nfsd4_encode_fattr4_supported_attrs,
 	[FATTR4_TYPE]			= nfsd4_encode_fattr4_type,
@@ -3487,6 +3536,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 
 	[FATTR4_MODE_UMASK]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_XATTR_SUPPORT]		= nfsd4_encode_fattr4_xattr_support,
+	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
 };
 
 /*
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4b56ba1e8e48d08c4e3e52f378822c311193c3d4..1955c8e9c4c793728fa75dd136cadc735245483f 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -458,7 +458,8 @@ enum {
 	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
 	FATTR4_WORD2_MODE_UMASK | \
 	NFSD4_2_SECURITY_ATTRS | \
-	FATTR4_WORD2_XATTR_SUPPORT)
+	FATTR4_WORD2_XATTR_SUPPORT | \
+	FATTR4_WORD2_OPEN_ARGUMENTS)
 
 extern const u32 nfsd_suppattrs[3][3];
 

-- 
2.47.1


