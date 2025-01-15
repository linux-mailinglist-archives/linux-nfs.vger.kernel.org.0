Return-Path: <linux-nfs+bounces-9249-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B7A12C6F
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25801887D86
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C701D89FA;
	Wed, 15 Jan 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFRAW4N0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C81D90AD
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972438; cv=none; b=KgiLvtjoIY7COCAqocwciC+XtzR/jh9C/pE54ZHZThIL+cYaU14J7vngZBMDtvdTdu9Ol/f8WEgI0EpqLHdZ+WyMYk8hpU68M31ja7mVo1ckeK/8zt14mR+G30lo2YHYsmzvalmNhfLF2Cbd5kq8t7BCtx7RUjavhS82ugisRxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972438; c=relaxed/simple;
	bh=xW70Aucnop/TXo6NJMtzRw2LYQdaei3qhN+R3YKWe9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcQ8ObMdC6hV/MXAGs43MCABzt7qd++e02+iBqpjrav66lFssNcQyfgWhBESHyXHw4zpowYdU91xDUZmm5YKgaIJT/NiaNQqN14vx41dQmo3/RfaRQCvnLcx8yVJ+shqUfF/zFS3kxFj7cpjR5mYkUi3a1+QDlk7Yxy44XNI1Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFRAW4N0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7FDC4CEE1;
	Wed, 15 Jan 2025 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736972438;
	bh=xW70Aucnop/TXo6NJMtzRw2LYQdaei3qhN+R3YKWe9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JFRAW4N01gjQg6D19bwsCVJafjT+O6XQyCp9elTR9GLfIIBU96rmwGQa6AnjPDCsk
	 r6RXcylehtYDXmvvxF+pZ000rexIZi0uqIQ+YIEB7tyvM0/XwQ29BKFxYY8EVElAG2
	 bKq8a/9C3mF9y8Otx2VVZsFXZPrrhOrkfORz/O049IS9Jc3WQLCESwrPUVNoltshz6
	 RzG1R7RYxp1IhTYOCrpa0wQX4unI5RINBRCmR4jzlC6GfnTNCPenbXU3hdOyzI+Chp
	 b7I3KwnQQAiqUrq0rM63GZYfy/0onVq6GiwmrIU7zDh8rrw+2HGG+bhkYGk9P5lBnA
	 RqSDzY7wDpGAA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 3/8] rpcctl: Fix flake8 line-too-long errors
Date: Wed, 15 Jan 2025 15:20:30 -0500
Message-ID: <20250115202035.112122-4-anna@kernel.org>
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


