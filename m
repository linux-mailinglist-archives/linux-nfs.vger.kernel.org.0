Return-Path: <linux-nfs+bounces-8994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4779A0674A
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33203A651E
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D67204696;
	Wed,  8 Jan 2025 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyK630XG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CE204699
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372252; cv=none; b=uOhdcM+gZr9ybFSryYwDcN04uP4SQdhUvBgUfzM8gHecxW89hr791kl8uajwvXTIIfc2F5NVuFCg2j839Zo6ihhBxokB+pm9YkhM89BfMXSen9rGzYKoG8hbdZ2UV1agmQHjckbhVVaAEmLWWu0iSePxC+xkO/N+6afqNrYV1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372252; c=relaxed/simple;
	bh=5qlZXj8hlh4KeRoXPvbvmIX++lohLRAE6j8J2PBxSB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0LI3Z6cxoObUn548USbDA4jc50bE9d7n7OKxE6xhnIuea9mkJFCZh42ahpTF/HRHrL7znslknoG7K9HU9sMrMgSQWJ4kZ+ABuevwyP/wYoqDvvN3l13DPzFqgGJSoKFMtbyFpHLZdRld0v8evMo7ZKG44cwJEDKFBeco/MxiYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyK630XG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4ADEC4CEE2;
	Wed,  8 Jan 2025 21:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372251;
	bh=5qlZXj8hlh4KeRoXPvbvmIX++lohLRAE6j8J2PBxSB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uyK630XGrEkgjxJZw8Ek05mjGJSuPImL3iJFJGDNMEsB3xpTeXnNYQnV6/YL4Disi
	 dmspzb2phczjRmXfvPnFd2FR5Mcr7GMX+K1khy1KMndKvDTxBfPfRp8PieDcUQ1Z1w
	 uRPQ0TVz9kTiCtvrGTfiKYyVEiZN/JWi/cO/dj18+BqvgQd31xC1vaR9JeLBU5W7k6
	 Zl3n4ZAtitW84ukhdQF77HVBaXzFvCMDg5ZiXBkCKgCTVcp0GyeIqEMA/pzkUsDhjm
	 vCUh2TnMr1xgwLBYZNmWZJ17tohemAYfA2Hqr2tP0ruBGMj4XqsQMsBbca4cWQOqpq
	 5xkDrycuqIT7A==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH NFS-UTILS 06/10] rpcctl: Add missing docstrings to the XprtSwitch class
Date: Wed,  8 Jan 2025 16:37:22 -0500
Message-ID: <20250108213726.260664-7-anna@kernel.org>
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
2.47.1


