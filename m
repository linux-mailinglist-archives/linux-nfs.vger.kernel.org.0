Return-Path: <linux-nfs+bounces-6831-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A11998F69A
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BD11C22D8D
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9681AB6C4;
	Thu,  3 Oct 2024 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPMgnuvf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975511AB6D3
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981771; cv=none; b=gD3KlcCheZYqtV+er85Qcolh7ZMrgYcT/1ShS1bpC7bLVgI8m6P85/BwpeftIx5q02c4OMmhpBF1SLROmAXCzWKQ4PMyPh/D3dsSMlrpybQIdijPrgRL3lvdJ50McmqoSjeLRCU8GxNYa9dCxq5XtkZFwz5TyAB/GeokxnNZd8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981771; c=relaxed/simple;
	bh=pRnpR6P5t42iIkCEFsBPKe8PwabUnPoOZMinZ/zFYto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaI+M8NdMwWKLnwCGnWc5P0oFDlF9RnsczyhIGxZ/rmDMawNXIHymH4WA9/uizx0cPBwbFz6jqY4DZVN8oyCV7dVL2WZOFj5mfim7Z4fRS+QgXkjb9+F1g6/SGvdo/XIQBX8Vsunf43gmZvTfNg5KvcjNx4mF+aTIGNWLZ/Os6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPMgnuvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B29C4CEC5;
	Thu,  3 Oct 2024 18:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981771;
	bh=pRnpR6P5t42iIkCEFsBPKe8PwabUnPoOZMinZ/zFYto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPMgnuvfFZiKDOuX8Si4HZcGJLBHjYlO0NdbTTlqLj9Ik8Z67cO/GpoXfttKBgMnE
	 zOYUN8kt26k+iI9YKTy0KZg2zGO9+aJP6y5RyIC1gCOM7xxjCFdpuLWPX+N9mDzKHp
	 srjX8ojMzqkbdlL97VLdxDQd46aghFe/kaR1PS2HMA7NXgyl5a9KfwBAbCF4HdiqKh
	 cs/bN+7jDi0aJHBLnCrD8For0/YKqBicaUtgOC73WzaBL7et95cq53a2dAVc5yzUaM
	 P8pkH1ekrE75tYWFIyGQL03EphX793szBbc94xijMMhMXrLRdFLrUBVo7UVXXk2IBJ
	 7cHQNtDNPTXkw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 06/16] xdrgen: XDR width for variable-length opaque
Date: Thu,  3 Oct 2024 14:54:36 -0400
Message-ID: <20241003185446.82984-7-cel@kernel.org>
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


