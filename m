Return-Path: <linux-nfs+bounces-8996-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B21A0674C
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892071661D1
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5796204699;
	Wed,  8 Jan 2025 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8lupjdP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1840204690
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372252; cv=none; b=UrYZxSLHDmWbWkB/HtpndUzO4CHGcezjDtcUvW3YGxOuITis7L5y2HSZ43e2RlWB6Qb1aYfR/+paYrAshN6zVRx3NOiZTUB6b7Wl18jux0x38hMSsgmXrdGsbBhtkbEa78Qe6Kj2aFFZMFq9gKUfRrvoWbPnIImygDgdB/vnDxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372252; c=relaxed/simple;
	bh=FH9V4eDopKIQlmPmb10TVifkgoelCXgFhNpQXHzB1+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UL9jVC6RR1x1S7Xi9N2yEWRgK5+4g+XNr2pWrSi2/RefaXDcbSvssm1P+2oao2LJBgZJau830JyajD5k687NWC9aqz4ipMjybdmIzj4EFvtmc1mo1RNrmsku2WIbKe/cGgjtgpGkBTmjeSvAYlZBv5Vtc8ZLV5SmGKIygLpgvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8lupjdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4427C4CEE1;
	Wed,  8 Jan 2025 21:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372252;
	bh=FH9V4eDopKIQlmPmb10TVifkgoelCXgFhNpQXHzB1+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8lupjdPohu3A9TboO5UhoqJwaeMWUi7Svew0BHvk+0F8QljlVulyuwePc1VR1ip5
	 0ie0M6g1HeQ4aH0qZ8eJSrSWvyUQn5+nBnv42pgwoVLlybr7XBAXhSGy3duop2uyt4
	 UBMVhNHaR8bN9SBbMNO7VElBkDmTtPweGXPxxzX7pqxbcb5DXDre6nvn0GKeeVNIbw
	 GUWxVnE3qAUiNUCV9kxMfL/bYFbf3yDw5zNde7C42K+XhIVSWvffR5419vXAI0CHUV
	 Co3TEE8Ju49Upho5+QYHle2jU7qaEz37zq9PmcoZ8jHI0yfyh9VwKIGtYDilLvozZX
	 A369GI/JT4aiA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH NFS-UTILS 08/10] rpcctl.py: Rename {read,write}_addr_file()
Date: Wed,  8 Jan 2025 16:37:24 -0500
Message-ID: <20250108213726.260664-9-anna@kernel.org>
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

There is nothing address specific about these functions, so name them
something more generic so they can be reused.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 tools/rpcctl/rpcctl.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 0221fbb68be1..654b2f60a894 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -20,8 +20,8 @@ if not sunrpc.is_dir():
     sys.exit(1)
 
 
-def read_addr_file(path):
-    """Read an xprt address file."""
+def read_sysfs_file(path):
+    """Read a sysfs file."""
     try:
         with open(path, 'r') as f:
             return f.readline().strip()
@@ -29,11 +29,11 @@ def read_addr_file(path):
         return "(enoent)"
 
 
-def write_addr_file(path, newaddr):
-    """Write a new address to an xprt address file."""
+def write_sysfs_file(path, input):
+    """Write 'input' to a sysfs file."""
     with open(path, 'w') as f:
-        f.write(newaddr)
-    return read_addr_file(path)
+        f.write(input)
+    return read_sysfs_file(path)
 
 
 def read_info_file(path):
@@ -56,8 +56,8 @@ class Xprt:
         self.name = path.stem.rsplit("-", 1)[0]
         self.type = path.stem.split("-")[2]
         self.info = read_info_file(path / "xprt_info")
-        self.dstaddr = read_addr_file(path / "dstaddr")
-        self.srcaddr = read_addr_file(path / "srcaddr")
+        self.dstaddr = read_sysfs_file(path / "dstaddr")
+        self.srcaddr = read_sysfs_file(path / "srcaddr")
         self.read_state()
 
     def __lt__(self, rhs):
@@ -106,7 +106,7 @@ class Xprt:
 
     def set_dstaddr(self, newaddr):
         """Change the dstaddr of an xprt."""
-        self.dstaddr = write_addr_file(self.path / "dstaddr", newaddr)
+        self.dstaddr = write_sysfs_file(self.path / "dstaddr", newaddr)
 
     def set_state(self, state):
         """Change the state of an xprt."""
-- 
2.47.1


