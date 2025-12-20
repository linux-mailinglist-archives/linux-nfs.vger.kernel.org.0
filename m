Return-Path: <linux-nfs+bounces-17246-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCE8CD3256
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Dec 2025 16:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07BB730109BB
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Dec 2025 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AF21DD525;
	Sat, 20 Dec 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/DfFNu8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2E1C69D
	for <linux-nfs@vger.kernel.org>; Sat, 20 Dec 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766245274; cv=none; b=BGoTAEBgWgVUEHt9smLF9FwvTK0gfaEs5vjaMGwuRZagI8yHQxyNz9hUdv4VXqwX6nQT5y1yz9yVkRNpxjaWOUNliD1GA5DCWWNk28wm93+sU+TXHxCSIb59Px8P2fEi9SqRQS1u8R9Ri4RCXxBkD68KIYlXQIDFX6q/mlgTjWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766245274; c=relaxed/simple;
	bh=TzatdKc3pZdlRLVQSvskOM9Zal0iaH+JX38I+17welo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tO6cJALP+7fFI6FZkilCZy7SidNcdM+iU0/60pb38rAxodd4wZUJ6Hn1F04bUtS2cGpbyZknFkSXz4LEAmodru9DLoCh6uo1BWHRTc6USDFmPPjT73eUdw/q0F/2gqAQGetIpPjaoSxObw7zNzMqF9QtUsuv01q1Rm1xbjL0ZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/DfFNu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249CCC4CEF5;
	Sat, 20 Dec 2025 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766245273;
	bh=TzatdKc3pZdlRLVQSvskOM9Zal0iaH+JX38I+17welo=;
	h=From:To:Cc:Subject:Date:From;
	b=D/DfFNu8Ec/6Ro7y63u2xVMUOQQfCEF1cYM6e14hliH5LkDXsf8iG1kSKTPuxNdRt
	 Imi3E77Q2IMqy+L7V+kxqVLZMOQ9hoXDCIS24jZrB6jSCMee9Lw5joq10QJQOYUzN4
	 aE+1IK6Q5BTD2nINxoK3FyOFcmZqf3U/MMwn7k7Hhql1/yEkQbhTFek3PmIZ5R5USL
	 eOitoQhzNeqxMlzPk7PKEtgNniHFWlKXzGF3XHHyFik01yWK0aOjavnx4QayW7Blb4
	 BSXmp8guFPczQ2HbBWpgSnVavY7f0moV2rAZXAmRli92b+46UOTTsT/G7PaOK0qS//
	 Kkhr2SWYFJUJg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] SUNRPC: xdrgen: Initialize data pointer for zero-length items
Date: Sat, 20 Dec 2025 10:41:09 -0500
Message-ID: <20251220154109.1361512-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The xdrgen decoders for strings and opaque data had an
optimization that skipped calling xdr_inline_decode() when the
item length was zero. This left the data pointer uninitialized,
which could lead to unpredictable behavior when callers access
it.

Remove the zero-length check and always call xdr_inline_decode().
When passed a length of zero, xdr_inline_decode() returns the
current buffer position, which is valid and matches the behavior
of hand-coded XDR decoders throughout the kernel.

Fixes: 4b132aacb076 ("tools: Add xdrgen")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdrgen/_builtins.h | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/xdrgen/_builtins.h b/include/linux/sunrpc/xdrgen/_builtins.h
index 52ed9a9151c4..a723fb1da9c8 100644
--- a/include/linux/sunrpc/xdrgen/_builtins.h
+++ b/include/linux/sunrpc/xdrgen/_builtins.h
@@ -248,12 +248,10 @@ xdrgen_decode_string(struct xdr_stream *xdr, string *ptr, u32 maxlen)
 		return false;
 	if (unlikely(maxlen && len > maxlen))
 		return false;
-	if (len != 0) {
-		p = xdr_inline_decode(xdr, len);
-		if (unlikely(!p))
-			return false;
-		ptr->data = (unsigned char *)p;
-	}
+	p = xdr_inline_decode(xdr, len);
+	if (unlikely(!p))
+		return false;
+	ptr->data = (unsigned char *)p;
 	ptr->len = len;
 	return true;
 }
@@ -279,12 +277,10 @@ xdrgen_decode_opaque(struct xdr_stream *xdr, opaque *ptr, u32 maxlen)
 		return false;
 	if (unlikely(maxlen && len > maxlen))
 		return false;
-	if (len != 0) {
-		p = xdr_inline_decode(xdr, len);
-		if (unlikely(!p))
-			return false;
-		ptr->data = (u8 *)p;
-	}
+	p = xdr_inline_decode(xdr, len);
+	if (unlikely(!p))
+		return false;
+	ptr->data = (u8 *)p;
 	ptr->len = len;
 	return true;
 }
-- 
2.52.0


