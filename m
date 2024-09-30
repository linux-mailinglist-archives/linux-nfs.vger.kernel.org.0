Return-Path: <linux-nfs+bounces-6708-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEE69898B8
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 02:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B853D1F21592
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 00:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143D91A288;
	Mon, 30 Sep 2024 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmT7rHtx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E218EBF
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657442; cv=none; b=gHoZ9mW/q1hWvGIoA+8HIthICx69QqJ6Dp1WOKUOZl1L9NTZamooD3e6d9mJp9Y6NcN0EMrMWGoXUkcukI/HLqqRKPzGEyD4JEWRD3tNkvSEHsEDFb3Aegw79+AJGR7PCAN6kLPOf2Ht0AXgSKn3yiVwWaYg8VEeMyT4Uu23vCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657442; c=relaxed/simple;
	bh=qj3wmElqpEN6deG3iE+r777ja0l0rgoX2LxYr9FKMuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hj0OXYQnOL9nnNarTxyWw1FnP/Uf3Cjjnz5PRyqwLwRAr5RowQtuNY/o9VXbrbzkKIO/K5L7ULnr8YS0Miz024wQAUezAy83SQ0/FusX9tVTIEH/IwVgtDl98+ba4st4/5sAxTSX63zU+VVZ4DPQaSjRdkiEfv9W15QYJZtqo7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmT7rHtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6851C4CEC6;
	Mon, 30 Sep 2024 00:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727657441;
	bh=qj3wmElqpEN6deG3iE+r777ja0l0rgoX2LxYr9FKMuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmT7rHtxONIjDtUPDWhtSXiAJ/CMaxUJmlDeGhjV+0TkefHU6QluBgFIs571nBL0E
	 cUUzBdQR3fEAQh/MjVAsGm4dwxisvvs5gCzejVEaf/MM4fThEghA8j00TLYk1aVhQS
	 nFOYnMHWJ26IYrBlEK8vn493Fnk+YN2T8LJ48cHWZAxqlLcB7sLnpEmJYjbH/41s0l
	 Ku4+X/q5D6S9YPjRwE35pVvFPxyuSLubpPBDn7a1BMBemO8ovuxCRWZ9dC0n3fNvZY
	 t1R3S2CDPtcp6rLs+Bf05T3elatF8qb2iTzlVOBj8wZsKEmg4GyQTiyT9eFC/CibDw
	 Kbin56nGYOESQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6/6] xdrgen: Implement big-endian enums
Date: Sun, 29 Sep 2024 20:50:16 -0400
Message-ID: <20240930005016.13374-8-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930005016.13374-1-cel@kernel.org>
References: <20240930005016.13374-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h                    | 21 ++++++++++++
 tools/net/sunrpc/xdrgen/README                | 17 ++++++++++
 tools/net/sunrpc/xdrgen/generators/enum.py    | 17 +++++++---
 tools/net/sunrpc/xdrgen/generators/union.py   | 34 ++++++++++++++-----
 tools/net/sunrpc/xdrgen/grammars/xdr.lark     |  4 ++-
 .../templates/C/enum/decoder/enum_be.j2       | 14 ++++++++
 .../templates/C/enum/definition/close_be.j2   |  3 ++
 .../templates/C/enum/encoder/enum_be.j2       | 14 ++++++++
 .../templates/C/union/decoder/case_spec_be.j2 |  2 ++
 .../templates/C/union/encoder/case_spec_be.j2 |  2 ++
 tools/net/sunrpc/xdrgen/xdr_ast.py            |  3 ++
 11 files changed, 117 insertions(+), 14 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum_be.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum_be.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec_be.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec_be.j2

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 2f8dc47f1eb0..e7ebabedb5a4 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -680,6 +680,27 @@ xdr_stream_decode_u32(struct xdr_stream *xdr, __u32 *ptr)
 	return 0;
 }
 
+/**
+ * xdr_stream_decode_be32 - Decode a big-endian 32-bit integer
+ * @xdr: pointer to xdr_stream
+ * @ptr: location to store integer
+ *
+ * Return values:
+ *   %0 on success
+ *   %-EBADMSG on XDR buffer overflow
+ */
+static inline ssize_t
+xdr_stream_decode_be32(struct xdr_stream *xdr, __be32 *ptr)
+{
+	const size_t count = sizeof(*ptr);
+	__be32 *p = xdr_inline_decode(xdr, count);
+
+	if (unlikely(!p))
+		return -EBADMSG;
+	*ptr = *p;
+	return 0;
+}
+
 /**
  * xdr_stream_decode_u64 - Decode a 64-bit integer
  * @xdr: pointer to xdr_stream
diff --git a/tools/net/sunrpc/xdrgen/README b/tools/net/sunrpc/xdrgen/README
index 92f7738ad50c..27218a78ab40 100644
--- a/tools/net/sunrpc/xdrgen/README
+++ b/tools/net/sunrpc/xdrgen/README
@@ -150,6 +150,23 @@ Pragma directives specify exceptions to the normal generation of
 encoding and decoding functions. Currently one directive is
 implemented: "public".
 
+Pragma big_endian
+------ ----------
+
+  pragma big_endian <enum> ;
+
+For variables that might contain only a small number values, it
+is more efficient to avoid the byte-swap when encoding or decoding
+on little-endian machines. Such is often the case with error status
+codes. For example:
+
+  pragma big_endian nfsstat3;
+
+In this case, when generating an XDR struct or union containing a
+field of type "nfsstat3", xdrgen will make the type of that field
+"__be32" instead of "enum nfsstat3". XDR unions then switch on the
+non-byte-swapped value of that field.
+
 Pragma exclude
 ------ -------
 
diff --git a/tools/net/sunrpc/xdrgen/generators/enum.py b/tools/net/sunrpc/xdrgen/generators/enum.py
index e37b5c297821..e63f45b8eb74 100644
--- a/tools/net/sunrpc/xdrgen/generators/enum.py
+++ b/tools/net/sunrpc/xdrgen/generators/enum.py
@@ -4,7 +4,7 @@
 """Generate code to handle XDR enum types"""
 
 from generators import SourceGenerator, create_jinja2_environment
-from xdr_ast import _XdrEnum, public_apis
+from xdr_ast import _XdrEnum, public_apis, big_endian
 
 
 class XdrEnumGenerator(SourceGenerator):
@@ -30,15 +30,24 @@ class XdrEnumGenerator(SourceGenerator):
         for enumerator in node.enumerators:
             print(template.render(name=enumerator.name, value=enumerator.value))
 
-        template = self.environment.get_template("definition/close.j2")
+        if node.name in big_endian:
+            template = self.environment.get_template("definition/close_be.j2")
+        else:
+            template = self.environment.get_template("definition/close.j2")
         print(template.render(name=node.name))
 
     def emit_decoder(self, node: _XdrEnum) -> None:
         """Emit one decoder function for an XDR enum type"""
-        template = self.environment.get_template("decoder/enum.j2")
+        if node.name in big_endian:
+            template = self.environment.get_template("decoder/enum_be.j2")
+        else:
+            template = self.environment.get_template("decoder/enum.j2")
         print(template.render(name=node.name))
 
     def emit_encoder(self, node: _XdrEnum) -> None:
         """Emit one encoder function for an XDR enum type"""
-        template = self.environment.get_template("encoder/enum.j2")
+        if node.name in big_endian:
+            template = self.environment.get_template("encoder/enum_be.j2")
+        else:
+            template = self.environment.get_template("encoder/enum.j2")
         print(template.render(name=node.name))
diff --git a/tools/net/sunrpc/xdrgen/generators/union.py b/tools/net/sunrpc/xdrgen/generators/union.py
index 7974967bbb9f..4522a5b7a943 100644
--- a/tools/net/sunrpc/xdrgen/generators/union.py
+++ b/tools/net/sunrpc/xdrgen/generators/union.py
@@ -8,7 +8,7 @@ from jinja2 import Environment
 from generators import SourceGenerator
 from generators import create_jinja2_environment, get_jinja2_template
 
-from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid
+from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, big_endian
 from xdr_ast import _XdrDeclaration, _XdrCaseSpec, public_apis
 
 
@@ -77,13 +77,18 @@ def emit_union_switch_spec_decoder(
     print(template.render(name=node.name, type=node.spec.type_name))
 
 
-def emit_union_case_spec_decoder(environment: Environment, node: _XdrCaseSpec) -> None:
+def emit_union_case_spec_decoder(
+    environment: Environment, node: _XdrCaseSpec, big_endian_discriminant: bool
+) -> None:
     """Emit decoder functions for an XDR union's case arm"""
 
     if isinstance(node.arm, _XdrVoid):
         return
 
-    template = get_jinja2_template(environment, "decoder", "case_spec")
+    if big_endian_discriminant:
+        template = get_jinja2_template(environment, "decoder", "case_spec_be")
+    else:
+        template = get_jinja2_template(environment, "decoder", "case_spec")
     for case in node.values:
         print(template.render(case=case))
 
@@ -136,7 +141,11 @@ def emit_union_decoder(environment: Environment, node: _XdrUnion) -> None:
     emit_union_switch_spec_decoder(environment, node.discriminant)
 
     for case in node.cases:
-        emit_union_case_spec_decoder(environment, case)
+        emit_union_case_spec_decoder(
+            environment,
+            case,
+            node.discriminant.spec.type_name in big_endian,
+        )
 
     emit_union_default_spec_decoder(environment, node)
 
@@ -153,17 +162,21 @@ def emit_union_switch_spec_encoder(
     print(template.render(name=node.name, type=node.spec.type_name))
 
 
-def emit_union_case_spec_encoder(environment: Environment, node: _XdrCaseSpec) -> None:
+def emit_union_case_spec_encoder(
+    environment: Environment, node: _XdrCaseSpec, big_endian_discriminant: bool
+) -> None:
     """Emit encoder functions for an XDR union's case arm"""
 
     if isinstance(node.arm, _XdrVoid):
         return
 
-    template = get_jinja2_template(environment, "encoder", "case_spec")
+    if big_endian_discriminant:
+        template = get_jinja2_template(environment, "encoder", "case_spec_be")
+    else:
+        template = get_jinja2_template(environment, "encoder", "case_spec")
     for case in node.values:
         print(template.render(case=case))
 
-    assert isinstance(node.arm, _XdrBasic)
     template = get_jinja2_template(environment, "encoder", node.arm.template)
     print(
         template.render(
@@ -192,7 +205,6 @@ def emit_union_default_spec_encoder(environment: Environment, node: _XdrUnion) -
         print(template.render())
         return
 
-    assert isinstance(default_case.arm, _XdrBasic)
     template = get_jinja2_template(environment, "encoder", default_case.arm.template)
     print(
         template.render(
@@ -210,7 +222,11 @@ def emit_union_encoder(environment, node: _XdrUnion) -> None:
     emit_union_switch_spec_encoder(environment, node.discriminant)
 
     for case in node.cases:
-        emit_union_case_spec_encoder(environment, case)
+        emit_union_case_spec_encoder(
+            environment,
+            case,
+            node.discriminant.spec.type_name in big_endian,
+        )
 
     emit_union_default_spec_encoder(environment, node)
 
diff --git a/tools/net/sunrpc/xdrgen/grammars/xdr.lark b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
index 0e1aeb02d667..7c2c1b8c86d1 100644
--- a/tools/net/sunrpc/xdrgen/grammars/xdr.lark
+++ b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
@@ -87,12 +87,14 @@ procedure_def           : type_specifier identifier "(" type_specifier ")" "=" c
 
 pragma_def              : "pragma" directive identifier [ identifier ] ";"
 
-directive               : exclude_directive
+directive               : big_endian_directive
+                        | exclude_directive
                         | header_directive
                         | pages_directive
                         | public_directive
                         | skip_directive
 
+big_endian_directive    : "big_endian"
 exclude_directive       : "exclude"
 header_directive        : "header"
 pages_directive         : "pages"
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum_be.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum_be.j2
new file mode 100644
index 000000000000..44c391c10b42
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum_be.j2
@@ -0,0 +1,14 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* enum {{ name }} (big-endian) */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ name }} *ptr)
+{
+	return xdr_stream_decode_be32(xdr, ptr) == 0;
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2
new file mode 100644
index 000000000000..2c18948bddf7
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+};
+typedef __be32 {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum_be.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum_be.j2
new file mode 100644
index 000000000000..fbbcc45948d6
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum_be.j2
@@ -0,0 +1,14 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* enum {{ name }} (big-endian) */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, {{ name }} value)
+{
+	return xdr_stream_encode_be32(xdr, value) == XDR_UNIT;
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec_be.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec_be.j2
new file mode 100644
index 000000000000..917f3a1c4588
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec_be.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	case __constant_cpu_to_be32({{ case }}):
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec_be.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec_be.j2
new file mode 100644
index 000000000000..917f3a1c4588
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec_be.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	case __constant_cpu_to_be32({{ case }}):
diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index 576e1ecfe1d7..d5f0535ec84c 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -12,6 +12,7 @@ from lark.tree import Meta
 
 this_module = sys.modules[__name__]
 
+big_endian = []
 excluded_apis = []
 header_name = "none"
 public_apis = []
@@ -480,6 +481,8 @@ class ParseToAst(Transformer):
         """Instantiate one _Pragma object"""
         directive = children[0].children[0].data
         match directive:
+            case "big_endian_directive":
+                big_endian.append(children[1].symbol)
             case "exclude_directive":
                 excluded_apis.append(children[1].symbol)
             case "header_directive":
-- 
2.46.2


