Return-Path: <linux-nfs+bounces-6707-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A29898B6
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 02:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7544B22AAC
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 00:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD1DC8E0;
	Mon, 30 Sep 2024 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ/ZTCuw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830EF257D
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657439; cv=none; b=n5riiyVa6pkZAJwb+KvbOdn1WP5D6xoVMyIDLdfNDfarJ004MTlBhVmgX8PGH+3BvH29EB/Wrb0I60WgM08n2uvvokclA5EZ9IjjKu0b50TaV9kavuU0ABa6X0eITz82ChHNuic1xD6IB2n3am1BjrMgSe26TJdow9XkAPPeZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657439; c=relaxed/simple;
	bh=0G1lXXWJhLIGzIDhELM5ULh3jB+HH9IXvFER2sXumOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmApu3ZgygAuo5LbVbyGH9TgXEEIN5xI3/YJpd9LNvTllZODwxW+2ceG635N7HsOpZHPdpe4fVBXhuoLLS8wXbKZs5MczTn/qL+hNv+aN3al+Bm7c1iVLzucsJn18fDGnotUgeoVLVZm2kt1q+455BS5DMlMwOyttho6R/bgmXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZ/ZTCuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72EFC4CEC5;
	Mon, 30 Sep 2024 00:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727657439;
	bh=0G1lXXWJhLIGzIDhELM5ULh3jB+HH9IXvFER2sXumOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZ/ZTCuwNc3ai+XzAN+N04FkX8kOgFezj1NvL1/WD0qfMIAdo8yM+XTJsp4tFgJ+7
	 E6ieNciBQAR5FR9mGD3vbmijHJdIl3TpDc/ZaxDeH9vp6On3FGrsrm5t/Tosgjyt7C
	 HrsxKtOX/0xKl34MmfaX1dvbwWPv7NzB6HDgtLQ/n16pQ2vIDap4bwL8gVBFAGtvOs
	 ZLnt5MMqRvPnzugz0qRxAClmAHry2tZkqL8B05ulwYhxlJboFW4ltYe9ktnldDqbxA
	 VuulN85KMEAMZSXRLM8TFUFURwDakgpMtryWTCQR/V06M5rS9wUqEsI1TiM2bB3ABv
	 uGQ8xs1KRTQqQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5/6] xdrgen: Rename "enum yada" types as just "yada"
Date: Sun, 29 Sep 2024 20:50:15 -0400
Message-ID: <20240930005016.13374-7-cel@kernel.org>
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

This simplifies the generated C code and makes way for supporting
big-endian XDR enums.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2 | 4 ++--
 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2     | 2 +-
 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2 | 1 +
 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2     | 2 +-
 tools/net/sunrpc/xdrgen/xdr_ast.py                           | 4 ----
 5 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
index ab1e576c9531..d1405c7c5354 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
@@ -1,4 +1,4 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
 
-bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, enum {{ name }} *ptr);
-bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, enum {{ name }} value);
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, {{ name }} value);
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2
index 341d829afeda..6482984f1cb7 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2
@@ -8,7 +8,7 @@ bool
 {% else %}
 static bool __maybe_unused
 {% endif %}
-xdrgen_decode_{{ name }}(struct xdr_stream *xdr, enum {{ name }} *ptr)
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ name }} *ptr)
 {
 	u32 val;
 
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2
index 9e62344a976a..a07586cbee17 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2
@@ -1,2 +1,3 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
 };
+typedef enum {{ name }} {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2
index bd0a770e50f2..67245b9a914d 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2
@@ -8,7 +8,7 @@ bool
 {% else %}
 static bool __maybe_unused
 {% endif %}
-xdrgen_encode_{{ name }}(struct xdr_stream *xdr, enum {{ name }} value)
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, {{ name }} value)
 {
 	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
 }
diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index 17d1689b5858..576e1ecfe1d7 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -15,7 +15,6 @@ this_module = sys.modules[__name__]
 excluded_apis = []
 header_name = "none"
 public_apis = []
-enums = set()
 structs = set()
 pass_by_reference = set()
 
@@ -294,8 +293,6 @@ class ParseToAst(Transformer):
         c_classifier = ""
         if isinstance(children[0], _XdrIdentifier):
             name = children[0].symbol
-            if name in enums:
-                c_classifier = "enum "
             if name in structs:
                 c_classifier = "struct "
             return _XdrDefinedType(
@@ -320,7 +317,6 @@ class ParseToAst(Transformer):
     def enum(self, children):
         """Instantiate one _XdrEnum object"""
         enum_name = children[0].symbol
-        enums.add(enum_name)
 
         i = 0
         enumerators = []
-- 
2.46.2


