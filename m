Return-Path: <linux-nfs+bounces-8995-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8948A0674B
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF0D166422
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160972046B0;
	Wed,  8 Jan 2025 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4JcVL6r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65282046AD
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372252; cv=none; b=j5a137caz6xsdOOo9axM4LjwuWYj2r7lTiLqX6gTPp1tfaObfHtnimSIIWr/XMe6eju8WfTBu9kOycvAWQDyVlmi5YYjgqnO8yBjJJWYftu+t6fGo5+SRQ56NLwKbg/BWZTzxflJhG1zyrUhyvQyml9cTQ461Uy/EGg2O9mxAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372252; c=relaxed/simple;
	bh=0DECj3dt2Ypdi8/vKPv5Nz3JV/SpaEltQPMDB1K/eR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4A+ZKoFLoD8kHnrSfc7aQ5mLOIrLstE7Fc2dJUpzNKb+SDU/Yv/aqmidawPe4xT0zKEk8UXW1uRSNbqgHpepxqAWcugILB/WZB2cebnBkNIDbHPAIFGRNj6XscCwDgY9LZF0+DTGFM7vJGAStw+meZzkmNv7OBxHZJOqvXCr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4JcVL6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F69C4CEDF;
	Wed,  8 Jan 2025 21:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372251;
	bh=0DECj3dt2Ypdi8/vKPv5Nz3JV/SpaEltQPMDB1K/eR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4JcVL6rTIeUTbG++fTsTYirWxWlQGmxw1uNgCNE5h7iX5GWsKAhC+J4ZQ61phQOB
	 nmyOP+5Bf8UUt2S4Zgu2Fh9n+f7LnVNTFZchnRy6Rcdxd9bIr9A4cbmyANY507gxj8
	 a/hbQM0zXa9a20w3pmfafyCNWxcWOEAPBktU4Q66Iocqf2llEGlPnkJ50at4dJgiJk
	 YwCFGuz+JiBmoMSdwzGkNE4zvGxH0aESw/SfKXZadVDjb8Qhc2OU8C+78sDthrukYU
	 0hrG9+JbY/jvIKXZO4tb+tyaDiTm+PEyyqe1OLYTb42VY5Lorh1xQ4v3iTvB8gpQ9N
	 cq56duYg5grRg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH NFS-UTILS 07/10] rpcctl: Add remaining missing docstrings
Date: Wed,  8 Jan 2025 16:37:23 -0500
Message-ID: <20250108213726.260664-8-anna@kernel.org>
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
2.47.1


