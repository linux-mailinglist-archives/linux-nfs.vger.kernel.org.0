Return-Path: <linux-nfs+bounces-6841-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C728D98F6AB
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3E92811E2
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628751AAE18;
	Thu,  3 Oct 2024 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXt/ZCcM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1322F19
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981871; cv=none; b=reqGiJYDmMdfIvb+tKyY+Vyuz36JcKpn9/aUpGpLmZe/5wnAVdb9Vw9YWuD/CSz0REDb8e71uG5+Ibj0vzsXuC5CSxru+7w5RotQBM7T/OIPAsjBsrry1mmyFgazd8LW/cTAFZWdG+UtTiujHX7Q+0Sp1HGsdeHbVNUzbZJX5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981871; c=relaxed/simple;
	bh=H7DStBXojbtO5NqvQ3kmL8wP5q2TC7czGheuTBTyS8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWj7G1/NPyWxyVmSBEldY4qiU6eJvqCaBMaGadOGelbdF7+kn1FqE/N+0keDGWnLEex9PS0AKyxCPtYJqTFdnhnv1oAiZficTuGOkF/zeW/QjUVLnCOXMV1PZKepV4I4M0NB6ttIP1f350EnKz7kFybLHwp29p1oLUjs+jSZN3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXt/ZCcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DC8C4CEC5;
	Thu,  3 Oct 2024 18:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981871;
	bh=H7DStBXojbtO5NqvQ3kmL8wP5q2TC7czGheuTBTyS8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXt/ZCcMD9Dv5AugEasFYqlDo2tV4DQO/586tkH4o+93V4QdZns+fMYy4MEs7vmDo
	 eCflKgAa30McgEB2oqKsfeVA2Yj+XZnBYN1cTmGOd+vKhy5qepRFOp0eMMH8kD5yXd
	 v4mpz+SUuo0RmaqLTFLfpSWrbivs/cVc/k+xhgo7FPcCopE9COw8BQBWcIZc1r/aVM
	 Wor5UnY7zLh8DyzYzYqZVlsu9F4xvwuZiAc9dPjnba9aMjhUv0eH03peMHVZEg40+A
	 dLRtqZRWHdg4rNb2EeeKYTUIArowtx2wuF8Rwiss4DDrPJNHbM3ZKSorhp257Ysjiy
	 bVrLjrTttUojQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 16/16] xdrgen: emit maxsize macros
Date: Thu,  3 Oct 2024 14:54:46 -0400
Message-ID: <20241003185446.82984-17-cel@kernel.org>
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

Add "definitions" subcommand logic to emit maxsize macros in
generated code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .../net/sunrpc/xdrgen/subcmds/definitions.py  | 24 ++++++++++++++++---
 tools/net/sunrpc/xdrgen/subcmds/source.py     |  3 +--
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/subcmds/definitions.py b/tools/net/sunrpc/xdrgen/subcmds/definitions.py
index 5cd13d53221f..c956e27f37c0 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/definitions.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/definitions.py
@@ -28,9 +28,7 @@ from xdr_parse import xdr_parser, set_xdr_annotate
 logger.setLevel(logging.INFO)
 
 
-def emit_header_definitions(
-    root: Specification, language: str, peer: str
-) -> None:
+def emit_header_definitions(root: Specification, language: str, peer: str) -> None:
     """Emit header definitions"""
     for definition in root.definitions:
         if isinstance(definition.value, _XdrConstant):
@@ -52,6 +50,25 @@ def emit_header_definitions(
         gen.emit_definition(definition.value)
 
 
+def emit_header_maxsize(root: Specification, language: str, peer: str) -> None:
+    """Emit header maxsize macros"""
+    print("")
+    for definition in root.definitions:
+        if isinstance(definition.value, _XdrEnum):
+            gen = XdrEnumGenerator(language, peer)
+        elif isinstance(definition.value, _XdrPointer):
+            gen = XdrPointerGenerator(language, peer)
+        elif isinstance(definition.value, _XdrTypedef):
+            gen = XdrTypedefGenerator(language, peer)
+        elif isinstance(definition.value, _XdrStruct):
+            gen = XdrStructGenerator(language, peer)
+        elif isinstance(definition.value, _XdrUnion):
+            gen = XdrUnionGenerator(language, peer)
+        else:
+            continue
+        gen.emit_maxsize(definition.value)
+
+
 def handle_parse_error(e: UnexpectedInput) -> bool:
     """Simple parse error reporting, no recovery attempted"""
     print(e)
@@ -71,6 +88,7 @@ def subcmd(args: Namespace) -> int:
         gen.emit_definition(args.filename, ast)
 
         emit_header_definitions(ast, args.language, args.peer)
+        emit_header_maxsize(ast, args.language, args.peer)
 
         gen = XdrHeaderBottomGenerator(args.language, args.peer)
         gen.emit_definition(args.filename, ast)
diff --git a/tools/net/sunrpc/xdrgen/subcmds/source.py b/tools/net/sunrpc/xdrgen/subcmds/source.py
index 00c04ad15b89..2024954748f0 100644
--- a/tools/net/sunrpc/xdrgen/subcmds/source.py
+++ b/tools/net/sunrpc/xdrgen/subcmds/source.py
@@ -83,8 +83,7 @@ def generate_client_source(filename: str, root: Specification, language: str) ->
     gen = XdrSourceTopGenerator(language, "client")
     gen.emit_source(filename, root)
 
-    # cel: todo: client needs XDR size macros
-
+    print("")
     for definition in root.definitions:
         emit_source_encoder(definition.value, language, "client")
     for definition in root.definitions:
-- 
2.46.2


