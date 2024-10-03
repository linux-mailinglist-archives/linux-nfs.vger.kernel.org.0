Return-Path: <linux-nfs+bounces-6832-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A360F98F69B
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0BA1F25D0A
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D561AB506;
	Thu,  3 Oct 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc+ar5Cu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283F19F134
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981781; cv=none; b=qAe0oZ8a+3oSp3CSrONHBls1Vyzt5eLgSADkjNWuj6XQ2DEH3GModkEWmUHHRJABm3x3ce/21ETYzz/LO5l5MdpywvIitfFLieFNqKUNb9n6g+XfINPmg8AVe/9ov+M0UUJaRmu0n+WV7YYJVd6Nk/VJDztP3iasmt61oCJkqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981781; c=relaxed/simple;
	bh=B1K+TALLHIEHvj5rQFKCTcCLrKzUGlUJX2BnsjrwRdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzVy+eQoXIEIEmoShgedJDSFCjS9hnTeY7AULF0PcKhOk0N9fBbqqk+aXAjxa6GZehbmwuqq7ldQ2wdPsICe+r0RLpk/2KQbX1l1V1pj9ErjVpIFG12ItIXqvY+ta/nb1nd/wQB8VDdJ06M81yX76quxtXu660awIUGVi8ssTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc+ar5Cu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75906C4CECC;
	Thu,  3 Oct 2024 18:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981781;
	bh=B1K+TALLHIEHvj5rQFKCTcCLrKzUGlUJX2BnsjrwRdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wc+ar5Cu3hcwlWkt3coYM9z4/w/yijoPiKRQlKzWOiSxnSdcEQ75gIpIrk3FuC02e
	 n5+L2lVzsqKLUQPu0ilYFPUJzeiNFWLO5oPDnaKXbyeQAVIA5uEnlMDWUDfiqia74y
	 Um5ithdcZI3VmS7DNCvbcnodOdsHVH1hnRzMFk5N6JiL0qlFeg6tduuvvcKt5n/K4v
	 bAk19PeAAUd+7cW89gwuar0jK8Jwuec2Tmwi3muaLSoCE/UepAKPN1FoYNz/DHoqQ5
	 InQLag7TucS2vC4hYi1WZwxLKRmQKdw+crvnx8wZhrrXVOAUJ1l/cEpxahnZRLoTiE
	 dS4iXaFNGdjoQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 07/16] xdrgen: XDR width for a string
Date: Thu,  3 Oct 2024 14:54:37 -0400
Message-ID: <20241003185446.82984-8-cel@kernel.org>
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

A string works like a variable-length opaque. See Section 4.11 of
RFC 4506.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index 94cdcfb36e77..d5f48c094729 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -172,6 +172,21 @@ class _XdrString(_XdrDeclaration):
     maxsize: str
     template: str = "string"
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        return 1 + xdr_quadlen(self.maxsize)
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        widths = ["XDR_unsigned_int"]
+        if self.maxsize != "0":
+            widths.append("XDR_QUADLEN(" + self.maxsize + ")")
+        return widths
+
+    def __post_init__(self):
+        max_widths[self.name] = self.max_width()
+        symbolic_widths[self.name] = self.symbolic_width()
+
 
 @dataclass
 class _XdrFixedLengthArray(_XdrDeclaration):
-- 
2.46.2


