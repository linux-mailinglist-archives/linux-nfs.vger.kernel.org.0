Return-Path: <linux-nfs+bounces-6812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896098F206
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E10F1F21E2A
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1061A01DD;
	Thu,  3 Oct 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arbrFfsU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9316F0F0
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967720; cv=none; b=W7euQacSfQjOEBS0O1gZ38R9X4geMLKQUlSXR9Hx7MF+mlCg9MXKeyILgf02tuvB2wR407MRvO7yCIO1ltdZ2ItRh4e1DhAXtqyeHEqvhoso9gDree9BMtemEkzVFSdPwSaL3J39460Ucek7DY8yO9UFETP7u/01q4y07L74u8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967720; c=relaxed/simple;
	bh=5Fxm3WlxwUd6LYcPwTxxa5VUv2bnYW6sxcIdtPqTwWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWjUIxelsgMvcA27DUjKWSttM+sukFwSoJsKBibuIipaRp76mHSsQSHaV1PzTX0E5Kq/TM5wPYGbg0SypGJX2MmssCmdBZWk4qXoipBgVyuNwYwCNgaO62UUwCZNfVVCIgIBaonSrqSqKQlIsLCr23KuyzY23K1n8GK0RuoEe/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arbrFfsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC73BC4CEC7;
	Thu,  3 Oct 2024 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967719;
	bh=5Fxm3WlxwUd6LYcPwTxxa5VUv2bnYW6sxcIdtPqTwWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arbrFfsUW8VNNO54dhI9z5pNkCeKlpasvZXUn0atgYmIR6HdLJFz/TZ/yShexg1L/
	 syl9zIeCXvKSCsjClz2BFjVTkttKwhPfX2Q72Bs3rJWq7pnCX1IKWqK32XOpq/soXX
	 rYrMWxPob+8gwSGjEKCDwKG2JYoChYXRdmCfvxNyKlVkXCBid3Z5Y5Lx9mtvWR2b4y
	 yyGA+VaSyK9szQGWW+n+qReHqLcrrEmGL6irppfsO5ZWMkQj6DY1iJW4yt6lLIBJ9I
	 pkOVJS0c+QdXiN+M16ZcQ8Gxty9JABwkR6Ilgx29yo1lZTNQzwVddFNCN/lMaqSbDX
	 EvZlmyPFWjzCw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 03/16] xdrgen: Keep track of on-the-wire data type widths
Date: Thu,  3 Oct 2024 11:01:45 -0400
Message-ID: <20241003150151.81951-4-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003150151.81951-1-cel@kernel.org>
References: <20241003150151.81951-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The generic parts of the RPC layer need to know the widths (in
XDR_UNIT increments) of the XDR data types defined for each
protocol.

As a first step, add dictionaries to keep track of the symbolic and
actual maximum XDR width of XDR types.

This makes it straightforward to look up the width of a type by its
name. The built-in dictionaries are pre-loaded with the widths of
the built-in XDR types as defined in RFC 4506.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdrgen/_defs.h |  9 ++++++
 tools/net/sunrpc/xdrgen/xdr_ast.py  | 43 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/sunrpc/xdrgen/_defs.h b/include/linux/sunrpc/xdrgen/_defs.h
index be9e62371758..20c7270aa64d 100644
--- a/include/linux/sunrpc/xdrgen/_defs.h
+++ b/include/linux/sunrpc/xdrgen/_defs.h
@@ -23,4 +23,13 @@ typedef struct {
 	u8 *data;
 } opaque;
 
+#define XDR_void		(0)
+#define XDR_bool		(1)
+#define XDR_int			(1)
+#define XDR_unsigned_int	(1)
+#define XDR_long		(1)
+#define XDR_unsigned_long	(1)
+#define XDR_hyper		(2)
+#define XDR_unsigned_hyper	(2)
+
 #endif /* _SUNRPC_XDRGEN__DEFS_H_ */
diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index b7df45f47707..f1d93a1d0ed8 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -21,6 +21,31 @@ pass_by_reference = set()
 
 constants = {}
 
+symbolic_widths = {
+    "void": ["XDR_void"],
+    "bool": ["XDR_bool"],
+    "int": ["XDR_int"],
+    "unsigned_int": ["XDR_unsigned_int"],
+    "long": ["XDR_long"],
+    "unsigned_long": ["XDR_unsigned_long"],
+    "hyper": ["XDR_hyper"],
+    "unsigned_hyper": ["XDR_unsigned_hyper"],
+}
+
+# Numeric XDR widths are tracked in a dictionary that is keyed
+# by type_name because sometimes a caller has nothing more than
+# the type_name to use to figure out the numeric width.
+max_widths = {
+    "void": 0,
+    "bool": 1,
+    "int": 1,
+    "unsigned_int": 1,
+    "long": 1,
+    "unsigned_long": 1,
+    "hyper": 2,
+    "unsigned_hyper": 2,
+}
+
 
 @dataclass
 class _XdrAst(ast_utils.Ast):
@@ -60,15 +85,24 @@ class _XdrTypeSpecifier(_XdrAst):
 class _XdrDefinedType(_XdrTypeSpecifier):
     """Corresponds to a type defined by the input specification"""
 
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        return [get_header_name().upper() + "_" + self.type_name + "_sz"]
+
     def __post_init__(self):
         if self.type_name in structs:
             self.c_classifier = "struct "
+        symbolic_widths[self.type_name] = self.symbolic_width()
 
 
 @dataclass
 class _XdrBuiltInType(_XdrTypeSpecifier):
     """Corresponds to a built-in XDR type"""
 
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        return symbolic_widths[self.type_name]
+
 
 @dataclass
 class _XdrDeclaration(_XdrAst):
@@ -148,8 +182,17 @@ class _XdrBasic(_XdrDeclaration):
 class _XdrVoid(_XdrDeclaration):
     """A void declaration"""
 
+    name: str = "void"
     template: str = "void"
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        return 0
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        return []
+
 
 @dataclass
 class _XdrConstant(_XdrAst):
-- 
2.46.2


