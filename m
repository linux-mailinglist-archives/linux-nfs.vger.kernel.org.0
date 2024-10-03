Return-Path: <linux-nfs+bounces-6817-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E985D98F20B
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE1628314B
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2101A08A9;
	Thu,  3 Oct 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/2kUCHB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ECF45BE3
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967724; cv=none; b=JKZADvyueE9kbn12vRr8+mFS5UQF58zfl/+McprjzLYpwo70erJzLP6MONDHsB0OSR1UjHFUk3VphLfPBxZu1UqsFGCXmwDFwQ3tG2QXuzo0iFi6Qe3/eCiqzyfQUfSZg8DAuoWDS6C67XEGRcmyJ2C9YCPBc1F3yI3Dr+Kojl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967724; c=relaxed/simple;
	bh=nqS0Fn7I2oTlrMlM/WcOIsUdT7xMf9K3lZTtNZxR9HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axK5mIaidqZJHcUqiGfA7Bi32bL4rawCsBGy/ustORgm7zIP1QpV3QKdTNYEc5ez+zLcXBBIEbPdIPbfWBrJKP7/zlktXr46jsbD5/9VBVJmz6Tj/QS/u99Zpmx8hdNmJGjumgoW+YV7tld6YAZw9QZj0Ftv9qdIihMbL01CBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/2kUCHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A366CC4CEC7;
	Thu,  3 Oct 2024 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967724;
	bh=nqS0Fn7I2oTlrMlM/WcOIsUdT7xMf9K3lZTtNZxR9HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/2kUCHBXfizaG6Pp/at/9GAtnJ3eu54xCSQO8rW24Gc3WeXCrvUwdlGbXY08CH4o
	 z9EvaIs7ZTwcURp1Zr7LIX7DoFUbm853BZGf3oFIE3LYdP43xxCUa2UVpn2Kd+2aKk
	 8gsis3hSR6kBCl88+JGrtxgS6SoJZwe3DXIb7MKb64bpWoIgnsW11maaZylvvfrk+k
	 P51owVZuGVI6HtfYJKLzrRJFMCVgMxOn9+LQ1qDJnPUgcdS/h4cJhzGO4ywK314ZeV
	 6b0DoyCjdUxv5D3V3hHgSvOGPQgDoF8zK4bqTRp+0jFfHgYVu9AWmPqPz2ruIv0yFj
	 xM32bfLznkv8w==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 08/16] xdrgen: XDR width for fixed-length array
Date: Thu,  3 Oct 2024 11:01:50 -0400
Message-ID: <20241003150151.81951-9-cel@kernel.org>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index d5f48c094729..e9bc81e83b48 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -197,6 +197,19 @@ class _XdrFixedLengthArray(_XdrDeclaration):
     size: str
     template: str = "fixed_length_array"
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        return xdr_quadlen(self.size) * max_widths[self.spec.type_name]
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        item_width = " + ".join(symbolic_widths[self.spec.type_name])
+        return ["(" + self.size + " * (" + item_width + "))"]
+
+    def __post_init__(self):
+        max_widths[self.name] = self.max_width()
+        symbolic_widths[self.name] = self.symbolic_width()
+
 
 @dataclass
 class _XdrVariableLengthArray(_XdrDeclaration):
-- 
2.46.2


