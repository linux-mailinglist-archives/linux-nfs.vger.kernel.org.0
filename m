Return-Path: <linux-nfs+bounces-17695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F937D0B3C1
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 17:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D44A2308A321
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B74320A0B;
	Fri,  9 Jan 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoDWuGIe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C3364038
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975710; cv=none; b=uO+dr855FuDGu0/nL6gfcpyl6bl2QIL8JzyGhDwARG1Q7VGMcAHbYC2H54ygxskvzTexdFZ1BxYn8owLRI3UXtHBT950t1ZlinaxZH0uctrjE4f8e2l6EXUWJEJHEAnV2lGSLS0zLugp8YtS2cD9TTAh541TVwfQpQlfykP5u1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975710; c=relaxed/simple;
	bh=rKalho+1+fKDd3pcStjR6hgIUCT57yZHMvGZSF+HqVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0AheIACPvghru0Ac2yNdPU/z/lsXDbRE8kBTa/CcpNDonQEze1IVOt/yuLCUFez59ihx0rt/ZOqbTHZGJWiM+uyBapoIO5w8Xyq1NRkQPvgK5OKdOLVbh5YIP0sbcsCfuu8BswUkcmRTQZh5ZSOCeZyEpmaaDnBVABZFG+me8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoDWuGIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BF6C19422;
	Fri,  9 Jan 2026 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975710;
	bh=rKalho+1+fKDd3pcStjR6hgIUCT57yZHMvGZSF+HqVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KoDWuGIeTmvgAErYCXeAbUCaAODe+EKm+kdbt2q4IQXyO5p1W9MaofWbxgjSc7vwb
	 Y8BU7xfXZj8Ill9p6rS8lP8UuBAoa9sgX+aGejA56GYg1oQ361zBEhpPp+xwnwjEcA
	 DeFWcFi9pJhlWKLHtU29d3a3EtmoiWxD/jseaN1fOj/AfrQdf8SjHmI1MeGM6Ky3hL
	 G4L80S1cra3vndWiwW5w1NYjLzVbBoChhX76rJJKKipPexD5jVz3zmADVo1QGNy6J0
	 aCLn4j5meV65jK7AFRko9JB3lHgbzvXBFO1D+vm+B2B56G66hTwQ5Mh5UB2zdc1gGH
	 o0ERpkL2dwk8A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 01/13] xdrgen: Implement pass-through lines in specifications
Date: Fri,  9 Jan 2026 11:21:30 -0500
Message-ID: <20260109162143.4186112-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109162143.4186112-1-cel@kernel.org>
References: <20260109162143.4186112-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

XDR specification files can contain lines prefixed with '%' that
pass through unchanged to generated output. Traditional rpcgen
removes the '%' and emits the remainder verbatim, allowing direct
insertion of C includes, pragma directives, or other language-
specific content into the generated code.

Until now, xdrgen silently discarded these lines during parsing.
This prevented specifications from including necessary headers or
preprocessor directives that might be required for the generated
code to compile correctly.

The grammar now captures pass-through lines instead of ignoring
them. A new AST node type represents pass-through content, and
the AST transformer strips the leading '%' character. Definition
and source generators emit pass-through content in document order,
preserving the original placement within the specification.

This brings xdrgen closer to feature parity with traditional
rpcgen while maintaining the existing document-order processing
model.

Existing generated xdrgen source code has been regenerated.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr_gen.c                         | 11 +++++-
 fs/nfsd/nfs4xdr_gen.h                         |  2 +-
 include/linux/sunrpc/xdrgen/nfs4_1.h          | 11 +++++-
 tools/net/sunrpc/xdrgen/README                |  2 -
 .../net/sunrpc/xdrgen/generators/passthru.py  | 26 +++++++++++++
 tools/net/sunrpc/xdrgen/grammars/xdr.lark     |  6 ++-
 .../net/sunrpc/xdrgen/subcmds/declarations.py |  4 +-
 .../net/sunrpc/xdrgen/subcmds/definitions.py  |  5 ++-
 tools/net/sunrpc/xdrgen/subcmds/source.py     | 24 ++++++++----
 .../xdrgen/templates/C/passthru/definition.j2 |  3 ++
 .../xdrgen/templates/C/passthru/source.j2     |  3 ++
 tools/net/sunrpc/xdrgen/xdr_ast.py            | 39 ++++++++++++++++++-
 12 files changed, 116 insertions(+), 20 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/generators/passthru.py
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/passthru/definition.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/passthru/source.j2

diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index 1e5e2243625c..ce5c36e9070a 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x
-// XDR specification modification time: Thu Dec 25 13:44:43 2025
+// XDR specification modification time: Thu Jan  8 23:11:48 2026
 
 #include <linux/sunrpc/svc.h>
 
@@ -178,6 +178,10 @@ xdrgen_decode_fattr4_open_arguments(struct xdr_stream *xdr, fattr4_open_argument
 	return xdrgen_decode_open_arguments4(xdr, ptr);
 }
 
+/*
+ * Determine what OPEN supports.
+ */
+
 bool
 xdrgen_decode_fattr4_time_deleg_access(struct xdr_stream *xdr, fattr4_time_deleg_access *ptr)
 {
@@ -190,6 +194,11 @@ xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg
 	return xdrgen_decode_nfstime4(xdr, ptr);
 }
 
+/*
+ * New RECOMMENDED Attribute for
+ * delegation caching of times
+ */
+
 static bool __maybe_unused
 xdrgen_decode_open_delegation_type4(struct xdr_stream *xdr, open_delegation_type4 *ptr)
 {
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
index 47437876e803..8dfe10246506 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Thu Dec 25 13:44:43 2025 */
+/* XDR specification modification time: Thu Jan  8 23:11:48 2026 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DECL_H
 #define _LINUX_XDRGEN_NFS4_1_DECL_H
diff --git a/include/linux/sunrpc/xdrgen/nfs4_1.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
index 352bffda08f7..5283739242c7 100644
--- a/include/linux/sunrpc/xdrgen/nfs4_1.h
+++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Thu Dec 25 13:44:43 2025 */
+/* XDR specification modification time: Thu Jan  8 23:11:48 2026 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DEF_H
 #define _LINUX_XDRGEN_NFS4_1_DEF_H
@@ -87,6 +87,10 @@ typedef enum open_args_createmode4 open_args_createmode4;
 
 typedef struct open_arguments4 fattr4_open_arguments;
 
+/*
+ * Determine what OPEN supports.
+ */
+
 enum { FATTR4_OPEN_ARGUMENTS = 86 };
 
 enum { OPEN4_RESULT_NO_OPEN_STATEID = 0x00000010 };
@@ -95,6 +99,11 @@ typedef struct nfstime4 fattr4_time_deleg_access;
 
 typedef struct nfstime4 fattr4_time_deleg_modify;
 
+/*
+ * New RECOMMENDED Attribute for
+ * delegation caching of times
+ */
+
 enum { FATTR4_TIME_DELEG_ACCESS = 84 };
 
 enum { FATTR4_TIME_DELEG_MODIFY = 85 };
diff --git a/tools/net/sunrpc/xdrgen/README b/tools/net/sunrpc/xdrgen/README
index 27218a78ab40..2cf05d1e4cd9 100644
--- a/tools/net/sunrpc/xdrgen/README
+++ b/tools/net/sunrpc/xdrgen/README
@@ -250,8 +250,6 @@ Add more pragma directives:
 Enable something like a #include to dynamically insert the content
 of other specification files
 
-Properly support line-by-line pass-through via the "%" decorator
-
 Build a unit test suite for verifying translation of XDR language
 into compilable code
 
diff --git a/tools/net/sunrpc/xdrgen/generators/passthru.py b/tools/net/sunrpc/xdrgen/generators/passthru.py
new file mode 100644
index 000000000000..cb17bd977f1e
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/passthru.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code for XDR pass-through lines"""
+
+from generators import SourceGenerator, create_jinja2_environment
+from xdr_ast import _XdrPassthru
+
+
+class XdrPassthruGenerator(SourceGenerator):
+    """Generate source code for XDR pass-through content"""
+
+    def __init__(self, language: str, peer: str):
+        """Initialize an instance of this class"""
+        self.environment = create_jinja2_environment(language, "passthru")
+        self.peer = peer
+
+    def emit_definition(self, node: _XdrPassthru) -> None:
+        """Emit one pass-through line"""
+        template = self.environment.get_template("definition.j2")
+        print(template.render(content=node.content))
+
+    def emit_decoder(self, node: _XdrPassthru) -> None:
+        """Emit one pass-through line"""
+        template = self.environment.get_template("source.j2")
+        print(template.render(content=node.content))
diff --git a/tools/net/sunrpc/xdrgen/grammars/xdr.lark b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
index b7c664f2acb7..1d2afff98ac5 100644
--- a/tools/net/sunrpc/xdrgen/grammars/xdr.lark
+++ b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
@@ -78,6 +78,9 @@ definition              : constant_def
                         | type_def
                         | program_def
                         | pragma_def
+                        | passthru_def
+
+passthru_def            : PASSTHRU
 
 //
 // RPC program definitions not specified in RFC 4506
@@ -115,8 +118,7 @@ decimal_constant        : /[\+-]?(0|[1-9][0-9]*)/
 hexadecimal_constant    : /0x([a-f]|[A-F]|[0-9])+/
 octal_constant          : /0[0-7]+/
 
-PASSTHRU                : "%" | "%" /.+/
-%ignore PASSTHRU
+PASSTHRU                : /%.*/
 
 %import common.C_COMMENT
 %ignore C_COMMENT
diff --git a/tools/net/sunrpc/xdrgen/subcmds/declarations.py b/tools/net/sunrpc/xdrgen/subcmds/declarations.py
index 97ffb76a02f1..ed83d48d1f68 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/declarations.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/declarations.py
@@ -10,7 +10,6 @@ from argparse import Namespace
 from lark import logger
 from lark.exceptions import VisitError
 
-from generators.constant import XdrConstantGenerator
 from generators.enum import XdrEnumGenerator
 from generators.header_bottom import XdrHeaderBottomGenerator
 from generators.header_top import XdrHeaderTopGenerator
@@ -21,8 +20,7 @@ from generators.struct import XdrStructGenerator
 from generators.union import XdrUnionGenerator
 
 from xdr_ast import transform_parse_tree, _RpcProgram, Specification
-from xdr_ast import _XdrConstant, _XdrEnum, _XdrPointer
-from xdr_ast import _XdrTypedef, _XdrStruct, _XdrUnion
+from xdr_ast import _XdrEnum, _XdrPointer, _XdrTypedef, _XdrStruct, _XdrUnion
 from xdr_parse import xdr_parser, set_xdr_annotate
 from xdr_parse import make_error_handler, XdrParseError
 from xdr_parse import handle_transform_error
diff --git a/tools/net/sunrpc/xdrgen/subcmds/definitions.py b/tools/net/sunrpc/xdrgen/subcmds/definitions.py
index b17526a03dda..a48ca0549382 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/definitions.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/definitions.py
@@ -14,6 +14,7 @@ from generators.constant import XdrConstantGenerator
 from generators.enum import XdrEnumGenerator
 from generators.header_bottom import XdrHeaderBottomGenerator
 from generators.header_top import XdrHeaderTopGenerator
+from generators.passthru import XdrPassthruGenerator
 from generators.pointer import XdrPointerGenerator
 from generators.program import XdrProgramGenerator
 from generators.typedef import XdrTypedefGenerator
@@ -21,7 +22,7 @@ from generators.struct import XdrStructGenerator
 from generators.union import XdrUnionGenerator
 
 from xdr_ast import transform_parse_tree, Specification
-from xdr_ast import _RpcProgram, _XdrConstant, _XdrEnum, _XdrPointer
+from xdr_ast import _RpcProgram, _XdrConstant, _XdrEnum, _XdrPassthru, _XdrPointer
 from xdr_ast import _XdrTypedef, _XdrStruct, _XdrUnion
 from xdr_parse import xdr_parser, set_xdr_annotate
 from xdr_parse import make_error_handler, XdrParseError
@@ -47,6 +48,8 @@ def emit_header_definitions(root: Specification, language: str, peer: str) -> No
             gen = XdrStructGenerator(language, peer)
         elif isinstance(definition.value, _XdrUnion):
             gen = XdrUnionGenerator(language, peer)
+        elif isinstance(definition.value, _XdrPassthru):
+            gen = XdrPassthruGenerator(language, peer)
         else:
             continue
         gen.emit_definition(definition.value)
diff --git a/tools/net/sunrpc/xdrgen/subcmds/source.py b/tools/net/sunrpc/xdrgen/subcmds/source.py
index 6508563494fe..27e8767b1b58 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/source.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/source.py
@@ -12,6 +12,7 @@ from lark.exceptions import VisitError
 
 from generators.source_top import XdrSourceTopGenerator
 from generators.enum import XdrEnumGenerator
+from generators.passthru import XdrPassthruGenerator
 from generators.pointer import XdrPointerGenerator
 from generators.program import XdrProgramGenerator
 from generators.typedef import XdrTypedefGenerator
@@ -19,7 +20,7 @@ from generators.struct import XdrStructGenerator
 from generators.union import XdrUnionGenerator
 
 from xdr_ast import transform_parse_tree, _RpcProgram, Specification
-from xdr_ast import _XdrAst, _XdrEnum, _XdrPointer
+from xdr_ast import _XdrAst, _XdrEnum, _XdrPassthru, _XdrPointer
 from xdr_ast import _XdrStruct, _XdrTypedef, _XdrUnion
 
 from xdr_parse import xdr_parser, set_xdr_annotate, set_xdr_enum_validation
@@ -74,22 +75,31 @@ def generate_server_source(filename: str, root: Specification, language: str) ->
     gen.emit_source(filename, root)
 
     for definition in root.definitions:
-        emit_source_decoder(definition.value, language, "server")
+        if isinstance(definition.value, _XdrPassthru):
+            passthru_gen = XdrPassthruGenerator(language, "server")
+            passthru_gen.emit_decoder(definition.value)
+        else:
+            emit_source_decoder(definition.value, language, "server")
     for definition in root.definitions:
-        emit_source_encoder(definition.value, language, "server")
+        if not isinstance(definition.value, _XdrPassthru):
+            emit_source_encoder(definition.value, language, "server")
 
 
 def generate_client_source(filename: str, root: Specification, language: str) -> None:
-    """Generate server-side source code"""
+    """Generate client-side source code"""
 
     gen = XdrSourceTopGenerator(language, "client")
     gen.emit_source(filename, root)
 
-    print("")
     for definition in root.definitions:
-        emit_source_encoder(definition.value, language, "client")
+        if isinstance(definition.value, _XdrPassthru):
+            passthru_gen = XdrPassthruGenerator(language, "client")
+            passthru_gen.emit_decoder(definition.value)
+        else:
+            emit_source_encoder(definition.value, language, "client")
     for definition in root.definitions:
-        emit_source_decoder(definition.value, language, "client")
+        if not isinstance(definition.value, _XdrPassthru):
+            emit_source_decoder(definition.value, language, "client")
 
     # cel: todo: client needs PROC macros
 
diff --git a/tools/net/sunrpc/xdrgen/templates/C/passthru/definition.j2 b/tools/net/sunrpc/xdrgen/templates/C/passthru/definition.j2
new file mode 100644
index 000000000000..900c7516a29c
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/passthru/definition.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{{ content }}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/passthru/source.j2 b/tools/net/sunrpc/xdrgen/templates/C/passthru/source.j2
new file mode 100644
index 000000000000..900c7516a29c
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/passthru/source.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{{ content }}
diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index dc2fa9fd8ec2..14bff9477473 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -516,6 +516,13 @@ class _Pragma(_XdrAst):
     """Empty class for pragma directives"""
 
 
+@dataclass
+class _XdrPassthru(_XdrAst):
+    """Passthrough line to emit verbatim in output"""
+
+    content: str
+
+
 @dataclass
 class Definition(_XdrAst, ast_utils.WithMeta):
     """Corresponds to 'definition' in the grammar"""
@@ -738,14 +745,42 @@ class ParseToAst(Transformer):
                 raise NotImplementedError("Directive not supported")
         return _Pragma()
 
+    def passthru_def(self, children):
+        """Instantiate one _XdrPassthru object"""
+        token = children[0]
+        content = token.value[1:]
+        return _XdrPassthru(content)
+
 
 transformer = ast_utils.create_transformer(this_module, ParseToAst())
 
 
+def _merge_consecutive_passthru(definitions: List[Definition]) -> List[Definition]:
+    """Merge consecutive passthru definitions into single nodes"""
+    result = []
+    i = 0
+    while i < len(definitions):
+        if isinstance(definitions[i].value, _XdrPassthru):
+            lines = [definitions[i].value.content]
+            meta = definitions[i].meta
+            j = i + 1
+            while j < len(definitions) and isinstance(definitions[j].value, _XdrPassthru):
+                lines.append(definitions[j].value.content)
+                j += 1
+            merged = _XdrPassthru("\n".join(lines))
+            result.append(Definition(meta, merged))
+            i = j
+        else:
+            result.append(definitions[i])
+            i += 1
+    return result
+
+
 def transform_parse_tree(parse_tree):
     """Transform productions into an abstract syntax tree"""
-
-    return transformer.transform(parse_tree)
+    ast = transformer.transform(parse_tree)
+    ast.definitions = _merge_consecutive_passthru(ast.definitions)
+    return ast
 
 
 def get_header_name() -> str:
-- 
2.52.0


