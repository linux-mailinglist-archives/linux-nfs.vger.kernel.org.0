Return-Path: <linux-nfs+bounces-15679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2309C0E314
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C617B188AFC7
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8862772D;
	Mon, 27 Oct 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZUJAZ3Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBCF25B30D
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573395; cv=none; b=D0tEAH6ra2YrEDFREhl6PDNwB3jGwiV+ociCzeyS2RG12PIVgHJ2LOnUaj0OXLX2kIo07s8xf7cDeVMJI5csTlOhFXNHUQqYyXb5xmSnUsI92bov/pnwsYvp2Do5sNN4PTCVtImVxeUTdkNXtnW/7QINfUuprw9r0lT5uZi9wsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573395; c=relaxed/simple;
	bh=Kli8NO+/Z5Qq4BfqoUSz0J1me2sARy1Np2xHk8yZMT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jr1SXL/IMUAKyYj/W+GMJlgqYm/aAKZHDAejmNWYgjqCgwg3aAEnWsryJjSvZjGvdIeETPDnCAdStYsI64w9G6yrIRhI0UqTHkb5e99vOO8yvtmCHpThn/FcGZwqT3J9JHqLpvOaci9Gs3ZzhfFd5PociaZJUL2AehuXCGjixBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZUJAZ3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47C9C4CEF1;
	Mon, 27 Oct 2025 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573395;
	bh=Kli8NO+/Z5Qq4BfqoUSz0J1me2sARy1Np2xHk8yZMT4=;
	h=From:To:Cc:Subject:Date:From;
	b=ZZUJAZ3QnjueIAldDXkECaehRqkx+Yzkf/P11teioCixxqDB82L7KZhv12f3xT9Hs
	 bNEnbMCQBF6f00QjtUyU4yfRG4P0JTaOyvuaVOtnRdTOtRkqd/OuZlSxREd9QQaFSG
	 aezVq4MLGO/GxYR1xgc0vl7WxXy3FYgIFAHZiYfxI/OW1Gb1BwWcz8wqio6ne3j/Kk
	 O2KtC1oYgkC+Hgx/41RNJBgPkkR2pRs+5EXRJ5qm0rvElStLV+qTcpr+Po+9/scVqn
	 FLelqdR4zfGzHOilUs+EZ0FY2cM9j3DZo8COP+qbFW2H3aoqg7D3kOPXPuk8/EX+p7
	 QMZvpHCDnBuaQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 1/3] xdrgen: Generalize/harden pathname construction
Date: Mon, 27 Oct 2025 09:56:31 -0400
Message-ID: <20251027135633.9573-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Use Python's built-in Path constructor to find the Jinja templates.
This provides better error checking, proper use of path component
separators, and more reliable location of the template files.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/generators/__init__.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/generators/__init__.py b/tools/net/sunrpc/xdrgen/generators/__init__.py
index b98574a36a4a..e22632cf38fb 100644
--- a/tools/net/sunrpc/xdrgen/generators/__init__.py
+++ b/tools/net/sunrpc/xdrgen/generators/__init__.py
@@ -2,7 +2,7 @@
 
 """Define a base code generator class"""
 
-import sys
+from pathlib import Path
 from jinja2 import Environment, FileSystemLoader, Template
 
 from xdr_ast import _XdrAst, Specification, _RpcProgram, _XdrTypeSpecifier
@@ -14,8 +14,11 @@ def create_jinja2_environment(language: str, xdr_type: str) -> Environment:
     """Open a set of templates based on output language"""
     match language:
         case "C":
+            templates_dir = (
+                Path(__file__).parent.parent / "templates" / language / xdr_type
+            )
             environment = Environment(
-                loader=FileSystemLoader(sys.path[0] + "/templates/C/" + xdr_type + "/"),
+                loader=FileSystemLoader(templates_dir),
                 trim_blocks=True,
                 lstrip_blocks=True,
             )
@@ -48,9 +51,7 @@ def find_xdr_program_name(root: Specification) -> str:
 
 def header_guard_infix(filename: str) -> str:
     """Extract the header guard infix from the specification filename"""
-    basename = filename.split("/")[-1]
-    program = basename.replace(".x", "")
-    return program.upper()
+    return Path(filename).stem.upper()
 
 
 def kernel_c_type(spec: _XdrTypeSpecifier) -> str:
-- 
2.51.0


