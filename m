Return-Path: <linux-nfs+bounces-8993-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78F2A06748
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B61F3A651E
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12260203717;
	Wed,  8 Jan 2025 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMERH7i/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A3204696
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372251; cv=none; b=Oz/PWm3KDsuq5fZ0Dnr59ISiyLTcY7lU55oOTKz1FaN9F0NpD+7NiNuooysd/I39QWKnVZWmbr4Y4+GyD2Aea4reXG7zd7AqvKUCmiQMsME8Zi25zP8Y4y9Z8xkl1covgxTu35lJwPu/ibwWbnQAOYQCVXjFkhs6qfZYi+qg9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372251; c=relaxed/simple;
	bh=ciNJNKQUk6OHtbaa2qJUKYgCaPsZGL7zLIgxK4tRh4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEmUDXlOW3VD9vFPjIpNiz6bQly9u5a43ilF/SSEB5R2RK4NhB8cwfX1rN3QYMgsIM4Q01PWrazWA96qfS2zZFs7UeIwCBVqfr/03sfOmNCcwLmsLeHvjJcO5H14/zlkpJ7KU2F8rDVeyfbA5+ZLRUl+FczSUH78o1nF5/kkGYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMERH7i/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF36C4CEDF;
	Wed,  8 Jan 2025 21:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372250;
	bh=ciNJNKQUk6OHtbaa2qJUKYgCaPsZGL7zLIgxK4tRh4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMERH7i/Ncln1YBX7JEo7yvUy9dzRWmDi+DRDiFHPwKDIK4WdRtNXflrK9yoW0cr+
	 a8Z4udmQFQUFcDZ3Cda/z9PjUrXqFBigzzILAH29vhP0shtJeyG0FNp6ESntTV5qMf
	 B8m5k+YBfA7FhAezzqnrNzmoCO89bhrjyAn/tY+C5lz027/5CqCuB0e7bJyleA3v9L
	 QzSsDU9FhfSk93tu3UnBhtMBAmgNdbUIsKzwtp0rBy5QWOgB30mQiRaj+FxDIVyaYY
	 Xm2eFgM2eJR2NHnNEoVOn1aUTO2PYfk1RIMixFLYe8A8+eSGkY4Xgowb4AVdl8OREc
	 4Ihju119lHMLQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH NFS-UTILS 05/10] rpcctl: Add missing docstrings to the Xprt class
Date: Wed,  8 Jan 2025 16:37:21 -0500
Message-ID: <20250108213726.260664-6-anna@kernel.org>
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

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 tools/rpcctl/rpcctl.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 435f4be6623a..b8808787b51d 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -44,7 +44,10 @@ def read_info_file(path):
 
 
 class Xprt:
+    """Represents a single sunrpc connection."""
+
     def __init__(self, path):
+        """Read in xprt information from sysfs."""
         self.path = path
         self.name = path.stem.rsplit("-", 1)[0]
         self.type = path.stem.split("-")[2]
@@ -54,6 +57,7 @@ class Xprt:
         self.read_state()
 
     def __lt__(self, rhs):
+        """Compare the names of two xprt instances."""
         return self.name < rhs.name
 
     def _xprt(self):
@@ -79,24 +83,29 @@ class Xprt:
                f"tasks {self.info['tasks_queuelen']}"
 
     def __str__(self):
+        """Return a string representation of an xprt."""
         if not self.path.exists():
             return f"{self.name}: has been removed"
         return "\n".join([self._xprt(), self._src_reqs(),
                           self._cong_slots(), self._queues()])
 
     def read_state(self):
+        """Read in the xprt_state file."""
         if self.path.exists():
             with open(self.path / "xprt_state") as f:
                 self.state = ','.join(f.readline().split()[1:])
 
     def small_str(self):
+        """Return a short string summary of an xprt."""
         main = " [main]" if self.info.get("main_xprt") else ""
         return f"{self.name}: {self.type}, {self.dstaddr}{main}"
 
     def set_dstaddr(self, newaddr):
+        """Change the dstaddr of an xprt."""
         self.dstaddr = write_addr_file(self.path / "dstaddr", newaddr)
 
     def set_state(self, state):
+        """Change the state of an xprt."""
         if self.info.get("main_xprt"):
             raise Exception(f"Main xprts cannot be set {state}")
         with open(self.path / "xprt_state", 'w') as f:
@@ -104,12 +113,14 @@ class Xprt:
         self.read_state()
 
     def remove(self):
+        """Remove an xprt."""
         if self.info.get("main_xprt"):
             raise Exception("Main xprts cannot be removed")
         self.set_state("offline")
         self.set_state("remove")
 
     def add_command(subparser):
+        """Add parser options for the `rpcctl xprt` command."""
         parser = subparser.add_parser("xprt",
                                       help="Commands for individual xprts")
         parser.set_defaults(func=Xprt.show, xprt=None)
@@ -140,6 +151,7 @@ class Xprt:
         dstaddr.set_defaults(func=Xprt.set_property, property="dstaddr")
 
     def get_by_name(name):
+        """Find a (sorted) list of Xprts matching the given name."""
         glob = f"**/{name}-*" if name else "**/xprt-*"
         res = [Xprt(x) for x in (sunrpc / "xprt-switches").glob(glob)]
         if name and len(res) == 0:
@@ -148,10 +160,12 @@ class Xprt:
         return sorted(res)
 
     def show(args):
+        """Handle the `rpcctl xprt show` command."""
         for xprt in Xprt.get_by_name(args.xprt):
             print(xprt)
 
     def set_property(args):
+        """Handle the `rpcctl xprt set` command."""
         for xprt in Xprt.get_by_name(args.xprt[0]):
             if args.property == "dstaddr":
                 xprt.set_dstaddr(socket.gethostbyname(args.newaddr[0]))
-- 
2.47.1


