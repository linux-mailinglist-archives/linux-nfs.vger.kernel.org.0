Return-Path: <linux-nfs+bounces-9260-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC95A12C96
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522771653AD
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659A1D95A2;
	Wed, 15 Jan 2025 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYC7lBsR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B1D1D968E
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973001; cv=none; b=nnGhMAV+xmh2JkuicT8D/2ecw2xiQbdLhfvwhw0t1GWwNME49YIY6r0DqsqnP5T5DbOd5C52GbRDF2yGCxxv0m7KnMXhYEzOlTJ+5LefaE0448le5s6zWeZFi4ymsyByl6Ljh3F2EcdWDSkCBKFB1vv6sZdllAW7SnwFD8r0XHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973001; c=relaxed/simple;
	bh=yjkDiLX5hhYPH6CbLSaMhXE49j7uLj8uXTgK9uVGAMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acFWc7J8ca3f/W3O3a59lXbRI0X5WlDJXewjYAPZQHHRc7zX8roRgMgsGwbfqcV0VR1aYra1LWY5C1yRnlt/GfsvM3IhDpSy8DnwW0HfBX1FFgPrHDYFJuZKvS8ccvhraJ39KzTPoLm+sGDWbukpwUVHI9zIhUhk1qxgC8VYqF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYC7lBsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AD5C4CED1;
	Wed, 15 Jan 2025 20:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736973001;
	bh=yjkDiLX5hhYPH6CbLSaMhXE49j7uLj8uXTgK9uVGAMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYC7lBsRtFeLFuoxPlCfdlvsNb0UMAeqFmCEILAt4YlgYTMPGsSJeyIFlkJFYPUiW
	 Z74c53NsybcaVabMcZLaRufUUtnnbeXvjkDDMuDJG33F2OsSmzy3KbmSUof7CDBThe
	 vX+E+qtO7RZZQdfLyP14V2709OijurcnCZGdGmbcU8imUVbC/TyxOfBQFxBmgjKrhO
	 wOxTNqu8SSanoxnuiiqofFdrs3IVTNAcXdv/qNQJm0VPAJz3nK/9JlRuzfiGqXJT6P
	 J6aAucaRHfO4yc8MezYi7WhU+aD7fz/LrCBAQeYE0MC5Evuof7RA3veIlEGObTt1Aj
	 AnaNqCN9t7m6w==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v3 5/7] rpcctl: Add missing docstrings to the Xprt class
Date: Wed, 15 Jan 2025 15:29:54 -0500
Message-ID: <20250115202957.113352-6-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250115202957.113352-1-anna@kernel.org>
References: <20250115202957.113352-1-anna@kernel.org>
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
2.48.1


