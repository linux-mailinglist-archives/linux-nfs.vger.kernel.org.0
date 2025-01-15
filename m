Return-Path: <linux-nfs+bounces-9254-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C7A12C73
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BF11609B3
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73CD1D934C;
	Wed, 15 Jan 2025 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS1mKebs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393B1D86CB
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972441; cv=none; b=fVJdCeN3P2aMRfeQ9h5900sn7w9DWm5HeosKbh011a/YVEwhQ7oqoJzsH5w92PljsAdthE4wpjyBVRHJDo7WM1TYvKFpXdalsbMjpSnQs4kC8NWuW4JlzXW65E+TT/pKUrcMH6qDZh+XbZ7MnZHuUG4BLF7FJr4df78nBxFM8/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972441; c=relaxed/simple;
	bh=5OsjFvU0tnvh9ALhRSGUnAbO4RpCWKUTxxN5Y9WxHjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3saqtYM/ulRxyRtsdRF3S3cVP3H1ANvYGrbcbSNp/C1X7lCu4etOLySCOs48Ue8t/J8Tsvhe7TaGinQ+Lo+D0jTgPNQzbdIPBfGkXg78NCcao6HeXzNnefg9JIJ8roffAHDjrkiB9uzuTDT8nHM7Mn5qxrrI75r/LD8wxgbjBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS1mKebs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0045CC4CED1;
	Wed, 15 Jan 2025 20:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736972441;
	bh=5OsjFvU0tnvh9ALhRSGUnAbO4RpCWKUTxxN5Y9WxHjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZS1mKebs07csQBy3Tjtu1bKV4Q1rkmkivdQFGIMppaNd+6sLFHE4vZH/C5K7KgLMG
	 /87XrVyvZHOlrFhj0XIKpnoamz4YLJ6G1V0ciy98yUAjz7zEQwEarmFsBC9GN/1T2d
	 FHCsvXcOBvEcSRWNyQ+LdKoleeGL4Xk+svOLOpHqHv5PzN5ZCNrrqZfcH1gqM3pxlT
	 J/aBrfjxkXATHjkJIAvsG+4a98p+vg5QYLSY0mLLhODzfFvZScN8tNH60pNXQmA2KK
	 3ciiD6u6c4gThB+ZfWddGEqXwjnOgXyGGe0g5vMdIk/A1YGw15UKwY2p7qTUBJ5d2k
	 l7R8K3llFuvSw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 8/8] rpcctl: Add remaining missing docstrings
Date: Wed, 15 Jan 2025 15:20:35 -0500
Message-ID: <20250115202035.112122-9-anna@kernel.org>
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
 tools/rpcctl/rpcctl.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index adeb26d51f0e..0221fbb68be1 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -1,4 +1,5 @@
 #!/usr/bin/python3
+"""Utility for working with the sunrpc sysfs files."""
 import argparse
 import collections
 import errno
@@ -20,6 +21,7 @@ if not sunrpc.is_dir():
 
 
 def read_addr_file(path):
+    """Read an xprt address file."""
     try:
         with open(path, 'r') as f:
             return f.readline().strip()
@@ -28,12 +30,14 @@ def read_addr_file(path):
 
 
 def write_addr_file(path, newaddr):
+    """Write a new address to an xprt address file."""
     with open(path, 'w') as f:
         f.write(newaddr)
     return read_addr_file(path)
 
 
 def read_info_file(path):
+    """Read an xprt or xprt switch information file."""
     res = collections.defaultdict(int)
     try:
         with open(path) as info:
@@ -246,18 +250,24 @@ class XprtSwitch:
 
 
 class RpcClient:
+    """Represents an rpc client instance."""
+
     def __init__(self, path):
+        """Read in rpc client information from sysfs."""
         self.path = path
         self.name = path.stem
         self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
 
     def __lt__(self, rhs):
+        """Compare the name of two rpc client instances."""
         return self.name < rhs.name
 
     def __str__(self):
+        """Return a string representation of an rpc client."""
         return f"{self.name}: {self.switch}"
 
     def add_command(subparser):
+        """Add parser options for the `rpcctl client` command."""
         parser = subparser.add_parser("client",
                                       help="Commands for rpc clients")
         parser.set_defaults(func=RpcClient.show, client=None)
@@ -269,12 +279,14 @@ class RpcClient:
         parser.set_defaults(func=RpcClient.show)
 
     def get_by_name(name):
+        """Find a (sorted) list of RpcClients matching the given name."""
         rpc_clients = sunrpc / "rpc-clients"
         if name:
             return [RpcClient(rpc_clients / name)]
         return [RpcClient(f) for f in sorted(rpc_clients.iterdir())]
 
     def show(args):
+        """Handle the `rpcctl client show` command."""
         for client in RpcClient.get_by_name(args.client):
             print(client)
 
@@ -283,6 +295,7 @@ parser = argparse.ArgumentParser()
 
 
 def show_small_help(args):
+    """Show a one-line usage summary if no subcommand is given."""
     parser.print_usage()
     print("sunrpc dir:", sunrpc)
 
-- 
2.48.1


