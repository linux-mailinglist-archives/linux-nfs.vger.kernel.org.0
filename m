Return-Path: <linux-nfs+bounces-6814-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 690CF98F208
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A48D283196
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F519C54D;
	Thu,  3 Oct 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvvSeCpv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96316F0F0
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967722; cv=none; b=dwRSS7FwWKrxIqM0tQI8Fxv3rEvUOUDCUk00Pk1JDgBsHA9Xcb/Zjr5KaP5jUSbUhTA42MrhaCkV/ZX+/K7SamU5+KhnAPKmL4OiXwZezRcG635XkzvFb0qkJCo5VooI1l5zo05beZsjxaoRzGCadCHl80un4qCtdf5XrbubSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967722; c=relaxed/simple;
	bh=zVPNu+hait7j1cpUDsk2WqOtmmz2VyWXZW/4CWdhAEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDLpTwfVK5J6agk8Ej1cs0gFCyntGhe19JPoEPTlDjBwRaVOi9cF0P2+Ex4qH4GbIlI2tabIA431vcd4xA/2e5n+JdLGyMjTD3G+UdRDdIsWQqy9XxFXSQYya1fea60Y00w+RThr59yLu+bIYc3MC1vuQLnzx7hc5sUmqQ12Pp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvvSeCpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9A4C4CEC7;
	Thu,  3 Oct 2024 15:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967721;
	bh=zVPNu+hait7j1cpUDsk2WqOtmmz2VyWXZW/4CWdhAEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvvSeCpvk66Q1iJP6YMYm6M9UWj3O+ctVMCh6NSw1DBihZ/RzKSrlPDk7U4E5K9yr
	 hAPcwFbtX/k/TEaI7TL0eoDHsllBBUr759H90ulWy22N2V6bISqk2U1SFguWaEr8lQ
	 xsZClI8bScui35lYr8fESwN5n/7puW2HnLANpFsWaXhuKqULtw1rDbIUeX2DBe++hv
	 KRZ5eXOlSsRzpF5Mrux6RDmTpA1x8QyZdT0T10w/4Em/603CJd7ndD3EHQnrFV3jV8
	 vizhsVXjCPcCakmtU6Cgy2DxpYazSRQygZPKqV1FwPiAkcHYzcaKBGcw8ujoeWYKXD
	 ZaWea/TpMBaVQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 05/16] xdrgen: XDR width for fixed-length opaque
Date: Thu,  3 Oct 2024 11:01:47 -0400
Message-ID: <20241003150151.81951-6-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003150151.81951-1-cel@kernel.org>
References: <20241003150151.81951-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The XDR width for a fixed-length opaque is the byte size of the
opaque rounded up to the next XDR_UNIT, divided by XDR_UNIT.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index fbee954c7f70..9fe7fa688caa 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -21,6 +21,16 @@ pass_by_reference = set()
 
 constants = {}
 
+
+def xdr_quadlen(val: str) -> int:
+    """Return integer XDR width of an XDR type"""
+    if val in constants:
+        octets = constants[val]
+    else:
+        octets = int(val)
+    return int((octets + 3) / 4)
+
+
 symbolic_widths = {
     "void": ["XDR_void"],
     "bool": ["XDR_bool"],
@@ -117,6 +127,18 @@ class _XdrFixedLengthOpaque(_XdrDeclaration):
     size: str
     template: str = "fixed_length_opaque"
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        return xdr_quadlen(self.size)
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        return ["XDR_QUADLEN(" + self.size + ")"]
+
+    def __post_init__(self):
+        max_widths[self.name] = self.max_width()
+        symbolic_widths[self.name] = self.symbolic_width()
+
 
 @dataclass
 class _XdrVariableLengthOpaque(_XdrDeclaration):
-- 
2.46.2


