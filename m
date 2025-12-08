Return-Path: <linux-nfs+bounces-16989-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AACFACADB86
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 17:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A8A3059979
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB832C11D4;
	Mon,  8 Dec 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dy3lAAnG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F8243964
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210535; cv=none; b=ezertHnXa9YH4bxwPmcL3vRV6rjcBcnlSuYVi2mfb1qHH/YuJEBkKWSxvmR7j6KtHo8xgIxDfvP4G2Lz7dSPZLJl6LrKlye4oOwywc/BPDCAQJcT5iASzunLxZhYLnciG233YY+1agHGPX7OQ0P445s5jwrb/P90dTSwcPBjE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210535; c=relaxed/simple;
	bh=p13llPx3PdFbKr1mLECQ44AcCoE/YF3JJ2Jlj94SnoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GihObxUeFioMWAw8wN8yirr7h86xlpRuNB5AsJpUXVRbPYdLUcURdwphkqkWkVm0TOcFJ4sSybfx7nqH8GxIZE220h5J3fyaABE3hONA0MaB1v+/d1ahu6yRs0dowxbwOsJvN4TXmhAS6KbvGbHmkORW9BaKutQUbs181898IAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dy3lAAnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DB8C4CEF1;
	Mon,  8 Dec 2025 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765210535;
	bh=p13llPx3PdFbKr1mLECQ44AcCoE/YF3JJ2Jlj94SnoE=;
	h=From:To:Cc:Subject:Date:From;
	b=Dy3lAAnGoFqxiHsKvLs/VS/a1HzjydtujPmjPDcJ9Tg89aSTXCIdu1z0Yv3r69w2w
	 LgJR+hHmsLW5kd+cPx8JwaQYBONR3yFHy96v70NJwo6QZ1XW9dFcR+CL7l65Nsmkgy
	 KyiVNww9KUY4tpz4pIeB9+P9wSNVcddx+VfSISCo4FcYPiV3Sha0Tb84xpDusIQHql
	 Jr1hdG4/gSKrUn4orSCoJ6tNEgFdSA3s/bjKPHVhUo2/25kuMPp9ezx1y1e38Qc5IO
	 Fk+IWyFqDkDBeKv3+GVV3id0ITDEMuRHIiWswPGErgoqzWax1h9/CnbJJOcpkrVyRn
	 AURCcDsbgWQyA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1] xdrgen: Fix struct prefix for typedef types in program wrappers
Date: Mon,  8 Dec 2025 11:15:32 -0500
Message-ID: <20251208161532.162398-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The program templates for decoder/argument.j2 and encoder/result.j2
unconditionally add 'struct' prefix to all types. This is incorrect
when an RPC protocol specification lists a typedef'd basic type or
an enum as a procedure argument or result (e.g., NFSv2's fhandle or
stat), resulting in compiler errors when building generated C code.

Fixes: 4b132aacb076 ("tools: Add xdrgen")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/generators/__init__.py              | 3 ++-
 .../sunrpc/xdrgen/templates/C/program/decoder/argument.j2   | 4 ++++
 .../net/sunrpc/xdrgen/templates/C/program/encoder/result.j2 | 6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/net/sunrpc/xdrgen/generators/__init__.py b/tools/net/sunrpc/xdrgen/generators/__init__.py
index e22632cf38fb..1d577a986c6c 100644
--- a/tools/net/sunrpc/xdrgen/generators/__init__.py
+++ b/tools/net/sunrpc/xdrgen/generators/__init__.py
@@ -6,7 +6,7 @@ from pathlib import Path
 from jinja2 import Environment, FileSystemLoader, Template
 
 from xdr_ast import _XdrAst, Specification, _RpcProgram, _XdrTypeSpecifier
-from xdr_ast import public_apis, pass_by_reference, get_header_name
+from xdr_ast import public_apis, pass_by_reference, structs, get_header_name
 from xdr_parse import get_xdr_annotate
 
 
@@ -25,6 +25,7 @@ def create_jinja2_environment(language: str, xdr_type: str) -> Environment:
             environment.globals["annotate"] = get_xdr_annotate()
             environment.globals["public_apis"] = public_apis
             environment.globals["pass_by_reference"] = pass_by_reference
+            environment.globals["structs"] = structs
             return environment
         case _:
             raise NotImplementedError("Language not supported")
diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2
index 0b1709cca0d4..19b219dd276d 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2
@@ -14,7 +14,11 @@ bool {{ program }}_svc_decode_{{ argument }}(struct svc_rqst *rqstp, struct xdr_
 {% if argument == 'void' %}
 	return xdrgen_decode_void(xdr);
 {% else %}
+{% if argument in structs %}
 	struct {{ argument }} *argp = rqstp->rq_argp;
+{% else %}
+	{{ argument }} *argp = rqstp->rq_argp;
+{% endif %}
 
 	return xdrgen_decode_{{ argument }}(xdr, argp);
 {% endif %}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2
index 6fc61a5d47b7..746592cfda56 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2
@@ -14,8 +14,14 @@ bool {{ program }}_svc_encode_{{ result }}(struct svc_rqst *rqstp, struct xdr_st
 {% if result == 'void' %}
 	return xdrgen_encode_void(xdr);
 {% else %}
+{% if result in structs %}
 	struct {{ result }} *resp = rqstp->rq_resp;
 
 	return xdrgen_encode_{{ result }}(xdr, resp);
+{% else %}
+	{{ result }} *resp = rqstp->rq_resp;
+
+	return xdrgen_encode_{{ result }}(xdr, *resp);
+{% endif %}
 {% endif %}
 }
-- 
2.52.0


