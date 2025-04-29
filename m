Return-Path: <linux-nfs+bounces-11356-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1251AAA1AAF
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 20:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747A74C38C8
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDAA253344;
	Tue, 29 Apr 2025 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh3Iit1R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E324E00F
	for <linux-nfs@vger.kernel.org>; Tue, 29 Apr 2025 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951598; cv=none; b=lX6sHNwqVJAnEZL3vXuf8P82WLWSenT6WKmJ8Q7qqAXJtN17/fZatLlP1QF3pVKPkD0RqBc2mZWH2o6v9PbTSsnbKmviYWq+i61XQ4SuFrn8eE3PVzul4ftAzNNSAz6wiJJEvpJPNLfvyNfi+xHRsFKwhYmJE2p5GNkIveS8S5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951598; c=relaxed/simple;
	bh=iQDVXysa+bpqwMj0MbzV9xnHXcsg+5z5+VfkNhyMeMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHfHfKM+fXoUo2wCfCBRhGXbcag+restWuBgZUmhBmXOw4X/CV0y/LM1tan8/RMvh6F2uEqN/Rt+2XCPTefflG3tMgtF/esTRtBe800mJgzsEA6UUzUifw6279cO8hgnPwMqQbiu+SHlY9G5d8oCT2NRXwe4QQhinDqnNSwFTus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh3Iit1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7750FC4CEE9;
	Tue, 29 Apr 2025 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745951598;
	bh=iQDVXysa+bpqwMj0MbzV9xnHXcsg+5z5+VfkNhyMeMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hh3Iit1RnH/SnMosdI7Veuw9xStN7nuvtshxxuhUv6SBfZfStWQTNX/8vSqKEIbeI
	 d+xOQKs7zbOxPSVBiQkG9XQ0CDWN8VvGpRJCm/em3vR4ksPdEqYblTNqFyGqBAvuHu
	 5HtiwV4o5WKzaIBQir5oF17meUwkGictlGfIdKCRA6YdO1X1gQwHDEWhLcQ8+tvm+A
	 zAIfv/YHWYZtTmpjkCq/olZOuRExsLnsZb0JjdLkJF0BphyxGnBKsdA0UWPMsRscxr
	 FNBB0SkTkOlPmeY157mrcWhlsCSRfUDRwgyXg0kG59GxUFrtxKtygeS8ErE8KKwO5E
	 rCAl3iyHgb7cA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH v3 3/4] rpcctl: Display new rpc_clnt sysfs attributes
Date: Tue, 29 Apr 2025 14:33:14 -0400
Message-ID: <20250429183315.254059-4-anna@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429183315.254059-1-anna@kernel.org>
References: <20250429183315.254059-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

This includes the rpc program name, rpc version, and maximum number of
connections.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 tools/rpcctl/rpcctl.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index ce22e424b804..130f245a64e8 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -185,14 +185,13 @@ class Xprt:
 class XprtSwitch:
     """Represents a group of xprt connections."""
 
-    def __init__(self, path, sep=":"):
+    def __init__(self, path):
         """Read in xprt switch information from sysfs."""
         self.path = path
         self.name = path.stem
         self.info = read_info_file(path / "xprt_switch_info")
         self.xprts = sorted([Xprt(p) for p in self.path.iterdir()
                              if p.is_dir()])
-        self.sep = sep
 
     def __lt__(self, rhs):
         """Compare the name of two xprt switch instances."""
@@ -200,7 +199,7 @@ class XprtSwitch:
 
     def __str__(self):
         """Return a string representation of an xprt switch."""
-        switch = f"{self.name}{self.sep} " \
+        switch = f"{self.name}: " \
                  f"xprts {self.info['num_xprts']}, " \
                  f"active {self.info['num_active']}, " \
                  f"queue {self.info['queue_len']}"
@@ -258,7 +257,11 @@ class RpcClient:
         """Read in rpc client information from sysfs."""
         self.path = path
         self.name = path.stem
-        self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
+        self.switch = XprtSwitch(path / (path / "switch").readlink())
+        self.program = read_sysfs_file(path / "program", missing="unknown")
+        self.version = read_sysfs_file(path / "rpc_version", missing="unknown")
+        self.max_connect = read_sysfs_file(path / "max_connect",
+                                           missing="unknown")
 
     def __lt__(self, rhs):
         """Compare the name of two rpc client instances."""
@@ -266,7 +269,9 @@ class RpcClient:
 
     def __str__(self):
         """Return a string representation of an rpc client."""
-        return f"{self.name}: {self.switch}"
+        return f"{self.name}: {self.program}, rpc version {self.version}, " \
+               f"max_connect {self.max_connect}" \
+               f"\n  {' ' * len(self.name)}{self.switch}"
 
     def add_command(subparser):
         """Add parser options for the `rpcctl client` command."""
-- 
2.49.0


