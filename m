Return-Path: <linux-nfs+bounces-6815-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE398F20A
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D896FB21A4C
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB616F0F0;
	Thu,  3 Oct 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbABxVET"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA4E1A073A
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967722; cv=none; b=DDsLXIIWs7z0EdixlhxtOAyQZ9Fvjn1DW99mPI0w322tMMvDOAfwsS1376SLGD+TSU4gtg9/QZk8MbWeKVO2Bu5IrPhAiaGMYzjw2bSmj7gE1VCSS388QTP3njDlSejyXH4he5/6ZsrDYRLG60N2JOY1aySkhjjJxzt5mV+xi7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967722; c=relaxed/simple;
	bh=pRnpR6P5t42iIkCEFsBPKe8PwabUnPoOZMinZ/zFYto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpxX6MwzPhvhERiLazO9BCUU0dSW6u5TbCjZsaQq+ia49fIH/3rWb+8bq5MguoO1OBWTYqjpsCmHRsGVZKQZ9zqZX0Kv4oruqU3DzeFMUR7CckuxuX4t0I4nYGgOjCb2+TPn4C3DWKTif34rWmnAadNf5G5yvtEY9l0N0LcvM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbABxVET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33A1C4CECF;
	Thu,  3 Oct 2024 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967722;
	bh=pRnpR6P5t42iIkCEFsBPKe8PwabUnPoOZMinZ/zFYto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbABxVETtqj/X0QH9DbWeReXOI7KEi4wkRYPSa7qDW67b2DpqRqG3qeBFXfy2V7q+
	 kL+JrJmwyh38mp0MI2Kuhl80grBMovro61AyXX9ldw61m+1Zh724xZsHxTPWM95LZU
	 KzvK3HCd1zrhJSzqbqbkyRW2DXORUa6ONvMbXN4OIexmZqcOA+SqhnIykf7gXmNtq7
	 uofRuLc7Od+CitC0tBTeExcHgjc7SXJHXZt4u3hISCGnV4UG4JxzrqC/jAOqFYsbOm
	 WwAtA8RlHREI7+ZacSPIJ+rJJgaOHGZLMROUekIRkQ860Ybd40TTHA5tyDWMwImfVj
	 LMosJy6VvkKzA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 06/16] xdrgen: XDR width for variable-length opaque
Date: Thu,  3 Oct 2024 11:01:48 -0400
Message-ID: <20241003150151.81951-7-cel@kernel.org>
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

The byte size of a variable-length opaque is conveyed in an unsigned
integer. If there is a specified maximum size, that is included in
the type's widths list.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index 9fe7fa688caa..94cdcfb36e77 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -148,6 +148,21 @@ class _XdrVariableLengthOpaque(_XdrDeclaration):
     maxsize: str
     template: str = "variable_length_opaque"
 
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
 class _XdrString(_XdrDeclaration):
-- 
2.46.2


