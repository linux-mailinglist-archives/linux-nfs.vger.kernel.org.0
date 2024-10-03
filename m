Return-Path: <linux-nfs+bounces-6839-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9770A98F6A9
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1879FB23C5F
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71D1A76B4;
	Thu,  3 Oct 2024 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4+EyAPd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662D22F19
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981851; cv=none; b=h5Q4pwIeDVgpXWoYQp0J85SrcMT6ma01X1ANJPNghPi+OdUB6iv1sofQlQw29gH0I7X18bd54oPAjHeXUOkeIfsxjQuBwzTi6IPHlPx6TIPcwhMROXD6lKEJ00n+mAM+/qIvX6agAulhdR1vf6miKIfjGEol76GA0KDSNFBpOwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981851; c=relaxed/simple;
	bh=A7CwuIw0S9h+lC2aNEw2fKCO4c8FITOoODYDMlmJt8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sj83qwiesHTKuzWZ1PDStPJE+UkSrttakZyx33ZXw3XwI69kWgUcdT4TbNX8FK0ZiRpOneL/DX/+GZVwWZfH4mMTEffSfJhBTEGxpuE8As9aBchmRiQU2tzbFa2UHWdvdBD3685hGy1LSEFZGv/iiux8xV6M8DGb3uk7KNm5v7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4+EyAPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520F7C4CEC5;
	Thu,  3 Oct 2024 18:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981851;
	bh=A7CwuIw0S9h+lC2aNEw2fKCO4c8FITOoODYDMlmJt8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4+EyAPdx18BzHT/vHk9TM4sinOnsIBUADO6vArLoTgX690+LYn/qCUbndAUSzZPd
	 D/C+3oaEgYKDV3OHY7ebtsBRzbWWYzU3M0lUW8Y1zCb/e3Y8LJEFTyXnHGpQynCGf7
	 CCxQi0FHdRe8X/5V5bYmv0PEBeGXZYY0O3bG+KIjNUMzEI2RXINWPmx0BG2PXDiYuF
	 Rz4+v3BR51hAUiPT0REd7coKZUkTZVer96konTOZhx5TD/z+uGbaC6xz8Xdzhexjwt
	 fXj6wQGsGuppXiED02rY9RIPgp1MCIks1CeAls1l/IqnAP/Dq1so0RUvR2L0fAKbKG
	 lgIVGVaLEtwRg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 14/16] xdrgen: XDR width for union types
Date: Thu,  3 Oct 2024 14:54:44 -0400
Message-ID: <20241003185446.82984-15-cel@kernel.org>
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

Not yet complete.

The tool doesn't do any math yet. Thus, even though the maximum XDR
width of a union is the width of the union enumerator plus the width
of its largest arm, we're using the sum of all the elements of the
union for the moment.

This means that buffer size requirements are overestimated, and that
the generated maxsize macro cannot yet be used for determining data
element alignment in the XDR buffer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index 8d53c889eee8..5233e73c7046 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -450,9 +450,35 @@ class _XdrUnion(_XdrAst):
     cases: List[_XdrCaseSpec]
     default: _XdrDeclaration
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        max_width = 0
+        for case in self.cases:
+            if case.arm.max_width() > max_width:
+                max_width = case.arm.max_width()
+        if self.default:
+            if self.default.arm.max_width() > max_width:
+                max_width = self.default.arm.max_width()
+        return 1 + max_width
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        max_width = 0
+        for case in self.cases:
+            if case.arm.max_width() > max_width:
+                max_width = case.arm.max_width()
+                width = case.arm.symbolic_width()
+        if self.default:
+            if self.default.arm.max_width() > max_width:
+                max_width = self.default.arm.max_width()
+                width = self.default.arm.symbolic_width()
+        return symbolic_widths[self.discriminant.name] + width
+
     def __post_init__(self):
         structs.add(self.name)
         pass_by_reference.add(self.name)
+        max_widths[self.name] = self.max_width()
+        symbolic_widths[self.name] = self.symbolic_width()
 
 
 @dataclass
-- 
2.46.2


