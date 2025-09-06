Return-Path: <linux-nfs+bounces-14112-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0955B4783E
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Sep 2025 01:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5433BD900
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 23:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2B27780C;
	Sat,  6 Sep 2025 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnhowdjX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE16A1C32FF;
	Sat,  6 Sep 2025 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757199657; cv=none; b=FTy5BAXoftStgUG+Q69/5e1lVCPhdvM9ouDnWdFmBVwqcOtkM20tUPpVtVC1qppDrr1ti748f0Fm/0ygLJmXG+uyiSg75cfR74OF1J14BGypSRyKSOZfjtxTmo1Jmd2jirRGaCABq6uB3A8k7NtUxDnRYWxOenFbSnwy4GXUVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757199657; c=relaxed/simple;
	bh=W4crxD5ZxD9MobQp2TG9BZxgFUpS+HqHgA3HF060leA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rv174z/rilIU10O5z0wupDcbScVE7K++fgrQBk5Y65yjOZ5UNaATf7El7ij4W9sk9UqMNu+ssMy2Qp4LUBQ0g7oc9H0HlLA6y1GRv1OeC+JLJoFWmFQUKZxhhMr4a1LeO0z99M72TKPLlyP9vUNw14M6BiwWVC7V93RL1163ruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnhowdjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12D1C4CEE7;
	Sat,  6 Sep 2025 23:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757199657;
	bh=W4crxD5ZxD9MobQp2TG9BZxgFUpS+HqHgA3HF060leA=;
	h=From:To:Cc:Subject:Date:From;
	b=SnhowdjXGNVO5C4W4Wye/UURz2Lm8s7jvues26ODSli++I1VMazfpDGLZKW3/KXQU
	 abVahEzvqZDFmTl+++5hMX3zhFrR8Nd7M89M6+14MEH1nDpnar1KsRu6C9nybmgiUc
	 YBjWsl3K1CYzT3VPoEKl+C0TfKFkTtnlAu2dOcXFxuxnZYlWsa2JL3yh5YqXnphyxK
	 AcmWEHq4YgAVtsYd6PqbNyxr/ccdabP5coUJj33UPLzNaRRDitMy5/JEg5LZ3Dxi0U
	 YlSerdaNowu/zw6eGzLAEKI4nJS1zSj3dAq0hfZXGHlyNsRRUh6jznTRhYNhwCgeUF
	 LnQzuQWO+mmNg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-crypto@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it
Date: Sat,  6 Sep 2025 16:00:19 -0700
Message-ID: <20250906230019.94569-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it.  This
unblocks the eventual removal of the selection of CRYPTO from NFSD_V4,
which will no longer be needed by nfsd itself due to switching to the
crypto library functions.  But NFSD_V4 selects RPCSEC_GSS_KRB5, which
still needs CRYPTO.  It makes more sense for RPCSEC_GSS_KRB5 to select
CRYPTO itself, like most other kconfig options that need CRYPTO do.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 net/sunrpc/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index 2d8b67dac7b5b..33aafdc8392e3 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -16,13 +16,14 @@ config SUNRPC_SWAP
 	bool
 	depends on SUNRPC
 
 config RPCSEC_GSS_KRB5
 	tristate "Secure RPC: Kerberos V mechanism"
-	depends on SUNRPC && CRYPTO
+	depends on SUNRPC
 	default y
 	select SUNRPC_GSS
+	select CRYPTO
 	select CRYPTO_SKCIPHER
 	select CRYPTO_HASH
 	help
 	  Choose Y here to enable Secure RPC using the Kerberos version 5
 	  GSS-API mechanism (RFC 1964).

base-commit: 4a0de50a44bb11ea67bb3ca961844b55ac57cf05
-- 
2.50.1


