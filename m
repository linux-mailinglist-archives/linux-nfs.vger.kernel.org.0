Return-Path: <linux-nfs+bounces-9257-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F5A12C93
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43951887C75
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB0E1D9337;
	Wed, 15 Jan 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6XF8Lxj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B71D9320
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972999; cv=none; b=DsEjMvLFbvYc6ITIzIvXkXNSUIxchYcLdASoH6923sZiSXdlwdpjNi9J1VYLhZhrtW3YgV/zzevFM0HOAqkV+YaAP02FCZwdwsTgAQ3O5BxU1GT/yzyRptu4aLjzLeU6hzN1d0hiCgkf7oLo9anc7ElS3/8bq1JytNF+HTqlPZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972999; c=relaxed/simple;
	bh=xW70Aucnop/TXo6NJMtzRw2LYQdaei3qhN+R3YKWe9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3+4h3CM/WDEsnN5CNAvLYHFnjbmUgWkQoLQK+U8DbbJJaPMQDj9VVi08grGHNWCUcbmt3Er3h7pkilN6M30BwHaIiZvYO7N9VwDbed5fprlQNVjMUIKWp6ixA6o2o7WlwSWcybS+KOd4WdAdh0VfOrUoOTZPBTA5jilvR2OPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6XF8Lxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084F5C4CED1;
	Wed, 15 Jan 2025 20:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736972999;
	bh=xW70Aucnop/TXo6NJMtzRw2LYQdaei3qhN+R3YKWe9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6XF8LxjbBn/QFgpKoQzQqzkWwivW3MCicTti3oGMd/9cyGqq1wmc1KMwO+r2G55v
	 ETb5A1LjIALrplPP4HLIzMquluJppB7DmycyMUehWnZgz3+qXOmUhD0Z3LAMZRvCa/
	 wmd7Dqecgl2w6bAA1UtZWGbdv2sZOp3kcogAFYkbgsijmcch9YjNYYlZUAaGf7LCf3
	 k50BAmmlirwl66VfOROEvw5ID7zcA6msw5BmwDjsKDJ8VkAbpqPkKkY84DPhGVMkeJ
	 Y092+75qn0EDYE6KGHKQEhUyPDltkD37YRWFFnBlIXSO4V4fGRxGzbqr+KzChL0GCT
	 UJmozFLyZEg4Q==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v3 2/7] rpcctl: Fix flake8 line-too-long errors
Date: Wed, 15 Jan 2025 15:29:51 -0500
Message-ID: <20250115202957.113352-3-anna@kernel.org>
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
2.48.1


