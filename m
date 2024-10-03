Return-Path: <linux-nfs+bounces-6833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A20098F69C
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3155E1F25CC1
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5566EB4A;
	Thu,  3 Oct 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5ZkZSKf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1D6A33F
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981791; cv=none; b=V/vLTDpmMMXaYEbJ9qYpB/kjEAJKIstg+i9ezFzYRRfc9DnsmGnrf8PVvGc3qXWAh99x/qoQTKVt5NdnKt+Tp1moJn5I7npLyk6Ft6rpuZjO224Tu/4gusjEG6W4RCb7dD8Un3rHCNMVUcJpPLWGjc7qRZWCLTag80RXYNEn7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981791; c=relaxed/simple;
	bh=nqS0Fn7I2oTlrMlM/WcOIsUdT7xMf9K3lZTtNZxR9HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6mR5Sjnpqe1Fl7AJ5tzmx/NSckTfiIAuYlM2sgaWXxb47ZtWtfHhVUnIcEOjpvQCX7qY2qwqh7lB75JiydvcdPXpX9hnwmeNN42cv6l6WZXAn0YmQVaM8qhpjkE4EK2lSoFMBXFpjun2XoQNUKe8RRLHdVNjZ8cvpDlbQNKWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5ZkZSKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693F9C4CEC5;
	Thu,  3 Oct 2024 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981791;
	bh=nqS0Fn7I2oTlrMlM/WcOIsUdT7xMf9K3lZTtNZxR9HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5ZkZSKf7ZwRQlXfSGZ+U5muwx920na6VLSkbTw9lvzhfRPNaQ4aJghjlYB2yK9Bb
	 UqAs3PH3a3K37Nf9XYRvuUq8ug/vasVH5LEr7wwHiDD2UDc+RhEpB3XDVBgEAQmktp
	 NOrd4m41dbGFMpMeG6lz5HA6saDdHonmRkOfaBDJPMEkhFZtavKxA5+becmDNGLtVM
	 hg+zK22B5Wjqi07sEaiG/cUF7asO8VQUZCakKkbT/2/03HmMaUgcO4eNRGu0JQUnjO
	 DCsbg3HIJN70+U05Y5jxzROh8j1ghxKTXa3KRPTgnAoVmeR87tu+vGqUeUUJi8EiPa
	 q9BK7NhR+bu6Q==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 08/16] xdrgen: XDR width for fixed-length array
Date: Thu,  3 Oct 2024 14:54:38 -0400
Message-ID: <20241003185446.82984-9-cel@kernel.org>
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


