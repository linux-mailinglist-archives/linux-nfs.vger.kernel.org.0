Return-Path: <linux-nfs+bounces-16828-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67269C995FA
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Dec 2025 23:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 771CA340647
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Dec 2025 22:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA24279792;
	Mon,  1 Dec 2025 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeB/PkYU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1975526E6E4
	for <linux-nfs@vger.kernel.org>; Mon,  1 Dec 2025 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627591; cv=none; b=OrxqfbsjJss9/W6rSyiJbmxrh/Wu9DalF+nQf2FXv6JcIcpGwrzLzK9IMNDVGlNTlOlOtyopJCKgxOLtXxmZuaUoONR4vibpGoehQnL5hOwOfO2UCKj32ZnSphJ6hE9WxCwODJ6YunUuC5YTu0W8pJWVV6TPOVnN5KJJIuR2MCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627591; c=relaxed/simple;
	bh=MD53785FPJgGk3qd3buSxYRujBNM2moAAvNXrBFG304=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RanqyaOkW1uEhydKcQ7lEe1VNS6kgQoU6GDJZUOnkZqMwDphMTky5/h7DlZy8QZThUUCJxMgP+9LJnLqfOOnRpFAk9dbd9JpS/ifJTDOM9tmD44/XcrLZpcmvyzHQGri7Un6bMVuXTWt+OncO0gCaIo6QJ0Aeg3bxoLq5ehiB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeB/PkYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2138DC116C6;
	Mon,  1 Dec 2025 22:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764627590;
	bh=MD53785FPJgGk3qd3buSxYRujBNM2moAAvNXrBFG304=;
	h=From:To:Cc:Subject:Date:From;
	b=FeB/PkYUeXpn4eS3ue9EBrY4slUnGdHrvdE0Ac9pJof+FyorztpTfVKGFFpDO3UdA
	 eNcXt5DA2WDCk+viI2XpN4rCkIxQZLoXlTTP5flvlA0aIgDYNOGRUYDJuAXfDMwWp0
	 2yafeBDDlRV9gWv2ib5cyUt0Gse/NqqF+syT1t6OUt1Niz10ATqqF55I89F3k2PLw2
	 IW75kdP9FgbLcAVRk10McRwTMvrVGN3/dugnzdyVIXhzDPBCdyQZ63vF0i/ZrrMrAb
	 ioXZw5x/hGrbVkRFFkPq82IkIfxa91wAyUYZIaQqGHYF2PkMjqi13esFWd+AhJH/Zl
	 2+mKsiG0abi5g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1] xdrgen: Address some checkpatch whitespace complaints
Date: Mon,  1 Dec 2025 17:19:46 -0500
Message-ID: <20251201221946.2680-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This is a roll-up of three template fixes that eliminate noise from
checkpatch output so that it's easier to spot non-trivial problems.

To follow conventional kernel C style, when a union declaration is
marked with "pragma public", there should be a blank line between
the emitted "union xxx { ... };" and the decoder and encoder
function declarations.

---

CHECK: Please use a blank line after function/struct/union/enum declarations
+};
+typedef enum createmode3 createmode3;

Make xdrgen output more "checkpatch friendly" -- add a blank line
after enum definitions.

---

CHECK: Please don't use multiple blank lines
+
+

Eliminate a source of checkpatch.pl warnings in xdrgen-generated
C header files.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2    | 1 -
 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2    | 1 +
 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2 | 1 +
 tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2   | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
index d1405c7c5354..c7ae506076bb 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
@@ -1,4 +1,3 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
-
 bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ name }} *ptr);
 bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, {{ name }} value);
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2
index a07586cbee17..446266ad6d17 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2
@@ -1,3 +1,4 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
 };
+
 typedef enum {{ name }} {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2
index 2c18948bddf7..cfeee2287e68 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2
@@ -1,3 +1,4 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
 };
+
 typedef __be32 {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2
index 01d716d0099e..5fc1937ba774 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2
@@ -3,6 +3,7 @@
 };
 {%- if name in public_apis %}
 
+
 bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, struct {{ name }} *ptr);
 bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const struct {{ name }} *ptr);
 {%- endif -%}
-- 
2.52.0


