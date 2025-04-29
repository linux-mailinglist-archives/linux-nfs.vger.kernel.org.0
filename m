Return-Path: <linux-nfs+bounces-11354-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 232F2AA1AAC
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 20:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59AC1BC1141
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 18:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1592522AA;
	Tue, 29 Apr 2025 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raFmuzlX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A3624E00F
	for <linux-nfs@vger.kernel.org>; Tue, 29 Apr 2025 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951598; cv=none; b=uIPSGtprSgxyyiWGT4NUmjPIHdAv4TOJH8ib5g1YVSU0ZHrx90xJvxB+3/YycinNBBxQqzjrLs9yo1W9A9hDVOZqpQorr5NpVYHU9DI0++ZRdzoTTv5Mi+E2rKR6DjyCl34Z9Y204GSSdrbKz/jSLG8b0ScyiBTfBFNHWCuYrcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951598; c=relaxed/simple;
	bh=ih5ncy/8ikjs+szKWYy9ewaZV6NXCGmHTunOi+l0AZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOeiQZA5jLla5dGfkNylHCaw1FDp7aAll8tQp4/57qG7y2nPE2XjFQOJSuoseC9bX17WVWWQq73ULvDBn060UNPtkUYmfQGIaVJztkwrx66xsyq74dlIInkk0cCcjyvqmpXuyZk76Ab6uD2sjfweTn/JD3jH/2WxSZAgWanvQZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raFmuzlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD59C4CEE9;
	Tue, 29 Apr 2025 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745951597;
	bh=ih5ncy/8ikjs+szKWYy9ewaZV6NXCGmHTunOi+l0AZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raFmuzlXmHoQRGRW/CXfnHkRA4r7/IU6115KGbWId+H3ObMDKbdydsT397Bw6raKr
	 ooEp9zsf9Gp5iHpQJsv6Ysbt4L6vXnWqroiSEvc3yTGXHaZEs8GNVOql4qyQm3k4jG
	 /JDvu5J03sN87jQ5rHOUfkLQWDJHolTz2h4CayHmhnEqqxjEbq4hX7ZWUyEHoPET6c
	 C4HSWrUQhiLSmhGzy4dPwQykJjqDTvIpGxWIJH4GLFCQpFvv97zacYA2Mu3NEkjpmt
	 caUlJkuuPtm06ifTKHD0rT6Ch7vSaPcz5cBY8gXqibEo+uU05nhHx1c6IqGtmzmbUC
	 ryG7EuzPKvTqQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH v3 1/4] rpcctl: Rename {read,write}_addr_file()
Date: Tue, 29 Apr 2025 14:33:12 -0400
Message-ID: <20250429183315.254059-2-anna@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429183315.254059-1-anna@kernel.org>
References: <20250429183315.254059-1-anna@kernel.org>
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
2.49.0


