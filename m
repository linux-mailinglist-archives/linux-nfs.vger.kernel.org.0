Return-Path: <linux-nfs+bounces-19451-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFCZB51no2kkCgUAu9opvQ
	(envelope-from <linux-nfs+bounces-19451-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 23:09:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9049D1C9611
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 23:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D0553002B75
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 22:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589D03AE6F6;
	Sat, 28 Feb 2026 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tsdl+Bfr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E738D012;
	Sat, 28 Feb 2026 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772316566; cv=none; b=OmmETtiixejOoFyuMbks4XTp5nY2arjiyqS+3NRg/1lz9ljjgNywfiZLyfzmMy05yMUoWRxYvGttUQNrUGF0pbKgRddiFqCLCAlbo+GBmMRWINl4I/NkVt7hY2LTatX8MlOBXILOnO/d6Kct+A38q07zhTF7yZLZyO1iJJ6WTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772316566; c=relaxed/simple;
	bh=BzZLDSW9Vc4YmrZNH3drbw8JdU2/nStx3ugUVjGmZrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQfBGbFkowEQNihzZJTthYGkMqiDEIw8wuU5WQuWciR0JCiUw9CqOfO1m+IyVAdvtu7CrtK8Kiode3UgkRAxmbnZphH5jg6DlVvPygM9wahYFzWuH4exkpp9cL2vEQtkAwG156FT/fm0iXZQNBVD9oEDUj+rdHmuQtXp8J4mGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tsdl+Bfr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=GEaMYXQvIbws8WgpaGOJMhToMWCr1KGELIU3EyPtuH8=; b=Tsdl+BfrNJKVzLYQdlbzwU65A1
	NlTgpl/TI8m0sNdQ5WEF7FoUH3pPAEjQo2Su3smPpaO2Yz7IQMzFNo8hnMdZKEiyGvxW5Mrsyacz4
	E3CRkRZpNDBztPB9YuTjHe6fu81yOVKw4Tp0UVC1RBIV03Ad+8ggbUpjwtpJm3X9usrQrhqRTHj61
	cP6KFp9ERDMV+YjwhTCuOcp3R2sUBYgM5eSTMAP4FdbJEaASno7/wyhU1NyFZ5ftld8lqgu3GXDmh
	oQ88eLtgtK75S33GN5JhT6kXkIxN28LAcCo16KBVk3DYWaInEv/LF4FRy64xQ8LuH3zuZp3qZlbc2
	GX/Oe4sw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwSV0-0000000AJbJ-3l6T;
	Sat, 28 Feb 2026 22:09:22 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: xdr.h: fix all kernel-doc warnings
Date: Sat, 28 Feb 2026 14:09:22 -0800
Message-ID: <20260228220922.2982492-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19451-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 9049D1C9611
X-Rspamd-Action: no action

Correct a function parameter name (s/page/folio/) and add function
return value sections for multiple functions to eliminate
kernel-doc warnings:

Warning: include/linux/sunrpc/xdr.h:298 function parameter 'folio' not
 described in 'xdr_set_scratch_folio'
Warning: include/linux/sunrpc/xdr.h:337 No description found for return
 value of 'xdr_stream_remaining'
Warning: include/linux/sunrpc/xdr.h:357 No description found for return
 value of 'xdr_align_size'
Warning: include/linux/sunrpc/xdr.h:374 No description found for return
 value of 'xdr_pad_size'
Warning: include/linux/sunrpc/xdr.h:387 No description found for return
 value of 'xdr_stream_encode_item_present'


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org

 include/linux/sunrpc/xdr.h |   48 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

--- linux-next-20260205.orig/include/linux/sunrpc/xdr.h
+++ linux-next-20260205/include/linux/sunrpc/xdr.h
@@ -290,7 +290,7 @@ xdr_set_scratch_buffer(struct xdr_stream
 /**
  * xdr_set_scratch_folio - Attach a scratch buffer for decoding data
  * @xdr: pointer to xdr_stream struct
- * @page: an anonymous folio
+ * @folio: an anonymous folio
  *
  * See xdr_set_scratch_buffer().
  */
@@ -330,7 +330,7 @@ static inline void xdr_commit_encode(str
  * xdr_stream_remaining - Return the number of bytes remaining in the stream
  * @xdr: pointer to struct xdr_stream
  *
- * Return value:
+ * Returns:
  *   Number of bytes remaining in @xdr before xdr->end
  */
 static inline size_t
@@ -350,7 +350,7 @@ ssize_t xdr_stream_encode_opaque_auth(st
  * xdr_align_size - Calculate padded size of an object
  * @n: Size of an object being XDR encoded (in bytes)
  *
- * Return value:
+ * Returns:
  *   Size (in bytes) of the object including xdr padding
  */
 static inline size_t
@@ -368,7 +368,7 @@ xdr_align_size(size_t n)
  * This implementation avoids the need for conditional
  * branches or modulo division.
  *
- * Return value:
+ * Returns:
  *   Size (in bytes) of the needed XDR pad
  */
 static inline size_t xdr_pad_size(size_t n)
@@ -380,7 +380,7 @@ static inline size_t xdr_pad_size(size_t
  * xdr_stream_encode_item_present - Encode a "present" list item
  * @xdr: pointer to xdr_stream
  *
- * Return values:
+ * Returns:
  *   On success, returns length in bytes of XDR buffer consumed
  *   %-EMSGSIZE on XDR buffer overflow
  */
@@ -399,7 +399,7 @@ static inline ssize_t xdr_stream_encode_
  * xdr_stream_encode_item_absent - Encode a "not present" list item
  * @xdr: pointer to xdr_stream
  *
- * Return values:
+ * Returns:
  *   On success, returns length in bytes of XDR buffer consumed
  *   %-EMSGSIZE on XDR buffer overflow
  */
@@ -419,7 +419,7 @@ static inline int xdr_stream_encode_item
  * @p: address in a buffer into which to encode
  * @n: boolean value to encode
  *
- * Return value:
+ * Returns:
  *   Address of item following the encoded boolean
  */
 static inline __be32 *xdr_encode_bool(__be32 *p, u32 n)
@@ -433,7 +433,7 @@ static inline __be32 *xdr_encode_bool(__
  * @xdr: pointer to xdr_stream
  * @n: boolean value to encode
  *
- * Return values:
+ * Returns:
  *   On success, returns length in bytes of XDR buffer consumed
  *   %-EMSGSIZE on XDR buffer overflow
  */
@@ -453,7 +453,7 @@ static inline int xdr_stream_encode_bool
  * @xdr: pointer to xdr_stream
  * @n: integer to encode
  *
- * Return values:
+ * Returns:
  *   On success, returns length in bytes of XDR buffer consumed
  *   %-EMSGSIZE on XDR buffer overflow
  */
@@ -474,7 +474,7 @@ xdr_stream_encode_u32(struct xdr_stream
  * @xdr: pointer to xdr_stream
  * @n: integer to encode
  *
- * Return values:
+ * Returns:
  *   On success, returns length in bytes of XDR buffer consumed
  *   %-EMSGSIZE on XDR buffer overflow
  */
@@ -495,7 +495,7 @@ xdr_stream_encode_be32(struct xdr_stream
  * @xdr: pointer to xdr_stream
  * @n: 64-bit integer to encode
  *
- * Return values:
+ * Returns:
  *   On success, returns length in bytes of XDR buffer consumed
  *   %-EMSGSIZE on XDR buffer overflow
  */
@@ -517,7 +517,7 @@ xdr_stream_encode_u64(struct xdr_stream
  * @ptr: pointer to void pointer
  * @len: size of object
  *
- * Return values:
+ * Returns:
  *   On success, returns length in bytes of XDR buffer consumed
  *   %-EMSGSIZE on XDR buffer overflow
  */
@@ -542,7 +542,7 @@ xdr_stream_encode_opaque_inline(struct x
  * @ptr: pointer to opaque data object
  * @len: size of object pointed to by @ptr
  *
- * Return values:
+ * Returns:
  *   On success, returns length in bytes of XDR buffer consumed
  *   %-EMSGSIZE on XDR buffer overflow
  */
@@ -563,7 +563,7 @@ xdr_stream_encode_opaque_fixed(struct xd
  * @ptr: pointer to opaque data object
  * @len: size of object pointed to by @ptr
  *
- * Return values:
+ * Returns:
  *   On success, returns length in bytes of XDR buffer consumed
  *   %-EMSGSIZE on XDR buffer overflow
  */
@@ -585,7 +585,7 @@ xdr_stream_encode_opaque(struct xdr_stre
  * @array: array of integers
  * @array_size: number of elements in @array
  *
- * Return values:
+ * Returns:
  *   On success, returns length in bytes of XDR buffer consumed
  *   %-EMSGSIZE on XDR buffer overflow
  */
@@ -608,7 +608,7 @@ xdr_stream_encode_uint32_array(struct xd
  * xdr_item_is_absent - symbolically handle XDR discriminators
  * @p: pointer to undecoded discriminator
  *
- * Return values:
+ * Returns:
  *   %true if the following XDR item is absent
  *   %false if the following XDR item is present
  */
@@ -621,7 +621,7 @@ static inline bool xdr_item_is_absent(co
  * xdr_item_is_present - symbolically handle XDR discriminators
  * @p: pointer to undecoded discriminator
  *
- * Return values:
+ * Returns:
  *   %true if the following XDR item is present
  *   %false if the following XDR item is absent
  */
@@ -635,7 +635,7 @@ static inline bool xdr_item_is_present(c
  * @xdr: pointer to xdr_stream
  * @ptr: pointer to a u32 in which to store the result
  *
- * Return values:
+ * Returns:
  *   %0 on success
  *   %-EBADMSG on XDR buffer overflow
  */
@@ -656,7 +656,7 @@ xdr_stream_decode_bool(struct xdr_stream
  * @xdr: pointer to xdr_stream
  * @ptr: location to store integer
  *
- * Return values:
+ * Returns:
  *   %0 on success
  *   %-EBADMSG on XDR buffer overflow
  */
@@ -677,7 +677,7 @@ xdr_stream_decode_u32(struct xdr_stream
  * @xdr: pointer to xdr_stream
  * @ptr: location to store integer
  *
- * Return values:
+ * Returns:
  *   %0 on success
  *   %-EBADMSG on XDR buffer overflow
  */
@@ -698,7 +698,7 @@ xdr_stream_decode_be32(struct xdr_stream
  * @xdr: pointer to xdr_stream
  * @ptr: location to store 64-bit integer
  *
- * Return values:
+ * Returns:
  *   %0 on success
  *   %-EBADMSG on XDR buffer overflow
  */
@@ -720,7 +720,7 @@ xdr_stream_decode_u64(struct xdr_stream
  * @ptr: location to store data
  * @len: size of buffer pointed to by @ptr
  *
- * Return values:
+ * Returns:
  *   %0 on success
  *   %-EBADMSG on XDR buffer overflow
  */
@@ -746,7 +746,7 @@ xdr_stream_decode_opaque_fixed(struct xd
  * on @xdr. It is therefore expected that the object it points to should
  * be processed immediately.
  *
- * Return values:
+ * Returns:
  *   On success, returns size of object stored in *@ptr
  *   %-EBADMSG on XDR buffer overflow
  *   %-EMSGSIZE if the size of the object would exceed @maxlen
@@ -777,7 +777,7 @@ xdr_stream_decode_opaque_inline(struct x
  * @array: location to store the integer array or NULL
  * @array_size: number of elements to store
  *
- * Return values:
+ * Returns:
  *   On success, returns number of elements stored in @array
  *   %-EBADMSG on XDR buffer overflow
  *   %-EMSGSIZE if the size of the array exceeds @array_size

