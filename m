Return-Path: <linux-nfs+bounces-13003-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA0EB02E2F
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 01:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508DF1C216B1
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Jul 2025 23:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18472199FAC;
	Sat, 12 Jul 2025 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="SZfvfBCY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C3A148827;
	Sat, 12 Jul 2025 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752363024; cv=none; b=lWUW1mY4GP4gXNvMHVr8HsEMuip8Jh1pJZK57sOi+VU9il3eWzIfON+aN1ikWH7wL8syzXZ2oC9H/y3Ih7+kQ6jOV3yVX2U18ADThYqPRyxVFMrw1UBXzLBnjPgN6IG7U5oG/ufgJrDQ15GK4uVzAYiFZu2wcFA8pD674B18lu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752363024; c=relaxed/simple;
	bh=f1o1dx2y61GSffGtceFUq+5wsrv9fyS0SFcYQnkuCG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uzv2Ylw8QGYiFapbziUWFUDWKl5L7K5xkOBAx280bxtrB2YU723EPscBZMwgmA08flvdmGApiZ0NLh43z/aXNfwDfo6/LW7jlKWoilIWwjGXU1ZXHsxhYVibA+LC32UODollS9EzekfnZrSHFHgOSfyDhHAyss8Dqdd/W6/3f18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=SZfvfBCY; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=K+KSdRhs8a1sQ4i99tI4+NeVAjoNOoEOQKcClNvYkek=; b=SZfvfBCY5IuPAoMi
	zpPdGOLPXo9ll5Es/ZroSQGDtzUlGmt5r+P2bFMq4I8jx3kNbArBBx5Zj1tA62A7DeIHbTjlVR7+g
	Uw+9yPYH6/PVAvQKW15AWaOi4tWfi5K9Z07QVIGi9iJdUxQNBES8xLrr/nIbhSxdKp/2ilMjh+hLD
	TNI8SuXrdP+FPXzDfO5B3ST6dH1wf2datxLbhytIl6cJ6HyQLmS1pfM+7C+weaou5y4FyXZMEisvn
	C1uhE/ba3Ri/47sGxciPibVbF+hROvrijHk+dMalNO5rIxWUKe8fpIh2sAhcjgZY7HX2W8qOK+rch
	j6kgEpnO9KheB0uEag==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uajfU-00FkLl-0M;
	Sat, 12 Jul 2025 23:30:08 +0000
From: linux@treblig.org
To: chuck.lever@oracle.com,
	anna@kernel.org,
	trondmy@kernel.org,
	jlayton@kernel.org
Cc: neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] SUNRPC: Remove unused xdr functions
Date: Sun, 13 Jul 2025 00:30:06 +0100
Message-ID: <20250712233006.403226-1-linux@treblig.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Remove a bunch of unused xdr_*decode* functions:
  The last use of xdr_decode_netobj() was removed in 2021 by:
commit 7cf96b6d0104 ("lockd: Update the NLMv4 SHARE arguments decoder to
use struct xdr_stream")
  The last use of xdr_decode_string_inplace() was removed in 2021 by:
commit 3049e974a7c7 ("lockd: Update the NLMv4 FREE_ALL arguments decoder
to use struct xdr_stream")
  The last use of xdr_stream_decode_opaque() was removed in 2024 by:
commit fed8a17c61ff ("xdrgen: typedefs should use the built-in string and
opaque functions")

  The functions xdr_stream_decode_string() and
xdr_stream_decode_opaque_dup() were both added in 2018 by the
commit 0e779aa70308 ("SUNRPC: Add helpers for decoding opaque and string
types")
but never used.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/sunrpc/xdr.h |   9 ---
 net/sunrpc/xdr.c           | 110 -------------------------------------
 2 files changed, 119 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index a2ab813a9800..e370886632b0 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -128,10 +128,7 @@ xdr_buf_init(struct xdr_buf *buf, void *start, size_t len)
 __be32 *xdr_encode_opaque_fixed(__be32 *p, const void *ptr, unsigned int len);
 __be32 *xdr_encode_opaque(__be32 *p, const void *ptr, unsigned int len);
 __be32 *xdr_encode_string(__be32 *p, const char *s);
-__be32 *xdr_decode_string_inplace(__be32 *p, char **sp, unsigned int *lenp,
-			unsigned int maxlen);
 __be32 *xdr_encode_netobj(__be32 *p, const struct xdr_netobj *);
-__be32 *xdr_decode_netobj(__be32 *p, struct xdr_netobj *);
 
 void	xdr_inline_pages(struct xdr_buf *, unsigned int,
 			 struct page **, unsigned int, unsigned int);
@@ -341,12 +338,6 @@ xdr_stream_remaining(const struct xdr_stream *xdr)
 	return xdr->nwords << 2;
 }
 
-ssize_t xdr_stream_decode_opaque(struct xdr_stream *xdr, void *ptr,
-		size_t size);
-ssize_t xdr_stream_decode_opaque_dup(struct xdr_stream *xdr, void **ptr,
-		size_t maxlen, gfp_t gfp_flags);
-ssize_t xdr_stream_decode_string(struct xdr_stream *xdr, char *str,
-		size_t size);
 ssize_t xdr_stream_decode_string_dup(struct xdr_stream *xdr, char **str,
 		size_t maxlen, gfp_t gfp_flags);
 ssize_t xdr_stream_decode_opaque_auth(struct xdr_stream *xdr, u32 *flavor,
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 2ea00e354ba6..a0aae1144212 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -37,19 +37,6 @@ xdr_encode_netobj(__be32 *p, const struct xdr_netobj *obj)
 }
 EXPORT_SYMBOL_GPL(xdr_encode_netobj);
 
-__be32 *
-xdr_decode_netobj(__be32 *p, struct xdr_netobj *obj)
-{
-	unsigned int	len;
-
-	if ((len = be32_to_cpu(*p++)) > XDR_MAX_NETOBJ)
-		return NULL;
-	obj->len  = len;
-	obj->data = (u8 *) p;
-	return p + XDR_QUADLEN(len);
-}
-EXPORT_SYMBOL_GPL(xdr_decode_netobj);
-
 /**
  * xdr_encode_opaque_fixed - Encode fixed length opaque data
  * @p: pointer to current position in XDR buffer.
@@ -102,21 +89,6 @@ xdr_encode_string(__be32 *p, const char *string)
 }
 EXPORT_SYMBOL_GPL(xdr_encode_string);
 
-__be32 *
-xdr_decode_string_inplace(__be32 *p, char **sp,
-			  unsigned int *lenp, unsigned int maxlen)
-{
-	u32 len;
-
-	len = be32_to_cpu(*p++);
-	if (len > maxlen)
-		return NULL;
-	*lenp = len;
-	*sp = (char *) p;
-	return p + XDR_QUADLEN(len);
-}
-EXPORT_SYMBOL_GPL(xdr_decode_string_inplace);
-
 /**
  * xdr_terminate_string - '\0'-terminate a string residing in an xdr_buf
  * @buf: XDR buffer where string resides
@@ -2247,88 +2219,6 @@ int xdr_process_buf(const struct xdr_buf *buf, unsigned int offset,
 }
 EXPORT_SYMBOL_GPL(xdr_process_buf);
 
-/**
- * xdr_stream_decode_opaque - Decode variable length opaque
- * @xdr: pointer to xdr_stream
- * @ptr: location to store opaque data
- * @size: size of storage buffer @ptr
- *
- * Return values:
- *   On success, returns size of object stored in *@ptr
- *   %-EBADMSG on XDR buffer overflow
- *   %-EMSGSIZE on overflow of storage buffer @ptr
- */
-ssize_t xdr_stream_decode_opaque(struct xdr_stream *xdr, void *ptr, size_t size)
-{
-	ssize_t ret;
-	void *p;
-
-	ret = xdr_stream_decode_opaque_inline(xdr, &p, size);
-	if (ret <= 0)
-		return ret;
-	memcpy(ptr, p, ret);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(xdr_stream_decode_opaque);
-
-/**
- * xdr_stream_decode_opaque_dup - Decode and duplicate variable length opaque
- * @xdr: pointer to xdr_stream
- * @ptr: location to store pointer to opaque data
- * @maxlen: maximum acceptable object size
- * @gfp_flags: GFP mask to use
- *
- * Return values:
- *   On success, returns size of object stored in *@ptr
- *   %-EBADMSG on XDR buffer overflow
- *   %-EMSGSIZE if the size of the object would exceed @maxlen
- *   %-ENOMEM on memory allocation failure
- */
-ssize_t xdr_stream_decode_opaque_dup(struct xdr_stream *xdr, void **ptr,
-		size_t maxlen, gfp_t gfp_flags)
-{
-	ssize_t ret;
-	void *p;
-
-	ret = xdr_stream_decode_opaque_inline(xdr, &p, maxlen);
-	if (ret > 0) {
-		*ptr = kmemdup(p, ret, gfp_flags);
-		if (*ptr != NULL)
-			return ret;
-		ret = -ENOMEM;
-	}
-	*ptr = NULL;
-	return ret;
-}
-EXPORT_SYMBOL_GPL(xdr_stream_decode_opaque_dup);
-
-/**
- * xdr_stream_decode_string - Decode variable length string
- * @xdr: pointer to xdr_stream
- * @str: location to store string
- * @size: size of storage buffer @str
- *
- * Return values:
- *   On success, returns length of NUL-terminated string stored in *@str
- *   %-EBADMSG on XDR buffer overflow
- *   %-EMSGSIZE on overflow of storage buffer @str
- */
-ssize_t xdr_stream_decode_string(struct xdr_stream *xdr, char *str, size_t size)
-{
-	ssize_t ret;
-	void *p;
-
-	ret = xdr_stream_decode_opaque_inline(xdr, &p, size);
-	if (ret > 0) {
-		memcpy(str, p, ret);
-		str[ret] = '\0';
-		return strlen(str);
-	}
-	*str = '\0';
-	return ret;
-}
-EXPORT_SYMBOL_GPL(xdr_stream_decode_string);
-
 /**
  * xdr_stream_decode_string_dup - Decode and duplicate variable length string
  * @xdr: pointer to xdr_stream
-- 
2.50.1


