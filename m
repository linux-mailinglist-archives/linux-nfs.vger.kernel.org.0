Return-Path: <linux-nfs+bounces-9703-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 201B2A20022
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F271165AFC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D481D9A50;
	Mon, 27 Jan 2025 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4nV4bru"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEEE1D9694
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014658; cv=none; b=S9WZhrC6kFyOYbt3asnbz2ycgYlS91yWJRxRtzX9EV9Ltt8RrPhxCk2hL11E6obhKmDhBCiSX6bCZgVA5j4gD9Op/DjVGZcsBUwBPLHgysF6SOrG7MGi93fsSbRAM3C24LlckEFRSZzsCQ3vEIaLUZgs6u/S+PjaNXhKOQIwpF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014658; c=relaxed/simple;
	bh=wnw37TjmjrEbZEIqiOgBas0AEzBeDuAHuVq2TkPyywM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxTtmHPgYNfgFf+r3wDKrwQlhrCpHF1QSfT0Vigmd469ASX5nmdFk1kkHmvMb+1c3rTsh107+7UrqJENlxVNrFq1UnZGitC+6rH4/a2cg6yfw8FOn8CMYozQm0Q1bCr3CJDngrMvX2s7TZlqgu6IBdEx7qpwh7z9avC1f6uwqVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4nV4bru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80FCC4CEE3;
	Mon, 27 Jan 2025 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738014658;
	bh=wnw37TjmjrEbZEIqiOgBas0AEzBeDuAHuVq2TkPyywM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4nV4bru5l/3GtCKRBYHWcUU8HKw+IXXzT2ZpKZvG3wNygZbXM/9jZ3VBKOX5aruK
	 tos/fgdUqhQYbqYUyh40igrNbd3f3+yGbUYrYILi99riI2UXZ4j3fUwnfj9BWbRBlr
	 W3gOyKd5kYUd9qi/HcUFqFquglmxqZdCwxWO+ajwyFeJb0oSZ+OsGcMFXk+/e463On
	 0KzLWKPLGh2WJC4WN+m9bn33WrDUT6t5NkUJvlPDbKFlgrRjEaxf+JKUArLeZK/ahP
	 ICoqADZYleYd4qpX+5Re6qlCD5JiuEdYKjvrbTEpndH7yJ8CJqe8L1U2vFs0DA6y3y
	 O+izCVhnm3nkA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 1/4] rpcctl: Rename {read,write}_addr_file()
Date: Mon, 27 Jan 2025 16:50:53 -0500
Message-ID: <20250127215056.352658-2-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127215056.352658-1-anna@kernel.org>
References: <20250127215056.352658-1-anna@kernel.org>
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
2.48.1


