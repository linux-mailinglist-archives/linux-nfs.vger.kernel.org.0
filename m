Return-Path: <linux-nfs+bounces-23269-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KN7oLZ36U2ozggMAu9opvQ
	(envelope-from <linux-nfs+bounces-23269-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:35:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C43745DAB
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:35:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C4xgUMgj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23269-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23269-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BBBB3019443
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 20:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F243B5305;
	Sun, 12 Jul 2026 20:35:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60BC3B47FC
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 20:34:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888500; cv=none; b=CfzxXbZJYNvgpKpIlBIHWnNVvEUJgXbSx5MbAm3jdoPv9g4gTHtrNC855cBYKwZGDUVsrrhxC9jdFJlpXFGkKbZV4Pyx0st0pIbk3nNTJb2fQfs+LyKhPFtxq+qT8dMgwZ2zS2U2zA4p7PTQceP957+XEVM0wqOo/oO2tXeoKak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888500; c=relaxed/simple;
	bh=GKxLU6ivIzlX1fKDl54mYfFo+fkN561zCHL50/yVXio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCEIpP8c2PEnN+JGdEDMy9MGO5bqkQxlNdkRM94vYULnHKczM9TnH5XAkBb3+z3HqHNALpKnNXdX0liKe2lJA51RCg5cPzNifLEjPiiFQJSeJw7C64p717R3yJv1vOYeAsN1pCTCKug+HBYCG26Ba5MYiSAMocuL4dAYhMDOmdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4xgUMgj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528D41F00A3E;
	Sun, 12 Jul 2026 20:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783888495;
	bh=RjZTc0SbAiKWndREUXGqdIAi3pcXRiTG0EPzTWzN+ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4xgUMgjQW6boYDXoCVjG0i2VkuItJ3hJvSxSLk5we/1Pdfx+JpvL61I64aVMF+Nq
	 N4+ww9Eg5kHR0MGRpADqjuHpBjFU49tQDFVl5fB/4M8L/xtctXXy9aO1LoGt3vMrd2
	 l7lasdvuMUb+ysIQ0O7BKDjPKOJ+NNMEWsD3lD/4Tz9VY5KqWw3BB44OJWaOT8PR+M
	 yEEJL6QlD8A6Gept6QqY3/dvmFLMcgAYKmmoPVX6dSk9IiHYqiL36SPlyyLSD2GRLY
	 c9FhUXipknkfWO92EJb6LO253y456dLp8IzkDFUUEvYweBPBq3Pnpf7az3RMl9l2AI
	 /GekaJkVzSi8Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 4/5] xdrgen: Enforce RFC 5531 name and number scoping for RPC programs
Date: Sun, 12 Jul 2026 16:34:50 -0400
Message-ID: <20260712203451.124902-5-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-23269-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,procedure.name:url,program.name:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19C43745DAB

The duplicate-identifier check enforces the RFC 4506 name space
for XDR type and constant identifiers but ignores what an RPC
program definition adds. RFC 5531 Section 12.3 completes the
model: a program identifier shares the specification-wide name
space with constant and type identifiers, a version name and
number are unique within their program, and a procedure name and
number are unique within their version.

xdrgen currently accepts a specification that breaks any of these
rules, and the symptom depends on which rule. A duplicate procedure
name reaches the generated header as a redeclared enumerator,
which the C compiler rejects. A duplicate procedure number is
more dangerous because it is silent: the two procedures emit
enumerators of equal value -- valid C that compiles cleanly --
leaving a dispatch collision to surface only at run time. A
duplicate program name shares the specification-wide name space
with constants and types and is caught alongside them.

Extend the check to enforce RFC 5531 scoping in full.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 49 ++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index cf68ff5dfe17..ec48506b239a 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -862,6 +862,50 @@ def _introduced_names(value):
         yield value.declaration.name, value.declaration
     elif isinstance(value, _XdrConstant):
         yield value.name, value
+    elif isinstance(value, _RpcProgram):
+        yield value.name, value
+
+
+def _check_rpc_scope_names(program: "_RpcProgram") -> None:
+    """Enforce RFC 5531 Section 12.3 scoping within an RPC program.
+
+    A version name and number are unique within the program and a
+    procedure name and number are unique within its version.
+    """
+    version_names = set()
+    version_numbers = set()
+    for version in program.versions:
+        if version.name in version_names:
+            raise XdrSemanticError(
+                f"duplicate version name '{version.name}'"
+                f" in program '{program.name}'",
+                version,
+            )
+        version_names.add(version.name)
+        if version.number in version_numbers:
+            raise XdrSemanticError(
+                f"duplicate version number {version.number}"
+                f" in program '{program.name}'",
+                version,
+            )
+        version_numbers.add(version.number)
+        procedure_names = set()
+        procedure_numbers = set()
+        for procedure in version.procedures:
+            if procedure.name in procedure_names:
+                raise XdrSemanticError(
+                    f"duplicate procedure name '{procedure.name}'"
+                    f" in version '{version.name}'",
+                    procedure,
+                )
+            procedure_names.add(procedure.name)
+            if procedure.number in procedure_numbers:
+                raise XdrSemanticError(
+                    f"duplicate procedure number {procedure.number}"
+                    f" in version '{version.name}'",
+                    procedure,
+                )
+            procedure_numbers.add(procedure.number)
 
 
 def check_duplicate_definitions(root: "Specification") -> None:
@@ -869,6 +913,9 @@ def check_duplicate_definitions(root: "Specification") -> None:
 
     RFC 4506 Section 6.4 places constant and type identifiers in a
     single name space that must be unique within a specification.
+    RFC 5531 Section 12.3 adds RPC program names to that name space
+    and scopes version names and numbers to their program and
+    procedure names and numbers to their version.
     """
     seen = {}
     for definition in root.definitions:
@@ -882,6 +929,8 @@ def check_duplicate_definitions(root: "Specification") -> None:
                     where,
                 )
             seen[name] = where
+        if isinstance(definition.value, _RpcProgram):
+            _check_rpc_scope_names(definition.value)
 
 
 def transform_parse_tree(parse_tree):
-- 
2.54.0


