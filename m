Return-Path: <linux-nfs+bounces-6838-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94DB98F6A4
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9AB1C20C32
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5281A7062;
	Thu,  3 Oct 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjIaQtVy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3850A6A33F
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981841; cv=none; b=fvfnonxVUz/AaMWFJrF/HoGDCX/CBNGcPiQ8altaxVxZlXLLvjOskmQIwRP3rb03uZI1jcQ82MXsUO+a1RsdqUGPhRxAB1k304fGAVXWiwxGj6HKtvTQj+6HUhzIUL4g+oYrSmnvh09c0VPsnZF5fUajxb3nTd2tbHaw7UM/Nb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981841; c=relaxed/simple;
	bh=eHKYDsi8arSciN1UWzAd+EN+iaio0ctyad/aKcGYhJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suLXG5+pPNrWc2ZGRkD1E38FzkujN0CHR1IAoq/4T0jaifcSdVwu9mNItNhC6IttfK0xy9m8zsT4Rgb6sKKoGw9/9Ndja6qXdGb23yQ8/YcJC7NPiFa0kH532quI55lGVWgkOht3+P5GYhj1iB2qgLRlIVbnHqN/nIdV1LEHgLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjIaQtVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BED6C4CEC5;
	Thu,  3 Oct 2024 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981841;
	bh=eHKYDsi8arSciN1UWzAd+EN+iaio0ctyad/aKcGYhJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjIaQtVyG4LDqsFQc2pCCaEAVEEBXrjQ8Jhqoi+th0meWTTZwShe3kI0aYdG7xXql
	 29o6t8SmGcEEt/5FOrbxUHzfn89NbdoRhbUwdjLNXHx6/TNgs3taTozZeGjlnBZEvR
	 sC3COKq/Nm1QbMJbRmF9xy5oOAgStvcnygcDDW7Ow6wcoCsOeUFvdkzCCnVuE9tVzt
	 YqHTFbZOqlKBIoesCrQJVr/8muUe0NsJmsOYf1QzpjoqiDvWS60+Uy2XaCtVLIg8NS
	 phoONR/jV/0Fx0DlJ0c5GHQaHleyy45UTQhnjpzVuyLUq1VYPko6QJFOt53IjZ3jD+
	 v4R2dW47kW7XQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 13/16] xdrgen: XDR width for pointer types
Date: Thu,  3 Oct 2024 14:54:43 -0400
Message-ID: <20241003185446.82984-14-cel@kernel.org>
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

The XDR width of a pointer type is the sum of the widths of each of
the struct's fields, except for the last field. The width of the
implicit boolean "value follows" field is added as well.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index f34b147c8dfd..8d53c889eee8 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -378,9 +378,26 @@ class _XdrPointer(_XdrAst):
     name: str
     fields: List[_XdrDeclaration]
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        width = 1
+        for field in self.fields[0:-1]:
+            width += field.max_width()
+        return width
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        widths = []
+        widths += ["XDR_bool"]
+        for field in self.fields[0:-1]:
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


