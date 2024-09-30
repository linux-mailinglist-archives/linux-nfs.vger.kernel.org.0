Return-Path: <linux-nfs+bounces-6705-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 453A39898AE
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 02:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC635B227EB
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 00:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CEA8F45;
	Mon, 30 Sep 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX6ekmUs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9C8489
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657434; cv=none; b=u9GiPm9KgkRgMyKSzC5ymn4/Ph4FSmmQDeYgO+CywIzAWXnLq68yTyiawMJBZ2B8Cf9SMU7QnvLr9b/tzZ+mjM7R7JQR7TgJgMbi0zv6pH4MGBUFe+zVQqSnvLZ8kIjfpM7mRi5Dv8ifHHCdkvp4sfmVbRyg25SssJFNCfKPuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657434; c=relaxed/simple;
	bh=4OkXTX8an3BLGKJRYOnMatzITKVogbEoYol4sGpRx/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORIrcHo1dktzB64pcq8C5cigIu9wfzxl5Tgsvrjtpxc00LBJPh0fPB1SJIWbVrDAmjqO6pcJHYSllkH+BBefufhwNQ8Gc5Ez86WqraEW0NL/vfwxdglUM6Kueup8Skkvu4J3VVDd1ZmiVD+bMbpeiTME1Z6ZVbombRQYFTB1qus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX6ekmUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D712C4CEC6;
	Mon, 30 Sep 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727657434;
	bh=4OkXTX8an3BLGKJRYOnMatzITKVogbEoYol4sGpRx/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bX6ekmUsQtBDsTnh/vJOqAQm+WyL/oK1FV7cXau/X11LGcb0d7sIj1yl38taFu7Tr
	 uq6kwB6KXi+PRBvgMIMCrO8TBxeItCwx0EPJSCu6wjzZHdpoDH8iciJTtyO5UkHbVk
	 5CDkSlOoh51yLq5rrE5LZJ6VpWwY19yoR/EfPYvxSmTTMymAe2yXppWzFvsjz4P6V7
	 D+EISeXrzXjaqO7aC/N5CyZFKsag3IDGnPEQOmYm8wEQG1xjtyYiHTFqjPezmA3uzS
	 dfpyVA5V3l4iskja/rOJBW/yH50Ephbu6BT/hxjGOU+GplfoRNMCilpjjYWT6cMgO1
	 EP0OcoBn9VZiw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 3/6] xdrgen: Rename "variable-length strings"
Date: Sun, 29 Sep 2024 20:50:13 -0400
Message-ID: <20240930005016.13374-5-cel@kernel.org>
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

I misread RFC 4506. The built-in data type is called simply
"string", as there is no fixed-length variety.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/generators/pointer.py          |  8 ++++----
 tools/net/sunrpc/xdrgen/generators/struct.py           |  8 ++++----
 tools/net/sunrpc/xdrgen/generators/typedef.py          | 10 +++++-----
 tools/net/sunrpc/xdrgen/grammars/xdr.lark              |  2 +-
 .../decoder/{variable_length_string.j2 => string.j2}   |  0
 .../{variable_length_string.j2 => string.j2}           |  0
 .../encoder/{variable_length_string.j2 => string.j2}   |  0
 .../decoder/{variable_length_string.j2 => string.j2}   |  0
 .../{variable_length_string.j2 => string.j2}           |  0
 .../encoder/{variable_length_string.j2 => string.j2}   |  0
 .../{variable_length_string.j2 => string.j2}           |  0
 .../decoder/{variable_length_string.j2 => string.j2}   |  0
 .../{variable_length_string.j2 => string.j2}           |  0
 .../encoder/{variable_length_string.j2 => string.j2}   |  0
 .../decoder/{variable_length_string.j2 => string.j2}   |  0
 tools/net/sunrpc/xdrgen/xdr_ast.py                     | 10 +++++-----
 16 files changed, 19 insertions(+), 19 deletions(-)
 rename tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/pointer/definition/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/struct/decoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/struct/definition/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/struct/encoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/typedef/definition/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/union/decoder/{variable_length_string.j2 => string.j2} (100%)

diff --git a/tools/net/sunrpc/xdrgen/generators/pointer.py b/tools/net/sunrpc/xdrgen/generators/pointer.py
index b0b27f1819c8..0aa3d35203f5 100644
--- a/tools/net/sunrpc/xdrgen/generators/pointer.py
+++ b/tools/net/sunrpc/xdrgen/generators/pointer.py
@@ -8,7 +8,7 @@ from jinja2 import Environment
 from generators import SourceGenerator, kernel_c_type
 from generators import create_jinja2_environment, get_jinja2_template
 
-from xdr_ast import _XdrBasic, _XdrVariableLengthString
+from xdr_ast import _XdrBasic, _XdrString
 from xdr_ast import _XdrFixedLengthOpaque, _XdrVariableLengthOpaque
 from xdr_ast import _XdrFixedLengthArray, _XdrVariableLengthArray
 from xdr_ast import _XdrOptionalData, _XdrPointer, _XdrDeclaration
@@ -46,7 +46,7 @@ def emit_pointer_member_definition(
     elif isinstance(field, _XdrVariableLengthOpaque):
         template = get_jinja2_template(environment, "definition", field.template)
         print(template.render(name=field.name))
-    elif isinstance(field, _XdrVariableLengthString):
+    elif isinstance(field, _XdrString):
         template = get_jinja2_template(environment, "definition", field.template)
         print(template.render(name=field.name))
     elif isinstance(field, _XdrFixedLengthArray):
@@ -119,7 +119,7 @@ def emit_pointer_member_decoder(
                 maxsize=field.maxsize,
             )
         )
-    elif isinstance(field, _XdrVariableLengthString):
+    elif isinstance(field, _XdrString):
         template = get_jinja2_template(environment, "decoder", field.template)
         print(
             template.render(
@@ -198,7 +198,7 @@ def emit_pointer_member_encoder(
                 maxsize=field.maxsize,
             )
         )
-    elif isinstance(field, _XdrVariableLengthString):
+    elif isinstance(field, _XdrString):
         template = get_jinja2_template(environment, "encoder", field.template)
         print(
             template.render(
diff --git a/tools/net/sunrpc/xdrgen/generators/struct.py b/tools/net/sunrpc/xdrgen/generators/struct.py
index b694cd470829..6dd7f4d7cd53 100644
--- a/tools/net/sunrpc/xdrgen/generators/struct.py
+++ b/tools/net/sunrpc/xdrgen/generators/struct.py
@@ -8,7 +8,7 @@ from jinja2 import Environment
 from generators import SourceGenerator, kernel_c_type
 from generators import create_jinja2_environment, get_jinja2_template
 
-from xdr_ast import _XdrBasic, _XdrVariableLengthString
+from xdr_ast import _XdrBasic, _XdrString
 from xdr_ast import _XdrFixedLengthOpaque, _XdrVariableLengthOpaque
 from xdr_ast import _XdrFixedLengthArray, _XdrVariableLengthArray
 from xdr_ast import _XdrOptionalData, _XdrStruct, _XdrDeclaration
@@ -46,7 +46,7 @@ def emit_struct_member_definition(
     elif isinstance(field, _XdrVariableLengthOpaque):
         template = get_jinja2_template(environment, "definition", field.template)
         print(template.render(name=field.name))
-    elif isinstance(field, _XdrVariableLengthString):
+    elif isinstance(field, _XdrString):
         template = get_jinja2_template(environment, "definition", field.template)
         print(template.render(name=field.name))
     elif isinstance(field, _XdrFixedLengthArray):
@@ -119,7 +119,7 @@ def emit_struct_member_decoder(
                 maxsize=field.maxsize,
             )
         )
-    elif isinstance(field, _XdrVariableLengthString):
+    elif isinstance(field, _XdrString):
         template = get_jinja2_template(environment, "decoder", field.template)
         print(
             template.render(
@@ -198,7 +198,7 @@ def emit_struct_member_encoder(
                 maxsize=field.maxsize,
             )
         )
-    elif isinstance(field, _XdrVariableLengthString):
+    elif isinstance(field, _XdrString):
         template = get_jinja2_template(environment, "encoder", field.template)
         print(
             template.render(
diff --git a/tools/net/sunrpc/xdrgen/generators/typedef.py b/tools/net/sunrpc/xdrgen/generators/typedef.py
index 85a1b2303333..6ea98445f5c8 100644
--- a/tools/net/sunrpc/xdrgen/generators/typedef.py
+++ b/tools/net/sunrpc/xdrgen/generators/typedef.py
@@ -8,7 +8,7 @@ from jinja2 import Environment
 from generators import SourceGenerator, kernel_c_type
 from generators import create_jinja2_environment, get_jinja2_template
 
-from xdr_ast import _XdrBasic, _XdrTypedef, _XdrVariableLengthString
+from xdr_ast import _XdrBasic, _XdrTypedef, _XdrString
 from xdr_ast import _XdrFixedLengthOpaque, _XdrVariableLengthOpaque
 from xdr_ast import _XdrFixedLengthArray, _XdrVariableLengthArray
 from xdr_ast import _XdrOptionalData, _XdrVoid, _XdrDeclaration
@@ -28,7 +28,7 @@ def emit_typedef_declaration(environment: Environment, node: _XdrDeclaration) ->
                 classifier=node.spec.c_classifier,
             )
         )
-    elif isinstance(node, _XdrVariableLengthString):
+    elif isinstance(node, _XdrString):
         template = get_jinja2_template(environment, "declaration", node.template)
         print(template.render(name=node.name))
     elif isinstance(node, _XdrFixedLengthOpaque):
@@ -74,7 +74,7 @@ def emit_type_definition(environment: Environment, node: _XdrDeclaration) -> Non
                 classifier=node.spec.c_classifier,
             )
         )
-    elif isinstance(node, _XdrVariableLengthString):
+    elif isinstance(node, _XdrString):
         template = get_jinja2_template(environment, "definition", node.template)
         print(template.render(name=node.name))
     elif isinstance(node, _XdrFixedLengthOpaque):
@@ -119,7 +119,7 @@ def emit_typedef_decoder(environment: Environment, node: _XdrDeclaration) -> Non
                 type=node.spec.type_name,
             )
         )
-    elif isinstance(node, _XdrVariableLengthString):
+    elif isinstance(node, _XdrString):
         template = get_jinja2_template(environment, "decoder", node.template)
         print(
             template.render(
@@ -180,7 +180,7 @@ def emit_typedef_encoder(environment: Environment, node: _XdrDeclaration) -> Non
                 type=node.spec.type_name,
             )
         )
-    elif isinstance(node, _XdrVariableLengthString):
+    elif isinstance(node, _XdrString):
         template = get_jinja2_template(environment, "encoder", node.template)
         print(
             template.render(
diff --git a/tools/net/sunrpc/xdrgen/grammars/xdr.lark b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
index f3c4552e548d..0e1aeb02d667 100644
--- a/tools/net/sunrpc/xdrgen/grammars/xdr.lark
+++ b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
@@ -3,7 +3,7 @@
 
 declaration             : "opaque" identifier "[" value "]"            -> fixed_length_opaque
                         | "opaque" identifier "<" [ value ] ">"        -> variable_length_opaque
-                        | "string" identifier "<" [ value ] ">"        -> variable_length_string
+                        | "string" identifier "<" [ value ] ">"        -> string
                         | type_specifier identifier "[" value "]"      -> fixed_length_array
                         | type_specifier identifier "<" [ value ] ">"  -> variable_length_array
                         | type_specifier "*" identifier                -> optional_data
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/string.j2
similarity index 100%
rename from tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_string.j2
rename to tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/string.j2
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/string.j2
similarity index 100%
rename from tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_string.j2
rename to tools/net/sunrpc/xdrgen/templates/C/pointer/definition/string.j2
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/string.j2
similarity index 100%
rename from tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_string.j2
rename to tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/string.j2
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/string.j2
similarity index 100%
rename from tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_string.j2
rename to tools/net/sunrpc/xdrgen/templates/C/struct/decoder/string.j2
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/string.j2
similarity index 100%
rename from tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_string.j2
rename to tools/net/sunrpc/xdrgen/templates/C/struct/definition/string.j2
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/string.j2
similarity index 100%
rename from tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_string.j2
rename to tools/net/sunrpc/xdrgen/templates/C/struct/encoder/string.j2
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/string.j2
similarity index 100%
rename from tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_string.j2
rename to tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/string.j2
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/string.j2
similarity index 100%
rename from tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_string.j2
rename to tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/string.j2
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/string.j2
similarity index 100%
rename from tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_string.j2
rename to tools/net/sunrpc/xdrgen/templates/C/typedef/definition/string.j2
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/string.j2
similarity index 100%
rename from tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_string.j2
rename to tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/string.j2
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/string.j2
similarity index 100%
rename from tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_string.j2
rename to tools/net/sunrpc/xdrgen/templates/C/union/decoder/string.j2
diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index 5d96c544a07b..17d1689b5858 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -88,12 +88,12 @@ class _XdrVariableLengthOpaque(_XdrDeclaration):
 
 
 @dataclass
-class _XdrVariableLengthString(_XdrDeclaration):
+class _XdrString(_XdrDeclaration):
     """A (NUL-terminated) variable-length string declaration"""
 
     name: str
     maxsize: str
-    template: str = "variable_length_string"
+    template: str = "string"
 
 
 @dataclass
@@ -350,15 +350,15 @@ class ParseToAst(Transformer):
 
         return _XdrVariableLengthOpaque(name, maxsize)
 
-    def variable_length_string(self, children):
-        """Instantiate one _XdrVariableLengthString declaration object"""
+    def string(self, children):
+        """Instantiate one _XdrString declaration object"""
         name = children[0].symbol
         if children[1] is not None:
             maxsize = children[1].value
         else:
             maxsize = "0"
 
-        return _XdrVariableLengthString(name, maxsize)
+        return _XdrString(name, maxsize)
 
     def fixed_length_array(self, children):
         """Instantiate one _XdrFixedLengthArray declaration object"""
-- 
2.46.2


