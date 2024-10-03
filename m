Return-Path: <linux-nfs+bounces-6840-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE09398F6AA
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA991F25F6F
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C291A76B4;
	Thu,  3 Oct 2024 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8qMYIWZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F81AAE2F
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981861; cv=none; b=Qo48JkamgSskz/Oo/3PMDJe213N6aAj4/jSIXJv8OxCYmA4NZe8NayAcBzeRVJ8Z3/z7aSx+BYpxe+O9c6jNMoZjjdcp9lO9/8eIghtZcAKIoCUM+K2EqxQv02ou2ZzI86XB0zL1yuEQFcD0WwZWA5CgrqzJOKxDBc3rrFaqhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981861; c=relaxed/simple;
	bh=5u5ySJcNqX2kDBi5mx70Jl9oDiWTQq26iSBlKP9iQKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhuQJOgju0oh6VPgyGvMBmPdLRSCvxu26TE+xHotPEpvqLeaOLvP5wPfT96E327riRQstQUSvqVL/J8sqyKO2jrUoHp4H65YHAW91UU+uf1LXphA714yuhY73FOcys2BWgZhcRcnkOcsZamB4ihYHsZ4gVvf2MMzBYChpespFEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8qMYIWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D60BC4CECC;
	Thu,  3 Oct 2024 18:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981861;
	bh=5u5ySJcNqX2kDBi5mx70Jl9oDiWTQq26iSBlKP9iQKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8qMYIWZKW5oTr3u+vzS/82iE0qBOAGEnm4CqRaebzHnuQW0NO1KJPXTXj5ffLMdG
	 KD/tTR0vP+F09SIdDnN9yNKFzdjfNxFAH+vBkMri8bKMvurdu4zWmcWzfl6bEhn2ws
	 /MH+bvRJnHai/3WwV/xnWM2nkPum5sgTwQE6QKZzbImaHBeY0LmIxVMYSpGp/YIc86
	 m/d9GPp+bC0es3w8FS8ESQNp4Puq3aDOPF65d1LcjMtU1RP9GTSCxilLMkkkto/AQ+
	 F02eoLGqjZALmyIWemWCFlyRSludTWWvOjQNPSM/g7bHKL8x42bXh5vkxrTqWEcXK5
	 mA6SSYKoFQ1Iw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 15/16] xdrgen: Add generator code for XDR width macros
Date: Thu,  3 Oct 2024 14:54:45 -0400
Message-ID: <20241003185446.82984-16-cel@kernel.org>
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

Introduce logic in the code generators to emit maxsize (XDR
width) definitions. In C, these are pre-processor macros.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .../net/sunrpc/xdrgen/generators/__init__.py  |  4 ++++
 tools/net/sunrpc/xdrgen/generators/enum.py    | 13 +++++++++++-
 tools/net/sunrpc/xdrgen/generators/pointer.py | 18 ++++++++++++++++-
 tools/net/sunrpc/xdrgen/generators/struct.py  | 18 ++++++++++++++++-
 tools/net/sunrpc/xdrgen/generators/typedef.py | 18 ++++++++++++++++-
 tools/net/sunrpc/xdrgen/generators/union.py   | 20 +++++++++++++++++--
 .../xdrgen/templates/C/enum/maxsize/enum.j2   |  2 ++
 .../templates/C/pointer/maxsize/pointer.j2    |  3 +++
 .../templates/C/struct/maxsize/struct.j2      |  3 +++
 .../templates/C/typedef/maxsize/basic.j2      |  3 +++
 .../C/typedef/maxsize/fixed_length_opaque.j2  |  2 ++
 .../templates/C/typedef/maxsize/string.j2     |  2 ++
 .../typedef/maxsize/variable_length_array.j2  |  2 ++
 .../typedef/maxsize/variable_length_opaque.j2 |  2 ++
 .../xdrgen/templates/C/union/maxsize/union.j2 |  3 +++
 15 files changed, 107 insertions(+), 6 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/maxsize/enum.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/maxsize/pointer.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/maxsize/struct.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/maxsize/union.j2

diff --git a/tools/net/sunrpc/xdrgen/generators/__init__.py b/tools/net/sunrpc/xdrgen/generators/__init__.py
index fd2457461274..b98574a36a4a 100644
--- a/tools/net/sunrpc/xdrgen/generators/__init__.py
+++ b/tools/net/sunrpc/xdrgen/generators/__init__.py
@@ -111,3 +111,7 @@ class SourceGenerator:
     def emit_encoder(self, node: _XdrAst) -> None:
         """Emit one encoder function for this XDR type"""
         raise NotImplementedError("Encoder generation not supported")
+
+    def emit_maxsize(self, node: _XdrAst) -> None:
+        """Emit one maxsize macro for this XDR type"""
+        raise NotImplementedError("Maxsize macro generation not supported")
diff --git a/tools/net/sunrpc/xdrgen/generators/enum.py b/tools/net/sunrpc/xdrgen/generators/enum.py
index e63f45b8eb74..e62f715d3996 100644
--- a/tools/net/sunrpc/xdrgen/generators/enum.py
+++ b/tools/net/sunrpc/xdrgen/generators/enum.py
@@ -4,7 +4,7 @@
 """Generate code to handle XDR enum types"""
 
 from generators import SourceGenerator, create_jinja2_environment
-from xdr_ast import _XdrEnum, public_apis, big_endian
+from xdr_ast import _XdrEnum, public_apis, big_endian, get_header_name
 
 
 class XdrEnumGenerator(SourceGenerator):
@@ -51,3 +51,14 @@ class XdrEnumGenerator(SourceGenerator):
         else:
             template = self.environment.get_template("encoder/enum.j2")
         print(template.render(name=node.name))
+
+    def emit_maxsize(self, node: _XdrEnum) -> None:
+        """Emit one maxsize macro for an XDR enum type"""
+        macro_name = get_header_name().upper() + "_" + node.name + "_sz"
+        template = self.environment.get_template("maxsize/enum.j2")
+        print(
+            template.render(
+                macro=macro_name,
+                width=" + ".join(node.symbolic_width()),
+            )
+        )
diff --git a/tools/net/sunrpc/xdrgen/generators/pointer.py b/tools/net/sunrpc/xdrgen/generators/pointer.py
index 0aa3d35203f5..6dbda60ad2db 100644
--- a/tools/net/sunrpc/xdrgen/generators/pointer.py
+++ b/tools/net/sunrpc/xdrgen/generators/pointer.py
@@ -12,7 +12,7 @@ from xdr_ast import _XdrBasic, _XdrString
 from xdr_ast import _XdrFixedLengthOpaque, _XdrVariableLengthOpaque
 from xdr_ast import _XdrFixedLengthArray, _XdrVariableLengthArray
 from xdr_ast import _XdrOptionalData, _XdrPointer, _XdrDeclaration
-from xdr_ast import public_apis
+from xdr_ast import public_apis, get_header_name
 
 
 def emit_pointer_declaration(environment: Environment, node: _XdrPointer) -> None:
@@ -247,6 +247,18 @@ def emit_pointer_encoder(environment: Environment, node: _XdrPointer) -> None:
     print(template.render())
 
 
+def emit_pointer_maxsize(environment: Environment, node: _XdrPointer) -> None:
+    """Emit one maxsize macro for an XDR pointer type"""
+    macro_name = get_header_name().upper() + "_" + node.name + "_sz"
+    template = get_jinja2_template(environment, "maxsize", "pointer")
+    print(
+        template.render(
+            macro=macro_name,
+            width=" + ".join(node.symbolic_width()),
+        )
+    )
+
+
 class XdrPointerGenerator(SourceGenerator):
     """Generate source code for XDR pointer"""
 
@@ -270,3 +282,7 @@ class XdrPointerGenerator(SourceGenerator):
     def emit_encoder(self, node: _XdrPointer) -> None:
         """Emit one encoder function for an XDR pointer type"""
         emit_pointer_encoder(self.environment, node)
+
+    def emit_maxsize(self, node: _XdrPointer) -> None:
+        """Emit one maxsize macro for an XDR pointer type"""
+        emit_pointer_maxsize(self.environment, node)
diff --git a/tools/net/sunrpc/xdrgen/generators/struct.py b/tools/net/sunrpc/xdrgen/generators/struct.py
index 6dd7f4d7cd53..64911de46f62 100644
--- a/tools/net/sunrpc/xdrgen/generators/struct.py
+++ b/tools/net/sunrpc/xdrgen/generators/struct.py
@@ -12,7 +12,7 @@ from xdr_ast import _XdrBasic, _XdrString
 from xdr_ast import _XdrFixedLengthOpaque, _XdrVariableLengthOpaque
 from xdr_ast import _XdrFixedLengthArray, _XdrVariableLengthArray
 from xdr_ast import _XdrOptionalData, _XdrStruct, _XdrDeclaration
-from xdr_ast import public_apis
+from xdr_ast import public_apis, get_header_name
 
 
 def emit_struct_declaration(environment: Environment, node: _XdrStruct) -> None:
@@ -247,6 +247,18 @@ def emit_struct_encoder(environment: Environment, node: _XdrStruct) -> None:
     print(template.render())
 
 
+def emit_struct_maxsize(environment: Environment, node: _XdrStruct) -> None:
+    """Emit one maxsize macro for an XDR struct type"""
+    macro_name = get_header_name().upper() + "_" + node.name + "_sz"
+    template = get_jinja2_template(environment, "maxsize", "struct")
+    print(
+        template.render(
+            macro=macro_name,
+            width=" + ".join(node.symbolic_width()),
+        )
+    )
+
+
 class XdrStructGenerator(SourceGenerator):
     """Generate source code for XDR structs"""
 
@@ -270,3 +282,7 @@ class XdrStructGenerator(SourceGenerator):
     def emit_encoder(self, node: _XdrStruct) -> None:
         """Emit one encoder function for an XDR struct type"""
         emit_struct_encoder(self.environment, node)
+
+    def emit_maxsize(self, node: _XdrStruct) -> None:
+        """Emit one maxsize macro for an XDR struct type"""
+        emit_struct_maxsize(self.environment, node)
diff --git a/tools/net/sunrpc/xdrgen/generators/typedef.py b/tools/net/sunrpc/xdrgen/generators/typedef.py
index 6ea98445f5c8..fab72e9d6915 100644
--- a/tools/net/sunrpc/xdrgen/generators/typedef.py
+++ b/tools/net/sunrpc/xdrgen/generators/typedef.py
@@ -12,7 +12,7 @@ from xdr_ast import _XdrBasic, _XdrTypedef, _XdrString
 from xdr_ast import _XdrFixedLengthOpaque, _XdrVariableLengthOpaque
 from xdr_ast import _XdrFixedLengthArray, _XdrVariableLengthArray
 from xdr_ast import _XdrOptionalData, _XdrVoid, _XdrDeclaration
-from xdr_ast import public_apis
+from xdr_ast import public_apis, get_header_name
 
 
 def emit_typedef_declaration(environment: Environment, node: _XdrDeclaration) -> None:
@@ -230,6 +230,18 @@ def emit_typedef_encoder(environment: Environment, node: _XdrDeclaration) -> Non
         raise NotImplementedError("typedef: type not recognized")
 
 
+def emit_typedef_maxsize(environment: Environment, node: _XdrDeclaration) -> None:
+    """Emit a maxsize macro for an XDR typedef"""
+    macro_name = get_header_name().upper() + "_" + node.name + "_sz"
+    template = get_jinja2_template(environment, "maxsize", node.template)
+    print(
+        template.render(
+            macro=macro_name,
+            width=" + ".join(node.symbolic_width()),
+        )
+    )
+
+
 class XdrTypedefGenerator(SourceGenerator):
     """Generate source code for XDR typedefs"""
 
@@ -253,3 +265,7 @@ class XdrTypedefGenerator(SourceGenerator):
     def emit_encoder(self, node: _XdrTypedef) -> None:
         """Emit one encoder function for an XDR typedef"""
         emit_typedef_encoder(self.environment, node.declaration)
+
+    def emit_maxsize(self, node: _XdrTypedef) -> None:
+        """Emit one maxsize macro for an XDR typedef"""
+        emit_typedef_maxsize(self.environment, node.declaration)
diff --git a/tools/net/sunrpc/xdrgen/generators/union.py b/tools/net/sunrpc/xdrgen/generators/union.py
index 4522a5b7a943..2cca00e279cd 100644
--- a/tools/net/sunrpc/xdrgen/generators/union.py
+++ b/tools/net/sunrpc/xdrgen/generators/union.py
@@ -8,8 +8,8 @@ from jinja2 import Environment
 from generators import SourceGenerator
 from generators import create_jinja2_environment, get_jinja2_template
 
-from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, big_endian
-from xdr_ast import _XdrDeclaration, _XdrCaseSpec, public_apis
+from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, get_header_name
+from xdr_ast import _XdrDeclaration, _XdrCaseSpec, public_apis, big_endian
 
 
 def emit_union_declaration(environment: Environment, node: _XdrUnion) -> None:
@@ -234,6 +234,18 @@ def emit_union_encoder(environment, node: _XdrUnion) -> None:
     print(template.render())
 
 
+def emit_union_maxsize(environment: Environment, node: _XdrUnion) -> None:
+    """Emit one maxsize macro for an XDR union type"""
+    macro_name = get_header_name().upper() + "_" + node.name + "_sz"
+    template = get_jinja2_template(environment, "maxsize", "union")
+    print(
+        template.render(
+            macro=macro_name,
+            width=" + ".join(node.symbolic_width()),
+        )
+    )
+
+
 class XdrUnionGenerator(SourceGenerator):
     """Generate source code for XDR unions"""
 
@@ -257,3 +269,7 @@ class XdrUnionGenerator(SourceGenerator):
     def emit_encoder(self, node: _XdrUnion) -> None:
         """Emit one encoder function for an XDR union"""
         emit_union_encoder(self.environment, node)
+
+    def emit_maxsize(self, node: _XdrUnion) -> None:
+        """Emit one maxsize macro for an XDR union"""
+        emit_union_maxsize(self.environment, node)
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/maxsize/enum.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/maxsize/enum.j2
new file mode 100644
index 000000000000..45c1d4c21b22
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/maxsize/enum.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+#define {{ '{:<31}'.format(macro) }} ({{ width }})
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/maxsize/pointer.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/maxsize/pointer.j2
new file mode 100644
index 000000000000..9f3bfb47d2f4
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/maxsize/pointer.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+#define {{ '{:<31}'.format(macro) }} \
+	({{ width }})
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/maxsize/struct.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/maxsize/struct.j2
new file mode 100644
index 000000000000..9f3bfb47d2f4
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/maxsize/struct.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+#define {{ '{:<31}'.format(macro) }} \
+	({{ width }})
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/basic.j2
new file mode 100644
index 000000000000..9f3bfb47d2f4
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/basic.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+#define {{ '{:<31}'.format(macro) }} \
+	({{ width }})
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/fixed_length_opaque.j2
new file mode 100644
index 000000000000..45c1d4c21b22
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/fixed_length_opaque.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+#define {{ '{:<31}'.format(macro) }} ({{ width }})
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/string.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/string.j2
new file mode 100644
index 000000000000..45c1d4c21b22
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/string.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+#define {{ '{:<31}'.format(macro) }} ({{ width }})
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_array.j2
new file mode 100644
index 000000000000..45c1d4c21b22
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_array.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+#define {{ '{:<31}'.format(macro) }} ({{ width }})
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_opaque.j2
new file mode 100644
index 000000000000..45c1d4c21b22
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_opaque.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+#define {{ '{:<31}'.format(macro) }} ({{ width }})
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/maxsize/union.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/maxsize/union.j2
new file mode 100644
index 000000000000..9f3bfb47d2f4
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/maxsize/union.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+#define {{ '{:<31}'.format(macro) }} \
+	({{ width }})
-- 
2.46.2


