Return-Path: <linux-nfs+bounces-9705-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9926AA20024
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D301887553
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 21:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE701DA10C;
	Mon, 27 Jan 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXR9mU8k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5E1D9694
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014659; cv=none; b=Sq6ROQeiTQT2Ko2ObFhQn3K3Wx+ykVy9RYR/F0r1cpnRb4rXE9MNp1PH4HIn95kVvnNuyTTJKk8n8Ydmcj9yP25jtfNr15mvynBNkkiofbfAxnq3KqutcUzyl3mtoyLWd1SnMEp2Huls05etCPkucQPqJtEl7P04ZvGwVws41vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014659; c=relaxed/simple;
	bh=6Ckg+G1pWZxG0m98V84G/PkldZUA9cgeUo4PkFz9bS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cvkn8hL6gswTcf6ZUINvvoHPxrNv65Aaseuegz61QsbWYbPCuSlYpCrflx0aQZs6iOp1JDfcUJ4wCnkuTimPT9OHWjgiwBNbY2z8Lm2ZRWRR7OZfAL7RyHSeLjjZhOtKIB2fCGZmSioOMiabHKAmE93u7JzHoLZncCewJRC+9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXR9mU8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1934AC4CED2;
	Mon, 27 Jan 2025 21:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738014659;
	bh=6Ckg+G1pWZxG0m98V84G/PkldZUA9cgeUo4PkFz9bS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXR9mU8kokGj6yU1PliaB/9r/5KEgu5x/vASb9X+7KTFJzEdSI0KUHRG0frqmpoMz
	 f59xENvgQwCoGg4EbJSW+4tQCDGYey+Ouvdw1HhXsW/CjdL4UmP+LIxaelG6aTLmMn
	 c0KYRVCVJcZUygmBnjVdtBIU28avwMhhkpRpV/n/juSE0v+OVfZ+0cT1eZtyJFrFJB
	 G3K//Hz1dzbpA/5VZ4lSu04vAnRxnZwwVIy6cqWz7Kds6ebNk2oT4yZLJcw6hQo9vH
	 BSsBMwjK9U0msyMx1xXkM03prECx5O+mXuyiQn9T0Rvr2PmQfmxayEcTKEvQ01GSE2
	 w+RFEgiV7vDnw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 3/4] rpcctl: Display new rpc_clnt sysfs attributes
Date: Mon, 27 Jan 2025 16:50:55 -0500
Message-ID: <20250127215056.352658-4-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127215056.352658-1-anna@kernel.org>
References: <20250127215056.352658-1-anna@kernel.org>
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
2.48.1


