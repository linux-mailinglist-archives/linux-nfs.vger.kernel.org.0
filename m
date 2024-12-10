Return-Path: <linux-nfs+bounces-8490-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE95C9EA40B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 02:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9D516804F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 01:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBDC70830;
	Tue, 10 Dec 2024 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="fGaDUc+v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224804C6C;
	Tue, 10 Dec 2024 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792572; cv=none; b=jcK5TZsflKQfw81ueZ7dsFHHTxwukl5hFr+LBiZ8zCTySm4QvFOJMLR7cuWD+tc+QimTDfn1GhBvlHz9E2YeRWLN0F8PPN/FvXcv59fOQzf/WeCQYzSYUUg3fnCvg1uxlvlgZPA8KW5JvUUTduJqKs8l6zvEq3DmeQdoFdMukVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792572; c=relaxed/simple;
	bh=q9aH6cg69qeeSABzW4tlMZZpt7twAzI9xN37hEWYAw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+CN4IF3qpZLf3LfV6v4oNewO2bobhfrcLLEdJh+M28REynBTGtziY/YF7tYl2CzAePyM0BL2HSDhUHK/WM7OWWsJD4GR8egyCghRKbi0c2EXZWiJgFFRX9X9Fi7wnBAGy7cIyNqDmYG6MoBQ5nEjdP0/eU1o52MwPl0I3HBE+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=fGaDUc+v; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=MCO32nEYMapchWmRtsISa3pnMm+DUILZP8k/5DytmfQ=; b=fGaDUc+vIchUdi5U
	tHKAKBo62YH/tN+z18NkpL+DM4a+RIc/mbtRUmjsrpus1v7LpJjAmyafsiW0SWEDrgeuYUeEYdl2W
	gLSthTCt5wOmuq6Nj90Uj9zpFkipXAgdkc5Jw69S+9ypLlEGKWvmR9QmoXazBKWJzpxfil5uotfS8
	YIbg8o1LtyNwe1lIrz7gJqddYNcGs8KQBq1Hn7mMjcqT3wXtDg0TN9CdW6VxXFF+cXHuEJwxIE6cI
	0MHeV7sEG/ycUqxvWEE+AAMt8VAYLc49fbHSWe0wMKkGxjZJpykCsRwAcreqRlijyVxB9pvdTiglS
	X/kvDgXuK6oWZMWYjw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tKodz-004Oea-1f;
	Tue, 10 Dec 2024 01:02:31 +0000
From: linux@treblig.org
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-nfs@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] sunrpc: Remove gss_generic_token deadcode
Date: Tue, 10 Dec 2024 01:02:24 +0000
Message-ID: <20241210010225.343017-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210010225.343017-1-linux@treblig.org>
References: <20241210010225.343017-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Commit ec596aaf9b48 ("SUNRPC: Remove code behind
CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED") was the last user of the routines
in gss_generic_token.c.

Remove the routines and associated header.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/sunrpc/gss_asn1.h         |  81 ---------
 include/linux/sunrpc/gss_krb5.h         |   1 -
 net/sunrpc/auth_gss/Makefile            |   2 +-
 net/sunrpc/auth_gss/gss_generic_token.c | 231 ------------------------
 net/sunrpc/auth_gss/gss_mech_switch.c   |   1 -
 5 files changed, 1 insertion(+), 315 deletions(-)
 delete mode 100644 include/linux/sunrpc/gss_asn1.h
 delete mode 100644 net/sunrpc/auth_gss/gss_generic_token.c

diff --git a/include/linux/sunrpc/gss_asn1.h b/include/linux/sunrpc/gss_asn1.h
deleted file mode 100644
index 3ccecd0ad229..000000000000
--- a/include/linux/sunrpc/gss_asn1.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- *  linux/include/linux/sunrpc/gss_asn1.h
- *
- *  minimal asn1 for generic encoding/decoding of gss tokens
- *
- *  Adapted from MIT Kerberos 5-1.2.1 lib/include/krb5.h,
- *  lib/gssapi/krb5/gssapiP_krb5.h, and others
- *
- *  Copyright (c) 2000 The Regents of the University of Michigan.
- *  All rights reserved.
- *
- *  Andy Adamson   <andros@umich.edu>
- */
-
-/*
- * Copyright 1995 by the Massachusetts Institute of Technology.
- * All Rights Reserved.
- *
- * Export of this software from the United States of America may
- *   require a specific license from the United States Government.
- *   It is the responsibility of any person or organization contemplating
- *   export to obtain such a license before exporting.
- *
- * WITHIN THAT CONSTRAINT, permission to use, copy, modify, and
- * distribute this software and its documentation for any purpose and
- * without fee is hereby granted, provided that the above copyright
- * notice appear in all copies and that both that copyright notice and
- * this permission notice appear in supporting documentation, and that
- * the name of M.I.T. not be used in advertising or publicity pertaining
- * to distribution of the software without specific, written prior
- * permission.  Furthermore if you modify this software you must label
- * your software as modified software and not distribute it in such a
- * fashion that it might be confused with the original M.I.T. software.
- * M.I.T. makes no representations about the suitability of
- * this software for any purpose.  It is provided "as is" without express
- * or implied warranty.
- *
- */
-
-
-#include <linux/sunrpc/gss_api.h>
-
-#define SIZEOF_INT 4
-
-/* from gssapi_err_generic.h */
-#define G_BAD_SERVICE_NAME                       (-2045022976L)
-#define G_BAD_STRING_UID                         (-2045022975L)
-#define G_NOUSER                                 (-2045022974L)
-#define G_VALIDATE_FAILED                        (-2045022973L)
-#define G_BUFFER_ALLOC                           (-2045022972L)
-#define G_BAD_MSG_CTX                            (-2045022971L)
-#define G_WRONG_SIZE                             (-2045022970L)
-#define G_BAD_USAGE                              (-2045022969L)
-#define G_UNKNOWN_QOP                            (-2045022968L)
-#define G_NO_HOSTNAME                            (-2045022967L)
-#define G_BAD_HOSTNAME                           (-2045022966L)
-#define G_WRONG_MECH                             (-2045022965L)
-#define G_BAD_TOK_HEADER                         (-2045022964L)
-#define G_BAD_DIRECTION                          (-2045022963L)
-#define G_TOK_TRUNC                              (-2045022962L)
-#define G_REFLECT                                (-2045022961L)
-#define G_WRONG_TOKID                            (-2045022960L)
-
-#define g_OID_equal(o1,o2) \
-   (((o1)->len == (o2)->len) && \
-    (memcmp((o1)->data,(o2)->data,(int) (o1)->len) == 0))
-
-u32 g_verify_token_header(
-     struct xdr_netobj *mech,
-     int *body_size,
-     unsigned char **buf_in,
-     int toksize);
-
-int g_token_size(
-     struct xdr_netobj *mech,
-     unsigned int body_size);
-
-void g_make_token_header(
-     struct xdr_netobj *mech,
-     int body_size,
-     unsigned char **buf);
diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 78a80bf3fdcb..43950b5237c8 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -40,7 +40,6 @@
 #include <crypto/skcipher.h>
 #include <linux/sunrpc/auth_gss.h>
 #include <linux/sunrpc/gss_err.h>
-#include <linux/sunrpc/gss_asn1.h>
 
 /* Length of constant used in key derivation */
 #define GSS_KRB5_K5CLENGTH (5)
diff --git a/net/sunrpc/auth_gss/Makefile b/net/sunrpc/auth_gss/Makefile
index ad1736d93b76..452f67deebc6 100644
--- a/net/sunrpc/auth_gss/Makefile
+++ b/net/sunrpc/auth_gss/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_SUNRPC_GSS) += auth_rpcgss.o
 
-auth_rpcgss-y := auth_gss.o gss_generic_token.o \
+auth_rpcgss-y := auth_gss.o \
 	gss_mech_switch.o svcauth_gss.o \
 	gss_rpc_upcall.o gss_rpc_xdr.o trace.o
 
diff --git a/net/sunrpc/auth_gss/gss_generic_token.c b/net/sunrpc/auth_gss/gss_generic_token.c
deleted file mode 100644
index 4a4082bb22ad..000000000000
--- a/net/sunrpc/auth_gss/gss_generic_token.c
+++ /dev/null
@@ -1,231 +0,0 @@
-/*
- *  linux/net/sunrpc/gss_generic_token.c
- *
- *  Adapted from MIT Kerberos 5-1.2.1 lib/gssapi/generic/util_token.c
- *
- *  Copyright (c) 2000 The Regents of the University of Michigan.
- *  All rights reserved.
- *
- *  Andy Adamson   <andros@umich.edu>
- */
-
-/*
- * Copyright 1993 by OpenVision Technologies, Inc.
- *
- * Permission to use, copy, modify, distribute, and sell this software
- * and its documentation for any purpose is hereby granted without fee,
- * provided that the above copyright notice appears in all copies and
- * that both that copyright notice and this permission notice appear in
- * supporting documentation, and that the name of OpenVision not be used
- * in advertising or publicity pertaining to distribution of the software
- * without specific, written prior permission. OpenVision makes no
- * representations about the suitability of this software for any
- * purpose.  It is provided "as is" without express or implied warranty.
- *
- * OPENVISION DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
- * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
- * EVENT SHALL OPENVISION BE LIABLE FOR ANY SPECIAL, INDIRECT OR
- * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
- * USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
- * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
- * PERFORMANCE OF THIS SOFTWARE.
- */
-
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/sunrpc/sched.h>
-#include <linux/sunrpc/gss_asn1.h>
-
-
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-# define RPCDBG_FACILITY        RPCDBG_AUTH
-#endif
-
-
-/* TWRITE_STR from gssapiP_generic.h */
-#define TWRITE_STR(ptr, str, len) \
-	memcpy((ptr), (char *) (str), (len)); \
-	(ptr) += (len);
-
-/* XXXX this code currently makes the assumption that a mech oid will
-   never be longer than 127 bytes.  This assumption is not inherent in
-   the interfaces, so the code can be fixed if the OSI namespace
-   balloons unexpectedly. */
-
-/* Each token looks like this:
-
-0x60				tag for APPLICATION 0, SEQUENCE
-					(constructed, definite-length)
-	<length>		possible multiple bytes, need to parse/generate
-	0x06			tag for OBJECT IDENTIFIER
-		<moid_length>	compile-time constant string (assume 1 byte)
-		<moid_bytes>	compile-time constant string
-	<inner_bytes>		the ANY containing the application token
-					bytes 0,1 are the token type
-					bytes 2,n are the token data
-
-For the purposes of this abstraction, the token "header" consists of
-the sequence tag and length octets, the mech OID DER encoding, and the
-first two inner bytes, which indicate the token type.  The token
-"body" consists of everything else.
-
-*/
-
-static int
-der_length_size( int length)
-{
-	if (length < (1<<7))
-		return 1;
-	else if (length < (1<<8))
-		return 2;
-#if (SIZEOF_INT == 2)
-	else
-		return 3;
-#else
-	else if (length < (1<<16))
-		return 3;
-	else if (length < (1<<24))
-		return 4;
-	else
-		return 5;
-#endif
-}
-
-static void
-der_write_length(unsigned char **buf, int length)
-{
-	if (length < (1<<7)) {
-		*(*buf)++ = (unsigned char) length;
-	} else {
-		*(*buf)++ = (unsigned char) (der_length_size(length)+127);
-#if (SIZEOF_INT > 2)
-		if (length >= (1<<24))
-			*(*buf)++ = (unsigned char) (length>>24);
-		if (length >= (1<<16))
-			*(*buf)++ = (unsigned char) ((length>>16)&0xff);
-#endif
-		if (length >= (1<<8))
-			*(*buf)++ = (unsigned char) ((length>>8)&0xff);
-		*(*buf)++ = (unsigned char) (length&0xff);
-	}
-}
-
-/* returns decoded length, or < 0 on failure.  Advances buf and
-   decrements bufsize */
-
-static int
-der_read_length(unsigned char **buf, int *bufsize)
-{
-	unsigned char sf;
-	int ret;
-
-	if (*bufsize < 1)
-		return -1;
-	sf = *(*buf)++;
-	(*bufsize)--;
-	if (sf & 0x80) {
-		if ((sf &= 0x7f) > ((*bufsize)-1))
-			return -1;
-		if (sf > SIZEOF_INT)
-			return -1;
-		ret = 0;
-		for (; sf; sf--) {
-			ret = (ret<<8) + (*(*buf)++);
-			(*bufsize)--;
-		}
-	} else {
-		ret = sf;
-	}
-
-	return ret;
-}
-
-/* returns the length of a token, given the mech oid and the body size */
-
-int
-g_token_size(struct xdr_netobj *mech, unsigned int body_size)
-{
-	/* set body_size to sequence contents size */
-	body_size += 2 + (int) mech->len;         /* NEED overflow check */
-	return 1 + der_length_size(body_size) + body_size;
-}
-
-EXPORT_SYMBOL_GPL(g_token_size);
-
-/* fills in a buffer with the token header.  The buffer is assumed to
-   be the right size.  buf is advanced past the token header */
-
-void
-g_make_token_header(struct xdr_netobj *mech, int body_size, unsigned char **buf)
-{
-	*(*buf)++ = 0x60;
-	der_write_length(buf, 2 + mech->len + body_size);
-	*(*buf)++ = 0x06;
-	*(*buf)++ = (unsigned char) mech->len;
-	TWRITE_STR(*buf, mech->data, ((int) mech->len));
-}
-
-EXPORT_SYMBOL_GPL(g_make_token_header);
-
-/*
- * Given a buffer containing a token, reads and verifies the token,
- * leaving buf advanced past the token header, and setting body_size
- * to the number of remaining bytes.  Returns 0 on success,
- * G_BAD_TOK_HEADER for a variety of errors, and G_WRONG_MECH if the
- * mechanism in the token does not match the mech argument.  buf and
- * *body_size are left unmodified on error.
- */
-u32
-g_verify_token_header(struct xdr_netobj *mech, int *body_size,
-		      unsigned char **buf_in, int toksize)
-{
-	unsigned char *buf = *buf_in;
-	int seqsize;
-	struct xdr_netobj toid;
-	int ret = 0;
-
-	if ((toksize-=1) < 0)
-		return G_BAD_TOK_HEADER;
-	if (*buf++ != 0x60)
-		return G_BAD_TOK_HEADER;
-
-	if ((seqsize = der_read_length(&buf, &toksize)) < 0)
-		return G_BAD_TOK_HEADER;
-
-	if (seqsize != toksize)
-		return G_BAD_TOK_HEADER;
-
-	if ((toksize-=1) < 0)
-		return G_BAD_TOK_HEADER;
-	if (*buf++ != 0x06)
-		return G_BAD_TOK_HEADER;
-
-	if ((toksize-=1) < 0)
-		return G_BAD_TOK_HEADER;
-	toid.len = *buf++;
-
-	if ((toksize-=toid.len) < 0)
-		return G_BAD_TOK_HEADER;
-	toid.data = buf;
-	buf+=toid.len;
-
-	if (! g_OID_equal(&toid, mech))
-		ret = G_WRONG_MECH;
-
-   /* G_WRONG_MECH is not returned immediately because it's more important
-      to return G_BAD_TOK_HEADER if the token header is in fact bad */
-
-	if ((toksize-=2) < 0)
-		return G_BAD_TOK_HEADER;
-
-	if (ret)
-		return ret;
-
-	*buf_in = buf;
-	*body_size = toksize;
-
-	return ret;
-}
-
-EXPORT_SYMBOL_GPL(g_verify_token_header);
diff --git a/net/sunrpc/auth_gss/gss_mech_switch.c b/net/sunrpc/auth_gss/gss_mech_switch.c
index fae632da1058..c84d0cf61980 100644
--- a/net/sunrpc/auth_gss/gss_mech_switch.c
+++ b/net/sunrpc/auth_gss/gss_mech_switch.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/oid_registry.h>
 #include <linux/sunrpc/msg_prot.h>
-#include <linux/sunrpc/gss_asn1.h>
 #include <linux/sunrpc/auth_gss.h>
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/gss_err.h>
-- 
2.47.1


