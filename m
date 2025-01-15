Return-Path: <linux-nfs+bounces-9253-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 532DDA12C74
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8ED07A296E
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A19C1D935A;
	Wed, 15 Jan 2025 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+u6aXJL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17D1D934C
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972440; cv=none; b=G08lPtV+5v6oc1/udyEg3diZ04nVxXQbugmPSRk6lmWxiS0p8shy8//sPEWgU9WW5wI6Dd+gowQFk3w8UlT/0FLJ7SP+uHK5MgyiZz3sV23D+IzglWIdZPNWgLgbai6lEiw/Ldg5yEQHeLrKZ7uXI9JNwSGR6D6ZDMxydUKzNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972440; c=relaxed/simple;
	bh=W6qK0Ba520y4HCa8GGP6e6N7kAmdoqUl7Q5Czvi8mmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SN777gNglJYL7VvO8Veq2bx3eWEPsIh7MfpcxW/Wnh4u6lFGtIa2h46HGj5R6KrkAj1YEqLNL0viYXPWgTnIJxBOsZmPMEpZC2tEvQs8YYrhjT9U7296XR5L1HbFwVZB8Rk8zmAs1arKFuoP2dXvUZT4LoEe6UVqQeMaK/lkUfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+u6aXJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6775AC4CEE2;
	Wed, 15 Jan 2025 20:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736972440;
	bh=W6qK0Ba520y4HCa8GGP6e6N7kAmdoqUl7Q5Czvi8mmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+u6aXJLlvfbyMWesKQTinVBtU0FXzqgSxEPQDZkmXfyDaWjVHGj480sTM5rhHegX
	 WpOKnozaoQDudW5GeqQhOepSsqjYNVKJF0/BtsvRGvO7N0dx+/1bdbc0NNMgSA/RDk
	 rNuREvUhyfeBLS2KgzXZwxd+fGgNP9plIktXXqoNStWrm7z2neXrVM1UOzBP7/abYb
	 JSgv3HbR2H7eoabfBPYAzQCETLHFREgeELDu0iLh9E557V1o266mZ9ghc4A8YlVWKd
	 +tspX7QER1pXgwZx1ZYR8mcbxilIoP/NH6j7xPQjvc6xEKbaUHpm0ZJlO21T2CYpS5
	 ZUMqqgOE1Gxkg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 7/8] rpcctl: Add missing docstrings to the XprtSwitch class
Date: Wed, 15 Jan 2025 15:20:34 -0500
Message-ID: <20250115202035.112122-8-anna@kernel.org>
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
 tools/rpcctl/rpcctl.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index b8808787b51d..adeb26d51f0e 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -177,7 +177,10 @@ class Xprt:
 
 
 class XprtSwitch:
+    """Represents a group of xprt connections."""
+
     def __init__(self, path, sep=":"):
+        """Read in xprt switch information from sysfs."""
         self.path = path
         self.name = path.stem
         self.info = read_info_file(path / "xprt_switch_info")
@@ -186,9 +189,11 @@ class XprtSwitch:
         self.sep = sep
 
     def __lt__(self, rhs):
+        """Compare the name of two xprt switch instances."""
         return self.name < rhs.name
 
     def __str__(self):
+        """Return a string representation of an xprt switch."""
         switch = f"{self.name}{self.sep} " \
                  f"xprts {self.info['num_xprts']}, " \
                  f"active {self.info['num_active']}, " \
@@ -197,6 +202,7 @@ class XprtSwitch:
         return "\n".join([switch] + xprts)
 
     def add_command(subparser):
+        """Add parser options for the `rpcctl switch` command."""
         parser = subparser.add_parser("switch",
                                       help="Commands for xprt switches")
         parser.set_defaults(func=XprtSwitch.show, switch=None)
@@ -219,16 +225,19 @@ class XprtSwitch:
         dstaddr.set_defaults(func=XprtSwitch.set_property, property="dstaddr")
 
     def get_by_name(name):
+        """Find a (sorted) list of XprtSwitches matching the given name."""
         xprt_switches = sunrpc / "xprt-switches"
         if name:
             return [XprtSwitch(xprt_switches / name)]
         return [XprtSwitch(f) for f in sorted(xprt_switches.iterdir())]
 
     def show(args):
+        """Handle the `rpcctl switch show` command."""
         for switch in XprtSwitch.get_by_name(args.switch):
             print(switch)
 
     def set_property(args):
+        """Handle the `rpcctl switch set` command."""
         for switch in XprtSwitch.get_by_name(args.switch[0]):
             resolved = socket.gethostbyname(args.newaddr[0])
             for xprt in switch.xprts:
-- 
2.48.1


