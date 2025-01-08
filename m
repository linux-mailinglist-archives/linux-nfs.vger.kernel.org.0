Return-Path: <linux-nfs+bounces-8997-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A5EA0674D
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7682B18896E8
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096892046B4;
	Wed,  8 Jan 2025 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuN+yh8q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4AB20469C
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372252; cv=none; b=N2tsMiIsltr9l5Oj9Vbjmv/GItxoHyBPJNn7mZR7KKVDqH87VIqCnHBz3Rb03JRd/nD3g0njmTtCuRWHo+Odt0Zp3XiIagQ/FBqyFF1GS6DaGwyZnpKo9IqS9eCMa0BOVDt/9hw0tGo52s75lZcK2wcWdJvxAYflwdBsfZichmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372252; c=relaxed/simple;
	bh=CTnzduBHPxc7Bt/P+DI7oh5Esmvkx82/JZ0FPV8utNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfsgp/AQWDEY5fiwLmPNWJp4djtNVywtXzDvqTfE3xczY2Z2GGmnw9wqSCuBlFFYAN9vNyQgNb06u7sjkaZ+DXWJPoUenu5Ydq3tXbf4SXsunfz2Hj+xoS3IBdWnUklFgWGbKzFKEaZSdlUA31PU2N2lAqg9gLlMTgk0ODw7Ma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuN+yh8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAA4C4CEE6;
	Wed,  8 Jan 2025 21:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372252;
	bh=CTnzduBHPxc7Bt/P+DI7oh5Esmvkx82/JZ0FPV8utNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iuN+yh8qa7r7qE6kWHLwdfCU6zoRjvMweRVZZJ2X9gcEIiB62iWMEAYj9HkfJ8av6
	 vDfUKw/Ap2JzRig0oC8mUPrSg7gLVTn6oa4nPMYXWimix0eheQ6qjQlpbuG0YLD+AW
	 bttlFp7U6W77ivHOm0++EuZVH7QFEkQvMvXc4w/IUzmx+e70aGdaB3aL7lX1jVKYy8
	 3F40ovyUrIFjS2cATvSYCuMc8+N+gC7YQBgcITSNvBMV9entXFOm39yKz9raoxQcLR
	 ykLOALkVZLahjlFXk4sdlmV0wjpho8LQ3Rvz9zROD8pLaIZoFCqZu3o17upF1SU2Jj
	 lsKJHZY/hSD7w==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH NFS-UTILS 09/10] rpcctl.py: Add support for the xprtsec sysfs attribute
Date: Wed,  8 Jan 2025 16:37:25 -0500
Message-ID: <20250108213726.260664-10-anna@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108213726.260664-1-anna@kernel.org>
References: <20250108213726.260664-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

This was recently added to the Linux kernel, so running rpcctl on
kernels that don't have this attribute will print out "unknown" in its
place instead.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 tools/rpcctl/rpcctl.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 654b2f60a894..20f90d6ca796 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -36,6 +36,15 @@ def write_sysfs_file(path, input):
     return read_sysfs_file(path)
 
 
+def read_xprtsec_file(path):
+    """Read an xprtsec file."""
+    try:
+        with open(path, 'r') as f:
+            return f.readline().strip()
+    except FileNotFoundError:
+        return "(unknown)"
+
+
 def read_info_file(path):
     """Read an xprt or xprt switch information file."""
     res = collections.defaultdict(int)
@@ -58,6 +67,7 @@ class Xprt:
         self.info = read_info_file(path / "xprt_info")
         self.dstaddr = read_sysfs_file(path / "dstaddr")
         self.srcaddr = read_sysfs_file(path / "srcaddr")
+        self.xprtsec = read_xprtsec_file(path / "xprtsec")
         self.read_state()
 
     def __lt__(self, rhs):
@@ -67,7 +77,8 @@ class Xprt:
     def _xprt(self):
         main = ", main" if self.info.get("main_xprt") else ""
         return f"{self.name}: {self.type}, {self.dstaddr}, " \
-               f"port {self.info['dst_port']}, state <{self.state}>{main}"
+               f"port {self.info['dst_port']}, sec {self.xprtsec}, " \
+               f"state <{self.state}>{main}"
 
     def _src_reqs(self):
         return f"	Source: {self.srcaddr}, port {self.info['src_port']}, " \
-- 
2.47.1


