Return-Path: <linux-nfs+bounces-23271-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UsLEN6T6U2o1ggMAu9opvQ
	(envelope-from <linux-nfs+bounces-23271-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:35:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88268745DB3
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:35:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=efeGyQSv;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23271-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23271-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98935301AAB9
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 20:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA89346784;
	Sun, 12 Jul 2026 20:35:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53E3B52FA
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 20:34:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888501; cv=none; b=agUEJ2WYTst/uxIiUVIkMW2AtNQD/7IiuezW9S3QcXERB2y9FyIevSx38GvEtGz6EKWeSXtHcg+AJdtwM4LHUl9061nZZDd6zBAbWg2Du+SxuIOJDP/SFGcL6sHyS0z++XFiUc5K/hcA9Na9DVt7BRf7upycCQavZi6aXqHz3es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888501; c=relaxed/simple;
	bh=f4znyC8hS+HhTzrzrdNRVwsPUIkR558WxDDSK7qzCFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDc6nZmMiDjAPUBhuLVjWupsftobtkRZAVMhFddrc1smQ8Hx/p+JfskYoVphtnAKmr9r2My+ko0hF3med2GvwXb3mz/loc3sylmNF/EBBcfabXQUMVTPH0fgWy6iNw5AIkxbgL8nvomVtJT2jjF+w7xx1pSpmsZIfh7qv18vxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efeGyQSv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160D41F00ACA;
	Sun, 12 Jul 2026 20:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783888496;
	bh=UHxuXRisStIwl9DF6vNg6hBoz5+6jgBUQMxGaNdQEq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=efeGyQSvo6lOuV5ThP225B12Zmvv9mpqEW5+CHDhcltXq/kgN/aCMhHfAaw0dl+Tu
	 nY0PF3nmgpat64knrEOVj/muD5zU79Bcoh56XAIteYWF2AtTn0crCRbHJX2sTOp5op
	 YSnb+mCivDLlE8AIW/zCQDMyB1SAyGKbYKbzM/QTYjOfgVdIz1yh72eNX9bYdbRzko
	 HX6Ez6BATVubHq++eathzcoiB9aW4tAPf9KqVpd3qB46XOPhbtRuxzfrtob+tmj3/P
	 7UYVS95S9LS4GziwZj+T+XPdMbpGcRlgfOoR2oMyOma0xd+MsHvn+9O/k6MbkjDVYi
	 75gRqYgKSpdzw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 5/5] xdrgen: Reject out-of-range program, version, and procedure numbers
Date: Sun, 12 Jul 2026 16:34:51 -0400
Message-ID: <20260712203451.124902-6-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-23271-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[program.name:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88268745DB3

RFC 5531 assigns only unsigned constants to program, version, and
procedure numbers (Section 12.3) and encodes each as an unsigned
32-bit integer (Section 9), so a valid number falls within
[0, 2**32 - 1]. RFC 4506 Section 6.2 permits a signed decimal constant
for XDR constants in general and sets no ceiling on magnitude, so the
grammar accepts an out-of-range value without complaint. It reaches
generated code -- a negative procedure number emerges as an enumerator
such as "FOO = -5", valid C that compiles cleanly even though the wire
field is an unsigned 32-bit integer. Thus the xdrgen front end is the
only place that can reject the malformed value.

Extend the semantic checks to require each program, version, and
procedure number to fall within [0, 2**32 - 1].

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 .../tests/bad-procedure-number-negative.x     | 20 ++++++
 .../tests/bad-procedure-number-too-large.x    | 20 ++++++
 .../tests/bad-program-number-negative.x       | 19 ++++++
 .../tests/bad-program-number-too-large.x      | 19 ++++++
 .../tests/bad-version-number-negative.x       | 19 ++++++
 .../tests/bad-version-number-too-large.x      | 19 ++++++
 tools/net/sunrpc/xdrgen/xdr_ast.py            | 64 ++++++++++++++++++-
 7 files changed, 177 insertions(+), 3 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/tests/bad-procedure-number-negative.x
 create mode 100644 tools/net/sunrpc/xdrgen/tests/bad-procedure-number-too-large.x
 create mode 100644 tools/net/sunrpc/xdrgen/tests/bad-program-number-negative.x
 create mode 100644 tools/net/sunrpc/xdrgen/tests/bad-program-number-too-large.x
 create mode 100644 tools/net/sunrpc/xdrgen/tests/bad-version-number-negative.x
 create mode 100644 tools/net/sunrpc/xdrgen/tests/bad-version-number-too-large.x

diff --git a/tools/net/sunrpc/xdrgen/tests/bad-procedure-number-negative.x b/tools/net/sunrpc/xdrgen/tests/bad-procedure-number-negative.x
new file mode 100644
index 000000000000..33ed272c3ce2
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/tests/bad-procedure-number-negative.x
@@ -0,0 +1,20 @@
+/*
+ * NEGATIVE TEST CASE -- xdrgen must REJECT this specification.
+ *
+ * RFC 5531 assigns only unsigned constants to program, version, and
+ * procedure numbers (Section 12.3). This spec gives a procedure a
+ * negative number, which the front end must reject.
+ *
+ * Expected diagnostic:
+ *   negative procedure number -5 in version 'BADVERS'
+ *
+ * The tests directory has no automated runner; exercise by hand:
+ *   ./xdrgen definitions tests/bad-procedure-number-negative.x   (must fail)
+ */
+
+program BADPROG {
+	version BADVERS {
+		void BADPROC_NULL(void) = 0;
+		void BADPROC_FOO(void)  = -5;
+	} = 1;
+} = 100000;
diff --git a/tools/net/sunrpc/xdrgen/tests/bad-procedure-number-too-large.x b/tools/net/sunrpc/xdrgen/tests/bad-procedure-number-too-large.x
new file mode 100644
index 000000000000..521581c57358
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/tests/bad-procedure-number-too-large.x
@@ -0,0 +1,20 @@
+/*
+ * NEGATIVE TEST CASE -- xdrgen must REJECT this specification.
+ *
+ * RFC 5531 encodes program, version, and procedure numbers as unsigned
+ * 32-bit integers (Section 9). This spec gives a procedure a number one
+ * past the 32-bit maximum, which the front end must reject.
+ *
+ * Expected diagnostic:
+ *   procedure number 4294967296 in version 'BADVERS' exceeds 4294967295
+ *
+ * The tests directory has no automated runner; exercise by hand:
+ *   ./xdrgen definitions tests/bad-procedure-number-too-large.x   (must fail)
+ */
+
+program BADPROG {
+	version BADVERS {
+		void BADPROC_NULL(void) = 0;
+		void BADPROC_FOO(void)  = 4294967296;
+	} = 1;
+} = 100000;
diff --git a/tools/net/sunrpc/xdrgen/tests/bad-program-number-negative.x b/tools/net/sunrpc/xdrgen/tests/bad-program-number-negative.x
new file mode 100644
index 000000000000..f7b71ee07f6c
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/tests/bad-program-number-negative.x
@@ -0,0 +1,19 @@
+/*
+ * NEGATIVE TEST CASE -- xdrgen must REJECT this specification.
+ *
+ * RFC 5531 assigns only unsigned constants to program, version, and
+ * procedure numbers (Section 12.3). This spec gives the program a
+ * negative number, which the front end must reject.
+ *
+ * Expected diagnostic:
+ *   negative program number -100000 in program 'BADPROG'
+ *
+ * The tests directory has no automated runner; exercise by hand:
+ *   ./xdrgen definitions tests/bad-program-number-negative.x   (must fail)
+ */
+
+program BADPROG {
+	version BADVERS {
+		void BADPROC_NULL(void) = 0;
+	} = 1;
+} = -100000;
diff --git a/tools/net/sunrpc/xdrgen/tests/bad-program-number-too-large.x b/tools/net/sunrpc/xdrgen/tests/bad-program-number-too-large.x
new file mode 100644
index 000000000000..c761584e712f
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/tests/bad-program-number-too-large.x
@@ -0,0 +1,19 @@
+/*
+ * NEGATIVE TEST CASE -- xdrgen must REJECT this specification.
+ *
+ * RFC 5531 encodes program, version, and procedure numbers as unsigned
+ * 32-bit integers (Section 9). This spec gives the program a number one
+ * past the 32-bit maximum, which the front end must reject.
+ *
+ * Expected diagnostic:
+ *   program number 4294967296 in program 'BADPROG' exceeds 4294967295
+ *
+ * The tests directory has no automated runner; exercise by hand:
+ *   ./xdrgen definitions tests/bad-program-number-too-large.x   (must fail)
+ */
+
+program BADPROG {
+	version BADVERS {
+		void BADPROC_NULL(void) = 0;
+	} = 1;
+} = 4294967296;
diff --git a/tools/net/sunrpc/xdrgen/tests/bad-version-number-negative.x b/tools/net/sunrpc/xdrgen/tests/bad-version-number-negative.x
new file mode 100644
index 000000000000..dd9c773435c0
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/tests/bad-version-number-negative.x
@@ -0,0 +1,19 @@
+/*
+ * NEGATIVE TEST CASE -- xdrgen must REJECT this specification.
+ *
+ * RFC 5531 assigns only unsigned constants to program, version, and
+ * procedure numbers (Section 12.3). This spec gives the version a
+ * negative number, which the front end must reject.
+ *
+ * Expected diagnostic:
+ *   negative version number -1 in program 'BADPROG'
+ *
+ * The tests directory has no automated runner; exercise by hand:
+ *   ./xdrgen definitions tests/bad-version-number-negative.x   (must fail)
+ */
+
+program BADPROG {
+	version BADVERS {
+		void BADPROC_NULL(void) = 0;
+	} = -1;
+} = 100000;
diff --git a/tools/net/sunrpc/xdrgen/tests/bad-version-number-too-large.x b/tools/net/sunrpc/xdrgen/tests/bad-version-number-too-large.x
new file mode 100644
index 000000000000..dd44f6eed564
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/tests/bad-version-number-too-large.x
@@ -0,0 +1,19 @@
+/*
+ * NEGATIVE TEST CASE -- xdrgen must REJECT this specification.
+ *
+ * RFC 5531 encodes program, version, and procedure numbers as unsigned
+ * 32-bit integers (Section 9). This spec gives the version a number one
+ * past the 32-bit maximum, which the front end must reject.
+ *
+ * Expected diagnostic:
+ *   version number 4294967296 in program 'BADPROG' exceeds 4294967295
+ *
+ * The tests directory has no automated runner; exercise by hand:
+ *   ./xdrgen definitions tests/bad-version-number-too-large.x   (must fail)
+ */
+
+program BADPROG {
+	version BADVERS {
+		void BADPROC_NULL(void) = 0;
+	} = 4294967296;
+} = 100000;
diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index ec48506b239a..9dab8bc545b0 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -498,7 +498,7 @@ class _RpcProcedure(_XdrAst):
     """RPC procedure definition"""
 
     name: str
-    number: str
+    number: int
     argument: _XdrTypeSpecifier
     result: _XdrTypeSpecifier
 
@@ -508,7 +508,7 @@ class _RpcVersion(_XdrAst):
     """RPC version definition"""
 
     name: str
-    number: str
+    number: int
     procedures: List[_RpcProcedure]
 
 
@@ -517,7 +517,7 @@ class _RpcProgram(_XdrAst):
     """RPC program definition"""
 
     name: str
-    number: str
+    number: int
     versions: List[_RpcVersion]
 
 
@@ -933,11 +933,69 @@ def check_duplicate_definitions(root: "Specification") -> None:
             _check_rpc_scope_names(definition.value)
 
 
+# RFC 5531 (Section 9) encodes program, version, and procedure numbers
+# as unsigned 32-bit integers, so each must fall within [0, 2**32 - 1].
+_RPC_NUMBER_MAX = 2**32 - 1
+
+
+def _check_rpc_number(kind: str, number: int, scope: str, meta) -> None:
+    """Reject one RPC number that is negative or wider than 32 bits."""
+    if number < 0:
+        raise XdrSemanticError(
+            f"negative {kind} number {number} {scope}",
+            meta,
+        )
+    if number > _RPC_NUMBER_MAX:
+        raise XdrSemanticError(
+            f"{kind} number {number} {scope} exceeds {_RPC_NUMBER_MAX}",
+            meta,
+        )
+
+
+def check_rpc_number_range(root: "Specification") -> None:
+    """Reject an out-of-range program, version, or procedure number.
+
+    RFC 5531 assigns only unsigned constants to program, version, and
+    procedure numbers (Section 12.3) and encodes each as an unsigned
+    32-bit integer (Section 9). RFC 4506 Section 6.2 permits a signed
+    decimal constant for XDR constants in general and sets no ceiling on
+    magnitude, so the grammar accepts an out-of-range value; the range
+    is enforced here instead. The parser retains no per-version or
+    per-procedure source location, so a violation is reported against the
+    program definition.
+    """
+    for definition in root.definitions:
+        program = definition.value
+        if not isinstance(program, _RpcProgram):
+            continue
+        _check_rpc_number(
+            "program",
+            program.number,
+            f"in program '{program.name}'",
+            definition.meta,
+        )
+        for version in program.versions:
+            _check_rpc_number(
+                "version",
+                version.number,
+                f"in program '{program.name}'",
+                definition.meta,
+            )
+            for procedure in version.procedures:
+                _check_rpc_number(
+                    "procedure",
+                    procedure.number,
+                    f"in version '{version.name}'",
+                    definition.meta,
+                )
+
+
 def transform_parse_tree(parse_tree):
     """Transform productions into an abstract syntax tree"""
     ast = transformer.transform(parse_tree)
     ast.definitions = _merge_consecutive_passthru(ast.definitions)
     check_duplicate_definitions(ast)
+    check_rpc_number_range(ast)
     return ast
 
 
-- 
2.54.0


