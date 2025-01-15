Return-Path: <linux-nfs+bounces-9256-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EF1A12C92
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19F03A5F26
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABF01D90DF;
	Wed, 15 Jan 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQzslfyp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454628F77
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972999; cv=none; b=XO4jpxx0/Rp1drGd/MAbB61GLZl2RKv5J90BVdxBQ5ow8CPuNRReJShHlSIGNq5ZVpsyYNwiDnAxvHI4yEJjWPg92ibwCf8z/PD7/WknyqOrYmMIL3ZpwO5j8eD+/ixi1L0rgcX4hk6soYtTfRboj1HF+REhg+k6Em/5y3kj9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972999; c=relaxed/simple;
	bh=lPEmA6ck3pSMyWC7cY1+5R4MNAM+1KDdJol1heDUFFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XN7/APpa0HHs3RZcAnixlHx65iU8mITJuI2V3k7QBUJDrQHn6uMU2gCIacmE0Hdk5L+NhQEdITuNbcDl5gr3BGjtlflbZrshUifihg3YyxojXoW3qssa/ECDBoSg6J4Ve6K9rkVZZ55fOPF6wB2H9hjzg4qWlIRnlReIKzNXdk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQzslfyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727BCC4CEE3;
	Wed, 15 Jan 2025 20:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736972998;
	bh=lPEmA6ck3pSMyWC7cY1+5R4MNAM+1KDdJol1heDUFFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQzslfypj0tejuVt/5R6PdCJ3cXTi2yA000S44vr+2lQGz3Yx1gDREPJJO9Tt1rd5
	 Gg9K22egZBq0hmVD/gf3zii3bTbHCAos1tjiuBnVa9tR32ifl0Aak1gJm472vOjkY3
	 cyJQY1GGBD5xrYyolk5u+6xx1NA3A8owsOcOIq9j7SVN8sVm0AX98dknc3H+6pg5/V
	 aQiO2utm5WFBvKvhgYbg4iF811MwJFg9wXJsMSjcKoxC8sPLw1PPF40qN6wwLjCKFI
	 hlxbrwPtClqIIgGynrPQtovkhXbf6eVrDa9Axzrzd4hKuXEBDiV/JLfdx2ePuu2DkJ
	 XG5c8MSCNVYGw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v3 1/7] rpcctl: Fix flake8 whitespace errors
Date: Wed, 15 Jan 2025 15:29:50 -0500
Message-ID: <20250115202957.113352-2-anna@kernel.org>
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
 tools/rpcctl/rpcctl.py | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index d2110ad6de93..92a851c2278b 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -8,7 +8,7 @@ import socket
 import sys
 
 with open("/proc/mounts", 'r') as f:
-    mount = [ line.split()[1] for line in f if "sysfs" in line ]
+    mount = [line.split()[1] for line in f if "sysfs" in line]
     if len(mount) == 0:
         print("ERROR: sysfs is not mounted")
         sys.exit(1)
@@ -18,6 +18,7 @@ if not sunrpc.is_dir():
     print("ERROR: sysfs does not have sunrpc directory")
     sys.exit(1)
 
+
 def read_addr_file(path):
     try:
         with open(path, 'r') as f:
@@ -25,17 +26,19 @@ def read_addr_file(path):
     except:
         return "(enoent)"
 
+
 def write_addr_file(path, newaddr):
     with open(path, 'w') as f:
         f.write(newaddr)
     return read_addr_file(path)
 
+
 def read_info_file(path):
     res = collections.defaultdict(int)
     try:
         with open(path) as info:
-            lines = [ l.split("=", 1) for l in info if "=" in l ]
-            res.update({ key:int(val.strip()) for (key, val) in lines })
+            lines = [l.split("=", 1) for l in info if "=" in l]
+            res.update({key: int(val.strip()) for (key, val) in lines})
     finally:
         return res
 
@@ -75,7 +78,7 @@ class Xprt:
         if not self.path.exists():
             return f"{self.name}: has been removed"
         return "\n".join([self._xprt(), self._src_reqs(),
-                          self._cong_slots(), self._queues() ])
+                          self._cong_slots(), self._queues()])
 
     def read_state(self):
         if self.path.exists():
@@ -132,7 +135,7 @@ class Xprt:
 
     def get_by_name(name):
         glob = f"**/{name}-*" if name else "**/xprt-*"
-        res = [ Xprt(x) for x in (sunrpc / "xprt-switches").glob(glob) ]
+        res = [Xprt(x) for x in (sunrpc / "xprt-switches").glob(glob)]
         if name and len(res) == 0:
             raise FileNotFoundError(errno.ENOENT, os.strerror(errno.ENOENT),
                                     f"{sunrpc / 'xprt-switches' / glob}")
@@ -158,19 +161,19 @@ class XprtSwitch:
         self.path = path
         self.name = path.stem
         self.info = read_info_file(path / "xprt_switch_info")
-        self.xprts = sorted([ Xprt(p) for p in self.path.iterdir() if p.is_dir() ])
+        self.xprts = sorted([Xprt(p) for p in self.path.iterdir() if p.is_dir()])
         self.sep = sep
 
     def __lt__(self, rhs):
         return self.name < rhs.name
 
     def __str__(self):
-        switch =  f"{self.name}{self.sep} " \
-                  f"xprts {self.info['num_xprts']}, " \
-                  f"active {self.info['num_active']}, " \
-                  f"queue {self.info['queue_len']}"
-        xprts = [ f"	{x.small_str()}" for x in self.xprts ]
-        return "\n".join([ switch ] + xprts)
+        switch = f"{self.name}{self.sep} " \
+                 f"xprts {self.info['num_xprts']}, " \
+                 f"active {self.info['num_active']}, " \
+                 f"queue {self.info['queue_len']}"
+        xprts = [f"	{x.small_str()}" for x in self.xprts]
+        return "\n".join([switch] + xprts)
 
     def add_command(subparser):
         parser = subparser.add_parser("switch", help="Commands for xprt switches")
@@ -194,8 +197,8 @@ class XprtSwitch:
     def get_by_name(name):
         xprt_switches = sunrpc / "xprt-switches"
         if name:
-            return [ XprtSwitch(xprt_switches / name) ]
-        return [ XprtSwitch(f) for f in sorted(xprt_switches.iterdir()) ]
+            return [XprtSwitch(xprt_switches / name)]
+        return [XprtSwitch(f) for f in sorted(xprt_switches.iterdir())]
 
     def show(args):
         for switch in XprtSwitch.get_by_name(args.switch):
@@ -234,8 +237,8 @@ class RpcClient:
     def get_by_name(name):
         rpc_clients = sunrpc / "rpc-clients"
         if name:
-            return [ RpcClient(rpc_clients / name) ]
-        return [ RpcClient(f) for f in sorted(rpc_clients.iterdir()) ]
+            return [RpcClient(rpc_clients / name)]
+        return [RpcClient(f) for f in sorted(rpc_clients.iterdir())]
 
     def show(args):
         for client in RpcClient.get_by_name(args.client):
@@ -244,9 +247,12 @@ class RpcClient:
 
 parser = argparse.ArgumentParser()
 
+
 def show_small_help(args):
     parser.print_usage()
     print("sunrpc dir:", sunrpc)
+
+
 parser.set_defaults(func=show_small_help)
 
 subparser = parser.add_subparsers(title="commands")
-- 
2.48.1


