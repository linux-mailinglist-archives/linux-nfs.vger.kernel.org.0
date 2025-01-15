Return-Path: <linux-nfs+bounces-9248-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704ADA12C6E
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BB81626B9
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6331F1D8E16;
	Wed, 15 Jan 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR/aVPo2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD351D89FA
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972438; cv=none; b=Tn+zgbR0agnDtIxFlAdMSs9tgHeQQLCHauqq7bP9RTBr3IpHaC1QMamspKC3qwT9w/7AVWjSuVF0PbfxiGqM+f0/ZHOnfRuxty/JZXFcNPG1LRYreZM5Q91vJ0eae9wcKdWdUqpDoSRCO+iePVy0ziudG4SI+y7RTXGDZiW3B8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972438; c=relaxed/simple;
	bh=lPEmA6ck3pSMyWC7cY1+5R4MNAM+1KDdJol1heDUFFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJBT6uJ5LHELOqBV7TxrQXFC1q3jJTUvl0JBYeeX5/cDvBR8fz6Szqo2Upa1+qQOzG4j4LDgzwFUkaEoF1oxsboA3jv4w18RQYDF+io1bPNLkxRuUJy2VoSSur7lF2pgLLG1vITw91O8Phen0Q9JRAr6W6EBedrzHJrNo5UcZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR/aVPo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76352C4CEE2;
	Wed, 15 Jan 2025 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736972437;
	bh=lPEmA6ck3pSMyWC7cY1+5R4MNAM+1KDdJol1heDUFFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MR/aVPo2DyKcxQL/wMgTQI66x5Ajo6gUZsVeKe9jY7IluNBIVA21cntlaYNthhrOV
	 Qn8JDng3TlttPqmPjAcZR/Oam4FaYEQ4pTIq+p6MPznoIfxiPqWhJAAomtwCdCWHD9
	 lJwMrINaEAIcK3JPOZIFjYHdsViKhs1YuHj+IaXZFHp1QJje+9YSp9nUvnLSh3sF97
	 PlmdQbQdhI3u5eJ6kxDNRC6rrFDNIpbZe7OfazEyLVTgI/wWkeu70f7JwGY1m83FFQ
	 yY2Q75IOEZv9rgelKVGwSxExzgD10mdCQ12SpeBPt8PpW/p/mSB9Sbftg7nY5T5lZo
	 bKao7v/goyhYg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 2/8] rpcctl: Fix flake8 whitespace errors
Date: Wed, 15 Jan 2025 15:20:29 -0500
Message-ID: <20250115202035.112122-3-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250115202035.112122-1-anna@kernel.org>
References: <20250115202035.112122-1-anna@kernel.org>
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


