Return-Path: <linux-nfs+bounces-8990-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FFAA06746
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D910316626C
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56958204687;
	Wed,  8 Jan 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B247t+UI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272A202C58
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372249; cv=none; b=UpSBhMz5Vk45xQCrayPVU0I/POLksvgNPNtnrpEk1koeKft9rsswy+uX9QmNA2D3IfO/HbtFuwj92qwlzcsY4j2tZaOfySK1qfXDSShXcln94rvaAj1aDja3dhr34bgbhKPewln8Xh/Pu5N8uhwuz26qKZxbOmwVH4xgIsGkvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372249; c=relaxed/simple;
	bh=0V4sxlCPz+itlsPtq1bPzgTX0ZYKT5JKKOgt2zH9uus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfmSSr0+yQ5f/gebWP+LPFQYI0W7ei3fWb51Z+7l0oPhBKFy+jMe+ZVfYDTqVzU2S3SYum1TWButP5rf7Htp4+rhmW9RmsnQg5N4diC65+x3I/Hj7Ap9tYBILJGzqHrU52uWIlQTh4AOPamwGAC86rwe0a27Zp0lioCE8Drdnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B247t+UI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7B1C4CEE2;
	Wed,  8 Jan 2025 21:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372248;
	bh=0V4sxlCPz+itlsPtq1bPzgTX0ZYKT5JKKOgt2zH9uus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B247t+UISj5WWb/JDVTsEtBMfhX5mKHrb3jN6RJyYriK3ho/+p2UU3mP84CYVhsbv
	 8zNL8gfX/40lmUb/y3NVaqGYNr0tI8hUU8LoGhIskoZfa3k7aVvC3Q79/OEssMT7n7
	 7RnlOlAn726dsytQPjqzm/haaM589ZmsEFeEmQ+tWr9GwQh9Fv0cuHXrbDkvZ8zWJm
	 P7hM5XaMhz7dw8ykrq1jWS4H2QEXjZuEKFFWM0w8Fcq3pA+JrBnR3w7Cts0lYQy4PK
	 l2OFr0tzYdS4GWcAS5KEM5oSzDRDPXKEHFpYd52umFi7sWdGUvGwO/rO5nEST1307y
	 x4EjAo7sZ2Sjg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH NFS-UTILS 02/10] rpcctl: Fix flake8 line-too-long errors
Date: Wed,  8 Jan 2025 16:37:18 -0500
Message-ID: <20250108213726.260664-3-anna@kernel.org>
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
 tools/rpcctl/rpcctl.py | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 92a851c2278b..ec43d12afc41 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -66,13 +66,17 @@ class Xprt:
                f"Requests: {self.info['num_reqs']}"
 
     def _cong_slots(self):
-        return f"	Congestion: cur {self.info['cur_cong']}, win {self.info['cong_win']}, " \
-               f"Slots: min {self.info['min_num_slots']}, max {self.info['max_num_slots']}"
+        return f"	Congestion: cur {self.info['cur_cong']}, " \
+               f"win {self.info['cong_win']}, " \
+               f"Slots: min {self.info['min_num_slots']}, " \
+               f"max {self.info['max_num_slots']}"
 
     def _queues(self):
         return f"	Queues: binding {self.info['binding_q_len']}, " \
-               f"sending {self.info['sending_q_len']}, pending {self.info['pending_q_len']}, " \
-               f"backlog {self.info['backlog_q_len']}, tasks {self.info['tasks_queuelen']}"
+               f"sending {self.info['sending_q_len']}, " \
+               f"pending {self.info['pending_q_len']}, " \
+               f"backlog {self.info['backlog_q_len']}, " \
+               f"tasks {self.info['tasks_queuelen']}"
 
     def __str__(self):
         if not self.path.exists():
@@ -106,7 +110,8 @@ class Xprt:
         self.set_state("remove")
 
     def add_command(subparser):
-        parser = subparser.add_parser("xprt", help="Commands for individual xprts")
+        parser = subparser.add_parser("xprt",
+                                      help="Commands for individual xprts")
         parser.set_defaults(func=Xprt.show, xprt=None)
         subparser = parser.add_subparsers()
 
@@ -128,7 +133,8 @@ class Xprt:
         online.set_defaults(func=Xprt.set_property, property="online")
         offline = subparser.add_parser("offline", help="Set an xprt offline")
         offline.set_defaults(func=Xprt.set_property, property="offline")
-        dstaddr = subparser.add_parser("dstaddr", help="Change an xprt's dstaddr")
+        dstaddr = subparser.add_parser("dstaddr",
+                                       help="Change an xprt's dstaddr")
         dstaddr.add_argument("newaddr", metavar="NEWADDR", nargs=1,
                              help="The new address for the xprt")
         dstaddr.set_defaults(func=Xprt.set_property, property="dstaddr")
@@ -161,7 +167,8 @@ class XprtSwitch:
         self.path = path
         self.name = path.stem
         self.info = read_info_file(path / "xprt_switch_info")
-        self.xprts = sorted([Xprt(p) for p in self.path.iterdir() if p.is_dir()])
+        self.xprts = sorted([Xprt(p) for p in self.path.iterdir()
+                             if p.is_dir()])
         self.sep = sep
 
     def __lt__(self, rhs):
@@ -176,7 +183,8 @@ class XprtSwitch:
         return "\n".join([switch] + xprts)
 
     def add_command(subparser):
-        parser = subparser.add_parser("switch", help="Commands for xprt switches")
+        parser = subparser.add_parser("switch",
+                                      help="Commands for xprt switches")
         parser.set_defaults(func=XprtSwitch.show, switch=None)
         subparser = parser.add_subparsers()
 
@@ -185,11 +193,13 @@ class XprtSwitch:
                           help="Name of a specific switch to show")
         show.set_defaults(func=XprtSwitch.show)
 
-        set = subparser.add_parser("set", help="Change an xprt switch property")
+        set = subparser.add_parser("set",
+                                   help="Change an xprt switch property")
         set.add_argument("switch", metavar="SWITCH", nargs=1,
                          help="Name of a specific xprt switch to modify")
         subparser = set.add_subparsers(required=True)
-        dstaddr = subparser.add_parser("dstaddr", help="Change an xprt switch's dstaddr")
+        dstaddr = subparser.add_parser("dstaddr",
+                                       help="Change an xprt switch's dstaddr")
         dstaddr.add_argument("newaddr", metavar="NEWADDR", nargs=1,
                              help="The new address for the xprt switch")
         dstaddr.set_defaults(func=XprtSwitch.set_property, property="dstaddr")
@@ -225,7 +235,8 @@ class RpcClient:
         return f"{self.name}: {self.switch}"
 
     def add_command(subparser):
-        parser = subparser.add_parser("client", help="Commands for rpc clients")
+        parser = subparser.add_parser("client",
+                                      help="Commands for rpc clients")
         parser.set_defaults(func=RpcClient.show, client=None)
         subparser = parser.add_subparsers()
 
-- 
2.47.1


