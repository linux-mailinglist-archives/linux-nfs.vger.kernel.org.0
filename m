Return-Path: <linux-nfs+bounces-17306-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCC7CDECA8
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 16:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 141793003FB1
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1D42264CF;
	Fri, 26 Dec 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojMuIrhH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968253E0B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Dec 2025 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766762379; cv=none; b=F8kN85p6N9bYh9hbt2JDkLTlUVrxoGo5Fk9wqTh773kj89OUyE07bemMzszMvlOCrIWwkfmEdTCMk16+Bep97+KuLcTAeTbinvubOJ1WvpkmvUb74tqXBOjIrnNVh0z+hhIjG4cYD1ixV5+vb1XIlxNGADTgAWW/W0UOdLzClPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766762379; c=relaxed/simple;
	bh=wgSymc5YgZjnV5HA8InYm3E/1oD1NNRwgihtCqfzhB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnwX/LtdCv2rDq7+KQpAQqYpCtJsd14EEb4JJyeWmpFdukoIOpnP+wxW6RLqAmJOQ2l8UlXon38m3LyphsdIxRcG2YANaXPPo0IfvHAGlcaqQCQGH5oaUhCvd9kUZmLtyLIsVTbDBIblj998OxeMWMvW9rxpbe0d87JzVQfWAHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojMuIrhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A541C16AAE;
	Fri, 26 Dec 2025 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766762378;
	bh=wgSymc5YgZjnV5HA8InYm3E/1oD1NNRwgihtCqfzhB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojMuIrhHoTDUtah147azwP4IeR5upKdnDZwpHDUP567SuXQfuOUw8pEpAXRK1V4Ti
	 SyL0sWq6m5xAW/kp35jkMPZCT7Hp8JzKu23E68b3NanGJtrvDc2vvMfxYdQvMNCVpU
	 BME+kAp2xR+hAs0cGUaHAYZf2s4fQCBslVh9HAv/zUIgfiL8B5lPQWGEFZw5RLrxoj
	 ev8/KFVsvHDBDGI5Fn4NPgjiPm5qHaCsGiu0M20Vzr/UMJvDxq9PegRbUMxNCcakE3
	 jw2Ev8MSo/7UsXPTkKpF5P54mV87lh43LBJbiq+E9p8wqhsvF7pqN+VVLBsFDX1QE0
	 gdQEdrz+UubbA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/3] xdrgen: Extend error reporting to AST transformation phase
Date: Fri, 26 Dec 2025 10:19:33 -0500
Message-ID: <20251226151935.441045-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226151935.441045-1-cel@kernel.org>
References: <20251226151935.441045-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Commit 277df18d7df9 ("xdrgen: Improve parse error reporting") added
clean, compiler-style error messages for syntax errors detected during
parsing. However, semantic errors discovered during AST transformation
still produce verbose Python stack traces.

When an XDR specification references an undefined type, the transformer
raises a VisitError wrapping a KeyError. Before this change:

  Traceback (most recent call last):
    File ".../lark/visitors.py", line 124, in _call_userfunc
      return f(children)
    ...
  KeyError: 'fsh4_mode'
  ...
  lark.exceptions.VisitError: Error trying to process rule "basic":
  'fsh4_mode'

After this change:

  file.x:156:2: semantic error
  Undefined type 'fsh4_mode'

      	fsh4_mode	mode;
              ^

The new handle_transform_error() function extracts position information
from the Lark tree node metadata and formats the error consistently with
parse error messages.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .../net/sunrpc/xdrgen/subcmds/declarations.py |  8 +++-
 .../net/sunrpc/xdrgen/subcmds/definitions.py  |  8 +++-
 tools/net/sunrpc/xdrgen/subcmds/lint.py       |  8 +++-
 tools/net/sunrpc/xdrgen/subcmds/source.py     |  8 +++-
 tools/net/sunrpc/xdrgen/xdr_parse.py          | 40 ++++++++++++++++++-
 5 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/subcmds/declarations.py b/tools/net/sunrpc/xdrgen/subcmds/declarations.py
index 2fd5c255a547..97ffb76a02f1 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/declarations.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/declarations.py
@@ -8,6 +8,7 @@ import logging
 
 from argparse import Namespace
 from lark import logger
+from lark.exceptions import VisitError
 
 from generators.constant import XdrConstantGenerator
 from generators.enum import XdrEnumGenerator
@@ -24,6 +25,7 @@ from xdr_ast import _XdrConstant, _XdrEnum, _XdrPointer
 from xdr_ast import _XdrTypedef, _XdrStruct, _XdrUnion
 from xdr_parse import xdr_parser, set_xdr_annotate
 from xdr_parse import make_error_handler, XdrParseError
+from xdr_parse import handle_transform_error
 
 logger.setLevel(logging.INFO)
 
@@ -63,7 +65,11 @@ def subcmd(args: Namespace) -> int:
             )
         except XdrParseError:
             return 1
-        ast = transform_parse_tree(parse_tree)
+        try:
+            ast = transform_parse_tree(parse_tree)
+        except VisitError as e:
+            handle_transform_error(e, source, args.filename)
+            return 1
 
         gen = XdrHeaderTopGenerator(args.language, args.peer)
         gen.emit_declaration(args.filename, ast)
diff --git a/tools/net/sunrpc/xdrgen/subcmds/definitions.py b/tools/net/sunrpc/xdrgen/subcmds/definitions.py
index 8ea5c57cc37a..d6c2dcd6f78f 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/definitions.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/definitions.py
@@ -8,6 +8,7 @@ import logging
 
 from argparse import Namespace
 from lark import logger
+from lark.exceptions import VisitError
 
 from generators.constant import XdrConstantGenerator
 from generators.enum import XdrEnumGenerator
@@ -24,6 +25,7 @@ from xdr_ast import _RpcProgram, _XdrConstant, _XdrEnum, _XdrPointer
 from xdr_ast import _XdrTypedef, _XdrStruct, _XdrUnion
 from xdr_parse import xdr_parser, set_xdr_annotate
 from xdr_parse import make_error_handler, XdrParseError
+from xdr_parse import handle_transform_error
 
 logger.setLevel(logging.INFO)
 
@@ -82,7 +84,11 @@ def subcmd(args: Namespace) -> int:
             )
         except XdrParseError:
             return 1
-        ast = transform_parse_tree(parse_tree)
+        try:
+            ast = transform_parse_tree(parse_tree)
+        except VisitError as e:
+            handle_transform_error(e, source, args.filename)
+            return 1
 
         gen = XdrHeaderTopGenerator(args.language, args.peer)
         gen.emit_definition(args.filename, ast)
diff --git a/tools/net/sunrpc/xdrgen/subcmds/lint.py b/tools/net/sunrpc/xdrgen/subcmds/lint.py
index 2c48fa57c4e5..e1da49632e62 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/lint.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/lint.py
@@ -8,8 +8,10 @@ import logging
 
 from argparse import Namespace
 from lark import logger
+from lark.exceptions import VisitError
 
 from xdr_parse import xdr_parser, make_error_handler, XdrParseError
+from xdr_parse import handle_transform_error
 from xdr_ast import transform_parse_tree
 
 logger.setLevel(logging.DEBUG)
@@ -27,6 +29,10 @@ def subcmd(args: Namespace) -> int:
             )
         except XdrParseError:
             return 1
-        transform_parse_tree(parse_tree)
+        try:
+            transform_parse_tree(parse_tree)
+        except VisitError as e:
+            handle_transform_error(e, source, args.filename)
+            return 1
 
     return 0
diff --git a/tools/net/sunrpc/xdrgen/subcmds/source.py b/tools/net/sunrpc/xdrgen/subcmds/source.py
index bc7d38802df3..08c883f547d7 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/source.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/source.py
@@ -8,6 +8,7 @@ import logging
 
 from argparse import Namespace
 from lark import logger
+from lark.exceptions import VisitError
 
 from generators.source_top import XdrSourceTopGenerator
 from generators.enum import XdrEnumGenerator
@@ -23,6 +24,7 @@ from xdr_ast import _XdrStruct, _XdrTypedef, _XdrUnion
 
 from xdr_parse import xdr_parser, set_xdr_annotate
 from xdr_parse import make_error_handler, XdrParseError
+from xdr_parse import handle_transform_error
 
 logger.setLevel(logging.INFO)
 
@@ -105,7 +107,11 @@ def subcmd(args: Namespace) -> int:
             )
         except XdrParseError:
             return 1
-        ast = transform_parse_tree(parse_tree)
+        try:
+            ast = transform_parse_tree(parse_tree)
+        except VisitError as e:
+            handle_transform_error(e, source, args.filename)
+            return 1
         match args.peer:
             case "server":
                 generate_server_source(args.filename, ast, args.language)
diff --git a/tools/net/sunrpc/xdrgen/xdr_parse.py b/tools/net/sunrpc/xdrgen/xdr_parse.py
index 426513be066c..38724ad5aea2 100644
--- a/tools/net/sunrpc/xdrgen/xdr_parse.py
+++ b/tools/net/sunrpc/xdrgen/xdr_parse.py
@@ -7,7 +7,7 @@ import sys
 from typing import Callable
 
 from lark import Lark
-from lark.exceptions import UnexpectedInput, UnexpectedToken
+from lark.exceptions import UnexpectedInput, UnexpectedToken, VisitError
 
 
 # Set to True to emit annotation comments in generated source
@@ -107,6 +107,44 @@ def make_error_handler(source: str, filename: str) -> Callable[[UnexpectedInput]
     return handle_parse_error
 
 
+def handle_transform_error(e: VisitError, source: str, filename: str) -> None:
+    """Report a transform error with context.
+
+    Args:
+        e: The VisitError from Lark's transformer
+        source: The XDR source text being parsed
+        filename: The name of the file being parsed
+    """
+    lines = source.splitlines()
+
+    # Extract position from the tree node if available
+    line_num = 0
+    column = 0
+    if hasattr(e.obj, "meta") and e.obj.meta:
+        line_num = e.obj.meta.line
+        column = e.obj.meta.column
+
+    line_text = lines[line_num - 1] if 0 < line_num <= len(lines) else ""
+
+    # Build the error message
+    msg_parts = [f"{filename}:{line_num}:{column}: semantic error"]
+
+    # The original exception is typically a KeyError for undefined types
+    if isinstance(e.orig_exc, KeyError):
+        msg_parts.append(f"Undefined type '{e.orig_exc.args[0]}'")
+    else:
+        msg_parts.append(str(e.orig_exc))
+
+    # Show the offending line with a caret pointing to the error
+    if line_text:
+        msg_parts.append("")
+        msg_parts.append(f"    {line_text}")
+        prefix = line_text[: column - 1].expandtabs()
+        msg_parts.append(f"    {' ' * len(prefix)}^")
+
+    sys.stderr.write("\n".join(msg_parts) + "\n")
+
+
 def xdr_parser() -> Lark:
     """Return a Lark parser instance configured with the XDR language grammar"""
 
-- 
2.52.0


