Return-Path: <linux-nfs+bounces-17307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28024CDECAB
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 16:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EBFE30062C5
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B69D2459F3;
	Fri, 26 Dec 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCTvH9g9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF953E0B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Dec 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766762380; cv=none; b=f5wgglpH5+vF+9Cnx9VA0oAzIDbuLXDDxjQz54AW52Xs+KYOWJztWwJfJxEBBmVYsKRhP5NTDDD/fwQJSoRJQ3BtO0bC/cGzOdlNRNnX4axcMQ3OsCWqCNFW2YDRpmorAl1muL56sp7FrpA50WpTYhGNpu13ivpDhejPcY6kzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766762380; c=relaxed/simple;
	bh=u6OeNFMfOujui3XJ3PwKlU9LbiqheZPd5LGuAyTisVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smBtSvZYegyWPAL+YO+kG+RrLwWFalJlC7sue7L0+/QVvNfyeXIzzs2BzNFp2jWaO2rXAd8tpa2knNbHuQZOpe+swOf81Z1hCn0/yPqOVyF5Y5C70pUSRbgKvl/i9nZe4JGkc3kMFKNDJAEX9xZCgBQNG4o2azqOtuEQeNob22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCTvH9g9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF589C4CEF7;
	Fri, 26 Dec 2025 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766762379;
	bh=u6OeNFMfOujui3XJ3PwKlU9LbiqheZPd5LGuAyTisVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCTvH9g9fi5AyVyNWRZV7dFRmxCI6VJAgc0uU1Voa2Nevgxt9X1KuEZohpk0zzbeO
	 M2q2xFPpiHHjm0FEshQpOyXmY7m7qIZLd7b93T7uQ/HA1KVYw789A7a/coTvTPfzbE
	 6VqmulYc9DEcoWGuDivYKMEmPfCQpxAuezmbGdU3Ep6bnBnR6w1jRx6JX2gemHyh4n
	 7gh95oZsczjyO8ek0epKtOS1mtj6lg+QeOMZq7vKMzFX2zKqEg6UEj6rAJ3gKbLwcM
	 SPGKO9bLQOWXC5URyJ0DFW4coKNZs1teTxCt+hzDbyA42gC+tEA9vrwheas+AQc/rd
	 xbfVjOdtB85/g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 2/3] xdrgen: Emit a max_arg_sz macro
Date: Fri, 26 Dec 2025 10:19:34 -0500
Message-ID: <20251226151935.441045-3-cel@kernel.org>
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

struct svc_service has a .vs_xdrsize field that is filled in by
servers for each of their RPC programs. This field is supposed to
contain the size of the largest procedure argument in the RPC
program. This value is also sometimes used to size network
transport buffers.

Currently, server implementations must manually calculate and
hard-code this value, which is error-prone and requires updates
when procedure arguments change.

Update xdrgen to determine which procedure argument structure is
largest, and emit a macro with a well-known name that contains
the size of that structure. Server code then uses this macro when
initializing the .vs_xdrsize field.

For NLM version 4, xdrgen now emits:

    #define NLM4_MAX_ARGS_SZ (NLM4_nlm4_lockargs_sz)

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/generators/program.py | 35 ++++++++++++++++++-
 .../net/sunrpc/xdrgen/subcmds/definitions.py  |  2 ++
 .../templates/C/program/maxsize/max_args.j2   |  3 ++
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/maxsize/max_args.j2

diff --git a/tools/net/sunrpc/xdrgen/generators/program.py b/tools/net/sunrpc/xdrgen/generators/program.py
index decb092ef02c..c0cb3f6d3319 100644
--- a/tools/net/sunrpc/xdrgen/generators/program.py
+++ b/tools/net/sunrpc/xdrgen/generators/program.py
@@ -5,8 +5,9 @@
 
 from jinja2 import Environment
 
-from generators import SourceGenerator, create_jinja2_environment
+from generators import SourceGenerator, create_jinja2_environment, get_jinja2_template
 from xdr_ast import _RpcProgram, _RpcVersion, excluded_apis
+from xdr_ast import max_widths, get_header_name
 
 
 def emit_version_definitions(
@@ -169,3 +170,35 @@ class XdrProgramGenerator(SourceGenerator):
                     emit_version_argument_encoders(
                         self.environment, program, version,
                     )
+
+    def emit_maxsize(self, node: _RpcProgram) -> None:
+        """Emit maxsize macro for maximum RPC argument size"""
+        header = get_header_name().upper()
+
+        # Find the largest argument across all versions
+        max_arg_width = 0
+        max_arg_name = None
+        for version in node.versions:
+            for procedure in version.procedures:
+                if procedure.name in excluded_apis:
+                    continue
+                arg_name = procedure.argument.type_name
+                if arg_name == "void":
+                    continue
+                if arg_name not in max_widths:
+                    continue
+                if max_widths[arg_name] > max_arg_width:
+                    max_arg_width = max_widths[arg_name]
+                    max_arg_name = arg_name
+
+        if max_arg_name is None:
+            return
+
+        macro_name = header + "_MAX_ARGS_SZ"
+        template = get_jinja2_template(self.environment, "maxsize", "max_args")
+        print(
+            template.render(
+                macro=macro_name,
+                width=header + "_" + max_arg_name + "_sz",
+            )
+        )
diff --git a/tools/net/sunrpc/xdrgen/subcmds/definitions.py b/tools/net/sunrpc/xdrgen/subcmds/definitions.py
index d6c2dcd6f78f..b17526a03dda 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/definitions.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/definitions.py
@@ -66,6 +66,8 @@ def emit_header_maxsize(root: Specification, language: str, peer: str) -> None:
             gen = XdrStructGenerator(language, peer)
         elif isinstance(definition.value, _XdrUnion):
             gen = XdrUnionGenerator(language, peer)
+        elif isinstance(definition.value, _RpcProgram):
+            gen = XdrProgramGenerator(language, peer)
         else:
             continue
         gen.emit_maxsize(definition.value)
diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/maxsize/max_args.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/maxsize/max_args.j2
new file mode 100644
index 000000000000..9f3bfb47d2f4
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/maxsize/max_args.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+#define {{ '{:<31}'.format(macro) }} \
+	({{ width }})
-- 
2.52.0


