Return-Path: <linux-nfs+bounces-6828-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A1398F696
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F24C281BD6
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958801ABEA1;
	Thu,  3 Oct 2024 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbbGbdoK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F11AB515
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981741; cv=none; b=cPQCnLzqWZmfylSbYddVUnnbFZO466UK6Y3PSNp2qY/ljYW2IhktahhHZobpvCcN9ZrgC2kWGIrbPi9Tv4oNxTGI1DPNO93ENeMPlbZuJDMbqLKiJYAV+vuwhKbMfpFZA3WUTBWppjgLyGXQIvktFG1NlAfe+kRtJxLuenF+x5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981741; c=relaxed/simple;
	bh=5Fxm3WlxwUd6LYcPwTxxa5VUv2bnYW6sxcIdtPqTwWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m55ONS1/USycGj1PUGymviQBQk9NUM4BpGPqt3xbdoR9YyvfiTef7kULyWtePh5fYRFEc+N4nuy3MQKmRaaIX2UBAj1SXo3Tm7lCyzZgILEB89G0HnA+hPvsqohlpp/QqX0p4E9sa/xCb04avFXNk/VobbaVdSY1/Z4a3Yhb/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbbGbdoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4876C4CEC5;
	Thu,  3 Oct 2024 18:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981741;
	bh=5Fxm3WlxwUd6LYcPwTxxa5VUv2bnYW6sxcIdtPqTwWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbbGbdoK52m+0oGetbP6zDN5MQSWfxxNvmdAvoAfN6hrIhPRWKJM+aIr6LW44OfwR
	 ceeIKHIF3KWHOiFyQnMdekNJLc9sGWoN4oDN0bVNHwnkAXwNw3P1gte7vKf7YN0uBG
	 QXDSKKrTfwAed/pqjs2OPFGy7RYT9Cn/G3mj6Pp+hRPWETJquKpuAEUJah3f1KWEsX
	 YU1hQ6FVUQDn3vRQkbTIi/xZYOF8zHRslZm4jAZKP0dYyMwgpYL9g0xZCwgf0hyohJ
	 PTKmw9w1dO/z6uC2F3Y8zIqypN/NaSjHsv1n1nWyaSezXQu0O9gDVpA/SE6Au3l1oq
	 uAVrqlQqSBKRw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 03/16] xdrgen: Keep track of on-the-wire data type widths
Date: Thu,  3 Oct 2024 14:54:33 -0400
Message-ID: <20241003185446.82984-4-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003185446.82984-1-cel@kernel.org>
References: <20241003185446.82984-1-cel@kernel.org>
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


