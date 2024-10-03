Return-Path: <linux-nfs+bounces-6810-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848C998F204
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F8C282F8C
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BCB19F42F;
	Thu,  3 Oct 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVzzRMBW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B2D16F0F0
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967718; cv=none; b=fdAqautkYpXLpEVE6UP8R3W9qlc6Ktsh5CTdDZnYceIoc0MTzaB1qC3tiDgDuLPpeNPrXR7VuVdxysz7eW73DJ5JWekoRqvvTAX2f5SNwz0RDa7s/dJY3W0JR8pRbmNeoRGh+XLAAjXjmvBd8Rs3I+IEiyKo+9LECZnOv+vyX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967718; c=relaxed/simple;
	bh=gRs3qK/pMAHS5JndlfkrrZYNxpjLyrlsQBN+cRdHt40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1qeSJm0PaIAevGo+PWOj/QhwKbC225O4PWevqRMzr0QdY7GsNbvMlZwDVgVMz9hII2bSzgThIwulSgcOW0SI6Wk8w5bxEI7+t+Om/ASGR6uYeEjShxIjRKHhnTJ70hVWoO8+pVZ12Wv+0L7jzB0gH1N4dqUqwzGCqRK62EINfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVzzRMBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0661EC4CECE;
	Thu,  3 Oct 2024 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967717;
	bh=gRs3qK/pMAHS5JndlfkrrZYNxpjLyrlsQBN+cRdHt40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVzzRMBWgkVRD61fbpjzXI/CDckeXMyNEqNuu2Clp2719yeuyU8qQYNxvbZIm7ECT
	 E6YGwvXI6pymJ4xC10Tj92oLPZix7nMaRgv/AnXJ/sp/3AwIRZgC+N/qsey/TbgSa7
	 pksbBIHs3CuvGvAFaVZydRLLWxJtkGuVlzZTvr/26rlcnka5WcadaDqnESfeBRCZ9I
	 6t0NPZsXIoAt686UuEBygAP6uE6vjACfscAEJ/dx/xx/qVu7kKrBVQjTQk9+N+sqgx
	 32KEUP9//mN+ydN04f2ClLoHlcPVHjVCCOiTtcP+k8ocwT7kKP0nFTetE+1CbxTHYW
	 7p4u2PhQNyVXQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 01/16] xdrgen: Refactor transformer arms
Date: Thu,  3 Oct 2024 11:01:43 -0400
Message-ID: <20241003150151.81951-2-cel@kernel.org>
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

Clean up: Add a __post_init__ function to the data classes that
need to update the "structs" and "pass_by_reference" sets.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 57 +++++++++++++++++-------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index d5f0535ec84c..68f09945f2c4 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -51,13 +51,17 @@ class _XdrTypeSpecifier(_XdrAst):
     """Corresponds to 'type_specifier' in the XDR language grammar"""
 
     type_name: str
-    c_classifier: str
+    c_classifier: str = ""
 
 
 @dataclass
 class _XdrDefinedType(_XdrTypeSpecifier):
     """Corresponds to a type defined by the input specification"""
 
+    def __post_init__(self):
+        if self.type_name in structs:
+            self.c_classifier = "struct "
+
 
 @dataclass
 class _XdrBuiltInType(_XdrTypeSpecifier):
@@ -124,6 +128,10 @@ class _XdrOptionalData(_XdrDeclaration):
     spec: _XdrTypeSpecifier
     template: str = "optional_data"
 
+    def __post_init__(self):
+        structs.add(self.name)
+        pass_by_reference.add(self.name)
+
 
 @dataclass
 class _XdrBasic(_XdrDeclaration):
@@ -174,6 +182,10 @@ class _XdrStruct(_XdrAst):
     name: str
     fields: List[_XdrDeclaration]
 
+    def __post_init__(self):
+        structs.add(self.name)
+        pass_by_reference.add(self.name)
+
 
 @dataclass
 class _XdrPointer(_XdrAst):
@@ -182,6 +194,10 @@ class _XdrPointer(_XdrAst):
     name: str
     fields: List[_XdrDeclaration]
 
+    def __post_init__(self):
+        structs.add(self.name)
+        pass_by_reference.add(self.name)
+
 
 @dataclass
 class _XdrTypedef(_XdrAst):
@@ -189,6 +205,15 @@ class _XdrTypedef(_XdrAst):
 
     declaration: _XdrDeclaration
 
+    def __post_init__(self):
+        if not isinstance(self.declaration, _XdrBasic):
+            return
+
+        new_type = self.declaration
+        if isinstance(new_type.spec, _XdrDefinedType):
+            if new_type.spec.type_name in pass_by_reference:
+                pass_by_reference.add(new_type.name)
+
 
 @dataclass
 class _XdrCaseSpec(_XdrAst):
@@ -216,6 +241,10 @@ class _XdrUnion(_XdrAst):
     cases: List[_XdrCaseSpec]
     default: _XdrDeclaration
 
+    def __post_init__(self):
+        structs.add(self.name)
+        pass_by_reference.add(self.name)
+
 
 @dataclass
 class _RpcProcedure(_XdrAst):
@@ -290,22 +319,13 @@ class ParseToAst(Transformer):
         return _XdrConstantValue(value)
 
     def type_specifier(self, children):
-        """Instantiate one type_specifier object"""
-        c_classifier = ""
+        """Instantiate one _XdrTypeSpecifier object"""
         if isinstance(children[0], _XdrIdentifier):
             name = children[0].symbol
-            if name in structs:
-                c_classifier = "struct "
-            return _XdrDefinedType(
-                type_name=name,
-                c_classifier=c_classifier,
-            )
+            return _XdrDefinedType(type_name=name)
 
         name = children[0].data.value
-        return _XdrBuiltInType(
-            type_name=name,
-            c_classifier=c_classifier,
-        )
+        return _XdrBuiltInType(type_name=name)
 
     def constant_def(self, children):
         """Instantiate one _XdrConstant object"""
@@ -380,8 +400,6 @@ class ParseToAst(Transformer):
         """Instantiate one _XdrOptionalData declaration object"""
         spec = children[0]
         name = children[1].symbol
-        structs.add(name)
-        pass_by_reference.add(name)
 
         return _XdrOptionalData(name, spec)
 
@@ -400,8 +418,6 @@ class ParseToAst(Transformer):
     def struct(self, children):
         """Instantiate one _XdrStruct object"""
         name = children[0].symbol
-        structs.add(name)
-        pass_by_reference.add(name)
         fields = children[1].children
 
         last_field = fields[-1]
@@ -416,11 +432,6 @@ class ParseToAst(Transformer):
     def typedef(self, children):
         """Instantiate one _XdrTypedef object"""
         new_type = children[0]
-        if isinstance(new_type, _XdrBasic) and isinstance(
-            new_type.spec, _XdrDefinedType
-        ):
-            if new_type.spec.type_name in pass_by_reference:
-                pass_by_reference.add(new_type.name)
 
         return _XdrTypedef(new_type)
 
@@ -442,8 +453,6 @@ class ParseToAst(Transformer):
     def union(self, children):
         """Instantiate one _XdrUnion object"""
         name = children[0].symbol
-        structs.add(name)
-        pass_by_reference.add(name)
 
         body = children[1]
         discriminant = body.children[0].children[0]
-- 
2.46.2


