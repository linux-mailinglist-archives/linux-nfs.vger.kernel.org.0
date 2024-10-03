Return-Path: <linux-nfs+bounces-6836-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDB998F69F
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C154280D71
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93CE1A705E;
	Thu,  3 Oct 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f774wOrR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830796A33F
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981821; cv=none; b=je4NN8dGvvFuJKTGJ6exLM63cSOqeVPMNeOi+8LyQacqU5mxexNtIekcW+M+VjIKLfpipEfriSMqXeyOArcOrm6cAWavFMyUZe82qA99noYp3ZrOYWzCrPD8zCp9BASyj7CqxDzRCxkZ+8nuifQO1nSGEtw/ZKvR0R5tt9BbPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981821; c=relaxed/simple;
	bh=c6Esw2UeMukJLvdz6V+zscUfk2VMSDxNx171EBgTBPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJ6ILcXABiOXXgHjH/f2N7BYQORNqlBzhKnNxd4k1c+PQs5sJV0Tb8MM32k46aMG1rmfNxBcFYSH2fvaYwmAEdS1F0sqXFDpmfBDHwaBtyodsSEkjvQOu0T3C0YaGQXnNyiN5IgA4nDEvUDL/6f9HzDfSEM9pxcwk2B0CWDAg9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f774wOrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AEBC4CEC5;
	Thu,  3 Oct 2024 18:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981821;
	bh=c6Esw2UeMukJLvdz6V+zscUfk2VMSDxNx171EBgTBPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f774wOrR9UL9EiG6BSBJxrACysywK03Wp3ken+XKEwLOGmEN6LeWyHJ1120EEPyGe
	 zUKwHmBwxvq7JEVnwiQ/G6q1Qzf3xkVbasEvTD5NTfVQRQrmKLGuajacuWvCVnv+KP
	 9a+q3BiiW5yeRR/fJfwT47ovtfwTu4KyUWAsL8t7j3UdeQ2vfpLlq1JYIxtkv9l85U
	 8QOonIPawygkrxze3CGM3SfOJAgfZsXlyEktU1Ry8ATHGnbrV+GOWqocwTJxUBADWv
	 Ijr00b+GSc61jwTihkprkfSP7Xwi+GXs6zBtk+QYiyqdopm7kTCZdQgyzXcM7Os2a1
	 1qulUSOmx0LWw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 11/16] xdrgen: XDR width for typedef
Date: Thu,  3 Oct 2024 14:54:41 -0400
Message-ID: <20241003185446.82984-12-cel@kernel.org>
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

The XDR width of a typedef is the same as the width of the base type.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 34 ++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index f2ef78654e36..8996f26cbd55 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -268,6 +268,18 @@ class _XdrBasic(_XdrDeclaration):
     spec: _XdrTypeSpecifier
     template: str = "basic"
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        return max_widths[self.spec.type_name]
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        return symbolic_widths[self.spec.type_name]
+
+    def __post_init__(self):
+        max_widths[self.name] = self.max_width()
+        symbolic_widths[self.name] = self.symbolic_width()
+
 
 @dataclass
 class _XdrVoid(_XdrDeclaration):
@@ -361,14 +373,22 @@ class _XdrTypedef(_XdrAst):
 
     declaration: _XdrDeclaration
 
-    def __post_init__(self):
-        if not isinstance(self.declaration, _XdrBasic):
-            return
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        return self.declaration.max_width()
 
-        new_type = self.declaration
-        if isinstance(new_type.spec, _XdrDefinedType):
-            if new_type.spec.type_name in pass_by_reference:
-                pass_by_reference.add(new_type.name)
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        return self.declaration.symbolic_width()
+
+    def __post_init__(self):
+        if isinstance(self.declaration, _XdrBasic):
+            new_type = self.declaration
+            if isinstance(new_type.spec, _XdrDefinedType):
+                if new_type.spec.type_name in pass_by_reference:
+                    pass_by_reference.add(new_type.name)
+                max_widths[new_type.name] = self.max_width()
+                symbolic_widths[new_type.name] = self.symbolic_width()
 
 
 @dataclass
-- 
2.46.2


