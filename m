Return-Path: <linux-nfs+bounces-17117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ABBCC4408
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 17:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ACAF3007D98
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB9E329C54;
	Tue, 16 Dec 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuWHvZUl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130C326952
	for <linux-nfs@vger.kernel.org>; Tue, 16 Dec 2025 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902193; cv=none; b=dHp7g+85RbSh9IA+ch2YayP9atfjMLq48WhB37k0PaXApKSebxYve2rJd1dqlJ/wzmXyf/PPoEgkZAy5u8K1SxdRuxOQo3xkBlSnolb3hLK7zbkNtMMtefQzKBOMuKy5sJXwFp5ByLqXuyj07iMraryd7dcfb17kiZNuPYHxr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902193; c=relaxed/simple;
	bh=zcfQy9eRzRx91zt7uW002Uabs0d4NlvCjLpMIZpEtAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPCbK0zYj+OR2kw7ENsFSe6V0Gwu++/cZxvD3y1IcnyKcTCvx/tEnX6NGrNZ9KKSsRqcwQD07gB7g8U/Ldp9cpzXblWcdHbkGPgR34pmQZwfXW2m6vhmVEV2Vau3XCFmHBB+Dkr4KzCaRJqCi6uCvs8cKj3i2x9q6qPDEcEo+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuWHvZUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4AFC4CEF1;
	Tue, 16 Dec 2025 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765902192;
	bh=zcfQy9eRzRx91zt7uW002Uabs0d4NlvCjLpMIZpEtAg=;
	h=From:To:Cc:Subject:Date:From;
	b=AuWHvZUlTTE9Z2o8+KD+xyRpEReFlfAzA6te7zf6vFtB7Apl+LJlQ9lHnaK/uINVV
	 do82YXeE5kXxprZZ5uaCi1uITu0sn9Hso92Ze+vWBTCpXeeGWZTKHDC6oujKHVw+5p
	 OsBeDhbnwq1Q2lxyoYrhv7ejELqAd+OZ/Lk5vRvOrG5ja0hV/uFwQdI20h5IeJBCaZ
	 6iYtDpcZA2TfyLgoshW5hS28++OELk+LK47NVCUE6fUesBmrGnPwQ8Gc/jWJxn5O/C
	 D9WE+qBH4dCy2ytLcU60l9D7XYfjBFgAuFrismPjUIKCNVIkBf5K4BCZw0eyo7ifjp
	 rlBZK7v1Dyg6Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] xdrgen: Implement short (16-bit) integer types
Date: Tue, 16 Dec 2025 11:23:09 -0500
Message-ID: <20251216162309.1010738-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

"short" and "unsigned short" types are not defined in RFC 4506, but
are supported by the rpcgen program. An upcoming protocol
specification includes at least one "unsigned short" field, so xdrgen
needs to implement support for these types.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdrgen/_builtins.h       | 60 +++++++++++++++++++
 .../net/sunrpc/xdrgen/generators/__init__.py  |  2 +
 tools/net/sunrpc/xdrgen/grammars/xdr.lark     |  4 ++
 tools/net/sunrpc/xdrgen/xdr_ast.py            |  4 ++
 4 files changed, 70 insertions(+)

diff --git a/include/linux/sunrpc/xdrgen/_builtins.h b/include/linux/sunrpc/xdrgen/_builtins.h
index 66ca3ece951a..52ed9a9151c4 100644
--- a/include/linux/sunrpc/xdrgen/_builtins.h
+++ b/include/linux/sunrpc/xdrgen/_builtins.h
@@ -46,6 +46,66 @@ xdrgen_encode_bool(struct xdr_stream *xdr, bool val)
 	return true;
 }
 
+/*
+ * De facto (non-standard but commonly implemented) signed short type:
+ *  - Wire sends sign-extended 32-bit value (e.g., 0xFFFFFFFF)
+ *  - be32_to_cpup() returns u32 (0xFFFFFFFF)
+ *  - Explicit (s16) cast truncates to 16 bits (0xFFFF = -1)
+ */
+static inline bool
+xdrgen_decode_short(struct xdr_stream *xdr, s16 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = (s16)be32_to_cpup(p);
+	return true;
+}
+
+/*
+ * De facto (non-standard but commonly implemented) signed short type:
+ *  - C integer promotion sign-extends s16 val to int before passing to
+ *    cpu_to_be32()
+ *  - This is well-defined: -1 as s16 -1 as int 0xFFFFFFFF on wire
+ */
+static inline bool
+xdrgen_encode_short(struct xdr_stream *xdr, s16 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*p = cpu_to_be32(val);
+	return true;
+}
+
+/*
+ * De facto (non-standard but commonly implemented) unsigned short type:
+ * 16-bit integer zero-extended to fill one XDR_UNIT.
+ */
+static inline bool
+xdrgen_decode_unsigned_short(struct xdr_stream *xdr, u16 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = (u16)be32_to_cpup(p);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_unsigned_short(struct xdr_stream *xdr, u16 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*p = cpu_to_be32(val);
+	return true;
+}
+
 static inline bool
 xdrgen_decode_int(struct xdr_stream *xdr, s32 *ptr)
 {
diff --git a/tools/net/sunrpc/xdrgen/generators/__init__.py b/tools/net/sunrpc/xdrgen/generators/__init__.py
index 1d577a986c6c..5c3a4a47ded8 100644
--- a/tools/net/sunrpc/xdrgen/generators/__init__.py
+++ b/tools/net/sunrpc/xdrgen/generators/__init__.py
@@ -59,6 +59,8 @@ def kernel_c_type(spec: _XdrTypeSpecifier) -> str:
     """Return name of C type"""
     builtin_native_c_type = {
         "bool": "bool",
+        "short": "s16",
+        "unsigned_short": "u16",
         "int": "s32",
         "unsigned_int": "u32",
         "long": "s32",
diff --git a/tools/net/sunrpc/xdrgen/grammars/xdr.lark b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
index 7c2c1b8c86d1..b7c664f2acb7 100644
--- a/tools/net/sunrpc/xdrgen/grammars/xdr.lark
+++ b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
@@ -20,9 +20,11 @@ constant                : decimal_constant | hexadecimal_constant | octal_consta
 type_specifier          : unsigned_hyper
                         | unsigned_long
                         | unsigned_int
+                        | unsigned_short
                         | hyper
                         | long
                         | int
+                        | short
                         | float
                         | double
                         | quadruple
@@ -35,9 +37,11 @@ type_specifier          : unsigned_hyper
 unsigned_hyper          : "unsigned" "hyper"
 unsigned_long           : "unsigned" "long"
 unsigned_int            : "unsigned" "int"
+unsigned_short          : "unsigned" "short"
 hyper                   : "hyper"
 long                    : "long"
 int                     : "int"
+short                   : "short"
 float                   : "float"
 double                  : "double"
 quadruple               : "quadruple"
diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index 5233e73c7046..2b5d160a0a60 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -34,6 +34,8 @@ def xdr_quadlen(val: str) -> int:
 symbolic_widths = {
     "void": ["XDR_void"],
     "bool": ["XDR_bool"],
+    "short": ["XDR_short"],
+    "unsigned_short": ["XDR_unsigned_short"],
     "int": ["XDR_int"],
     "unsigned_int": ["XDR_unsigned_int"],
     "long": ["XDR_long"],
@@ -48,6 +50,8 @@ symbolic_widths = {
 max_widths = {
     "void": 0,
     "bool": 1,
+    "short": 1,
+    "unsigned_short": 1,
     "int": 1,
     "unsigned_int": 1,
     "long": 1,
-- 
2.52.0


