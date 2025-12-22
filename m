Return-Path: <linux-nfs+bounces-17256-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C49CD66C1
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 15:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B87903016195
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1B0309F19;
	Mon, 22 Dec 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e64IR5vf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95724309DAF
	for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414702; cv=none; b=H0MuPsVZS2QYskqVB0QKgWc8NnZG9y6Amd7Hg/LfycbjUYylJY7tfGO6FrbomJuoTnchY+goVVEtWLnIRM4CVDBqoKqydTus61sd+TatxBk5Q5oGaG6tn8/02Z3VzLXHbbyOv7NJP00PSwBW+ugyV42KstSQxKiqM8n2jXI9Ad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414702; c=relaxed/simple;
	bh=rZTblXiS71DWS6SPfKLiqE421lfqT2/i9UL5oaHveZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MW3KIgbh1MDFQJzEuVHQZN0BRIxrdvuNG3uRbIujjdjM8BE6+k5OC+BktgeErAGjSr14cx49G0Vb4VX12I0fr4lFqSydCMgWYipaw2NjeX/+fFCi/1cgoPOMTog93mEw6QowhPGV5f4qc2Yh6qxqWbahyPbAvNionKJTJYclQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e64IR5vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF2FC4CEF1;
	Mon, 22 Dec 2025 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766414702;
	bh=rZTblXiS71DWS6SPfKLiqE421lfqT2/i9UL5oaHveZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=e64IR5vf2jXeHzxVKWr+xOKtQYAkkYODBc3nvdlqbOjw5Sb4Pp3QU3bgsTCnf/f0n
	 f0MWsTWxmkbCpoWqGP2QRlz7Wl91HZfifZH1S2A6HrEENi+i1cogYpa5ts75Wd5NlL
	 1yjTYq+kk7NJAtAq6enaC36sPFZYDfhNn3l3cEDkGtMvSMTYo/yHds3qqI1wgenthm
	 2xEa4yFyQ/C+U3Ggj37KpgkcjnbBcCyg6bN63sFhM8Xve4B+dppUgV9D1OBgMcq6PD
	 W4d5sqH4qNF5/f9XzcWbRky8vUerpWNb9cpwmyGmsYiBDe23X89lhrsoBrlyrdyE1A
	 WgLlSxFhW4QoQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] xdrgen: Improve parse error reporting
Date: Mon, 22 Dec 2025 09:44:59 -0500
Message-ID: <20251222144459.1331160-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The current verbose Lark exception output makes it difficult to
quickly identify and fix syntax errors in XDR specifications. Users
must wade through hundreds of lines of cascading errors to find the
root cause.

Replace this with concise, compiler-style error messages showing
file, line, column, the unexpected token, and the source line with
a caret pointing to the error location.

Before:
  Unexpected token Token('__ANON_1', '+1') at line 14, column 35.
  Expected one of:
          * SEMICOLON
  Previous tokens: [Token('__ANON_0', 'LM_MAXSTRLEN')]
  [hundreds more cascading errors...]

After:
  file.x:14:35: parse error
  Unexpected number '+1'

      const LM_MAXNAMELEN = LM_MAXSTRLEN+1;
                                        ^

The error handler now raises XdrParseError on the first error,
preventing cascading messages that obscure the root cause.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .../net/sunrpc/xdrgen/subcmds/declarations.py | 16 ++--
 .../net/sunrpc/xdrgen/subcmds/definitions.py  | 16 ++--
 tools/net/sunrpc/xdrgen/subcmds/lint.py       | 17 ++--
 tools/net/sunrpc/xdrgen/subcmds/source.py     | 16 ++--
 tools/net/sunrpc/xdrgen/xdr_parse.py          | 86 +++++++++++++++++++
 tools/net/sunrpc/xdrgen/xdrgen                |  2 -
 6 files changed, 118 insertions(+), 35 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/subcmds/declarations.py b/tools/net/sunrpc/xdrgen/subcmds/declarations.py
index c5e8d79986ef..2fd5c255a547 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/declarations.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/declarations.py
@@ -8,7 +8,6 @@ import logging
 
 from argparse import Namespace
 from lark import logger
-from lark.exceptions import UnexpectedInput
 
 from generators.constant import XdrConstantGenerator
 from generators.enum import XdrEnumGenerator
@@ -24,6 +23,7 @@ from xdr_ast import transform_parse_tree, _RpcProgram, Specification
 from xdr_ast import _XdrConstant, _XdrEnum, _XdrPointer
 from xdr_ast import _XdrTypedef, _XdrStruct, _XdrUnion
 from xdr_parse import xdr_parser, set_xdr_annotate
+from xdr_parse import make_error_handler, XdrParseError
 
 logger.setLevel(logging.INFO)
 
@@ -50,19 +50,19 @@ def emit_header_declarations(
         gen.emit_declaration(definition.value)
 
 
-def handle_parse_error(e: UnexpectedInput) -> bool:
-    """Simple parse error reporting, no recovery attempted"""
-    print(e)
-    return True
-
-
 def subcmd(args: Namespace) -> int:
     """Generate definitions and declarations"""
 
     set_xdr_annotate(args.annotate)
     parser = xdr_parser()
     with open(args.filename, encoding="utf-8") as f:
-        parse_tree = parser.parse(f.read(), on_error=handle_parse_error)
+        source = f.read()
+        try:
+            parse_tree = parser.parse(
+                source, on_error=make_error_handler(source, args.filename)
+            )
+        except XdrParseError:
+            return 1
         ast = transform_parse_tree(parse_tree)
 
         gen = XdrHeaderTopGenerator(args.language, args.peer)
diff --git a/tools/net/sunrpc/xdrgen/subcmds/definitions.py b/tools/net/sunrpc/xdrgen/subcmds/definitions.py
index c956e27f37c0..8ea5c57cc37a 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/definitions.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/definitions.py
@@ -8,7 +8,6 @@ import logging
 
 from argparse import Namespace
 from lark import logger
-from lark.exceptions import UnexpectedInput
 
 from generators.constant import XdrConstantGenerator
 from generators.enum import XdrEnumGenerator
@@ -24,6 +23,7 @@ from xdr_ast import transform_parse_tree, Specification
 from xdr_ast import _RpcProgram, _XdrConstant, _XdrEnum, _XdrPointer
 from xdr_ast import _XdrTypedef, _XdrStruct, _XdrUnion
 from xdr_parse import xdr_parser, set_xdr_annotate
+from xdr_parse import make_error_handler, XdrParseError
 
 logger.setLevel(logging.INFO)
 
@@ -69,19 +69,19 @@ def emit_header_maxsize(root: Specification, language: str, peer: str) -> None:
         gen.emit_maxsize(definition.value)
 
 
-def handle_parse_error(e: UnexpectedInput) -> bool:
-    """Simple parse error reporting, no recovery attempted"""
-    print(e)
-    return True
-
-
 def subcmd(args: Namespace) -> int:
     """Generate definitions"""
 
     set_xdr_annotate(args.annotate)
     parser = xdr_parser()
     with open(args.filename, encoding="utf-8") as f:
-        parse_tree = parser.parse(f.read(), on_error=handle_parse_error)
+        source = f.read()
+        try:
+            parse_tree = parser.parse(
+                source, on_error=make_error_handler(source, args.filename)
+            )
+        except XdrParseError:
+            return 1
         ast = transform_parse_tree(parse_tree)
 
         gen = XdrHeaderTopGenerator(args.language, args.peer)
diff --git a/tools/net/sunrpc/xdrgen/subcmds/lint.py b/tools/net/sunrpc/xdrgen/subcmds/lint.py
index 36cc43717d30..2c48fa57c4e5 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/lint.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/lint.py
@@ -8,26 +8,25 @@ import logging
 
 from argparse import Namespace
 from lark import logger
-from lark.exceptions import UnexpectedInput
 
-from xdr_parse import xdr_parser
+from xdr_parse import xdr_parser, make_error_handler, XdrParseError
 from xdr_ast import transform_parse_tree
 
 logger.setLevel(logging.DEBUG)
 
 
-def handle_parse_error(e: UnexpectedInput) -> bool:
-    """Simple parse error reporting, no recovery attempted"""
-    print(e)
-    return True
-
-
 def subcmd(args: Namespace) -> int:
     """Lexical and syntax check of an XDR specification"""
 
     parser = xdr_parser()
     with open(args.filename, encoding="utf-8") as f:
-        parse_tree = parser.parse(f.read(), on_error=handle_parse_error)
+        source = f.read()
+        try:
+            parse_tree = parser.parse(
+                source, on_error=make_error_handler(source, args.filename)
+            )
+        except XdrParseError:
+            return 1
         transform_parse_tree(parse_tree)
 
     return 0
diff --git a/tools/net/sunrpc/xdrgen/subcmds/source.py b/tools/net/sunrpc/xdrgen/subcmds/source.py
index 2024954748f0..bc7d38802df3 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/source.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/source.py
@@ -8,7 +8,6 @@ import logging
 
 from argparse import Namespace
 from lark import logger
-from lark.exceptions import UnexpectedInput
 
 from generators.source_top import XdrSourceTopGenerator
 from generators.enum import XdrEnumGenerator
@@ -23,6 +22,7 @@ from xdr_ast import _XdrAst, _XdrEnum, _XdrPointer
 from xdr_ast import _XdrStruct, _XdrTypedef, _XdrUnion
 
 from xdr_parse import xdr_parser, set_xdr_annotate
+from xdr_parse import make_error_handler, XdrParseError
 
 logger.setLevel(logging.INFO)
 
@@ -92,19 +92,19 @@ def generate_client_source(filename: str, root: Specification, language: str) ->
     # cel: todo: client needs PROC macros
 
 
-def handle_parse_error(e: UnexpectedInput) -> bool:
-    """Simple parse error reporting, no recovery attempted"""
-    print(e)
-    return True
-
-
 def subcmd(args: Namespace) -> int:
     """Generate encoder and decoder functions"""
 
     set_xdr_annotate(args.annotate)
     parser = xdr_parser()
     with open(args.filename, encoding="utf-8") as f:
-        parse_tree = parser.parse(f.read(), on_error=handle_parse_error)
+        source = f.read()
+        try:
+            parse_tree = parser.parse(
+                source, on_error=make_error_handler(source, args.filename)
+            )
+        except XdrParseError:
+            return 1
         ast = transform_parse_tree(parse_tree)
         match args.peer:
             case "server":
diff --git a/tools/net/sunrpc/xdrgen/xdr_parse.py b/tools/net/sunrpc/xdrgen/xdr_parse.py
index 964b44e675df..426513be066c 100644
--- a/tools/net/sunrpc/xdrgen/xdr_parse.py
+++ b/tools/net/sunrpc/xdrgen/xdr_parse.py
@@ -3,12 +3,40 @@
 
 """Common parsing code for xdrgen"""
 
+import sys
+from typing import Callable
+
 from lark import Lark
+from lark.exceptions import UnexpectedInput, UnexpectedToken
 
 
 # Set to True to emit annotation comments in generated source
 annotate = False
 
+# Map internal Lark token names to human-readable names
+TOKEN_NAMES = {
+    "__ANON_0": "identifier",
+    "__ANON_1": "number",
+    "SEMICOLON": "';'",
+    "LBRACE": "'{'",
+    "RBRACE": "'}'",
+    "LPAR": "'('",
+    "RPAR": "')'",
+    "LSQB": "'['",
+    "RSQB": "']'",
+    "LESSTHAN": "'<'",
+    "MORETHAN": "'>'",
+    "EQUAL": "'='",
+    "COLON": "':'",
+    "COMMA": "','",
+    "STAR": "'*'",
+    "$END": "end of file",
+}
+
+
+class XdrParseError(Exception):
+    """Raised when XDR parsing fails"""
+
 
 def set_xdr_annotate(set_it: bool) -> None:
     """Set 'annotate' if --annotate was specified on the command line"""
@@ -21,6 +49,64 @@ def get_xdr_annotate() -> bool:
     return annotate
 
 
+def make_error_handler(source: str, filename: str) -> Callable[[UnexpectedInput], bool]:
+    """Create an error handler that reports the first parse error and aborts.
+
+    Args:
+        source: The XDR source text being parsed
+        filename: The name of the file being parsed
+
+    Returns:
+        An error handler function for use with Lark's on_error parameter
+    """
+    lines = source.splitlines()
+
+    def handle_parse_error(e: UnexpectedInput) -> bool:
+        """Report a parse error with context and abort parsing"""
+        line_num = e.line
+        column = e.column
+        line_text = lines[line_num - 1] if 0 < line_num <= len(lines) else ""
+
+        # Build the error message
+        msg_parts = [f"{filename}:{line_num}:{column}: parse error"]
+
+        # Show what was found vs what was expected
+        if isinstance(e, UnexpectedToken):
+            token = e.token
+            if token.type == "__ANON_0":
+                found = f"identifier '{token.value}'"
+            elif token.type == "__ANON_1":
+                found = f"number '{token.value}'"
+            else:
+                found = f"'{token.value}'"
+            msg_parts.append(f"Unexpected {found}")
+
+            # Provide helpful expected tokens list
+            expected = e.expected
+            if expected:
+                readable = [
+                    TOKEN_NAMES.get(exp, exp.lower().replace("_", " "))
+                    for exp in sorted(expected)
+                ]
+                if len(readable) == 1:
+                    msg_parts.append(f"Expected {readable[0]}")
+                elif len(readable) <= 4:
+                    msg_parts.append(f"Expected one of: {', '.join(readable)}")
+        else:
+            msg_parts.append(str(e).split("\n")[0])
+
+        # Show the offending line with a caret pointing to the error
+        msg_parts.append("")
+        msg_parts.append(f"    {line_text}")
+        prefix = line_text[: column - 1].expandtabs()
+        msg_parts.append(f"    {' ' * len(prefix)}^")
+
+        sys.stderr.write("\n".join(msg_parts) + "\n")
+        raise XdrParseError()
+
+    return handle_parse_error
+
+
 def xdr_parser() -> Lark:
     """Return a Lark parser instance configured with the XDR language grammar"""
 
diff --git a/tools/net/sunrpc/xdrgen/xdrgen b/tools/net/sunrpc/xdrgen/xdrgen
index 3afd0547d67c..e22638f8324b 100755
--- a/tools/net/sunrpc/xdrgen/xdrgen
+++ b/tools/net/sunrpc/xdrgen/xdrgen
@@ -133,7 +133,5 @@ There is NO WARRANTY, to the extent permitted by law.""",
 try:
     if __name__ == "__main__":
         sys.exit(main())
-except SystemExit:
-    sys.exit(0)
 except (KeyboardInterrupt, BrokenPipeError):
     sys.exit(1)
-- 
2.52.0


