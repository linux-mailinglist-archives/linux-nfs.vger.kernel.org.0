Return-Path: <linux-nfs+bounces-6837-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF8798F6A1
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06BD1F25EC2
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629541AB51D;
	Thu,  3 Oct 2024 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs3Wtz4a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D71AB506
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981831; cv=none; b=RPsWJyITcSdZH8JDP8mzRHoIsjzmhEX5jJZt51dIO5v/PYPBktBXe2U+N+0naIdFVUJOl9nx7o/XC99azifh3dsdNhOdjr91ESzt18cfKzWS2jlthCyJRcunR0ewmyn41InDtkr3gyEQL3Y0AkZHmL2UTTmtisAZtL3S6KIzMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981831; c=relaxed/simple;
	bh=RiS6mY/x/ZknGZnGnU0tpz3Kqu9pfk3vIe1I6jXSeqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSDWFqXqaP6dnp/pH+nslaAFF41Db8+ihfUkeV+Nw0hCYAEPkcWcUTOAETQxNdaBSqkTWmcUmmrXgHf8yVF3QEKOIDl4U7DgaDL18JZQGjGZWMmCYZnlvYDDgoVRrynjg4H4pnkKkmvOgSEDv0KmnJQdqztT2m4OArPYMPML0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs3Wtz4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBC5C4CEC5;
	Thu,  3 Oct 2024 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981831;
	bh=RiS6mY/x/ZknGZnGnU0tpz3Kqu9pfk3vIe1I6jXSeqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bs3Wtz4aiX9wbgULGLzb3kjcgjPhFz0Z/wlNI9wAKeVkc+Msw852sUV8hKwANnboK
	 EltI2ND/m19ig/LCs/JLfyCuo38CHD2vtHHPDT7qy7MnL3DFj92ZNJEpHBlAzJy+js
	 QDAM9SjdnSaWveMeaZaabW7QjHr0tc184UQEGlAjeKViT80SMetiTRokj82l+fa3qL
	 /v5DcbVdpyNdtq578+Hq8i8NcW03wNlTDqKANXQSvHn2Y42UiRp8A6BDSFkBzw3VME
	 uZIj5DSm0TuJCyTg1oT2HyASDWFvn3FtjUFkMwZP8FWRXxrSL2IiUBIJh0ZPj/owAM
	 Ev8DbqtTY/zzQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 12/16] xdrgen: XDR width for struct types
Date: Thu,  3 Oct 2024 14:54:42 -0400
Message-ID: <20241003185446.82984-13-cel@kernel.org>
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

The XDR width of a struct type is the sum of the widths of each of
the struct's fields.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index 8996f26cbd55..f34b147c8dfd 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -350,9 +350,25 @@ class _XdrStruct(_XdrAst):
     name: str
     fields: List[_XdrDeclaration]
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        width = 0
+        for field in self.fields:
+            width += field.max_width()
+        return width
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        widths = []
+        for field in self.fields:
+            widths += field.symbolic_width()
+        return widths
+
     def __post_init__(self):
         structs.add(self.name)
         pass_by_reference.add(self.name)
+        max_widths[self.name] = self.max_width()
+        symbolic_widths[self.name] = self.symbolic_width()
 
 
 @dataclass
-- 
2.46.2


