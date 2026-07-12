Return-Path: <linux-nfs+bounces-23270-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PuBPGp76U2o0ggMAu9opvQ
	(envelope-from <linux-nfs+bounces-23270-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:35:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1A1745DAE
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:35:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cWU6kclt;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23270-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23270-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2BCF3019812
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 20:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FABA3B530A;
	Sun, 12 Jul 2026 20:35:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23E3B4EB5
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 20:34:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888500; cv=none; b=UcjABRAP2wPhipJUDfGY6DLhYtiqE7tQTAPpOBelfF5GeD7N6b51Jcg/DzwmmIBoTnPFv/JWH4WpWs1a71G5cLXk8UsLdZZ7FtQMEyl9sfFmgE/JmMe0Opwo17PUbdiZNNLYyrMC2eRDE1qW+iKnD20OtL5PrI+AEa5l9U1cnGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888500; c=relaxed/simple;
	bh=dgwkMiVsZ1/EewTi7PVV2cCHsN3mxeIgjgqwgmyqE1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH4N5G2dDY6iqhxkucHPzFYWSwkKOwbaJt1Ic/fLShZo3MaVzQ1ty6Buea4iKuyqgWJSHodZDdSVqIhyXSfQok1n7xmW+AsIZexUZYJKfUs3NjXLMZXbvbXIWtgRylbjOM8L0cbMTXXnNmRrKGy8uauffceLA4zi1FxELzlDYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWU6kclt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907961F00A3A;
	Sun, 12 Jul 2026 20:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783888495;
	bh=e1QJWTPHognPLIfws+OCS1K8ik6TBEO5+5AWJmWgfR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cWU6kcltJFXRoe+mtHSoLBbgVYX6QJn+xP5QvSL9OJKonGlLxxIr28Bk5uy/p5U7H
	 CVvY/ykm4Zu1LsBvXloWhvyZZmTyJHZ2+AJVqp2wgC3HjJRexhBoscc22rK4dd/U6l
	 Zeq31PhVCGkoOhx9grW9eIYntleEv/i4+ne+qI39qNkBdW5KGk1PZ1ugj7rvOqJ5qZ
	 zlHZRfN5U0F9iG07hmgv+zVm00ujb22xnEp7sEP+x2+DhSLofpsG26h0p95EX6ERd/
	 0PG+yt4M+bSSSmvqzm71ofSLM96/ydqc8aH+Algbvz7NhzcsB4/r+0bFFoqcwdkBMf
	 D/QOqyB2dTo9g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 3/5] xdrgen: Reject specifications that define a name twice
Date: Sun, 12 Jul 2026 16:34:49 -0400
Message-ID: <20260712203451.124902-4-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712203451.124902-1-cel@kernel.org>
References: <20260712203451.124902-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23270-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:jlayton@kernel.org,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,logging.info:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB1A1745DAE

When an RPC specification defines the same type or constant name
more than once, currently xdrgen emits every definition without
complaint. The duplication surfaces later as a C compiler error
about a redefined struct or function that points at generated code
instead of the actual offending line in the .x source.

RFC 4506 Section 6.4 places constant and type identifiers in a
single name space that must be unique within a specification. Add
a semantic check that enforces this rule.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 .../net/sunrpc/xdrgen/subcmds/declarations.py | 10 +--
 .../net/sunrpc/xdrgen/subcmds/definitions.py  |  7 ++-
 tools/net/sunrpc/xdrgen/subcmds/lint.py       |  7 ++-
 tools/net/sunrpc/xdrgen/subcmds/source.py     |  7 ++-
 tools/net/sunrpc/xdrgen/xdr_ast.py            | 61 ++++++++++++++++++-
 tools/net/sunrpc/xdrgen/xdr_parse.py          | 20 ++++++
 6 files changed, 101 insertions(+), 11 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/subcmds/declarations.py b/tools/net/sunrpc/xdrgen/subcmds/declarations.py
index ed83d48d1f68..f187611466d7 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/declarations.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/declarations.py
@@ -21,16 +21,15 @@ from generators.union import XdrUnionGenerator
 
 from xdr_ast import transform_parse_tree, _RpcProgram, Specification
 from xdr_ast import _XdrEnum, _XdrPointer, _XdrTypedef, _XdrStruct, _XdrUnion
+from xdr_ast import XdrSemanticError
 from xdr_parse import xdr_parser, set_xdr_annotate
 from xdr_parse import make_error_handler, XdrParseError
-from xdr_parse import handle_transform_error
+from xdr_parse import handle_transform_error, handle_semantic_error
 
 logger.setLevel(logging.INFO)
 
 
-def emit_header_declarations(
-    root: Specification, language: str, peer: str
-) -> None:
+def emit_header_declarations(root: Specification, language: str, peer: str) -> None:
     """Emit header declarations"""
     for definition in root.definitions:
         if isinstance(definition.value, _XdrEnum):
@@ -68,6 +67,9 @@ def subcmd(args: Namespace) -> int:
         except VisitError as e:
             handle_transform_error(e, source, args.filename)
             return 1
+        except XdrSemanticError as e:
+            handle_semantic_error(e, source, args.filename)
+            return 1
 
         gen = XdrHeaderTopGenerator(args.language, args.peer)
         gen.emit_declaration(args.filename, ast)
diff --git a/tools/net/sunrpc/xdrgen/subcmds/definitions.py b/tools/net/sunrpc/xdrgen/subcmds/definitions.py
index a48ca0549382..77b666943a11 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/definitions.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/definitions.py
@@ -21,12 +21,12 @@ from generators.typedef import XdrTypedefGenerator
 from generators.struct import XdrStructGenerator
 from generators.union import XdrUnionGenerator
 
-from xdr_ast import transform_parse_tree, Specification
+from xdr_ast import transform_parse_tree, Specification, XdrSemanticError
 from xdr_ast import _RpcProgram, _XdrConstant, _XdrEnum, _XdrPassthru, _XdrPointer
 from xdr_ast import _XdrTypedef, _XdrStruct, _XdrUnion
 from xdr_parse import xdr_parser, set_xdr_annotate
 from xdr_parse import make_error_handler, XdrParseError
-from xdr_parse import handle_transform_error
+from xdr_parse import handle_transform_error, handle_semantic_error
 
 logger.setLevel(logging.INFO)
 
@@ -94,6 +94,9 @@ def subcmd(args: Namespace) -> int:
         except VisitError as e:
             handle_transform_error(e, source, args.filename)
             return 1
+        except XdrSemanticError as e:
+            handle_semantic_error(e, source, args.filename)
+            return 1
 
         gen = XdrHeaderTopGenerator(args.language, args.peer)
         gen.emit_definition(args.filename, ast)
diff --git a/tools/net/sunrpc/xdrgen/subcmds/lint.py b/tools/net/sunrpc/xdrgen/subcmds/lint.py
index e1da49632e62..b4ea0f55f079 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/lint.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/lint.py
@@ -11,8 +11,8 @@ from lark import logger
 from lark.exceptions import VisitError
 
 from xdr_parse import xdr_parser, make_error_handler, XdrParseError
-from xdr_parse import handle_transform_error
-from xdr_ast import transform_parse_tree
+from xdr_parse import handle_transform_error, handle_semantic_error
+from xdr_ast import transform_parse_tree, XdrSemanticError
 
 logger.setLevel(logging.DEBUG)
 
@@ -34,5 +34,8 @@ def subcmd(args: Namespace) -> int:
         except VisitError as e:
             handle_transform_error(e, source, args.filename)
             return 1
+        except XdrSemanticError as e:
+            handle_semantic_error(e, source, args.filename)
+            return 1
 
     return 0
diff --git a/tools/net/sunrpc/xdrgen/subcmds/source.py b/tools/net/sunrpc/xdrgen/subcmds/source.py
index 27e8767b1b58..56eba34d8eb3 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/source.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/source.py
@@ -21,11 +21,11 @@ from generators.union import XdrUnionGenerator
 
 from xdr_ast import transform_parse_tree, _RpcProgram, Specification
 from xdr_ast import _XdrAst, _XdrEnum, _XdrPassthru, _XdrPointer
-from xdr_ast import _XdrStruct, _XdrTypedef, _XdrUnion
+from xdr_ast import _XdrStruct, _XdrTypedef, _XdrUnion, XdrSemanticError
 
 from xdr_parse import xdr_parser, set_xdr_annotate, set_xdr_enum_validation
 from xdr_parse import make_error_handler, XdrParseError
-from xdr_parse import handle_transform_error
+from xdr_parse import handle_transform_error, handle_semantic_error
 
 logger.setLevel(logging.INFO)
 
@@ -123,6 +123,9 @@ def subcmd(args: Namespace) -> int:
         except VisitError as e:
             handle_transform_error(e, source, args.filename)
             return 1
+        except XdrSemanticError as e:
+            handle_semantic_error(e, source, args.filename)
+            return 1
         match args.peer:
             case "server":
                 generate_server_source(args.filename, ast, args.language)
diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index 15d2c6c40dd9..cf68ff5dfe17 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -814,7 +814,9 @@ def _merge_consecutive_passthru(definitions: List[Definition]) -> List[Definitio
             lines = [definitions[i].value.content]
             meta = definitions[i].meta
             j = i + 1
-            while j < len(definitions) and isinstance(definitions[j].value, _XdrPassthru):
+            while j < len(definitions) and isinstance(
+                definitions[j].value, _XdrPassthru
+            ):
                 lines.append(definitions[j].value.content)
                 j += 1
             merged = _XdrPassthru("\n".join(lines))
@@ -826,10 +828,67 @@ def _merge_consecutive_passthru(definitions: List[Definition]) -> List[Definitio
     return result
 
 
+def _meta_line(meta) -> int:
+    """Return the 1-based source line for a node's meta, or 0 if unknown"""
+    try:
+        return meta.line
+    except AttributeError:
+        return 0
+
+
+class XdrSemanticError(Exception):
+    """A specification that parses but violates an XDR semantic rule.
+
+    Detection lives in the language-independent front end because a
+    duplicate name is malformed XDR regardless of the output language.
+    """
+
+    def __init__(self, message: str, meta):
+        super().__init__(message)
+        self.message = message
+        self.line = _meta_line(meta)
+        self.column = getattr(meta, "column", 0)
+
+
+def _introduced_names(value):
+    """Yield (name, node) for each identifier a definition introduces."""
+    if isinstance(value, (_XdrStruct, _XdrUnion, _XdrPointer)):
+        yield value.name, value
+    elif isinstance(value, _XdrEnum):
+        yield value.name, value
+        for enumerator in value.enumerators:
+            yield enumerator.name, enumerator
+    elif isinstance(value, _XdrTypedef):
+        yield value.declaration.name, value.declaration
+    elif isinstance(value, _XdrConstant):
+        yield value.name, value
+
+
+def check_duplicate_definitions(root: "Specification") -> None:
+    """Reject a spec that declares an identifier more than once.
+
+    RFC 4506 Section 6.4 places constant and type identifiers in a
+    single name space that must be unique within a specification.
+    """
+    seen = {}
+    for definition in root.definitions:
+        for name, node in _introduced_names(definition.value):
+            where = node if node.line else definition.meta
+            first = seen.get(name)
+            if first is not None:
+                raise XdrSemanticError(
+                    f"duplicate identifier '{name}'"
+                    f" (first declared at line {_meta_line(first)})",
+                    where,
+                )
+            seen[name] = where
+
+
 def transform_parse_tree(parse_tree):
     """Transform productions into an abstract syntax tree"""
     ast = transformer.transform(parse_tree)
     ast.definitions = _merge_consecutive_passthru(ast.definitions)
+    check_duplicate_definitions(ast)
     return ast
 
 
diff --git a/tools/net/sunrpc/xdrgen/xdr_parse.py b/tools/net/sunrpc/xdrgen/xdr_parse.py
index 3e76717d2f85..78298553ee78 100644
--- a/tools/net/sunrpc/xdrgen/xdr_parse.py
+++ b/tools/net/sunrpc/xdrgen/xdr_parse.py
@@ -169,6 +169,26 @@ def handle_transform_error(e: VisitError, source: str, filename: str) -> None:
     sys.stderr.write("\n".join(msg_parts) + "\n")
 
 
+def handle_semantic_error(e, source: str, filename: str) -> None:
+    """Report a semantic error (e.g., a duplicate name) with context.
+
+    Args:
+        e: The XdrSemanticError carrying message and source position
+        source: The XDR source text being parsed
+        filename: The name of the file being parsed
+    """
+    lines = source.splitlines()
+    line_num = getattr(e, "line", 0)
+    column = getattr(e, "column", 0)
+    line_text = lines[line_num - 1] if 0 < line_num <= len(lines) else ""
+
+    msg_parts = [f"{filename}:{line_num}:{column}: semantic error", e.message]
+    if line_text:
+        msg_parts.extend(format_source_caret(line_text, column))
+
+    sys.stderr.write("\n".join(msg_parts) + "\n")
+
+
 def xdr_parser() -> Lark:
     """Return a Lark parser instance configured with the XDR language grammar"""
 
-- 
2.54.0


