Return-Path: <linux-nfs+bounces-16055-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B16C36710
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 16:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A101A22CC2
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 15:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EC72D46DB;
	Wed,  5 Nov 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG6tj0+n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E131DDBB
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356370; cv=none; b=qxjrncW3kU7pl44KpRXKMd+C9/h8ydw+ziKG8eskMWIS49ttbx24GZun/hTOAH0BDWf4BBGABpmwA+9DNcaMY8BVHEWyGEF2b3a4SZ0ExSACuav8HUYPLawNgTmDy8cVeEuEmPIRX5lo8/KBB2eHDB34YWeILLB9ByXcbfHAV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356370; c=relaxed/simple;
	bh=KV/HQg8UeZitDq2SJ5bD3EvlxprbFCG77QeXFgc+Kjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=boItcbnJ9JFIG5IB0Vu/tg8b9+SvzNQdNKbF6gqZ03wr0Wk22FsDCTt4IiTQMeOhd+yh834DxPL3JvoIaLEuODUjD2P9zn/D9Y2w3G8XEu+5ipTcfQ+sQi9zEvrjiQeCDcaGtcC7zxRnsidoZmWZq9R6DasVYhzTlHfnjsmSnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG6tj0+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8749EC4CEF5;
	Wed,  5 Nov 2025 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762356370;
	bh=KV/HQg8UeZitDq2SJ5bD3EvlxprbFCG77QeXFgc+Kjs=;
	h=From:To:Cc:Subject:Date:From;
	b=GG6tj0+n+QgHhY9xRZtSdy98XidUV0RCWYgJ+IA/sbOA+hIBOEdr/7lsKx1ykUvcD
	 4zrYWNQ8EOVBShSKadQdtnp6Zqm4w/49OnZl58CcoAMZAEILORVKHn1fqTHi5N6zG0
	 KNUlpfIqI9iGocnslmlf1AlF+5nYGMgughWZf2VanvbWYgcm83gM+I2KOOy9rT0DJg
	 S2UNgakPvHylXrufgDW1tXSD4zTbYuWyVu3Ickl569mqCaG6GghL5weH9uYk194aVr
	 r+S1oVSScUYf7hjB76jw/snhH64+o3FfXSkvDbPFSvRd/G+WMasF4c/eefe6Clwquy
	 gHALIkme8hoIw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/2] xdrgen: Fix union declarations
Date: Wed,  5 Nov 2025 10:26:06 -0500
Message-ID: <20251105152607.63773-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add a missing template file. This file is used when a union is
defined as a public API (ie, "pragma public <union name>;").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .../net/sunrpc/xdrgen/templates/C/union/declaration/close.j2  | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/declaration/close.j2

diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/declaration/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/declaration/close.j2
new file mode 100644
index 000000000000..816291184e8c
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/declaration/close.j2
@@ -0,0 +1,4 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, struct {{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const struct {{ name }} *value);
-- 
2.51.0


